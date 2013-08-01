From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 1 Aug 2013 14:11:18 -0400
Subject: [FAILURE] omap4430-sdp allnoconfig
In-Reply-To: <20130801175214.GA23053@n2100.arm.linux.org.uk>
References: <20130801175214.GA23053@n2100.arm.linux.org.uk>
Message-ID: <51FAA4C6.10203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 August 2013 01:52 PM, Russell King - ARM Linux wrote:
> My allnoconfig fails with this error:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap4_local_timer_init':
> dss-common.c:(.init.text+0x1d90): undefined reference to `twd_local_timer_register'
> 
> Might be worth looking into whatever's missing?

Looks like coming from below snippet but am just wondering how ?

#ifdef CONFIG_ARCH_OMAP4
#ifdef CONFIG_LOCAL_TIMERS
static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
void __init omap4_local_timer_init(void)
{
	omap4_sync32k_timer_init();
	/* Local timers are not supprted on OMAP4430 ES1.0 */
	if (omap_rev() != OMAP4430_REV_ES1_0) {
		int err;

		if (of_have_populated_dt()) {
			clocksource_of_init();
			return;
		}

		err = twd_local_timer_register(&twd_local_timer);
		if (err)
			pr_err("twd_local_timer_register failed %d\n", err);
	}
}
#else /* CONFIG_LOCAL_TIMERS */
void __init omap4_local_timer_init(void)
{
	omap4_sync32k_timer_init();
}
#endif /* CONFIG_LOCAL_TIMERS */
#endif /* CONFIG_ARCH_OMAP4 */
