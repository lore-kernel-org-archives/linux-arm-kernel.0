From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Dec 2012 21:13:20 +0800
Subject: [PATCH 3/7] ARM i.MX5: switch IPU clk support to devicetree
 bindings
In-Reply-To: <20121211091453.GO10369@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <1352733809-27230-4-git-send-email-s.hauer@pengutronix.de>
 <20121211055657.GA28581@S2101-09.ap.freescale.net>
 <20121211091453.GO10369@pengutronix.de>
Message-ID: <20121211131317.GB10128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 10:14:53AM +0100, Sascha Hauer wrote:
> I just tested it, this seems to be a bit complicated. I can confirm that
> with IPU disabled the last message I see from the kernel is:
> 
> IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> 
> When the IPU is enabled everything is fine. In my testing the IPU was
> enabled, in the end that was the motivation of the whole series.
> 
> It seems to be that the system does not work when the MIPI/HSP clocks
> are enabled and the IPU clock is disabled. I found some reserved bits
> in the reference manual. Could you try the following and see if it fixes
> your problem?
> 
Yes, it fixes my problem.  Thanks for the quick fixing.

> 
> From 7d6eca0b10c1a1e2f13c229f6c6c8d6541926dd5 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Tue, 11 Dec 2012 10:08:50 +0100
> Subject: [PATCH] ARM i.MX51 clock: Fix regression since enabling MIPI/HSP
>  clocks
> 
> The MIPI/HSP clocks were recently turned on in the i.MX51 clock tree.
> It turned out that the system does not work properly when the MIPI/HSP
> clocks are enabled, but the IPU clock is disabled. This happens when
> IPU support is disabled. In this case the IPU clock gets disabled when
> the clock framework turns off unused clock in a late_initcall. This
> is broken since:
> 
> | commit 9a2d4825a9368e018003a2732a61be063d178f67
> | Author: Sascha Hauer <s.hauer@pengutronix.de>
> | Date:   Tue Jun 5 13:53:32 2012 +0200
> |
> |     ARM i.MX5: switch IPU clk support to devicetree bindings
> |
> |     The i.MX5 clk support has platform based clock bindings for the
> |     IPU. IPU support is devicetree only, so move them over to devicetree
> |     based bindings. Also, enable MIPI clocks which do not have a device
> |     associated with, but still need to be enabled to do graphics on
> |     i.MX51.
> 
> This patch fixes this by setting some reserved bits in the CCM as recommended
> in the reference manual.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Shawn

> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index e8c0473..579023f 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -319,6 +319,7 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  			unsigned long rate_ckih1, unsigned long rate_ckih2)
>  {
>  	int i;
> +	u32 val;
>  	struct device_node *np;
>  
>  	clk[pll1_sw] = imx_clk_pllv2("pll1_sw", "osc", MX51_DPLL1_BASE);
> @@ -390,6 +391,21 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  	imx_print_silicon_rev("i.MX51", mx51_revision());
>  	clk_disable_unprepare(clk[iim_gate]);
>  
> +	/*
> +	 * Reference Manual says: Functionality of CCDR[18] and CLPCR[23] is no
> +	 * longer supported. Set to one for better power saving.
> +	 *
> +	 * The effect of not setting these bits is that MIPI clocks can't be
> +	 * enabled without the IPU clock being enabled aswell.
> +	 */
> +	val = readl(MXC_CCM_CCDR);
> +	val |= 1 << 18;
> +	writel(val, MXC_CCM_CCDR);
> +
> +	val = readl(MXC_CCM_CLPCR);
> +	val |= 1 << 23;
> +	writel(val, MXC_CCM_CLPCR);
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.10.4
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
