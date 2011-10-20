From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 20 Oct 2011 17:17:32 +0530
Subject: [PATCH] ARM: imx: Use CLKDEV_INIT for creating clk_lookup instance
Message-ID: <1319111252-27748-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common macro CLKDEV_INIT was added for creating clk_lookup
instance in include/linux/clkdev.h. So replace _REGISTER_CLOCK macro
with CLKDEV_INIT.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-imx/clock-imx1.c  |   38 +++++-------
 arch/arm/mach-imx/clock-imx21.c |   91 ++++++++++++++----------------
 arch/arm/mach-imx/clock-imx25.c |   79 ++++++++++++--------------
 arch/arm/mach-imx/clock-imx27.c |  111 +++++++++++++++++--------------------
 arch/arm/mach-imx/clock-imx31.c |  103 ++++++++++++++++------------------
 arch/arm/mach-imx/clock-imx35.c |  117 ++++++++++++++++++--------------------
 6 files changed, 249 insertions(+), 290 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
index 4aabeb2..8bdcfa2 100644
--- a/arch/arm/mach-imx/clock-imx1.c
+++ b/arch/arm/mach-imx/clock-imx1.c
@@ -575,29 +575,23 @@ static struct clk rtc_clk = {
 	.parent = &clk32,
 };
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
 static struct clk_lookup lookups[] __initdata = {
-	_REGISTER_CLOCK(NULL, "dma", dma_clk)
-	_REGISTER_CLOCK("mx1-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK(NULL, "mma", mma_clk)
-	_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
-	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
-	_REGISTER_CLOCK("imx1-uart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("imx1-uart.1", NULL, uart_clk)
-	_REGISTER_CLOCK("imx1-uart.2", NULL, uart_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
-	_REGISTER_CLOCK("imx1-cspi.1", NULL, spi_clk)
-	_REGISTER_CLOCK("imx-mmc.0", NULL, sdhc_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
-	_REGISTER_CLOCK(NULL, "ssi", ssi_clk)
-	_REGISTER_CLOCK("mxc_rtc.0", NULL, rtc_clk)
+	CLKDEV_INIT(NULL, "dma", &dma_clk),
+	CLKDEV_INIT("mx1-camera.0", NULL, &csi_clk),
+	CLKDEV_INIT(NULL, "mma", &mma_clk),
+	CLKDEV_INIT("imx_udc.0", NULL, &usbd_clk),
+	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
+	CLKDEV_INIT("imx1-uart.0", NULL, &uart_clk),
+	CLKDEV_INIT("imx1-uart.1", NULL, &uart_clk),
+	CLKDEV_INIT("imx1-uart.2", NULL, &uart_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c_clk),
+	CLKDEV_INIT("imx1-cspi.0", NULL, &spi_clk),
+	CLKDEV_INIT("imx1-cspi.1", NULL, &spi_clk),
+	CLKDEV_INIT("imx-mmc.0", NULL, &sdhc_clk),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk),
+	CLKDEV_INIT(NULL, "mshc", &mshc_clk),
+	CLKDEV_INIT(NULL, "ssi", &ssi_clk),
+	CLKDEV_INIT("mxc_rtc.0", NULL, &rtc_clk),
 };
 
 int __init mx1_clocks_init(unsigned long fref)
diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
index ee15d8c..2a7747d 100644
--- a/arch/arm/mach-imx/clock-imx21.c
+++ b/arch/arm/mach-imx/clock-imx21.c
@@ -1139,58 +1139,51 @@ static struct clk clko_clk = {
 	.set_parent = _clk_clko_set_parent,
 };
 
-
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
 static struct clk_lookup lookups[] = {
 /* It's unlikely that any driver wants one of them directly:
-	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
-	_REGISTER_CLOCK(NULL, "ckil", ckil_clk)
-	_REGISTER_CLOCK(NULL, "fpm", fpm_clk)
-	_REGISTER_CLOCK(NULL, "mpll", mpll_clk)
-	_REGISTER_CLOCK(NULL, "spll", spll_clk)
-	_REGISTER_CLOCK(NULL, "fclk", fclk_clk)
-	_REGISTER_CLOCK(NULL, "hclk", hclk_clk)
-	_REGISTER_CLOCK(NULL, "ipg", ipg_clk)
+	CLKDEV_INIT(NULL, "ckih", &ckih_clk),
+	CLKDEV_INIT(NULL, "ckil", &ckil_clk),
+	CLKDEV_INIT(NULL, "fpm", &fpm_clk),
+	CLKDEV_INIT(NULL, "mpll", &mpll_clk),
+	CLKDEV_INIT(NULL, "spll", &spll_clk),
+	CLKDEV_INIT(NULL, "fclk", &fclk_clk),
+	CLKDEV_INIT(NULL, "hclk", &hclk_clk),
+	CLKDEV_INIT(NULL, "ipg", &ipg_clk),
 */
-	_REGISTER_CLOCK(NULL, "perclk1", per_clk[0])
-	_REGISTER_CLOCK(NULL, "perclk2", per_clk[1])
-	_REGISTER_CLOCK(NULL, "perclk3", per_clk[2])
-	_REGISTER_CLOCK(NULL, "perclk4", per_clk[3])
-	_REGISTER_CLOCK(NULL, "clko", clko_clk)
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart_clk[0])
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart_clk[1])
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart_clk[2])
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart_clk[3])
-	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[0])
-	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[1])
-	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[2])
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk[0])
-	_REGISTER_CLOCK(NULL, "sdhc1", sdhc_clk[0])
-	_REGISTER_CLOCK(NULL, "sdhc2", sdhc_clk[1])
-	_REGISTER_CLOCK("imx21-cspi.0", NULL, cspi_clk[0])
-	_REGISTER_CLOCK("imx21-cspi.1", NULL, cspi_clk[1])
-	_REGISTER_CLOCK("imx21-cspi.2", NULL, cspi_clk[2])
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk[0])
-	_REGISTER_CLOCK(NULL, "csi", csi_clk[0])
-	_REGISTER_CLOCK("imx21-hcd.0", NULL, usb_clk[0])
-	_REGISTER_CLOCK(NULL, "ssi1", ssi_clk[0])
-	_REGISTER_CLOCK(NULL, "ssi2", ssi_clk[1])
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK(NULL, "dma", dma_clk[0])
-	_REGISTER_CLOCK(NULL, "brom", brom_clk)
-	_REGISTER_CLOCK(NULL, "emma", emma_clk[0])
-	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk[0])
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
-	_REGISTER_CLOCK(NULL, "owire", owire_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
+	CLKDEV_INIT(NULL, "perclk1", &per_clk[0]),
+	CLKDEV_INIT(NULL, "perclk2", &per_clk[1]),
+	CLKDEV_INIT(NULL, "perclk3", &per_clk[2]),
+	CLKDEV_INIT(NULL, "perclk4", &per_clk[3]),
+	CLKDEV_INIT(NULL, "clko", &clko_clk),
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart_clk[0]),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart_clk[1]),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart_clk[2]),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart_clk[3]),
+	CLKDEV_INIT(NULL, "gpt1", &gpt_clk[0]),
+	CLKDEV_INIT(NULL, "gpt1", &gpt_clk[1]),
+	CLKDEV_INIT(NULL, "gpt1", &gpt_clk[2]),
+	CLKDEV_INIT(NULL, "pwm", &pwm_clk[0]),
+	CLKDEV_INIT(NULL, "sdhc1", &sdhc_clk[0]),
+	CLKDEV_INIT(NULL, "sdhc2", &sdhc_clk[1]),
+	CLKDEV_INIT("imx21-cspi.0", NULL, &cspi_clk[0]),
+	CLKDEV_INIT("imx21-cspi.1", NULL, &cspi_clk[1]),
+	CLKDEV_INIT("imx21-cspi.2", NULL, &cspi_clk[2]),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk[0]),
+	CLKDEV_INIT(NULL, "csi", &csi_clk[0]),
+	CLKDEV_INIT("imx21-hcd.0", NULL, &usb_clk[0]),
+	CLKDEV_INIT(NULL, "ssi1", &ssi_clk[0]),
+	CLKDEV_INIT(NULL, "ssi2", &ssi_clk[1]),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
+	CLKDEV_INIT(NULL, "dma", &dma_clk[0]),
+	CLKDEV_INIT(NULL, "brom", &brom_clk),
+	CLKDEV_INIT(NULL, "emma", &emma_clk[0]),
+	CLKDEV_INIT(NULL, "slcdc", &slcdc_clk[0]),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c_clk),
+	CLKDEV_INIT("mxc-keypad", NULL, &kpp_clk),
+	CLKDEV_INIT(NULL, "owire", &owire_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
 };
 
 /*
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index b0fec74c..85508f4 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -265,53 +265,46 @@ DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(iim_clk,    0, CCM_CGCR1, 26, NULL, NULL, NULL);
 
-#define _REGISTER_CLOCK(d, n, c)	\
-	{				\
-		.dev_id = d,		\
-		.con_id = n,		\
-		.clk = &c,		\
-	},
-
 static struct clk_lookup lookups[] = {
 	/* i.mx25 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
+	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usbotg_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
 	/* i.mx25 has the i.mx35 type cspi */
