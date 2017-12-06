From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Dec 2017 14:03:01 +0000
Subject: [PATCH v3 20/20] arm64: kaslr: Put kernel vectors address in
 separate data page
In-Reply-To: <20171206132714.GA31186@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <1512563739-25239-21-git-send-email-will.deacon@arm.com>
 <CAKv+Gu_qpJCXqfrGqMGDfjeYHQVYU4SWChMXdPi53g6rmqQz6Q@mail.gmail.com>
 <20171206132714.GA31186@arm.com>
Message-ID: <CAKv+Gu-=QbpCPLqiHabG=W21q5s6yM6-XhVRHDvjD1gj7ots4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2017 at 13:27, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Wed, Dec 06, 2017 at 12:59:40PM +0000, Ard Biesheuvel wrote:
>> On 6 December 2017 at 12:35, Will Deacon <will.deacon@arm.com> wrote:
>> > The literal pool entry for identifying the vectors base is the only piece
>> > of information in the trampoline page that identifies the true location
>> > of the kernel.
>> >
>> > This patch moves it into its own page, which is only mapped by the full
>> > kernel page table, which protects against any accidental leakage of the
>> > trampoline contents.
>
> [...]
>
>> > @@ -1073,6 +1079,11 @@ END(tramp_exit_compat)
>> >
>> >         .ltorg
>> >         .popsection                             // .entry.tramp.text
>> > +#ifdef CONFIG_RANDOMIZE_BASE
>> > +       .pushsection ".entry.tramp.data", "a"   // .entry.tramp.data
>> > +       .quad   vectors
>> > +       .popsection                             // .entry.tramp.data
>>
>> This does not need to be in a section of its own, and doesn't need to
>> be padded to a full page.
>>
>> If you just stick this in .rodata but align it to page size, you can
>> just map whichever page it ends up in into the TRAMP_DATA fixmap slot
>> (which is a r/o mapping anyway). You could then drop most of the
>> changes below. And actually, I'm not entirely sure whether it still
>> makes sense then to do this only for CONFIG_RANDOMIZE_BASE.
>
> Good point; I momentarily forgot this was in the kernel page table anyway.
> How about something like the diff below merged on top (so this basically
> undoes a bunch of the patch)?
>

Yes, that looks much better.

> I'd prefer to keep the CONFIG_RANDOMIZE_BASE dependency, at least for now.
>

Fair enough.

> --->8
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index a70c6dd2cc19..031392ee5f47 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -1080,9 +1080,12 @@ END(tramp_exit_compat)
>         .ltorg
>         .popsection                             // .entry.tramp.text
>  #ifdef CONFIG_RANDOMIZE_BASE
> -       .pushsection ".entry.tramp.data", "a"   // .entry.tramp.data
> +       .pushsection ".rodata", "a"
> +       .align PAGE_SHIFT
> +       .globl  __entry_tramp_data_start
> +__entry_tramp_data_start:
>         .quad   vectors
> -       .popsection                             // .entry.tramp.data
> +       .popsection                             // .rodata
>  #endif /* CONFIG_RANDOMIZE_BASE */
>  #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 976109b3ae51..27cf9be20a00 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -64,21 +64,8 @@ jiffies = jiffies_64;
>         *(.entry.tramp.text)                                    \
>         . = ALIGN(PAGE_SIZE);                                   \
>         VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
> -#ifdef CONFIG_RANDOMIZE_BASE
> -#define TRAMP_DATA                                             \
> -       .entry.tramp.data : {                                   \
> -               . = ALIGN(PAGE_SIZE);                           \
> -               VMLINUX_SYMBOL(__entry_tramp_data_start) = .;   \
> -               *(.entry.tramp.data)                            \
> -               . = ALIGN(PAGE_SIZE);                           \
> -               VMLINUX_SYMBOL(__entry_tramp_data_end) = .;     \
> -       }
> -#else
> -#define TRAMP_DATA
> -#endif /* CONFIG_RANDOMIZE_BASE */
>  #else
>  #define TRAMP_TEXT
> -#define TRAMP_DATA
>  #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>
>  /*
> @@ -150,7 +137,6 @@ SECTIONS
>         RO_DATA(PAGE_SIZE)              /* everything from this point to     */
>         EXCEPTION_TABLE(8)              /* __init_begin will be marked RO NX */
>         NOTES
> -       TRAMP_DATA
>
>         . = ALIGN(SEGMENT_ALIGN);
>         __init_begin = .;
> @@ -268,10 +254,6 @@ ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
>         "Entry trampoline text too big")
> -#ifdef CONFIG_RANDOMIZE_BASE
> -ASSERT((__entry_tramp_data_end - __entry_tramp_data_start) == PAGE_SIZE,
> -       "Entry trampoline data too big")
> -#endif
>  #endif
>  /*
>   * If padding is applied before .head.text, virt<->phys conversions will fail.
