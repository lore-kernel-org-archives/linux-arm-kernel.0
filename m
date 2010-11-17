From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Nov 2010 14:44:35 +0100
Subject: [PATCH 03/11] ARM: imx: Add reset routine for i.MX28
In-Reply-To: <AANLkTimpvmRLhWuDdZVLGcyro5bfNGEDYx509RLbC_nq@mail.gmail.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<1289831795-4373-4-git-send-email-shawn.guo@freescale.com>
	<20101115163646.GK8942@pengutronix.de>
	<AANLkTimpvmRLhWuDdZVLGcyro5bfNGEDYx509RLbC_nq@mail.gmail.com>
Message-ID: <20101117134435.GB8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 07:17:39PM +0800, Shawn Guo wrote:
> 2010/11/16 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Mon, Nov 15, 2010 at 10:36:27PM +0800, Shawn Guo wrote:
> >> +#ifdef CONFIG_ARCH_MX28
> >> +int mxc_reset_block(void __iomem *reg_addr)
> >> +{
> >> + ? ? u32 reg;
> >> + ? ? int timeout;
> >> +
> >> + ? ? /*
> >> + ? ? ?* The process of software reset of IP block is done
> >> + ? ? ?* in several steps:
> >> + ? ? ?*
> >> + ? ? ?* 1) clear SFTRST and wait it cleared;
> >> + ? ? ?* 2) clear CLKGATE, set SFTRST, wait CLKGATE set;
> >> + ? ? ?* 3) clear SFTRST and wait it cleared;
> >> + ? ? ?* 4) clear CLKGATE and wait it cleared.
> >> + ? ? ?*/
> >> +
> >> + ? ? /* Clear SFTRST */
> >> + ? ? reg = __raw_readl(reg_addr);
> >> + ? ? reg &= ~(1 << 31);
> >> + ? ? __raw_writel(reg, reg_addr);
> >> + ? ? /* Wait SFTRST cleared */
> >> + ? ? timeout = 1000;
> >> + ? ? do {
> >> + ? ? ? ? ? ? mdelay(1);
> >> + ? ? ? ? ? ? if ((__raw_readl(reg_addr) & (1 << 31)) == 0)
> >> + ? ? ? ? ? ? ? ? ? ? break;
> >> + ? ? } while (--timeout > 0);
> > Does the mdelay make sence here?
> >
> i.MX28 Application Processor Reference Manual, Chapter 39.5.10
> "Correct Way to Software Reset a Block".
Quoting the chapter you pointed out:

	// Prepare for soft-reset by making sure that SFTRST is not currently
	// asserted. Also clear CLKGATE so we can wait for its assertion below.
	HW_GPMI_CTRL0_CLR(BM_GPMI_CTRL0_SFTRST);
	// Wait at least a microsecond for SFTRST to deassert. In actuality, we
	// need to wait 3 GPMI clocks, but this is much easier to implement.
	musecs = hw_profile_GetMicroseconds();
	while (HW_GPMI_CTRL0.B.SFTRST || (hw_profile_GetMicroseconds() - musecs <
	DDI_NAND_HAL_GPMI_SOFT_RESET_LATENCY));
	[...]

This talks about a microsecond, not a millisecond.

Expecting that most of the time not a whole millisecond is needed, I'd
do something like that:

	val = __raw_readl(reset_addr);
	val &= ~MX28_MODULERESET_SFTRST;
	__raw_writel(val, reset_addr);

	/*
	 * SFTRST needs 3 GPMI clocks to settle, the reference manual
         * recommends to wait 1us.
	 */
	udelay(1);

	timeout = 0x400;
	while ((__raw_readl(reset_addr) & MX28_MODULERESET_SFTRST) && --timeout)
		/* nothing /*;

	if (!timeout)
		goto error;

That is do a busy read and don't busy wait a millisecond between two
consecutive reads just twiddling thumbs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
