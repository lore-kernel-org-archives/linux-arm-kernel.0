From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Nov 2014 13:33:58 +0100
Subject: [PATCH v3/resend] ARM: shmobile: Add early debugging support
 using SCIF(A)
In-Reply-To: <3499638.LG41cHl0JS@wuerfel>
References: <1415273910-32356-1-git-send-email-geert+renesas@glider.be>
 <3499638.LG41cHl0JS@wuerfel>
Message-ID: <CAMuHMdUU7XK57a70HWP0+nfwaZ-sXQ5EC2CShgmxwx6JKnuyPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for your review!

On Thu, Nov 6, 2014 at 12:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 06 November 2014 12:38:30 Geert Uytterhoeven wrote:
>> Add serial port debug macros for the SCIF(A) serial ports.
>> This includes all shmobile SoCs, except for EMEV2.

> I don't object to this patch going in, but have you looked at doing
> just earlycon instead? We are still missing some fixmap changes

I was thinking about earlycon support...

> before that works on arm32, but in general, early looks nicer than

Good to know there are still some parts missing.

> debug_ll because it doesn't require you to build for a particular
> machine, with the downside that it's not available as early during
> boot.

Hence we're gonna need debug_ll anyway?
So far I only needed it for real early issues.

>> @@ -1039,6 +1047,54 @@ config DEBUG_STI_UART
>>       bool
>>       depends on ARCH_STI
>>
>> +choice
>> +     prompt "Renesas SCIF(A) debugging SoC/port"
>> +     depends on DEBUG_RENESAS_SCIF
>> +     help
>> +       Choose SoC and SCIF(A) debug port combination from the list below.
>> +
>> +       The kernel will most probably only work on the selected SoC.
>> +       The selected debug port will be used to provide the default SCIF(A)
>> +       physical address; the actual address can still be overridden using
>> +       the DEBUG_UART_PHYS option, if needed.
>
> We used to have multi-level choice statements here, but Russell removed
> them all in cce278d2034 ("ARM: debug: clean up low level kernel debugging
> selection"). Please follow the same style.

OK, will move it up.

>> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
>> index d08e75cceaab3ead..b31032294f478c91 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
>> @@ -62,6 +62,15 @@ static struct map_desc r8a7779_io_desc[] __initdata = {
>>               .length         = SZ_16M,
>>               .type           = MT_DEVICE_NONSHARED
>>       },
>> +#ifdef CONFIG_DEBUG_R8A7779_SCIF2
>> +     /* 64K entity map for 0xffe40000 (SCIF) */
>
> s/entity/identity/ ?

Yep. Never copy swenglish comments.

>> +     {
>> +             .virtual        = 0xffe40000,
>> +             .pfn            = __phys_to_pfn(0xffe40000),
>> +             .length         = SZ_64K,
>> +             .type           = MT_DEVICE_NONSHARED
>> +     },
>> +#endif /* CONFIG_DEBUG_R8A7779_SCIF2 */
>>  };
>
> This should be done automatically if you call debug_ll_io_init() or
> have an empty map_io() callback.

On r8a7779 map_io() is not empty, but it didn't cover the SCIF registers,
cfr. the commit log:

> >   4. On SoCs using the legacy machine_desc.map_io(), an identity mapping
> >      of the SCIF(A) registers must be set up in .map_io(). On all but
> >      r8a7779 this was already done.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
