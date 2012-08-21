From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 21 Aug 2012 16:26:31 +0800
Subject: [PATCH 1/3] ARM: PRIMA2: use DT_MACHINE_START and convert to
 generic board
In-Reply-To: <201208210753.12718.arnd@arndb.de>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <201208202056.28361.arnd@arndb.de>
 <CAGsJ_4wR1dU05QutVeKHephDmSpSKOki1+AGZVV95hf3ABePDA@mail.gmail.com>
 <201208210753.12718.arnd@arndb.de>
Message-ID: <CAGsJ_4x+sm9=bg1Riyeb6JF0sSC-n=ZBAy6ibx_Styu5rM9yYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Thanks.

2012/8/21 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 21 August 2012, Barry Song wrote:
>> 2012/8/21 Arnd Bergmann <arnd@arndb.de>:
>> > On Monday 20 August 2012, Barry Song wrote:
>> >
>> > I would prefer not to have a board-* file in there, because it's not
>> > specific to a board. If you want to get rid of the prima2 name in it,
>> > you can call it common.c.
>>
>> that is fine to me. i rename to board-generic.c just because omap and
>> some others did like that.
>> and i'll add marco and polo DT_MACHINE_START to this file too.
>
> Ok. For the older platforms that have a lot of non-DT board files, it makes
> sense to have a separate board-generic.c file.

ok. then renaming to common.c is better for this full-DT platform.

>
>> >> diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/board-generic.c
>> >> similarity index 81%
>> >> rename from arch/arm/mach-prima2/prima2.c
>> >> rename to arch/arm/mach-prima2/board-generic.c
>> >> index e9a17ae..f06b887 100644
>> >> --- a/arch/arm/mach-prima2/prima2.c
>> >> +++ b/arch/arm/mach-prima2/board-generic.c
>> >> @@ -30,12 +30,13 @@ void __init sirfsoc_init_late(void)
>> >>       sirfsoc_pm_init();
>> >>  }
>> >>
>> >> -static const char *prima2cb_dt_match[] __initdata = {
>> >> -       "sirf,prima2-cb",
>> >> +#ifdef CONFIG_ARCH_PRIMA2
>> >> +static const char *prima2_dt_match[] __initdata = {
>> >> +       "sirf,prima2",
>> >>         NULL
>> >>  };
>> >>
>> >> -MACHINE_START(PRIMA2_EVB, "prima2cb")
>> >> +DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
>> >>       /* Maintainer: Barry Song <baohua.song@csr.com> */
>> >>       .atag_offset    = 0x100,
>> >>       .map_io         = sirfsoc_map_lluart,
>> >> @@ -44,6 +45,7 @@ MACHINE_START(PRIMA2_EVB, "prima2cb")
>> >>       .dma_zone_size  = SZ_256M,
>> >>       .init_machine   = sirfsoc_mach_init,
>> >>       .init_late      = sirfsoc_init_late,
>> >> -     .dt_compat      = prima2cb_dt_match,
>> >> +     .dt_compat      = prima2_dt_match,
>> >>       .restart        = sirfsoc_restart,
>> >>  MACHINE_END
>> >> +#endif
>> >
>> > I suppose this never really worked before then?
>>
>> i am not sure what you mean, but this does work and i tested and found
>> prima2 can boot normally.
>
> I mean the old version, not the new one. If you use MACHINE_START,
> you cannot access the device tree data from the boot loader, which
> means that none of the device drivers find their devices.

sorry i didn't get you.

DT is read to 0x3608000 by bootloader, and bootm has param "bootm
0x02008000 - 0x3608000" as:

bootcmd=mmc read 0 0x3608000 0x3780 0x80;mmc read 0 0x02008000 0x1800
0x1800;fdt addr 0x3608000;
fdt resize;bootm 0x02008000 - 0x3608000

kernel has been always able to read DT data from bootloader.

>
> I also just noticed that you ahve both the .atag_offset and the .dt_compat
> field set here, which is a bit strange as the dt_compat field was previously
> unused. Now, the .atag_offset field is unused, so you should remove that.
>

i'll remove .atag_offset field then.

>         Arnd

-barry
