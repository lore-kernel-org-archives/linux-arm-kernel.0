From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:09 +0100
Subject: [PATCH 41/51] ARM: imx: use SOC_IMX25 instead of ARCH_MX25 for
	multi-SoC
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-41-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some usages of ARCH_MX25 are assuming that if it is
defined the other SoCs are undefined.  Use SOC_IMX25 for the save
places.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/audmux-v2.c                     |    4 ++--
 arch/arm/plat-mxc/devices/platform-esdhc.c        |    4 ++--
 arch/arm/plat-mxc/devices/platform-fec.c          |    4 ++--
 arch/arm/plat-mxc/devices/platform-flexcan.c      |    4 ++--
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx-dma.c      |    6 +++---
 arch/arm/plat-mxc/devices/platform-imx-fb.c       |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx-i2c.c      |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx-keypad.c   |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx-ssi.c      |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx-uart.c     |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c     |    4 ++--
 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c    |    4 ++--
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c     |    4 ++--
 arch/arm/plat-mxc/devices/platform-mxc_nand.c     |    4 ++--
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c      |    4 ++--
 arch/arm/plat-mxc/devices/platform-spi_imx.c      |    4 ++--
 arch/arm/plat-mxc/ehci.c                          |    4 ++--
 arch/arm/plat-mxc/gpio.c                          |    4 ++--
 19 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 0be1ac7..175e364 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -209,7 +209,7 @@ static int mxc_audmux_v2_init(void)
 		audmux_base = MX35_IO_ADDRESS(MX35_AUDMUX_BASE_ADDR);
 	}
 #endif
-#if defined(CONFIG_ARCH_MX25)
+#if defined(CONFIG_SOC_IMX25)
 	if (cpu_is_mx25()) {
 		audmux_clk = clk_get(NULL, "audmux");
 		if (IS_ERR(audmux_clk)) {
@@ -220,7 +220,7 @@ static int mxc_audmux_v2_init(void)
 		}
 		audmux_base = MX25_IO_ADDRESS(MX25_AUDMUX_BASE_ADDR);
 	}
-#endif
+#endif /* if defined(CONFIG_SOC_IMX25) */
 	audmux_debugfs_init();
 
 	return 0;
diff --git a/arch/arm/plat-mxc/devices/platform-esdhc.c b/arch/arm/plat-mxc/devices/platform-esdhc.c
index 2605bfa..87df70b 100644
--- a/arch/arm/plat-mxc/devices/platform-esdhc.c
+++ b/arch/arm/plat-mxc/devices/platform-esdhc.c
@@ -20,14 +20,14 @@
 #define imx_esdhc_imx_data_entry(soc, id, hwid)	\
 	[id] = imx_esdhc_imx_data_entry_single(soc, id, hwid)
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst = {
 #define imx25_esdhc_data_entry(_id, _hwid)				\
 	imx_esdhc_imx_data_entry(MX25, _id, _hwid)
 	imx25_esdhc_data_entry(0, 1),
 	imx25_esdhc_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_ARCH_MX35
 const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
index 11d087f..e6a365e 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -16,10 +16,10 @@
 		.irq = soc ## _INT_FEC,					\
 	}
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_fec_data imx25_fec_data __initconst =
 	imx_fec_data_entry_single(MX25);
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_fec_data imx27_fec_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-flexcan.c b/arch/arm/plat-mxc/devices/platform-flexcan.c
index 5189017..f10db6f 100644
--- a/arch/arm/plat-mxc/devices/platform-flexcan.c
+++ b/arch/arm/plat-mxc/devices/platform-flexcan.c
@@ -19,14 +19,14 @@
 #define imx_flexcan_data_entry(soc, _id, _hwid, _size)			\
 	[_id] = imx_flexcan_data_entry_single(soc, _id, _hwid, _size)
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_flexcan_data imx25_flexcan_data[] __initconst = {
 #define imx25_flexcan_data_entry(_id, _hwid)				\
 	imx_flexcan_data_entry(MX25, _id, _hwid, SZ_16K)
 	imx25_flexcan_data_entry(0, 1),
 	imx25_flexcan_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_ARCH_MX35
 const struct imx_flexcan_data imx35_flexcan_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
index cb5fb71..42c3923 100644
--- a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
@@ -15,10 +15,10 @@
 		.irq = soc ## _INT_USB_OTG,				\
 	}
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst =
 	imx_fsl_usb2_udc_data_entry_single(MX25);
