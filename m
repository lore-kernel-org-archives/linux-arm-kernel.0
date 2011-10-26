From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 26 Oct 2011 09:47:05 +0200
Subject: [PATCH] ARM: mx5: Use CLKDEV_INIT for creating clk_lookup instance
In-Reply-To: <1319111391-27820-1-git-send-email-padma.v@samsung.com>
References: <1319111391-27820-1-git-send-email-padma.v@samsung.com>
Message-ID: <20111026074705.GD2263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 05:19:51PM +0530, Padmavathi Venna wrote:
> A common macro CLKDEV_INIT was added for creating clk_lookup
> instance in include/linux/clkdev.h. So replace _REGISTER_CLOCK
> macro with CLKDEV_INIT.

The patches are fine this way. Let's wait until the trees from next are
merged. It's not necessary to risk merge conflicts for this cleanup.

Sascha

> 
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Amit Kucheria <amit.kucheria@canonical.com>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c |  149 +++++++++++++++++------------------
>  1 files changed, 71 insertions(+), 78 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 2b9bd1f..d198515 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1422,97 +1422,90 @@ DEFINE_CLOCK(ipu_di1_clk, 0, MXC_CCM_CCGR6, MXC_CCM_CCGRx_CG6_OFFSET,
>  DEFINE_CLOCK(pata_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG0_OFFSET,
>  		NULL, NULL, &ipg_clk, &spba_clk);
>  
> -#define _REGISTER_CLOCK(d, n, c) \
> -       { \
> -		.dev_id = d, \
> -		.con_id = n, \
> -		.clk = &c,   \
> -       },
> -
>  static struct clk_lookup mx51_lookups[] = {
>  	/* i.mx51 has the i.mx21 type uart */
> -	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
> -	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
> -	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
> -	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
> +	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
> +	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
> +	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
> +	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
>  	/* i.mx51 has the i.mx27 type fec */
> -	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
> -	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
> -	_REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
> -	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
> -	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
> -	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_ahb_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", usb_phy1_clk)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_ahb_clk)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb", usboh3_clk)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_ahb_clk)
> -	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
> -	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
> -	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
> -	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
> -	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
> -	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
> -	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
> +	CLKDEV_INIT("imx27-fec.0", NULL, &fec_clk),
> +	CLKDEV_INIT("mxc_pwm.0", "pwm", &pwm1_clk),
> +	CLKDEV_INIT("mxc_pwm.1", "pwm", &pwm2_clk),
> +	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
> +	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
> +	CLKDEV_INIT("imx-i2c.2", NULL, &hsi2c_clk),
> +	CLKDEV_INIT("mxc-ehci.0", "usb", &usboh3_clk),
> +	CLKDEV_INIT("mxc-ehci.0", "usb_ahb", &usb_ahb_clk),
> +	CLKDEV_INIT("mxc-ehci.0", "usb_phy1", &usb_phy1_clk),
> +	CLKDEV_INIT("mxc-ehci.1", "usb", &usboh3_clk),
> +	CLKDEV_INIT("mxc-ehci.1", "usb_ahb", &usb_ahb_clk),
> +	CLKDEV_INIT("mxc-ehci.2", "usb", &usboh3_clk),
> +	CLKDEV_INIT("mxc-ehci.2", "usb_ahb", &usb_ahb_clk),
> +	CLKDEV_INIT("fsl-usb2-udc", "usb", &usboh3_clk),
> +	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &ahb_clk),
> +	CLKDEV_INIT("imx-keypad", NULL, &dummy_clk),
> +	CLKDEV_INIT("mxc_nand", NULL, &nfc_clk),
> +	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
> +	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
> +	CLKDEV_INIT("imx-ssi.2", NULL, &ssi3_clk),
>  	/* i.mx51 has the i.mx35 type sdma */
> -	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
> -	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
> -	_REGISTER_CLOCK(NULL, "ckih2", ckih2_clk)
> -	_REGISTER_CLOCK(NULL, "gpt_32k", gpt_32k_clk)
> -	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
> -	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
> +	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
> +	CLKDEV_INIT(NULL, "ckih", &ckih_clk),
> +	CLKDEV_INIT(NULL, "ckih2", &ckih2_clk),
> +	CLKDEV_INIT(NULL, "gpt_32k", &gpt_32k_clk),
> +	CLKDEV_INIT("imx51-ecspi.0", NULL, &ecspi1_clk),
> +	CLKDEV_INIT("imx51-ecspi.1", NULL, &ecspi2_clk),
>  	/* i.mx51 has the i.mx35 type cspi */
> -	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx51.0", NULL, esdhc1_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx51.1", NULL, esdhc2_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx51.2", NULL, esdhc3_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx51.3", NULL, esdhc4_clk)
> -	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
> -	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
> -	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
> -	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> -	_REGISTER_CLOCK(NULL, "mipi_hsp", mipi_hsp_clk)
> -	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
> -	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
> -	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
> -	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
> -	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
> +	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx51.0", NULL, &esdhc1_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx51.1", NULL, &esdhc2_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx51.2", NULL, &esdhc3_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx51.3", NULL, &esdhc4_clk),
> +	CLKDEV_INIT(NULL, "cpu_clk", &cpu_clk),
> +	CLKDEV_INIT(NULL, "iim_clk", &iim_clk),
> +	CLKDEV_INIT("imx2-wdt.0", NULL, &dummy_clk),
> +	CLKDEV_INIT("imx2-wdt.1", NULL, &dummy_clk),
> +	CLKDEV_INIT(NULL, "mipi_hsp", &mipi_hsp_clk),
> +	CLKDEV_INIT("imx-ipuv3", NULL, &ipu_clk),
> +	CLKDEV_INIT("imx-ipuv3", "di0", &ipu_di0_clk),
> +	CLKDEV_INIT("imx-ipuv3", "di1", &ipu_di1_clk),
> +	CLKDEV_INIT(NULL, "gpc_dvfs", &gpc_dvfs_clk),
> +	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
>  };
>  
>  static struct clk_lookup mx53_lookups[] = {
>  	/* i.mx53 has the i.mx21 type uart */
> -	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
> -	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
> -	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
> -	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
> -	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
> -	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
> +	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
> +	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
> +	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
> +	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
> +	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
> +	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
>  	/* i.mx53 has the i.mx25 type fec */
> -	_REGISTER_CLOCK("imx25-fec.0", NULL, fec_clk)
> -	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
> -	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
> -	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
> -	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_mx53_clk)
> +	CLKDEV_INIT("imx25-fec.0", NULL, &fec_clk),
> +	CLKDEV_INIT(NULL, "iim_clk", &iim_clk),
> +	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
> +	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
> +	CLKDEV_INIT("imx-i2c.2", NULL, &i2c3_mx53_clk),
>  	/* i.mx53 has the i.mx51 type ecspi */
> -	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
> -	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
> +	CLKDEV_INIT("imx51-ecspi.0", NULL, &ecspi1_clk),
> +	CLKDEV_INIT("imx51-ecspi.1", NULL, &ecspi2_clk),
>  	/* i.mx53 has the i.mx25 type cspi */
> -	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx53.0", NULL, esdhc1_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx53.1", NULL, esdhc2_mx53_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx53.2", NULL, esdhc3_mx53_clk)
> -	_REGISTER_CLOCK("sdhci-esdhc-imx53.3", NULL, esdhc4_mx53_clk)
> -	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
> -	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> +	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx53.0", NULL, &esdhc1_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx53.1", NULL, &esdhc2_mx53_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx53.2", NULL, &esdhc3_mx53_clk),
> +	CLKDEV_INIT("sdhci-esdhc-imx53.3", NULL, &esdhc4_mx53_clk),
> +	CLKDEV_INIT("imx2-wdt.0", NULL, &dummy_clk),
> +	CLKDEV_INIT("imx2-wdt.1", NULL, &dummy_clk),
>  	/* i.mx53 has the i.mx35 type sdma */
> -	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
> -	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
> -	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
> -	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
> -	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
> -	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
> +	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
> +	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
> +	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
> +	CLKDEV_INIT("imx-ssi.2", NULL, &ssi3_clk),
> +	CLKDEV_INIT("imx-keypad", NULL, &dummy_clk),
> +	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
>  };
>  
>  static void clk_tree_init(void)
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
