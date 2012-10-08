From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 8 Oct 2012 16:33:59 -0300
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20ARM=3A=20imx=3A=20clk=3A=20Split=20SSI=20clock=20into=20=27ipg=27=20and=20=27per=27?=
Message-ID: <1349724840-10466-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently imx ssi driver has been using only the ipg clock as only slave mode
is supported.

For mx27 it is necessay to provide both 'ipg' and 'per' clocks in order to get
ssi functional.

This issue was found on mx27 by unselecting the mmc driver from the kernel
,which resulted on a system that could not play audio.

When the mmc driver is selected the required 'per2' clock is provided and it 
allows the ssi to work.

Add the required 'per' clock to the mx27 ssi and a dummy one for the other SoCs.

Reported-by: Ga?tan Carlier <gcembed@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx21.c       |   11 +++++++----
 arch/arm/mach-imx/clk-imx25.c       |    6 ++++--
 arch/arm/mach-imx/clk-imx27.c       |    9 +++++----
 arch/arm/mach-imx/clk-imx31.c       |   11 +++++++----
 arch/arm/mach-imx/clk-imx35.c       |   12 ++++++++----
 arch/arm/mach-imx/clk-imx51-imx53.c |   19 +++++++++++++------
 6 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index cf65148..2ed49c8 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -51,8 +51,8 @@ static const char *mpll_sel_clks[] = { "fpm", "ckih", };
 static const char *spll_sel_clks[] = { "fpm", "ckih", };
 
 enum imx21_clks {
-	ckil, ckih, fpm, mpll_sel, spll_sel, mpll, spll, fclk, hclk, ipg, per1,
-	per2, per3, per4, uart1_ipg_gate, uart2_ipg_gate, uart3_ipg_gate,
+	dummy, ckil, ckih, fpm, mpll_sel, spll_sel, mpll, spll, fclk, hclk, ipg,
+	per1, per2, per3, per4, uart1_ipg_gate, uart2_ipg_gate, uart3_ipg_gate,
 	uart4_ipg_gate, gpt1_ipg_gate, gpt2_ipg_gate, gpt3_ipg_gate,
 	pwm_ipg_gate, sdhc1_ipg_gate, sdhc2_ipg_gate, lcdc_ipg_gate,
 	lcdc_hclk_gate, cspi3_ipg_gate, cspi2_ipg_gate, cspi1_ipg_gate,
@@ -72,6 +72,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 {
 	int i;
 
+	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckil] = imx_clk_fixed("ckil", lref);
 	clk[ckih] = imx_clk_fixed("ckih", href);
 	clk[fpm] = imx_clk_fixed_factor("fpm", "ckil", 512, 1);
@@ -174,8 +175,10 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[gpio_gate], "gpio", NULL);
 	clk_register_clkdev(clk[rtc_gate], "rtc", NULL);
 	clk_register_clkdev(clk[csi_hclk_gate], "csi", NULL);
-	clk_register_clkdev(clk[ssi1_gate], "ssi1", NULL);
-	clk_register_clkdev(clk[ssi2_gate], "ssi2", NULL);
+	clk_register_clkdev(clk[ssi1_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[ssi2_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.1");
 	clk_register_clkdev(clk[sdhc1_ipg_gate], "sdhc1", NULL);
 	clk_register_clkdev(clk[sdhc2_ipg_gate], "sdhc2", NULL);
 
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index d20d479..c81864d 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -222,8 +222,10 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[lcdc_ipg], "ipg", "imx-fb.0");
 	clk_register_clkdev(clk[lcdc_ahb], "ahb", "imx-fb.0");
 	clk_register_clkdev(clk[wdt_ipg], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[ssi1_ipg], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_ipg], NULL, "imx-ssi.1");
+	clk_register_clkdev(clk[ssi1_ipg], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[ssi2_ipg], "ipg", "imx-ssi.1");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.1");
 	clk_register_clkdev(clk[esdhc1_ipg_per], "per", "sdhci-esdhc-imx25.0");
 	clk_register_clkdev(clk[esdhc1_ipg], "ipg", "sdhci-esdhc-imx25.0");
 	clk_register_clkdev(clk[esdhc1_ahb], "ahb", "sdhci-esdhc-imx25.0");
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 3b6b640..453b4f3 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -224,6 +224,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[lcdc_ipg_gate], "ipg", "imx-fb.0");
 	clk_register_clkdev(clk[lcdc_ahb_gate], "ahb", "imx-fb.0");
 	clk_register_clkdev(clk[csi_ahb_gate], "ahb", "mx2-camera.0");
+	clk_register_clkdev(clk[per4_gate], "per", "mx2-camera.0");
 	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "fsl-usb2-udc");
@@ -236,8 +237,10 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
+	clk_register_clkdev(clk[ssi1_ipg_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[ssi2_ipg_gate], "ipg", "imx-ssi.1");
+	clk_register_clkdev(clk[per2_gate], "per", "imx-ssi.0");
+	clk_register_clkdev(clk[per2_gate], "per", "imx-ssi.1");
 	clk_register_clkdev(clk[nfc_baud_gate], NULL, "mxc_nand.0");
 	clk_register_clkdev(clk[vpu_baud_gate], "per", "coda-imx27.0");
 	clk_register_clkdev(clk[vpu_ahb_gate], "ahb", "coda-imx27.0");
@@ -262,8 +265,6 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
 	clk_register_clkdev(clk[cpu_div], "cpu", NULL);
 	clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);
