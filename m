From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 10:11:18 +0800
Subject: [PATCH v3 1/3] ARM i.MX6: change mxs usbphy clock usage
In-Reply-To: <1358326745-25018-1-git-send-email-peter.chen@freescale.com>
References: <1358326745-25018-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130117021116.GC26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 04:59:03PM +0800, Peter Chen wrote:
> This mxs usbphy is only needs to be on after system boots
> up, and software never needs to control it anymore.
> Meanwhile, usbphy's parent needs to be notified if usb
> is suspend or not. So we design below mxs usbphy usage:
> 
> - usbphy1_gate and usbphy2_gate:
> Their parents are dummy clock, we only needs to enable
> it after system boots up.
> - usbphy1 and usbphy2
> Usage reserved bit for this clock, in that case, the refcount
> will be updated, but without hardware changing.
> 
Ok, so we change the clocks usbphy1 and ushphy2 to access a reserved bit
for gating.  Then usbphy driver can play the clocks to maintain the use
count for parent PLL, which may have other child clocks, while leaving
the actual gating control to hardware.

Meanwhile, we add new clocks usbphy1_gate and ushphy2_gate being the
children of dummy clock to accessing the real gate bit.  Then clock
initialization can call clk_prepare_enable to enable for only once.

Though I feel this is a total hack, I do not see any other better option
to fulfill the hardware requirement with the least churn to software.
So I'm fine with it.

See one minor comment below.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
> Changes for v3:
> - Add new clk for usbphy clk gate which is only used 
> at system boots up process.
> 
> Changes for v2:
> - Use reserved bit for usb phy clk control
> 
>  arch/arm/mach-imx/clk-imx6q.c |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 7f2c10c..ccb24cf 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -154,8 +154,8 @@ enum mx6q_clks {
>  	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
>  	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
>  	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
> -	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref,
> -	clk_max
> +	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
> +	usbphy2_gate, clk_max

usbphy1_gate and usbphy2_gate need to be numbered in binding doc.

Shawn

>  };
>  
>  static struct clk *clk[clk_max];
> @@ -208,8 +208,21 @@ int __init mx6q_clocks_init(void)
>  	clk[pll7_usb_host] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host","osc", base + 0x20, 0x3);
>  	clk[pll8_mlb]      = imx_clk_pllv3(IMX_PLLV3_MLB,	"pll8_mlb",	"osc", base + 0xd0, 0x0);
>  
> -	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 6);
> -	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 6);
> +	/*
> +	 * Bit 20 is the reserved and read-only bit, we do this only for:
> +	 * - Do nothing for usbphy clk_enable/disable
> +	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
> +	 * the clk framework may need to enable/disable usbphy's parent
> +	 */
> +	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 20);
> +	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 20);
> +
> +	/*
> +	 * usbphy*_gate needs to be on after system boots up, and software
> +	 * never needs to control it anymore.
> +	 */
> +	clk[usbphy1_gate] = imx_clk_gate("usbphy1_gate", "dummy", base + 0x10, 6);
> +	clk[usbphy2_gate] = imx_clk_gate("usbphy2_gate", "dummy", base + 0x20, 6);
>  
>  	clk[sata_ref] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 5);
>  	clk[pcie_ref] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 4);
> @@ -436,6 +449,11 @@ int __init mx6q_clocks_init(void)
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>  		clk_prepare_enable(clk[clks_init_on[i]]);
>  
> +	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
> +		clk_prepare_enable(clk[usbphy1_gate]);
> +		clk_prepare_enable(clk[usbphy2_gate]);
> +	}
> +
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpt");
>  	base = of_iomap(np, 0);
>  	WARN_ON(!base);
> -- 
> 1.7.0.4
> 
> 
