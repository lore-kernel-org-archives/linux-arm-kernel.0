From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  2 Mar 2011 12:01:23 +0100
Subject: [PATCH 4/4] ARM i.MX: introduce imx_otg_ulpi_create to create ULPI
	transceivers
In-Reply-To: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
References: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1299063683-24903-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The boards are currently using otg_ulpi_create and mxc_ulpi_access_ops,
both are only present if CONFIG_USB_ULPI is set. To remove the need of
ifdefs in the board code introduce a imx_otg_ulpi_create functions
which expands to a static inline function if compiled without ulpi.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-cpuimx27.c        |   24 ++++++++++--------------
 arch/arm/mach-imx/mach-mx27_3ds.c        |   13 ++++++-------
 arch/arm/mach-imx/mach-pca100.c          |   21 +++++++++------------
 arch/arm/mach-mx3/mach-armadillo5x0.c    |   20 +++++++++-----------
 arch/arm/mach-mx3/mach-mx31_3ds.c        |   20 +++++++++-----------
 arch/arm/mach-mx3/mach-mx31lilly.c       |   15 +++++----------
 arch/arm/mach-mx3/mach-mx31lite.c        |   12 ++++--------
 arch/arm/mach-mx3/mach-mx31moboard.c     |   11 ++++-------
 arch/arm/mach-mx3/mach-pcm037.c          |   19 ++++++++-----------
 arch/arm/mach-mx3/mach-pcm043.c          |   12 ++++--------
 arch/arm/mach-mx3/mx31moboard-smartbot.c |    6 ++++--
 arch/arm/mach-mx5/board-mx51_efikasb.c   |    8 ++++----
 arch/arm/mach-mx5/mx51_efika.c           |    8 ++++----
 arch/arm/plat-mxc/include/mach/ulpi.h    |    9 +++++++++
 arch/arm/plat-mxc/ulpi.c                 |    5 +++++
 15 files changed, 94 insertions(+), 109 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 6b724c2..759299b 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -209,7 +209,6 @@ static struct platform_device serial_device = {
 };
 #endif
 
-#if defined(CONFIG_USB_ULPI)
 static int eukrea_cpuimx27_otg_init(struct platform_device *pdev)
 {
 	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
@@ -229,7 +228,6 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= eukrea_cpuimx27_usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
-#endif
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
@@ -283,21 +281,19 @@ static void __init eukrea_cpuimx27_init(void)
 	platform_device_register(&serial_device);
 #endif
 
-#if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
-		imx27_add_mxc_ehci_otg(&otg_pdata);
+		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+				ULPI_OTG_DRVVBUS_EXT);
+		if (otg_pdata.otg)
+			imx27_add_mxc_ehci_otg(&otg_pdata);
+	} else {
+		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 	}
 
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
-	imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
-#endif
-	if (!otg_mode_host)
-		imx27_add_fsl_usb2_udc(&otg_device_pdata);
+	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (usbh2_pdata.otg)
+		imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
 
 #ifdef CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD
 	eukrea_mbimx27_baseboard_init();
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index f4f2725..614b3c0 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -162,7 +162,6 @@ static int otg_phy_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_USB_ULPI)
 static int mx27_3ds_otg_init(struct platform_device *pdev)
 {
 	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
@@ -172,7 +171,6 @@ static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.init	= mx27_3ds_otg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
-#endif
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
@@ -275,14 +273,15 @@ static void __init mx27pdk_init(void)
 	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 	imx27_add_imx2_wdt(NULL);
 	otg_phy_init();
-#if defined(CONFIG_USB_ULPI)
+
 	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+				ULPI_OTG_DRVVBUS_EXT);
 
-		imx27_add_mxc_ehci_otg(&otg_pdata);
+		if (otg_pdata.otg)
+			imx27_add_mxc_ehci_otg(&otg_pdata);
 	}
-#endif
+
 	if (!otg_mode_host)
 		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index f754bab..63e1825 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -267,7 +267,6 @@ static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.exit = pca100_sdhc2_exit,
 };
 
-#if defined(CONFIG_USB_ULPI)
 static int otg_phy_init(struct platform_device *pdev)
 {
 	gpio_set_value(OTG_PHY_CS_GPIO, 0);
@@ -295,7 +294,6 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
-#endif
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
@@ -402,23 +400,22 @@ static void __init pca100_init(void)
 	gpio_request(USBH2_PHY_CS_GPIO, "usb-host2-cs");
 	gpio_direction_output(USBH2_PHY_CS_GPIO, 1);
 
-#if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+				ULPI_OTG_DRVVBUS_EXT);
 
-		imx27_add_mxc_ehci_otg(&otg_pdata);
+		if (otg_pdata.otg)
+			imx27_add_mxc_ehci_otg(&otg_pdata);
+	} else {
+		gpio_set_value(OTG_PHY_CS_GPIO, 0);
+		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
-#endif
-	if (!otg_mode_host) {
-		gpio_set_value(OTG_PHY_CS_GPIO, 0);
-		imx27_add_fsl_usb2_udc(&otg_device_pdata);
-	}
+	if (usbh2_pdata.otg)
+		imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
 
 	imx27_add_imx_fb(&pca100_fb_data);
 
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 34e619e..226829b 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -133,7 +133,6 @@ static int armadillo5x0_pins[] = {
 };
 
 /* USB */
-#if defined(CONFIG_USB_ULPI)
 
 #define OTG_RESET IOMUX_TO_GPIO(MX31_PIN_STXD4)
 #define USBH2_RESET IOMUX_TO_GPIO(MX31_PIN_SCK6)
@@ -256,7 +255,6 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 };
-#endif /* CONFIG_USB_ULPI */
 
 /* RTC over I2C*/
 #define ARMADILLO5X0_RTC_GPIO	IOMUX_TO_GPIO(MX31_PIN_SRXD4)
