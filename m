From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 7 Dec 2015 23:17:46 +0100
Subject: [PATCH] ARM: mm: mark section-aligned portion of rodata NX
In-Reply-To: <CAKv+Gu_L-9bnaDs-HAONgHARFpeEk41y0KUAFobBcdh1i9Ughg@mail.gmail.com>
References: <20151207205432.GA5271@www.outflux.net>
 <CAKv+Gu-q4ziskce+KneLTKZWi+sB_-4ZG4tyYssK7HNyqxAn4A@mail.gmail.com>
 <CAGXu5jKOn7S-GVu4bZU+B3QbrJZxen4mPzK7-TyzcFf7YiKDNA@mail.gmail.com>
 <CAKv+Gu_L-9bnaDs-HAONgHARFpeEk41y0KUAFobBcdh1i9Ughg@mail.gmail.com>
Message-ID: <CAKv+Gu_4bzobQw=n353V9Z_Ao-a-TxTHab3UL7U7OpsYds48CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 December 2015 at 23:14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 7 December 2015 at 22:56, Kees Cook <keescook@chromium.org> wrote:
>> On Mon, Dec 7, 2015 at 1:52 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 7 December 2015 at 21:54, Kees Cook <keescook@chromium.org> wrote:
>>>> When rodata is large enough that it crosses a section boundary after the
>>>> kernel text, mark the rest NX. This is as close to full NX of rodata as
>>>> we can get without splitting page tables or doing section alignment via
>>>> CONFIG_DEBUG_ALIGN_RODATA.
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>> I am baffled why I can't put the ALIGN in the ".start = " initializer.
>>>> GCC seems to think it's non-static, but only because of the "&" operator.
>>>> Does anyone see a way to do this that doesn't require the runtime ALIGN?
>>>
>>> Yes, but you need to move the ALIGN() expression to the linker script
>>> as the value of a new symbol
>>
>> I didn't see a way to do this without actually bumping the alignment
>> (CONFIG_DEBUG_ALIGN_RODATA already does that, I want the other case).
>> Do you have an example anywhere I could look at?
>>
>
> Something like this (untested)
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 8b60fde5ce48..9fb98c5dd35b 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -336,6 +336,8 @@ SECTIONS
>   STABS_DEBUG
>  }
>
> +__start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
> +
>  /*
>   * These must never be empty
>   * If you have to comment these two assert statements out, your
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 8a63b4cdc0f2..ddacd3bd8f8b 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -592,15 +592,13 @@ static struct section_perm nx_perms[] = {
>   .mask = ~PMD_SECT_XN,
>   .prot = PMD_SECT_XN,
>   },
> -#ifdef CONFIG_DEBUG_RODATA
>   /* Make rodata NX (set RO in ro_perms below). */
>   {
> - .start  = (unsigned long)__start_rodata,
> + .start  = (unsigned long)__start_rodata_section_aligned,
>   .end    = (unsigned long)__init_begin,
>   .mask   = ~PMD_SECT_XN,
>   .prot   = PMD_SECT_XN,
>   },
> -#endif
>  };
>
>  #ifdef CONFIG_DEBUG_RODATA

... and you also need a

extern char __start_rodata_section_aligned[];

somewhere;
