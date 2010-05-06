From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 May 2010 09:14:15 +0200
Subject: [PATCHv1 2.6.34-rc6 2/3] mx5: change usb clock source from
	pll3 to pll2
In-Reply-To: <1273100171-3235-3-git-send-email-Dinh.Nguyen@freescale.com>
References: <1273100171-3235-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1273100171-3235-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1273100171-3235-3-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100506071415.GO31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 05:56:10PM -0500, Dinh Nguyen wrote:
> For power management reasons, pll2 should be used to source the USBOH3
> clock for mx51. PLL3 can be completely gated off when USB is not used.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/mach-mx5/clock-mx51.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
> index dcca330..933c0d1 100644
> --- a/arch/arm/mach-mx5/clock-mx51.c
> +++ b/arch/arm/mach-mx5/clock-mx51.c
> @@ -763,7 +763,7 @@ DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
>  
>  /* USB */
>  DEFINE_CLOCK(usboh3_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG14_OFFSET,
> -	NULL, NULL, &pll3_sw_clk, NULL);
> +	NULL, NULL, &pll2_sw_clk, NULL);

The commit message suggests that the parent is changed in this patch.
The only thing this patch changes is that when usboh3_clk is enabled,
pll2 instead of pll3 gets enabled. The real parent of this clock
is defined by the status quo of the CSCMR1/usboh3_clk_sel bits.

So the solution here is to initialize the parent field during runtime
according to the bits in hardware or to change the hardware bits
according to the parent field. Either way, please make sure that
hardware and state of the clock tree are consistent.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