@@ -549,15 +547,15 @@ static void __init armadillo5x0_init(void)
 	i2c_register_board_info(1, &armadillo5x0_i2c_rtc, 1);
 
 	/* USB */
-#if defined(CONFIG_USB_ULPI)
-	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
-	imx31_add_mxc_ehci_otg(&usbotg_pdata);
-	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-#endif
+
+	usbotg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (usbotg_pdata.otg)
+		imx31_add_mxc_ehci_otg(&usbotg_pdata);
+	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (usbh2_pdata.otg)
+		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 }
 
 static void __init armadillo5x0_timer_init(void)
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 35fdb2a..f1dbb9d 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -244,7 +244,6 @@ usbotg_free_reset:
 	return err;
 }
 
-#if defined(CONFIG_USB_ULPI)
 static int mx31_3ds_otg_init(struct platform_device *pdev)
 {
 	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
@@ -300,7 +299,6 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init = mx31_3ds_host2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
-#endif
 
 static const struct fsl_usb2_platform_data usbotg_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
@@ -345,17 +343,17 @@ static void __init mx31_3ds_init(void)
 	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
 
 	mx31_3ds_usbotg_init();
-#if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
-		imx31_add_mxc_ehci_otg(&otg_pdata);
+		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+				ULPI_OTG_DRVVBUS_EXT);
+		if (otg_pdata.otg)
+			imx31_add_mxc_ehci_otg(&otg_pdata);
 	}
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-#endif
+	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (usbh2_pdata.otg)
+		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
+
 	if (!otg_mode_host)
 		imx31_add_fsl_usb2_udc(&usbotg_pdata);
 
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index e2f9de1..ed95745 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -111,8 +111,6 @@ static struct platform_device physmap_flash_device = {
 
 /* USB */
 
-#if defined(CONFIG_USB_ULPI)
-
 #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
 			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
@@ -197,16 +195,13 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 
 static void lilly1131_usb_init(void)
 {
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
 	imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
-	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-}
 
-#else
-static inline void lilly1131_usb_init(void) {}
-#endif /* CONFIG_USB_ULPI */
+	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (usbh2_pdata.otg)
+		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
+}
 
 /* SPI */
 
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 81021bf..24a21a3 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -130,7 +130,6 @@ static struct spi_board_info mc13783_spi_dev __initdata = {
  * USB
  */
 
-#if defined(CONFIG_USB_ULPI)
 #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
 			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
@@ -177,7 +176,6 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init   = usbh2_init,
 	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 };
-#endif
 
 /*
  * NOR flash
@@ -254,13 +252,11 @@ static void __init mx31lite_init(void)
 	imx31_add_spi_imx1(&spi1_pdata);
 	spi_register_board_info(&mc13783_spi_dev, 1);
 
-#if defined(CONFIG_USB_ULPI)
 	/* USB */
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
-	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-#endif
+	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (usbh2_pdata.otg)
+		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 845d0b6..6f3692b 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -400,7 +400,6 @@ static void usb_xcvr_reset(void)
 	mdelay(1);
 }
 