-#endif
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 02d9890..cbafd93 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -39,10 +39,10 @@ struct imx_imx_sdma_data {
 		},							\
 	}
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imx_sdma_data imx25_imx_sdma_data __initconst =
 	imx_imx_sdma_data_entry_single(MX25, 1, "imx25", 0);
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_ARCH_MX31
 struct imx_imx_sdma_data imx31_imx_sdma_data __initdata =
@@ -94,7 +94,7 @@ static int __init imxXX_add_imx_dma(void)
 	else
 #endif
 
-#if defined(CONFIG_ARCH_MX25)
+#if defined(CONFIG_SOC_IMX25)
 	if (cpu_is_mx25())
 		ret = imx_add_imx_sdma(&imx25_imx_sdma_data);
 	else
diff --git a/arch/arm/plat-mxc/devices/platform-imx-fb.c b/arch/arm/plat-mxc/devices/platform-imx-fb.c
index f228ba6..6100a7d 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-fb.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-fb.c
@@ -21,10 +21,10 @@ const struct imx_imx_fb_data imx21_imx_fb_data __initconst =
 	imx_imx_fb_data_entry_single(MX21, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imx_fb_data imx25_imx_fb_data __initconst =
 	imx_imx_fb_data_entry_single(MX25, SZ_16K);
-#endif
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_fb_data imx27_imx_fb_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index 6795884..2cb0232 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -30,7 +30,7 @@ const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst =
 	imx_imx_i2c_data_entry_single(MX21, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst = {
 #define imx25_imx_i2c_data_entry(_id, _hwid)				\
 	imx_imx_i2c_data_entry(MX25, _id, _hwid, SZ_16K)
@@ -38,7 +38,7 @@ const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst = {
 	imx25_imx_i2c_data_entry(1, 2),
 	imx25_imx_i2c_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
index 5995e81..5f3b367 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -21,10 +21,10 @@ const struct imx_imx_keypad_data imx21_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX21, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX25, SZ_16K);
-#endif
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
index 38a7a0b..d6410e1 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -30,14 +30,14 @@ const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst = {
 #define imx25_imx_ssi_data_entry(_id, _hwid)				\
 	imx_imx_ssi_data_entry(MX25, _id, _hwid, SZ_4K)
 	imx25_imx_ssi_data_entry(0, 1),
 	imx25_imx_ssi_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index 2039640..b10c736 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -47,7 +47,7 @@ const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst = {
 };
 #endif
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst = {
 #define imx25_imx_uart_data_entry(_id, _hwid)				\
 	imx_imx_uart_1irq_data_entry(MX25, _id, _hwid, SZ_16K)
@@ -57,7 +57,7 @@ const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst = {
 	imx25_imx_uart_data_entry(3, 4),
 	imx25_imx_uart_data_entry(4, 5),
 };
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
index 7508281..bd9c546 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -21,10 +21,10 @@ const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
 	imx_imx2_wdt_data_entry_single(MX21, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst =
         imx_imx2_wdt_data_entry_single(MX25, SZ_16K);
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c b/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
index 387f650..10653cc 100644
--- a/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
+++ b/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
@@ -16,10 +16,10 @@
 		.irq = soc ## _INT_DRYICE,				\
 	}
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst =
 	imx_imxdi_rtc_data_entry_single(MX25);
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 struct platform_device *__init imx_add_imxdi_rtc(
 		const struct imx_imxdi_rtc_data *data)
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
index 825a048ca..9bec63f 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
@@ -16,12 +16,12 @@
 		.irq = soc ## _INT_USB_ ## hs,				\
 	}
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst =
 	imx_mxc_ehci_data_entry_single(MX25, 0, OTG);
 const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst =
 	imx_mxc_ehci_data_entry_single(MX25, 1, HS);
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
index 3fdcc32e..967d847 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -31,10 +31,10 @@ const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX21, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX25, SZ_8K);
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
index 5a47d1e..3d8ebdb 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -24,7 +24,7 @@ const struct imx_mxc_pwm_data imx21_mxc_pwm_data __initconst =
 	imx_mxc_pwm_data_entry_single(MX21, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_mxc_pwm_data imx25_mxc_pwm_data[] __initconst = {
 #define imx25_mxc_pwm_data_entry(_id, _hwid)				\
 	imx_mxc_pwm_data_entry(MX25, _id, _hwid, SZ_16K)
@@ -33,7 +33,7 @@ const struct imx_mxc_pwm_data imx25_mxc_pwm_data[] __initconst = {
 	imx25_mxc_pwm_data_entry(2, 3),
 	imx25_mxc_pwm_data_entry(3, 4),
 };
-#endif
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_pwm_data imx27_mxc_pwm_data __initconst =
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index e48340e..bf2cb47 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -29,7 +29,7 @@ const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
 	imx21_cspi_data_entry(1, 2),
 #endif
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 const struct imx_spi_imx_data imx25_cspi_data[] __initconst = {
 #define imx25_cspi_data_entry(_id, _hwid)				\
 	imx_spi_imx_data_entry(MX25, CSPI, "imx25-cspi", _id, _hwid, SZ_16K)
@@ -37,7 +37,7 @@ const struct imx_spi_imx_data imx25_cspi_data[] __initconst = {
 	imx25_cspi_data_entry(1, 2),
 	imx25_cspi_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX25 */
+#endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_spi_imx_data imx27_cspi_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index f699235..4bac3d5 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -69,7 +69,7 @@
 int mxc_initialize_usb_hw(int port, unsigned int flags)
 {
 	unsigned int v;
-#if defined(CONFIG_ARCH_MX25)
+#if defined(CONFIG_SOC_IMX25)
 	if (cpu_is_mx25()) {
 		v = readl(MX25_IO_ADDRESS(MX25_USB_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
@@ -112,7 +112,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 				     USBCTRL_OTGBASE_OFFSET));
 		return 0;
 	}
-#endif /* CONFIG_ARCH_MX25 */
+#endif /* if defined(CONFIG_SOC_IMX25) */
 #if defined(CONFIG_ARCH_MX3)
 	if (cpu_is_mx31()) {
 		v = readl(MX31_IO_ADDRESS(MX31_OTG_BASE_ADDR +
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index e59fb97..c853bfa 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -395,7 +395,7 @@ DEFINE_REGISTER_FUNCTION(imx21)
 
 #endif /* if defined(CONFIG_SOC_IMX21) */
 
-#if defined(CONFIG_ARCH_MX25)
+#if defined(CONFIG_SOC_IMX25)
 static struct mxc_gpio_port imx25_gpio_ports[] = {
 	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 0, 1, MX25_INT_GPIO1),
 	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 1, 2, MX25_INT_GPIO2),
@@ -405,7 +405,7 @@ static struct mxc_gpio_port imx25_gpio_ports[] = {
 
 DEFINE_REGISTER_FUNCTION(imx25)
 
-#endif /* if defined(CONFIG_ARCH_MX25) */
+#endif /* if defined(CONFIG_SOC_IMX25) */
 
 #if defined(CONFIG_SOC_IMX27)
 static struct mxc_gpio_port imx27_gpio_ports[] = {
-- 
1.7.2.3
