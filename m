From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 5 Aug 2013 16:42:05 +0800
Subject: [PATCH 2/8] ARM: tegra: config the polarity of the request of
 sys clock
In-Reply-To: <51FC1579.50100@wwwdotorg.org>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-3-git-send-email-josephl@nvidia.com>
 <51F6F109.8010102@wwwdotorg.org>
 <1375429739.6761.31.camel@jlo-ubuntu-64.nvidia.com>
 <51FC1579.50100@wwwdotorg.org>
Message-ID: <1375692125.1731.45.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-08-03 at 04:24 +0800, Stephen Warren wrote:
> On 08/02/2013 01:48 AM, Joseph Lo wrote:
> > On Tue, 2013-07-30 at 06:47 +0800, Stephen Warren wrote:
> >> On 07/26/2013 03:15 AM, Joseph Lo wrote:
> >>> When suspending to LP1 mode, the SYSCLK will be clock gated. And different
> >>> board may have different polarity of the request of SYSCLK, this patch
> >>> configure the polarity from the DT for the board.
> >>
> >>> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> >>
> >>> @@ -238,6 +240,20 @@ void tegra_pmc_suspend_init(void)
> >>>  	reg = tegra_pmc_readl(PMC_CTRL);
> >>>  	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
> >>>  	tegra_pmc_writel(reg, PMC_CTRL);
> >>> +
> >>> +	reg = tegra_pmc_readl(PMC_CTRL);
> >>> +
> >>> +	if (!pmc_pm_data.sysclkreq_high)
> >>> +		reg |= TEGRA_POWER_SYSCLK_POLARITY;
> >>> +	else
> >>> +		reg &= ~TEGRA_POWER_SYSCLK_POLARITY;
> >>> +
> >>> +	/* configure the output inverts while the request is tristated */
> >>> +	tegra_pmc_writel(reg, PMC_CTRL);
> >>
> >> I think s/inverts/polarity/ in that comment would make a lot more sense.
> >>
> > Yes, thanks.
> > 
> >> Must _OE be disabled for the code to work correctly? If so, should the
> >> code explicitly clear _OE first, since who knows what state it was
> >> originally in? Can't we just set the new polarity and enable _OE in a
> >> single register write?
> >>
> > The SYSCLK is super clock that was connected to COP subsystem. It can't
> > be disabled when system is running. The boot loader had initialized it
> > and brought it to kernel. We follow the HW description in DT of the
> > polarity of SCLK to re-configure and re-init again. Then the PMC can
> > clock gate it when system go into suspend state.
> 
> So it sounds like the bootloader has already configured the clock to a
> certain polarity. If so, why do we need to reconfigure it again?
> 
> Or, is this code not duplicating something the bootloader must have
> done, but simply informing some HW in the PMC that's receiving SYSCLK
> how the clock is configured elsewhere?

I can't always guarantee the bootloader does the stuffs that kernel
needs. For this reason, it's better to do what the kernel needs in the
kernel.