-	clk_register_clkdev(clk[ssi1_baud_gate], "bitrate" , "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_baud_gate], "bitrate" , "imx-ssi.1");
 
 	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 1253af2..a653ecf 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -35,8 +35,8 @@ static const char *csi_sel[] = { "upll", "spll", };
 static const char *fir_sel[] = { "mcu_main", "upll", "spll" };
 
 enum mx31_clks {
-	ckih, ckil, mpll, spll, upll, mcu_main, hsp, ahb, nfc, ipg, per_div,
-	per, csi, fir, csi_div, usb_div_pre, usb_div_post, fir_div_pre,
+	dummy, ckih, ckil, mpll, spll, upll, mcu_main, hsp, ahb, nfc, ipg,
+	per_div, per, csi, fir, csi_div, usb_div_pre, usb_div_post, fir_div_pre,
 	fir_div_post, sdhc1_gate, sdhc2_gate, gpt_gate, epit1_gate, epit2_gate,
 	iim_gate, ata_gate, sdma_gate, cspi3_gate, rng_gate, uart1_gate,
 	uart2_gate, ssi1_gate, i2c1_gate, i2c2_gate, i2c3_gate, hantro_gate,
@@ -53,6 +53,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	void __iomem *base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
 	int i;
 
+	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
 	clk[ckil] = imx_clk_fixed("ckil", 32768);
 	clk[mpll] = imx_clk_pllv1("mpll", "ckih", base + MXC_CCM_MPCTL);
@@ -161,8 +162,10 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1.0");
 	clk_register_clkdev(clk[sdhc1_gate], NULL, "mxc-mmc.0");
 	clk_register_clkdev(clk[sdhc2_gate], NULL, "mxc-mmc.1");
-	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
+	clk_register_clkdev(clk[ssi1_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[ssi2_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.1");
 	clk_register_clkdev(clk[firi_gate], "firi", NULL);
 	clk_register_clkdev(clk[ata_gate], NULL, "pata_imx");
 	clk_register_clkdev(clk[rtic_gate], "rtic", NULL);
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 177259b..0d952c7 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -50,7 +50,7 @@ static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
 enum mx35_clks {
-	ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
+	dummy, ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
 	arm_per_div, ahb_per_div, ipg_per, uart_sel, uart_div, esdhc_sel,
 	esdhc1_div, esdhc2_div, esdhc3_div, spdif_sel, spdif_div_pre,
 	spdif_div_post, ssi_sel, ssi1_div_pre, ssi1_div_post, ssi2_div_pre,
@@ -87,7 +87,8 @@ int __init mx35_clocks_init()
 		 */
 		aad = &clk_consumer[0];
 	}
-
+
+	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", 24000000);
 	clk[mpll] = imx_clk_pllv1("mpll", "ckih", base + MX35_CCM_MPCTL);
 	clk[ppll] = imx_clk_pllv1("ppll", "ckih", base + MX35_CCM_PPCTL);
@@ -234,8 +235,11 @@ int __init mx35_clocks_init()
 	clk_register_clkdev(clk[kpp_gate], NULL, "imx-keypad");
 	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1");
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
-	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
+	clk_register_clkdev(clk[ssi1_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[ssi2_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.1");
+
 	/* i.mx35 has the i.mx21 type uart */
 	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
 	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.0");
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index a0bf848..46d679c 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -273,9 +273,12 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[usboh3_gate], "ipg", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usboh3_gate], "ahb", "fsl-usb2-udc");
 	clk_register_clkdev(clk[nfc_gate], NULL, "mxc_nand");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
-	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
+	clk_register_clkdev(clk[ssi1_ipg_gate], "ipg", "imx-ssi.0");
+	clk_register_clkdev(clk[ssi2_ipg_gate], "ipg", "imx-ssi.1");
+	clk_register_clkdev(clk[ssi3_ipg_gate], "ipg", "imx-ssi.2");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.0");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.1");
+	clk_register_clkdev(clk[dummy], "per", "imx-ssi.2");
 	clk_register_clkdev(clk[ssi_ext1_gate], "ssi_ext1", NULL);
 	clk_register_clkdev(clk[ssi_ext2_gate], "ssi_ext2", NULL);
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
@@ -366,9 +369,13 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[esdhc4_ipg_gate], "ipg", "sdhci-esdhc-imx51.3");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx51.3");
 	clk_register_clkdev(clk[esdhc4_per_gate], "per", "sdhci-esdhc-imx51.3");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "83fcc000.ssi");
-	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "70014000.ssi");
-	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "83fe8000.ssi");
+	clk_register_clkdev(clk[ssi1_ipg_gate], "ipg", "83fcc000.ssi");
+	clk_register_clkdev(clk[ssi2_ipg_gate], "ipg", "70014000.ssi");
+	clk_register_clkdev(clk[ssi3_ipg_gate], "ipg", "83fe8000.ssi");
+	clk_register_clkdev(clk[dummy], "per", "83fcc000.ssi");
+	clk_register_clkdev(clk[dummy], "per", "70014000.ssi");
+	clk_register_clkdev(clk[dummy], "per", "83fe8000.ssi");
+
 	clk_register_clkdev(clk[nfc_gate], NULL, "83fdb000.nand");
 
 	/* set the usboh3 parent to pll2_sw */
-- 
1.7.9.5
