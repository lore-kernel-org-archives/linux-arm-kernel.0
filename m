From: james.morse@arm.com (James Morse)
Date: Mon, 22 Aug 2016 14:15:48 +0100
Subject: [PATCH v4 2/3] arm64: vmlinux.ld: Add .mmuoff.{text,
 data} sections
In-Reply-To: <CAKv+Gu8X22ghgvez5tTfwrm8PDzsB6xatHDs6S5_BM4YWaKgmQ@mail.gmail.com>
References: <1471281122-26295-1-git-send-email-james.morse@arm.com>
 <1471281122-26295-3-git-send-email-james.morse@arm.com>
 <CAKv+Gu-1jEPAFL7mUP6FqVzYrPQvVXfrB9RPuuR5AZFAWHBQQQ@mail.gmail.com>
 <57B59E85.8020304@arm.com>
 <CAKv+Gu8X22ghgvez5tTfwrm8PDzsB6xatHDs6S5_BM4YWaKgmQ@mail.gmail.com>
Message-ID: <57BAFB04.2000906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 18/08/16 12:55, Ard Biesheuvel wrote:
> Actually, it is not even necessary to align the end of .mmuoff.data,
> as long as the next section starts at at 2 KB aligned boundary (which
> is guaranteed for .bss since it covers page aligned data, although it
> would make sense to make that explicit) I.e., something like
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 659963d40bb4..70aa77060729 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -185,10 +185,18 @@ SECTIONS
>         _data = .;
>         _sdata = .;
>         RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +
> +       .mmuoff.read : ALIGN(SZ_2K) {
> +               *(.mmuoff.read)
> +       }
> +       .mmuoff.write : ALIGN(SZ_2K) {
> +               *(.mmuoff.write)
> +       }
> +
>         PECOFF_EDATA_PADDING
>         _edata = .;
> 
> -       BSS_SECTION(0, 0, 0)
> +       BSS_SECTION(SZ_2K, SZ_2K, 0)
> 
>         . = ALIGN(PAGE_SIZE);
>         idmap_pg_dir = .;
> 
> AFAICT, this should allow you to drop the alignments in the code. This
> is also more future proof, since you can simply emit variables into
> these sections anywhere, whereas the explicit .align directive aligns
> that particular variable, which could lead to more waste of space.

Thanks! This looks a lot better.

I think the 2K alignment is only needed for the mmuoff.write section as it
invalidates cache lines. I don't see a problem with the mmuoff.read section's
CWG overlapping with the BSS or other data as the cache maintenance is
clean+invalidate.



Thanks,

James
