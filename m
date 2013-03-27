From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Mar 2013 12:57:00 +0100
Subject: [PATCH 2/2] ARM: clk: imx35 sound admux_gate bugfix
In-Reply-To: <1364383352-27267-3-git-send-email-mpa@pengutronix.de>
References: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
 <1364383352-27267-3-git-send-email-mpa@pengutronix.de>
Message-ID: <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

Am Mittwoch, den 27.03.2013, 12:22 +0100 schrieb Markus Pargmann:
> imx-ssi needs admux_gate clock to work on imx35. This patch registers
> this clock and enables it in the imx-ssi driver.

I have no idea what the admux_gate really is, but the ssi driver doesn't
seem like the right place. Isn't this more closely related to the
imx-audmux.c driver?

> A reboot without this patch results in a failing AC97 for example on
> pcm043.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/mach-imx/clk-imx25.c       |  6 ++++--
>  arch/arm/mach-imx/clk-imx27.c       |  6 ++++--
>  arch/arm/mach-imx/clk-imx31.c       |  6 ++++--
>  arch/arm/mach-imx/clk-imx35.c       |  6 ++++--
>  arch/arm/mach-imx/clk-imx51-imx53.c |  9 ++++++---
>  sound/soc/fsl/imx-ssi.c             | 16 +++++++++++++++-
>  sound/soc/fsl/imx-ssi.h             |  2 ++
>  7 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
> index 69858c7..174ff8b 100644
> --- a/arch/arm/mach-imx/clk-imx25.c
> +++ b/arch/arm/mach-imx/clk-imx25.c
> @@ -285,8 +285,10 @@ int __init mx25_clocks_init(void)
>  	clk_register_clkdev(clk[lcdc_ipg], "ipg", "imx21-fb.0");
>  	clk_register_clkdev(clk[lcdc_ahb], "ahb", "imx21-fb.0");
>  	clk_register_clkdev(clk[wdt_ipg], NULL, "imx2-wdt.0");
> -	clk_register_clkdev(clk[ssi1_ipg], NULL, "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi2_ipg], NULL, "imx-ssi.1");
> +	clk_register_clkdev(clk[ssi1_ipg], "ipg", "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi2_ipg], "ipg", "imx-ssi.1");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.0");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.1");
>  	clk_register_clkdev(clk[esdhc1_ipg_per], "per", "sdhci-esdhc-imx25.0");
>  	clk_register_clkdev(clk[esdhc1_ipg], "ipg", "sdhci-esdhc-imx25.0");
>  	clk_register_clkdev(clk[esdhc1_ahb], "ahb", "sdhci-esdhc-imx25.0");
> diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
> index 30b3242..439d5bd 100644
> --- a/arch/arm/mach-imx/clk-imx27.c
> +++ b/arch/arm/mach-imx/clk-imx27.c
> @@ -252,8 +252,10 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.2");
> -	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
> +	clk_register_clkdev(clk[ssi1_ipg_gate], "ipg", "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi2_ipg_gate], "ipg", "imx-ssi.1");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.0");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.1");
>  	clk_register_clkdev(clk[nfc_baud_gate], NULL, "imx27-nand.0");
>  	clk_register_clkdev(clk[vpu_baud_gate], "per", "coda-imx27.0");
>  	clk_register_clkdev(clk[vpu_ahb_gate], "ahb", "coda-imx27.0");
> diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
> index b5b65f3..478b33e 100644
> --- a/arch/arm/mach-imx/clk-imx31.c
> +++ b/arch/arm/mach-imx/clk-imx31.c
> @@ -171,8 +171,10 @@ int __init mx31_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1.0");
>  	clk_register_clkdev(clk[sdhc1_gate], NULL, "imx31-mmc.0");
>  	clk_register_clkdev(clk[sdhc2_gate], NULL, "imx31-mmc.1");
> -	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
> +	clk_register_clkdev(clk[ssi1_gate], "ipg", "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi2_gate], "ipg", "imx-ssi.1");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.0");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.1");
>  	clk_register_clkdev(clk[firi_gate], "firi", NULL);
>  	clk_register_clkdev(clk[ata_gate], NULL, "pata_imx");
>  	clk_register_clkdev(clk[rtic_gate], "rtic", NULL);
> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index b95898a..4ab18ac 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -233,8 +233,10 @@ int __init mx35_clocks_init(void)
>  	clk_register_clkdev(clk[kpp_gate], NULL, "imx-keypad");
>  	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1");
>  	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
> -	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
> +	clk_register_clkdev(clk[ssi1_gate], "ipg", "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi2_gate], "ipg", "imx-ssi.1");
> +	clk_register_clkdev(clk[admux_gate], "admux", "imx-ssi.0");
> +	clk_register_clkdev(clk[admux_gate], "admux", "imx-ssi.1");
>  	/* i.mx35 has the i.mx21 type uart */
>  	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.0");
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 0f39f8c..b413a1e 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -275,9 +275,12 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_register_clkdev(clk[usboh3_gate], "ipg", "imx-udc-mx51");
>  	clk_register_clkdev(clk[usboh3_gate], "ahb", "imx-udc-mx51");
>  	clk_register_clkdev(clk[nfc_gate], NULL, "imx51-nand");
> -	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
> -	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
> +	clk_register_clkdev(clk[ssi1_ipg_gate], "ipg", "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi2_ipg_gate], "ipg", "imx-ssi.1");
> +	clk_register_clkdev(clk[ssi3_ipg_gate], "ipg", "imx-ssi.2");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.0");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.1");
> +	clk_register_clkdev(clk[dummy], "admux", "imx-ssi.2");

I think those should be removed completely. If really needed, it should
rather be added to the device tree for i.MX5:

--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -162,7 +162,8 @@
                                        compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
                                        reg = <0x50014000 0x4000>;
                                        interrupts = <30>;
-                                       clocks = <&clks 49>;
+                                       clocks = <&clks 49>, <&clks 0>;
+                                       clock-names = "ipg", "admux";
                                        fsl,fifo-depth = <15>;
                                        fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
                                        status = "disabled";
@@ -791,7 +792,8 @@
                                compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
                                reg = <0x63fcc000 0x4000>;
                                interrupts = <29>;
-                               clocks = <&clks 48>;
+                               clocks = <&clks 48>, <&clks 0>;
+                               clock-names = "ipg", "admux";
                                fsl,fifo-depth = <15>;
                                fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
                                status = "disabled";
@@ -815,7 +817,8 @@
                                compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
                                reg = <0x63fe8000 0x4000>;
                                interrupts = <96>;
-                               clocks = <&clks 50>;
+                               clocks = <&clks 50>, <&clks 0>;
+                               clock-names = "ipg", "admux";
                                fsl,fifo-depth = <15>;
                                fsl,ssi-dma-events = <47 46 45 44>; /* TX0 RX0 TX1 RX1 */
                                status = "disabled";

But again, I'm not convinced the ssi driver is the right place to enable
the "admux" gate.

>  	clk_register_clkdev(clk[ssi_ext1_gate], "ssi_ext1", NULL);
>  	clk_register_clkdev(clk[ssi_ext2_gate], "ssi_ext2", NULL);
>  	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index 55464a5..9f96785 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -535,7 +535,7 @@ static int imx_ssi_probe(struct platform_device *pdev)
>  
>  	ssi->irq = platform_get_irq(pdev, 0);
>  
> -	ssi->clk = devm_clk_get(&pdev->dev, NULL);
> +	ssi->clk = devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(ssi->clk)) {
>  		ret = PTR_ERR(ssi->clk);
>  		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
> @@ -544,6 +544,15 @@ static int imx_ssi_probe(struct platform_device *pdev)
>  	}
>  	clk_prepare_enable(ssi->clk);
>  
> +	ssi->admux_clk = devm_clk_get(&pdev->dev, "admux");
> +	if (IS_ERR(ssi->admux_clk)) {
> +		if (PTR_ERR(ssi->admux_clk) == -ENOMEM)
> +			goto failed_admux_clk_mem;
> +		ssi->admux_clk = NULL;
> +	} else {
> +		clk_prepare_enable(ssi->admux_clk);
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		ret = -ENODEV;
> @@ -631,6 +640,9 @@ failed_pdev_fiq_alloc:
>  failed_register:
>  	release_mem_region(res->start, resource_size(res));
>  failed_get_resource:
> +	if (ssi->admux_clk)
> +		clk_disable_unprepare(ssi->admux_clk);
> +failed_admux_clk_mem:
>  	clk_disable_unprepare(ssi->clk);
>  failed_clk:
>  
> @@ -652,6 +664,8 @@ static int imx_ssi_remove(struct platform_device *pdev)
>  
>  	release_mem_region(res->start, resource_size(res));
>  	clk_disable_unprepare(ssi->clk);
> +	if (ssi->admux_clk)
> +		clk_disable_unprepare(ssi->admux_clk);
>  
>  	return 0;
>  }
> diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
> index dc114bd..3dfbd92 100644
> --- a/sound/soc/fsl/imx-ssi.h
> +++ b/sound/soc/fsl/imx-ssi.h
> @@ -194,6 +194,8 @@ struct imx_ssi {
>  
>  	struct snd_soc_dai *imx_ac97;
>  	struct clk *clk;
> +	/* imx35 has a admux clock that has to be active for sound to work */
> +	struct clk *admux_clk;
>  	void __iomem *base;
>  	int irq;
>  	int fiq_enable;

regards
Philipp
