From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Oct 2014 11:08:04 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <2257006.dpJJ6zLgnP@avalon>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon>
Message-ID: <CAMuHMdUyLJx6wt7dLoiJLzKBTdJQWnQeHvk6POZknT+-BC5kcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Mon, Oct 6, 2014 at 12:18 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> It looks like you've beaten Ian Molton (CC'ed) on this, he was planning to
> send exactly the same thing.

Sorry, I desperately needed this for r8a7740 :-)

> On Thursday 02 October 2014 21:02:43 Geert Uytterhoeven wrote:
>>   - On armadillo-multiplatform there may be a period while garbage data
>>     is output.
>>     This happens because sh_mobile_i2c_init() enables and disables its
>>     clock during probing. As iic0 and scifa1 share the same parent
>>     clock, this causes the scifa1 clock to no longer receive clock
>>     ticks.
>>     On armadillo-legacy, this is mitigated by the pre-CCF clock driver,
>>     which never really disables clocks during boot-up for exactly this
>>     reason. Cfr. "One example of this is the handling of the Mackerel
>>     serial console output that shares clock with the I2C controller.",
>>     in commit 794d78fea51504ba ("drivers: sh: late disabling of clocks
>>     V2").
>>     I'm wondering whether this can be fixed in the i2c driver? Does it
>>     really have to enable and disable the clock?
>
> Do you think it be possible to enable the required clock dynamically in setup
> code when CONFIG_DEBUG_LL is enabled ?

It's definitely possibly, but IMHO that would add complexity.

>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index b11ad54f8d17fa6b..58ace40b30938e58 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -699,6 +699,14 @@ choice
>>                 their output to UART 2. The port must have been initialised
>>                 by the boot-loader before use.
>>
>> +     config DEBUG_SCIF
>
> How about calling this DEBUG_RENESAS_SCIF ? Other platforms use the platform
> name instead of the serial IP core name.

Good point. Will fix.

>> @@ -1028,6 +1036,7 @@ config DEBUG_LL_INCLUDE
>>                                DEBUG_IMX6SX_UART
>>       default "debug/msm.S" if DEBUG_MSM_UART || DEBUG_QCOM_UARTDM
>>       default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
>> +     default "debug/scif.S" if DEBUG_SCIF
>
> Similarly, renesas-scif.S ?

OK.

>> --- /dev/null
>> +++ b/arch/arm/include/debug/scif.S
>> @@ -0,0 +1,60 @@
>> +/*
>> + * Renesas SCIF(A) debugging macro include header
>> + *
>> + * Based on r8a7790.S
>> + *
>> + * Copyright (C) 2012-2013 Renesas Electronics Corporation
>
> 2014 ?

Based on the date I got r8a7790.S from you, I don't think anyone from
Renesas touched it in 2014.

>> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
>> @@ -66,6 +66,13 @@ static struct map_desc r8a7779_io_desc[] __initdata = {
>>               .length         = SZ_16M,
>>               .type           = MT_DEVICE_NONSHARED
>>       },
>> +     /* 64K entity map for 0xffe40000 (SCIF0/1) */
>> +     {
>> +             .virtual        = 0xffe40000,
>> +             .pfn            = __phys_to_pfn(0xffe40000),
>> +             .length         = SZ_64K,
>> +             .type           = MT_DEVICE_NONSHARED
>> +     },
>
> Should we guard that with #ifdef CONFIG_DEBUG_LL ?

Better, using CONFIG_DEBUG_RENESAS_SCIF.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
