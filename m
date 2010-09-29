From: charu@ti.com (Varadarajan, Charulatha)
Date: Wed, 29 Sep 2010 20:16:41 +0530
Subject: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
In-Reply-To: <87d3rw62ft.fsf@deeprootsystems.com>
References: <1285252363-3630-1-git-send-email-charu@ti.com>
	<877hi5740v.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02B1E@dbde02.ent.ti.com>
	<87d3rw62ft.fsf@deeprootsystems.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02BA7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com]

<<snip>>

> >>
> >> I found a little snag with this series.  Try testing with
> >> omap2plus_defconfig and changing CONFIG_OMAP_WATCHDOG=n.
> >>
> >> If CONFIG_OMAP_WATCHDOG is not enabled in the kernel config, the system
> >> will reboot soon after bootup.
> >
> > Thanks for finding this issue.
> >
> > After watchdog module reset, the WDTs are enabled. The default time
> > for a system reset after a watchdog module reset is ~10s as per the
> > default value of the WDT registers. Hence the above problem is observed.
> >
> > If CONFIG_OMAP_WATCHDOG is defined, wdt's probe is called within this
> > 10s time and watchdog_disable is called during probe. Hence we are not
> > finding this issue if CONFIG_OMAP_WATCHDOG is defined.
> >
> > Ideally, because of the above, watchdog should be with
> > HWMOD_INIT_NO_RESET flag.
> >
> > If agreed, I would send the below patch (extended to other OMAPs)
> > on top of my watchdog timer hwmod series with proper change log.
> 
> Using HWMOD_INIT_NO_RESET makes us still dependent on the bootloader
> settings.

Agreed.

> 
> Instead, I would rather have a small piece of code in omap_init_wdt()
> which disarms the watchdog so we don't have any assumptions about
> bootloader behavior.
> 
> The question remains whether this disarm should be
> #ifndef CONFIG_OMAP_WATCHDOG or if it should happen all the time.  In
> case the watchdog is a module, it's probe may not happen within the
> timeout period and they system may reboot also, so I lean towards
> disarming the watchdog unconditionally.

Agreed. But this shall be handled in mach-omap2/devices.c by directly
accessing the watchdog registers and disabling it, as the watchdog driver
would not be available by this time. If this okay, I would send a
separate patch on top my hwmod series to handle this.

-V Charulatha

<<snip>>
