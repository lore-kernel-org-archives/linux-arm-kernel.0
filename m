From: keescook@chromium.org (Kees Cook)
Date: Tue, 16 Feb 2016 12:16:30 -0800
Subject: [PATCH] ARM: fix __start_rodata_section_aligned on XIP
In-Reply-To: <CAMuHMdXuAkXqZ_09iF3ZCksPtWB-pm-9YtAOqw+E3KpFnoegug@mail.gmail.com>
References: <20160216183809.GA26069@www.outflux.net>
 <CAMuHMdXuAkXqZ_09iF3ZCksPtWB-pm-9YtAOqw+E3KpFnoegug@mail.gmail.com>
Message-ID: <CAGXu5j+8LtBjxBms1qjWHSvyVc_2ajp8QxGOc_Ca+gze7ib=Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 11:20 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Kees,
>
> On Tue, Feb 16, 2016 at 7:38 PM, Kees Cook <keescook@chromium.org> wrote:
>> This fixes the build for both allnoconfig (!CONFIG_MMU) and with
>> XIP_KERNEL (due to missing pieces in the linker script), as seen after
>> both "ARM: 8502/1: mm: mark section-aligned portion of rodata NX" and
>> "ARM: 8513/1: xip: Move XIP linking to a separate file".
>>
>> Reported-by: Russell King <linux@arm.linux.org.uk>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
>> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
>> index 40bc4cadb959..2da60cd1b295 100644
>> --- a/arch/arm/kernel/vmlinux-xip.lds.S
>> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
>
>> @@ -310,6 +311,17 @@ SECTIONS
>>  }
>>
>>  /*
>> + * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
>> + * be the first section-aligned location after __start_rodata. Otherwise,
>> + * it will be equal to __start_rodata.
>> + */
>> +#ifdef CONFIG_MMU
>
> CONFIG_DEBUG_ALIGN_RODATA or CONFIG_MMU?
>
>> +__start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);

CONFIG_MMU controls the availability of SECTION_SHIFT, so I used that.
Either will work, since without CONFIG_DEBUG_ALIGN_RODATA, the values
will end up being identical, as in the #else.

Though it looks like XIP_KERNEL should kill all of the
CONFIG_DEBUG_*RODATA defines anyway. I think we need a different
version of this combined with the patch from Ard...

-Kees

>> +#else
>> +__start_rodata_section_aligned = __start_rodata;
>> +#endif
>> +
>> +/*
>>   * These must never be empty
>>   * If you have to comment these two assert statements out, your
>>   * binutils is too old (for other reasons as well)
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>> index 1707b9431761..f13960e44955 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -328,7 +328,11 @@ SECTIONS
>>   * be the first section-aligned location after __start_rodata. Otherwise,
>>   * it will be equal to __start_rodata.
>>   */
>> +#ifdef CONFIG_MMU
>
> Likewise (the out-of-scope comment says CONFIG_DEBUG_ALIGN_RODATA)?
>
>>  __start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
>> +#else
>> +__start_rodata_section_aligned = __start_rodata;
>> +#endif
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Kees Cook
Chrome OS & Brillo Security
