From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 29 Sep 2010 07:37:26 -0700
Subject: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02B1E@dbde02.ent.ti.com>
	(Charulatha Varadarajan's message of "Wed, 29 Sep 2010 18:44:03
	+0530")
References: <1285252363-3630-1-git-send-email-charu@ti.com>
	<877hi5740v.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02B1E@dbde02.ent.ti.com>
Message-ID: <87d3rw62ft.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman at deeprootsystems.com]
>> Sent: Wednesday, September 29, 2010 6:36 AM
>> To: Varadarajan, Charulatha
>> Cc: tony at atomide.com; wim at iguana.be; linux-omap at vger.kernel.org; linux-
>> watchdog at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> paul at pwsan.com; Cousson, Benoit; Nayak, Rajendra; Basak, Partha
>> Subject: Re: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
>> 
>> Hi Charu,
>> 
>> "Varadarajan, Charulatha" <charu@ti.com> writes:
>> 
>> > Series of patches to port watchdog module to use hwmod APIs
>> > for OMAP2PLUS chips and use runtime APIs for all OMAP chips.
>> > For this hwmod database for OMAP2PLUS watchdog instances are
>> > populated and implements watchdog module to use PM runtime APIs.
>> >
>> > This patch series is generated on "origin/pm-core" which
>> > has Kevin's pm-next series, the runtime PM core patch series,
>> > and a collection of hwmod fixes that Paul/Benoit have lined up
>> > for 2.6.37.
>> >
>> > Tested on OMAP2430, OMAP4430 (ES1.0 & ES2.0), OMAP3430 SDP boards
>> > and zoom3 board. Also verified that this patch series does not
>> > break the OMAP1 build.
>> 
>> I found a little snag with this series.  Try testing with
>> omap2plus_defconfig and changing CONFIG_OMAP_WATCHDOG=n.
>> 
>> If CONFIG_OMAP_WATCHDOG is not enabled in the kernel config, the system
>> will reboot soon after bootup. 
>
> Thanks for finding this issue.
>
> After watchdog module reset, the WDTs are enabled. The default time
> for a system reset after a watchdog module reset is ~10s as per the
> default value of the WDT registers. Hence the above problem is observed.
>
> If CONFIG_OMAP_WATCHDOG is defined, wdt's probe is called within this
> 10s time and watchdog_disable is called during probe. Hence we are not
> finding this issue if CONFIG_OMAP_WATCHDOG is defined.
>
> Ideally, because of the above, watchdog should be with
> HWMOD_INIT_NO_RESET flag.
>
> If agreed, I would send the below patch (extended to other OMAPs)
> on top of my watchdog timer hwmod series with proper change log.

Using HWMOD_INIT_NO_RESET makes us still dependent on the bootloader
settings.

Instead, I would rather have a small piece of code in omap_init_wdt()
which disarms the watchdog so we don't have any assumptions about
bootloader behavior.

The question remains whether this disarm should be
#ifndef CONFIG_OMAP_WATCHDOG or if it should happen all the time.  In
case the watchdog is a module, it's probe may not happen within the
timeout period and they system may reboot also, so I lean towards
disarming the watchdog unconditionally.

Kevin

> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_3xxx_data.c
> index 5bfe9c9..c567b24 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -260,6 +260,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
>         .slaves         = omap3xxx_wd_timer2_slaves,
>         .slaves_cnt     = ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
>         .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       .flags          = HWMOD_INIT_NO_RESET,
>  };
>
> -V Charulatha
>
> <<snip>>
