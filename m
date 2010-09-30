From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 30 Sep 2010 22:35:05 +0530
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com>,<20100930150713.GG3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD03185@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Varadarajan, Charulatha
> Sent: Thursday, September 30, 2010 9:25 PM
> To: Tony Lindgren; Cousson, Benoit
> Cc: Kevin Hilman; Menon, Nishanth; wim at iguana.be; linux-
> omap at vger.kernel.org; linux-watchdog at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; paul at pwsan.com; Nayak, Rajendra; Basak, Partha
> Subject: RE: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during
> init
> 
> Tony/ Benoit,
> 
> > >
> > > I think that disabling it should be done only if the CONFIG_OMAP_WDT
> > > is not set.
> >
> > How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
> > is set?
> 
> As given in the patch description, this patch does a disable of watchdog
> timer, during init, to avoid the system rebooting that happens due to
> enabling of watchdog timer after a reset of the module (during hwmod init).
> 
> According to the default WDT registers values, the system reboot would
> happen in ~10s if watchdog is enabled with default values. Hence, after
> a WDT module reset during init, the watchdog has to be disabled within 10s
> otherwise the system will keep rebooting.
> 
> Hence irrespective of CONFIG_WATCHDOG_NOWAYOUT/ CONFIG_OMAP_WDT,
> the watchdog timer needs to be disabled after a WDT reset has happened.
> 
One more option is to avoid the software reset using the CONFIG_OMAP_WDT
flag. Something like below.

--------------
static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
	.name		= "wd_timer2",
	.class		= &omap44xx_wd_timer_hwmod_class,
	.mpu_irqs	= omap44xx_wd_timer2_irqs,

+ #ifndef CONFIG_OMAP_WDT,
+ .flags		= HWMOD_INIT_NO_RESET,
+ #endif
	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_irqs),
	.main_clk	= "wd_timer2_fck",
	.prcm = {
		.omap4 = {
			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
		},
	},
	.slaves		= omap44xx_wd_timer2_slaves,
	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
};

Regards,
Santosh