-#if defined(CONFIG_USB_ULPI)
 static int moboard_usbh2_init_hw(struct platform_device *pdev)
 {
 	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
@@ -415,8 +414,10 @@ static int __init moboard_usbh2_init(void)
 {
 	struct platform_device *pdev;
 
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (!usbh2_pdata.otg)
+		return -ENODEV;
 
 	pdev = imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 	if (IS_ERR(pdev))
@@ -424,10 +425,6 @@ static int __init moboard_usbh2_init(void)
 
 	return 0;
 }
-#else
-static inline int moboard_usbh2_init(void) { return 0; }
-#endif
-
 
 static struct gpio_led mx31moboard_leds[] = {
 	{
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 783d31b..f07d3bd 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -533,7 +533,6 @@ static struct platform_device pcm970_sja1000 = {
 	.num_resources = ARRAY_SIZE(pcm970_sja1000_resources),
 };
 
-#if defined(CONFIG_USB_ULPI)
 static int pcm037_otg_init(struct platform_device *pdev)
 {
 	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
@@ -553,7 +552,6 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= pcm037_usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
-#endif
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
@@ -656,19 +654,18 @@ static void __init pcm037_init(void)
 
 	platform_device_register(&pcm970_sja1000);
 
-#if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
-		imx31_add_mxc_ehci_otg(&otg_pdata);
+		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+				ULPI_OTG_DRVVBUS_EXT);
+		if (otg_pdata.otg)
+			imx31_add_mxc_ehci_otg(&otg_pdata);
 	}
 
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT);
+	if (usbh2_pdata.otg)
+		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 
-	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-#endif
 	if (!otg_mode_host)
 		imx31_add_fsl_usb2_udc(&otg_device_pdata);
 
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 262af17..b3ecfb2 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -305,7 +305,6 @@ pcm037_nand_board_info __initconst = {
 	.hw_ecc = 1,
 };
 
-#if defined(CONFIG_USB_ULPI)
 static int pcm043_otg_init(struct platform_device *pdev)
 {
 	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
@@ -315,7 +314,6 @@ static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.init	= pcm043_otg_init,
 	.portsc	= MXC_EHCI_MODE_UTMI,
 };
-#endif
 
 static int pcm043_usbh1_init(struct platform_device *pdev)
 {
@@ -385,14 +383,12 @@ static void __init pcm043_init(void)
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
 
-#if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
-		imx35_add_mxc_ehci_otg(&otg_pdata);
+		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+				ULPI_OTG_DRVVBUS_EXT);
+		if (otg_pdata.otg)
+			imx35_add_mxc_ehci_otg(&otg_pdata);
 	}
-#endif
 	imx35_add_mxc_ehci_hs(&usbh1_pdata);
 
 	if (!otg_mode_host)
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index 87d556f..35f806e 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -137,8 +137,10 @@ static int __init smartbot_otg_host_init(void)
 {
 	struct platform_device *pdev;
 
-	otg_host_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+	otg_host_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+		ULPI_OTG_DRVVBUS_EXT);
+	if (!otg_host_pdata.otg)
+		return -ENODEV;
 
 	pdev = imx31_add_mxc_ehci_otg(&otg_host_pdata);
 	if (IS_ERR(pdev))
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index 18e29b9..db04ce8 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -129,10 +129,10 @@ static struct mxc_usbh_platform_data usbh2_config = {
 
 static void __init mx51_efikasb_usb(void)
 {
-	usbh2_config.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT |
-				ULPI_OTG_EXTVBUSIND);
-	mxc_register_device(&mxc_usbh2_device, &usbh2_config);
+	usbh2_config.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT | ULPI_OTG_EXTVBUSIND);
+	if (usbh2_config.otg)
+		mxc_register_device(&mxc_usbh2_device, &usbh2_config);
 }
 
 static struct gpio_led mx51_efikasb_leds[] = {
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 74991c9..51a67fc 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -218,12 +218,12 @@ static void __init mx51_efika_usb(void)
 	msleep(1);
 	gpio_set_value(EFIKA_USB_PHY_RESET, 1);
 
-	usbh1_config.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT |
-				ULPI_OTG_EXTVBUSIND);
+	usbh1_config.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
+			ULPI_OTG_DRVVBUS_EXT | ULPI_OTG_EXTVBUSIND);
 
 	mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
-	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
+	if (usbh1_config.otg)
+		mxc_register_device(&mxc_usbh1_device, &usbh1_config);
 }
 
 static struct mtd_partition mx51_efika_spi_nor_partitions[] = {
diff --git a/arch/arm/plat-mxc/include/mach/ulpi.h b/arch/arm/plat-mxc/include/mach/ulpi.h
index 96b6ab4..f9161c9 100644
--- a/arch/arm/plat-mxc/include/mach/ulpi.h
+++ b/arch/arm/plat-mxc/include/mach/ulpi.h
@@ -1,6 +1,15 @@
 #ifndef __MACH_ULPI_H
 #define __MACH_ULPI_H
 
+#ifdef CONFIG_USB_ULPI
+struct otg_transceiver *imx_otg_ulpi_create(unsigned int flags);
+#else
+static inline struct otg_transceiver *imx_otg_ulpi_create(unsigned int flags)
+{
+	return NULL;
+}
+#endif
+
 extern struct otg_io_access_ops mxc_ulpi_access_ops;
 
 #endif /* __MACH_ULPI_H */
diff --git a/arch/arm/plat-mxc/ulpi.c b/arch/arm/plat-mxc/ulpi.c
index 582c6df..477e45b 100644
--- a/arch/arm/plat-mxc/ulpi.c
+++ b/arch/arm/plat-mxc/ulpi.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
 
 #include <mach/ulpi.h>
 
@@ -111,3 +112,7 @@ struct otg_io_access_ops mxc_ulpi_access_ops = {
 };
 EXPORT_SYMBOL_GPL(mxc_ulpi_access_ops);
 
+struct otg_transceiver *imx_otg_ulpi_create(unsigned int flags)
+{
+	return otg_ulpi_create(&mxc_ulpi_access_ops, flags);
+}
-- 
1.7.2.3