-	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx35-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx35-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
-	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
-	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
-	_REGISTER_CLOCK("mxc_pwm.3", NULL, pwm4_clk)
-	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
-	_REGISTER_CLOCK("mx25-adc", NULL, tsc_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx25-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdt_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx25.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx25.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
-	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
-	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
+	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx35-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT("imx35-cspi.2", NULL, &cspi3_clk),
+	CLKDEV_INIT("mxc_pwm.0", NULL, &pwm1_clk),
+	CLKDEV_INIT("mxc_pwm.1", NULL, &pwm2_clk),
+	CLKDEV_INIT("mxc_pwm.2", NULL, &pwm3_clk),
+	CLKDEV_INIT("mxc_pwm.3", NULL, &pwm4_clk),
+	CLKDEV_INIT("imx-keypad", NULL, &kpp_clk),
+	CLKDEV_INIT("mx25-adc", NULL, &tsc_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &i2c_clk),
+	CLKDEV_INIT("imx25-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT("imxdi_rtc.0", NULL, &dryice_clk),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdt_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx25.0", NULL, &esdhc1_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx25.1", NULL, &esdhc2_clk),
+	CLKDEV_INIT("mx2-camera.0", NULL, &csi_clk),
+	CLKDEV_INIT(NULL, "audmux", &audmux_clk),
+	CLKDEV_INIT("flexcan.0", NULL, &can1_clk),
+	CLKDEV_INIT("flexcan.1", NULL, &can2_clk),
 	/* i.mx25 has the i.mx35 type sdma */
-	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
+	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
 };
 
 int __init mx25_clocks_init(void)
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 88fe00a..940a8cb 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -616,67 +616,60 @@ DEFINE_CLOCK(uart6_clk,    5, NULL,   0, NULL, &uart6_clk1, &per1_clk);
 DEFINE_CLOCK1(lcdc_clk,    0, NULL,   0, parent, &lcdc_clk1, &per3_clk);
 DEFINE_CLOCK1(csi_clk,     0, NULL,   0, parent, &csi_clk1, &per4_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
 	/* i.mx27 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("imx21-uart.5", NULL, uart6_clk)
-	_REGISTER_CLOCK(NULL, "gpt1", gpt1_clk)
-	_REGISTER_CLOCK(NULL, "gpt2", gpt2_clk)
-	_REGISTER_CLOCK(NULL, "gpt3", gpt3_clk)
-	_REGISTER_CLOCK(NULL, "gpt4", gpt4_clk)
-	_REGISTER_CLOCK(NULL, "gpt5", gpt5_clk)
-	_REGISTER_CLOCK(NULL, "gpt6", gpt6_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
-	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
-	_REGISTER_CLOCK("mxc-mmc.2", NULL, sdhc3_clk)
-	_REGISTER_CLOCK("imx27-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx27-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx27-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK(NULL, "vpu", vpu_clk)
-	_REGISTER_CLOCK(NULL, "dma", dma_clk)
-	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
-	_REGISTER_CLOCK(NULL, "brom", brom_clk)
-	_REGISTER_CLOCK(NULL, "emma", emma_clk)
-	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk)
-	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK(NULL, "sahara2", sahara2_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
-	_REGISTER_CLOCK(NULL, "mstick", mstick_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
-	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
-	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
-	_REGISTER_CLOCK(NULL, "scc", scc_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
+	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
+	CLKDEV_INIT("imx21-uart.5", NULL, &uart6_clk),
+	CLKDEV_INIT(NULL, "gpt1", &gpt1_clk),
+	CLKDEV_INIT(NULL, "gpt2", &gpt2_clk),
+	CLKDEV_INIT(NULL, "gpt3", &gpt3_clk),
+	CLKDEV_INIT(NULL, "gpt4", &gpt4_clk),
+	CLKDEV_INIT(NULL, "gpt5", &gpt5_clk),
+	CLKDEV_INIT(NULL, "gpt6", &gpt6_clk),
+	CLKDEV_INIT("mxc_pwm.0", NULL, &pwm_clk),
+	CLKDEV_INIT("mxc-mmc.0", NULL, &sdhc1_clk),
+	CLKDEV_INIT("mxc-mmc.1", NULL, &sdhc2_clk),
+	CLKDEV_INIT("mxc-mmc.2", NULL, &sdhc3_clk),
+	CLKDEV_INIT("imx27-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx27-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT("imx27-cspi.2", NULL, &cspi3_clk),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk),
+	CLKDEV_INIT("mx2-camera.0", NULL, &csi_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usb_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usb_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usb_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usb_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
+	CLKDEV_INIT(NULL, "vpu", &vpu_clk),
+	CLKDEV_INIT(NULL, "dma", &dma_clk),
+	CLKDEV_INIT(NULL, "rtic", &rtic_clk),
+	CLKDEV_INIT(NULL, "brom", &brom_clk),
+	CLKDEV_INIT(NULL, "emma", &emma_clk),
+	CLKDEV_INIT(NULL, "slcdc", &slcdc_clk),
+	CLKDEV_INIT("imx27-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT(NULL, "sahara2", &sahara2_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
+	CLKDEV_INIT(NULL, "mstick", &mstick_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
+	CLKDEV_INIT(NULL, "kpp", &kpp_clk),
+	CLKDEV_INIT("mxc_w1.0", NULL, &owire_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
+	CLKDEV_INIT(NULL, "scc", &scc_clk),
 };
 
 /* Adjust the clock path for TO2 and later */
diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
index 988a281..56510c5 100644
--- a/arch/arm/mach-imx/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -516,63 +516,56 @@ DEFINE_CLOCK(nfc_clk,     0, NULL,          0, nfc_get_rate, NULL, &ahb_clk);
 DEFINE_CLOCK(scc_clk,     0, NULL,          0, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(ipg_clk,     0, NULL,          0, ipg_get_rate, NULL, &ahb_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK("imx31-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx31-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx31-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
-	_REGISTER_CLOCK(NULL, "epit", epit1_clk)
-	_REGISTER_CLOCK(NULL, "epit", epit2_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK("ipu-core", NULL, ipu_clk)
-	_REGISTER_CLOCK("mx3_sdc_fb", NULL, ipu_clk)
-	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk1)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mx3-camera.0", NULL, csi_clk)
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT("imx31-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx31-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT("imx31-cspi.2", NULL, &cspi3_clk),
+	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
+	CLKDEV_INIT(NULL, "pwm", &pwm_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
+	CLKDEV_INIT(NULL, "epit", &epit1_clk),
+	CLKDEV_INIT(NULL, "epit", &epit2_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
+	CLKDEV_INIT("ipu-core", NULL, &ipu_clk),
+	CLKDEV_INIT("mx3_sdc_fb", NULL, &ipu_clk),
+	CLKDEV_INIT(NULL, "kpp", &kpp_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.0", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.1", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.2", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usb_clk1),
+	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("mx3-camera.0", NULL, &csi_clk),
 	/* i.mx31 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_clk)
-	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
-	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
-	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK(NULL, "firi", firi_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
-	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
-	_REGISTER_CLOCK(NULL, "rng", rng_clk)
-	_REGISTER_CLOCK("imx31-sdma", NULL, sdma_clk1)
-	_REGISTER_CLOCK(NULL, "sdma_ipg", sdma_clk2)
-	_REGISTER_CLOCK(NULL, "mstick", mstick1_clk)
-	_REGISTER_CLOCK(NULL, "mstick", mstick2_clk)
-	_REGISTER_CLOCK(NULL, "scc", scc_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
-	_REGISTER_CLOCK(NULL, "mpeg4", mpeg4_clk)
-	_REGISTER_CLOCK(NULL, "mbx", mbx_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
+	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &i2c3_clk),
+	CLKDEV_INIT("mxc_w1.0", NULL, &owire_clk),
+	CLKDEV_INIT("mxc-mmc.0", NULL, &sdhc1_clk),
+	CLKDEV_INIT("mxc-mmc.1", NULL, &sdhc2_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT(NULL, "firi", &firi_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
+	CLKDEV_INIT(NULL, "rtic", &rtic_clk),
+	CLKDEV_INIT(NULL, "rng", &rng_clk),
+	CLKDEV_INIT("imx31-sdma", NULL, &sdma_clk1),
+	CLKDEV_INIT(NULL, "sdma_ipg", &sdma_clk2),
+	CLKDEV_INIT(NULL, "mstick", &mstick1_clk),
+	CLKDEV_INIT(NULL, "mstick", &mstick2_clk),
+	CLKDEV_INIT(NULL, "scc", &scc_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
+	CLKDEV_INIT(NULL, "mpeg4", &mpeg4_clk),
+	CLKDEV_INIT(NULL, "mbx", &mbx_clk),
 };
 
 int __init mx31_clocks_init(unsigned long fref)
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 8116f11..8f5e1d9 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -438,71 +438,64 @@ static struct clk nfc_clk = {
 	.disable	= clk_dummy_disable
 };
 
-#define _REGISTER_CLOCK(d, n, c)	\
-	{				\
-		.dev_id = d,		\
-		.con_id = n,		\
-		.clk = &c,		\
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "asrc", asrc_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
-	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
-	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
-	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx35-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK(NULL, "ect", ect_clk)
-	_REGISTER_CLOCK(NULL, "edio", edio_clk)
-	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK("imx-epit.0", NULL, epit1_clk)
-	_REGISTER_CLOCK("imx-epit.1", NULL, epit2_clk)
-	_REGISTER_CLOCK(NULL, "esai", esai_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx35.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx35.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx35.2", NULL, esdhc3_clk)
+	CLKDEV_INIT(NULL, "asrc", &asrc_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
+	CLKDEV_INIT("flexcan.0", NULL, &can1_clk),
+	CLKDEV_INIT("flexcan.1", NULL, &can2_clk),
+	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx35-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT(NULL, "ect", &ect_clk),
+	CLKDEV_INIT(NULL, "edio", &edio_clk),
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT("imx-epit.0", NULL, &epit1_clk),
+	CLKDEV_INIT("imx-epit.1", NULL, &epit2_clk),
+	CLKDEV_INIT(NULL, "esai", &esai_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx35.0", NULL, &esdhc1_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx35.1", NULL, &esdhc2_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx35.2", NULL, &esdhc3_clk),
 	/* i.mx35 has the i.mx27 type fec */
-	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio1_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio2_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio3_clk)
-	_REGISTER_CLOCK("gpt.0", NULL, gpt_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_clk)
-	_REGISTER_CLOCK(NULL, "iomuxc", iomuxc_clk)
-	_REGISTER_CLOCK("ipu-core", NULL, ipu_clk)
-	_REGISTER_CLOCK("mx3_sdc_fb", NULL, ipu_clk)
-	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
-	_REGISTER_CLOCK(NULL, "mlb", mlb_clk)
-	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
-	_REGISTER_CLOCK("mxc_w1", NULL, owire_clk)
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
-	_REGISTER_CLOCK(NULL, "rngc", rngc_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
-	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
-	_REGISTER_CLOCK(NULL, "scc", scc_clk)
-	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
-	_REGISTER_CLOCK(NULL, "spba", spba_clk)
-	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	CLKDEV_INIT("imx27-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio1_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio2_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio3_clk),
+	CLKDEV_INIT("gpt.0", NULL, &gpt_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &i2c3_clk),
+	CLKDEV_INIT(NULL, "iomuxc", &iomuxc_clk),
+	CLKDEV_INIT("ipu-core", NULL, &ipu_clk),
+	CLKDEV_INIT("mx3_sdc_fb", NULL, &ipu_clk),
+	CLKDEV_INIT(NULL, "kpp", &kpp_clk),
+	CLKDEV_INIT(NULL, "mlb", &mlb_clk),
+	CLKDEV_INIT(NULL, "mshc", &mshc_clk),
+	CLKDEV_INIT("mxc_w1", NULL, &owire_clk),
+	CLKDEV_INIT(NULL, "pwm", &pwm_clk),
+	CLKDEV_INIT(NULL, "rngc", &rngc_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
+	CLKDEV_INIT(NULL, "rtic", &rtic_clk),
+	CLKDEV_INIT(NULL, "scc", &scc_clk),
+	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
+	CLKDEV_INIT(NULL, "spba", &spba_clk),
+	CLKDEV_INIT(NULL, "spdif", &spdif_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
 	/* i.mx35 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usbahb_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "max", max_clk)
-	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
-	_REGISTER_CLOCK(NULL, "csi", csi_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
-	_REGISTER_CLOCK(NULL, "gpu2d", gpu2d_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usbotg_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usbotg_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &usbahb_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "max", &max_clk),
+	CLKDEV_INIT(NULL, "audmux", &audmux_clk),
+	CLKDEV_INIT(NULL, "csi", &csi_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
+	CLKDEV_INIT(NULL, "gpu2d", &gpu2d_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
 };
 
 int __init mx35_clocks_init()
-- 
1.7.4.4
