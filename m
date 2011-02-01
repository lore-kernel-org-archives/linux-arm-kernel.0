From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  1 Feb 2011 12:18:36 +0100
Subject: [PATCH 2/5] ARM i.MX ehci: do ehci init in board specific functions
In-Reply-To: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
References: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296559119-7723-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc-ehci driver calls SoC specific phy initialization right after
calling board specific initialization. To offer greater flexibility for
boards to setup the phy and to get rid of some unnecessary flags in
platform data this patch lets the boards call the SoC specific phy
initialization and remove it from the driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-cpuimx27.c           |   14 +++++++-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c    |   16 +++++++--
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    7 +++-
 arch/arm/mach-imx/mach-mx25_3ds.c           |    7 +++-
 arch/arm/mach-imx/mach-mx27_3ds.c           |    6 +++-
 arch/arm/mach-imx/mach-pca100.c             |   12 +++++--
 arch/arm/mach-imx/mach-pcm038.c             |    8 ++++-
 arch/arm/mach-mx3/mach-armadillo5x0.c       |   10 +++--
 arch/arm/mach-mx3/mach-cpuimx35.c           |   16 +++++++--
 arch/arm/mach-mx3/mach-mx31_3ds.c           |   15 ++++++--
 arch/arm/mach-mx3/mach-mx31lilly.c          |   17 ++++++---
 arch/arm/mach-mx3/mach-mx31lite.c           |    6 ++-
 arch/arm/mach-mx3/mach-mx31moboard.c        |    6 +++-
 arch/arm/mach-mx3/mach-mx35_3ds.c           |   16 +++++++--
 arch/arm/mach-mx3/mach-pcm037.c             |   14 +++++++-
 arch/arm/mach-mx3/mach-pcm043.c             |   16 +++++++--
 arch/arm/mach-mx3/mx31moboard-devboard.c    |    7 +++-
 arch/arm/mach-mx3/mx31moboard-marxbot.c     |    6 ++-
 arch/arm/mach-mx3/mx31moboard-smartbot.c    |    7 +++-
 arch/arm/mach-mx5/board-cpuimx51.c          |   13 +++++--
 arch/arm/mach-mx5/board-cpuimx51sd.c        |   13 +++++--
 arch/arm/mach-mx5/board-mx51_babbage.c      |   13 +++++--
 arch/arm/mach-mx5/board-mx51_efikamx.c      |    6 ++-
 arch/arm/plat-mxc/Makefile                  |    1 -
 arch/arm/plat-mxc/ehci.c                    |   46 ---------------------------
 arch/arm/plat-mxc/include/mach/mxc_ehci.h   |    3 --
 drivers/usb/host/ehci-mxc.c                 |    5 ---
 27 files changed, 190 insertions(+), 116 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/ehci.c

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 6cf04da..12e89c6 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -210,14 +210,24 @@ static struct platform_device serial_device = {
 #endif
 
 #if defined(CONFIG_USB_ULPI)
+static int eukrea_cpuimx27_otg_init(struct platform_device *pdev)
+{
+	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.init	= eukrea_cpuimx27_otg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
+static int eukrea_cpuimx27_usbh2_init(struct platform_device *pdev)
+{
+	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
+	.init	= eukrea_cpuimx27_usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 #endif
 
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index eb395ab..03ba93e 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -84,15 +84,25 @@ static struct i2c_board_info eukrea_cpuimx25_i2c_devices[] = {
 	},
 };
 
+static int eukrea_cpuimx25_otg_init(struct platform_device *pdev)
+{
+	return mx25_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static const struct mxc_usbh_platform_data otg_pdata __initconst = {
+	.init	= eukrea_cpuimx25_otg_init,
 	.portsc	= MXC_EHCI_MODE_UTMI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
+static int eukrea_cpuimx25_usbh2_init(struct platform_device *pdev)
+{
+	return mx25_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_SINGLE_UNI |
+			MXC_EHCI_INTERNAL_PHY | MXC_EHCI_IPPUE_DOWN);
+}
+
 static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
+	.init	= eukrea_cpuimx25_usbh2_init,
 	.portsc	= MXC_EHCI_MODE_SERIAL,
-	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
-		  MXC_EHCI_IPPUE_DOWN,
 };
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 40a3666..7d813d5 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -30,6 +30,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/delay.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -210,14 +211,16 @@ static struct i2c_board_info visstrim_m10_i2c_devices[] = {
 static int otg_phy_init(struct platform_device *pdev)
 {
 	gpio_set_value(OTG_PHY_CS_GPIO, 0);
-	return 0;
+
+	mdelay(10);
+
+	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
 }
 
 static const struct mxc_usbh_platform_data
 visstrim_m10_usbotg_pdata __initconst = {
 	.init = otg_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static void __init visstrim_m10_board_init(void)
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index aa76cfd..e8a5e70 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -185,9 +185,14 @@ static const struct matrix_keymap_data mx25pdk_keymap_data __initdata = {
 	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
 };
 
+static int mx25pdk_usbh2_init(struct platform_device *pdev)
+{
+	return mx25_initialize_usb_hw(pdev->id, MXC_EHCI_INTERNAL_PHY);
+}
+
 static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
+	.init	= mx25pdk_usbh2_init,
 	.portsc	= MXC_EHCI_MODE_SERIAL,
-	.flags	= MXC_EHCI_INTERNAL_PHY,
 };
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 1643315..aa957f4 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -160,10 +160,14 @@ static int otg_phy_init(void)
 }
 
 #if defined(CONFIG_USB_ULPI)
+static int mx27_3ds_otg_init(struct platform_device *pdev)
+{
+	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
 
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.init	= mx27_3ds_otg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 #endif
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index cccc0a0..cc11bb9 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -273,25 +273,29 @@ static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 static int otg_phy_init(struct platform_device *pdev)
 {
 	gpio_set_value(OTG_PHY_CS_GPIO, 0);
-	return 0;
+
+	mdelay(10);
+
+	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
 }
 
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.init	= otg_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
 static int usbh2_phy_init(struct platform_device *pdev)
 {
 	gpio_set_value(USBH2_PHY_CS_GPIO, 0);
-	return 0;
+
+	mdelay(10);
+
+	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
 }
 
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 #endif
 
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 5056148..b6fa95d 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -281,9 +281,15 @@ static struct spi_board_info pcm038_spi_board_info[] __initdata = {
 	}
 };
 
+static int pcm038_usbh2_init(struct platform_device *pdev)
+{
+	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
+	.init	= pcm038_usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
 static void __init pcm038_init(void)
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 28b6f41..8d82c9e 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -176,8 +176,10 @@ static int usbotg_init(struct platform_device *pdev)
 	gpio_set_value(OTG_RESET, 0/*LOW*/);
 	mdelay(5);
 	gpio_set_value(OTG_RESET, 1/*HIGH*/);
+	mdelay(10);
 
-	return 0;
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_INTERFACE_DIFF_UNI);
 
 otg_free_reset:
 	gpio_free(OTG_RESET);
@@ -233,8 +235,10 @@ static int usbh2_init(struct platform_device *pdev)
 	gpio_set_value(USBH2_RESET, 0/*LOW*/);
 	mdelay(5);
 	gpio_set_value(USBH2_RESET, 1/*HIGH*/);
+	mdelay(10);
 
-	return 0;
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_INTERFACE_DIFF_UNI);
 
 h2_free_reset:
 	gpio_free(USBH2_RESET);
@@ -246,13 +250,11 @@ h2_free_cs:
 static struct mxc_usbh_platform_data usbotg_pdata __initdata = {
 	.init	= usbotg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 #endif /* CONFIG_USB_ULPI */
 
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 26ae90f..c0953d4 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -111,15 +111,25 @@ static const struct mxc_nand_platform_data
 	.flash_bbt	= 1,
 };
 
+static int eukrea_cpuimx35_otg_init(struct platform_device *pdev)
+{
+	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static const struct mxc_usbh_platform_data otg_pdata __initconst = {
+	.init	= eukrea_cpuimx35_otg_init,
 	.portsc	= MXC_EHCI_MODE_UTMI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
+static int eukrea_cpuimx35_usbh1_init(struct platform_device *pdev)
+{
+	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_SINGLE_UNI |
+			MXC_EHCI_INTERNAL_PHY | MXC_EHCI_IPPUE_DOWN);
+}
+
 static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
+	.init	= eukrea_cpuimx35_usbh1_init,
 	.portsc	= MXC_EHCI_MODE_SERIAL,
-	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
-		  MXC_EHCI_IPPUE_DOWN,
 };
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 0d65db8..8255904 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -245,6 +245,12 @@ usbotg_free_reset:
 	return err;
 }
 
+#if defined(CONFIG_USB_ULPI)
+static int mx31_3ds_otg_init(struct platform_device *pdev)
+{
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
+}
+
 static int mx31_3ds_host2_init(struct platform_device *pdev)
 {
 	int err;
@@ -276,23 +282,24 @@ static int mx31_3ds_host2_init(struct platform_device *pdev)
 
 	mdelay(1);
 	gpio_set_value(USBH2_RST_B, 1);
-	return 0;
+
+	mdelay(10);
+
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
 
 usbotg_free_reset:
 	gpio_free(USBH2_RST_B);
 	return err;
 }
 
-#if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.init	= mx31_3ds_otg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init = mx31_3ds_host2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 #endif
 
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index 2c59548..68e527e 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/smsc911x.h>
@@ -156,7 +157,9 @@ static int usbotg_init(struct platform_device *pdev)
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE2), "USBH1 CS");
 	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE2), 0);
 
-	return 0;
+	mdelay(10);
+
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
 }
 
 static int usbh1_init(struct platform_device *pdev)
@@ -183,7 +186,10 @@ static int usbh1_init(struct platform_device *pdev)
 
 	mxc_iomux_set_gpr(MUX_PGP_USB_SUSPEND, true);
 
-	return 0;
+	mdelay(10);
+
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_INTERFACE_SINGLE_UNI);
 }
 
 static int usbh2_init(struct platform_device *pdev)
@@ -220,25 +226,24 @@ static int usbh2_init(struct platform_device *pdev)
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), "USBH2 CS");
 	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), 0);
 
-	return 0;
+	mdelay(10);
+
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
 }
 
 static struct mxc_usbh_platform_data usbotg_pdata = {
 	.init	= usbotg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
 	.init	= usbh1_init,
 	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
 };
 
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static void lilly1131_usb_init(void)
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 9e64c66..ef906f8 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -27,6 +27,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/mtd/physmap.h>
+#include <linux/delay.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -167,13 +168,14 @@ static int usbh2_init(struct platform_device *pdev)
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), "USBH2 CS");
 	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), 0);
 
-	return 0;
+	mdelay(10);
+
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
 }
 
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init   = usbh2_init,
 	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags  = MXC_EHCI_POWER_PINS_ENABLED,
 };
 #endif
 
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 1aa8d65..a87fed6 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -401,10 +401,14 @@ static void usb_xcvr_reset(void)
 }
 
 #if defined(CONFIG_USB_ULPI)
+static int moboard_usbh2_init_hw(struct platform_device *pdev)
+{
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
+}
 
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
+	.init	= moboard_usbh2_init_hw,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static int __init moboard_usbh2_init(void)
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index b1963f2..2625844 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -120,6 +120,11 @@ static iomux_v3_cfg_t mx35pdk_pads[] = {
 	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
 };
 
+static int mx35_3ds_otg_init(struct platform_device *pdev)
+{
+	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERNAL_PHY);
+}
+
 /* OTG config */
 static const struct fsl_usb2_platform_data usb_otg_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
@@ -127,15 +132,20 @@ static const struct fsl_usb2_platform_data usb_otg_pdata __initconst = {
 };
 
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.init	= mx35_3ds_otg_init,
 	.portsc	= MXC_EHCI_MODE_UTMI,
-	.flags	= MXC_EHCI_INTERNAL_PHY,
 };
 
+static int mx35_3ds_usbh_init(struct platform_device *pdev)
+{
+	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_SINGLE_UNI |
+			  MXC_EHCI_INTERNAL_PHY);
+}
+
 /* USB HOST config */
 static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
+	.init		= mx35_3ds_usbh_init,
 	.portsc		= MXC_EHCI_MODE_SERIAL,
-	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
-			  MXC_EHCI_INTERNAL_PHY,
 };
 
 static int otg_mode_host;
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index b752f6b..252ba5d 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -534,14 +534,24 @@ static struct platform_device pcm970_sja1000 = {
 };
 
 #if defined(CONFIG_USB_ULPI)
+static int pcm037_otg_init(struct platform_device *pdev)
+{
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.init	= pcm037_otg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
+static int pcm037_usbh2_init(struct platform_device *pdev)
+{
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
+	.init	= pcm037_usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 #endif
 
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index bcf83fc..2af7041 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -308,15 +308,25 @@ pcm037_nand_board_info __initconst = {
 };
 
 #if defined(CONFIG_USB_ULPI)
+static int pcm043_otg_init(struct platform_device *pdev)
+{
+	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
+}
+
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.init	= pcm043_otg_init,
 	.portsc	= MXC_EHCI_MODE_UTMI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
+static int pcm043_usbh1_init(struct platform_device *pdev)
+{
+	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_SINGLE_UNI |
+			MXC_EHCI_INTERNAL_PHY | MXC_EHCI_IPPUE_DOWN);
+}
+
 static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
+	.init	= pcm043_usbh1_init,
 	.portsc	= MXC_EHCI_MODE_SERIAL,
-	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
-		  MXC_EHCI_IPPUE_DOWN,
 };
 #endif
 
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 94a0b9e..6410b9c 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -15,6 +15,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -149,7 +150,10 @@ static int devboard_usbh1_hw_init(struct platform_device *pdev)
 	mxc_iomux_set_pad(MX31_PIN_CSPI1_SPI_RDY, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_SFS6, USB_PAD_CFG);
 
-	return 0;
+	mdelay(10);
+
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_INTERFACE_SINGLE_UNI);
 }
 
 #define USBH1_VBUSEN_B	IOMUX_TO_GPIO(MX31_PIN_NFRE_B)
@@ -187,7 +191,6 @@ static int devboard_isp1105_set_vbus(struct otg_transceiver *otg, bool on)
 static struct mxc_usbh_platform_data usbh1_pdata __initdata = {
 	.init	= devboard_usbh1_hw_init,
 	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
 };
 
 static int __init devboard_usbh1_init(void)
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index f449a97..57f7b00 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -265,7 +265,10 @@ static int marxbot_usbh1_hw_init(struct platform_device *pdev)
 	mxc_iomux_set_pad(MX31_PIN_CSPI1_SPI_RDY, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_SFS6, USB_PAD_CFG);
 
-	return 0;
+	mdelay(10);
+
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_INTERFACE_SINGLE_UNI);
 }
 
 #define USBH1_VBUSEN_B	IOMUX_TO_GPIO(MX31_PIN_NFRE_B)
@@ -303,7 +306,6 @@ static int marxbot_isp1105_set_vbus(struct otg_transceiver *otg, bool on)
 static struct mxc_usbh_platform_data usbh1_pdata __initdata = {
 	.init	= marxbot_usbh1_hw_init,
 	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
 };
 
 static int __init marxbot_usbh1_init(void)
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index bbec3c8..87d556f 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -123,9 +123,14 @@ static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 
 #if defined(CONFIG_USB_ULPI)
 
+static int smartbot_otg_init(struct platform_device *pdev)
+{
+	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
+}
+
 static struct mxc_usbh_platform_data otg_host_pdata __initdata = {
+	.init	= smartbot_otg_init,
 	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static int __init smartbot_otg_host_init(void)
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index f8652ef..0709815 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -188,7 +188,10 @@ static int initialize_otg_port(struct platform_device *pdev)
 	v |= MX51_USB_PLL_DIV_19_2_MHZ;
 	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
 	iounmap(usb_base);
-	return 0;
+
+	mdelay(10);
+
+	return mx51_initialize_usb_hw(0, MXC_EHCI_INTERNAL_PHY);
 }
 
 static int initialize_usbh1_port(struct platform_device *pdev)
@@ -206,13 +209,16 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	v = __raw_readl(usbother_base + MX51_USB_CTRL_1_OFFSET);
 	__raw_writel(v | MX51_USB_CTRL_UH1_EXT_CLK_EN, usbother_base + MX51_USB_CTRL_1_OFFSET);
 	iounmap(usb_base);
-	return 0;
+
+	mdelay(10);
+
+	return mx51_initialize_usb_hw(1, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
 static struct mxc_usbh_platform_data dr_utmi_config = {
 	.init		= initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
-	.flags	= MXC_EHCI_INTERNAL_PHY,
 };
 
 static struct fsl_usb2_platform_data usb_pdata = {
@@ -223,7 +229,6 @@ static struct fsl_usb2_platform_data usb_pdata = {
 static struct mxc_usbh_platform_data usbh1_config = {
 	.init		= initialize_usbh1_port,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= (MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_ITC_NO_THRESHOLD),
 };
 
 static int otg_mode_host;
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ad93189..ab5a8a8 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -167,7 +167,10 @@ static int initialize_otg_port(struct platform_device *pdev)
 	v |= MX51_USB_PLL_DIV_19_2_MHZ;
 	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
 	iounmap(usb_base);
-	return 0;
+
+	mdelay(10);
+
+	return mx51_initialize_usb_hw(0, MXC_EHCI_INTERNAL_PHY);
 }
 
 static int initialize_usbh1_port(struct platform_device *pdev)
@@ -186,13 +189,16 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	__raw_writel(v | MX51_USB_CTRL_UH1_EXT_CLK_EN,
 			usbother_base + MX51_USB_CTRL_1_OFFSET);
 	iounmap(usb_base);
-	return 0;
+
+	mdelay(10);
+
+	return mx51_initialize_usb_hw(1, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
 static struct mxc_usbh_platform_data dr_utmi_config = {
 	.init		= initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
-	.flags	= MXC_EHCI_INTERNAL_PHY,
 };
 
 static struct fsl_usb2_platform_data usb_pdata = {
@@ -203,7 +209,6 @@ static struct fsl_usb2_platform_data usb_pdata = {
 static struct mxc_usbh_platform_data usbh1_config = {
 	.init		= initialize_usbh1_port,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= (MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_ITC_NO_THRESHOLD),
 };
 
 static int otg_mode_host;
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 1d231e8..8f765a1 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -272,7 +272,10 @@ static int initialize_otg_port(struct platform_device *pdev)
 	v |= MX51_USB_PLL_DIV_19_2_MHZ;
 	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
 	iounmap(usb_base);
-	return 0;
+
+	mdelay(10);
+
+	return mx51_initialize_usb_hw(0, MXC_EHCI_INTERNAL_PHY);
 }
 
 static int initialize_usbh1_port(struct platform_device *pdev)
@@ -290,13 +293,16 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	v = __raw_readl(usbother_base + MX51_USB_CTRL_1_OFFSET);
 	__raw_writel(v | MX51_USB_CTRL_UH1_EXT_CLK_EN, usbother_base + MX51_USB_CTRL_1_OFFSET);
 	iounmap(usb_base);
-	return 0;
+
+	mdelay(10);
+
+	return mx51_initialize_usb_hw(1, MXC_EHCI_POWER_PINS_ENABLED |
+			MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
 static struct mxc_usbh_platform_data dr_utmi_config = {
 	.init		= initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
-	.flags	= MXC_EHCI_INTERNAL_PHY,
 };
 
 static struct fsl_usb2_platform_data usb_pdata = {
@@ -307,7 +313,6 @@ static struct fsl_usb2_platform_data usb_pdata = {
 static struct mxc_usbh_platform_data usbh1_config = {
 	.init		= initialize_usbh1_port,
 	.portsc	= MXC_EHCI_MODE_ULPI,
-	.flags	= (MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_ITC_NO_THRESHOLD),
 };
 
 static int otg_mode_host;
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index b7946f8..d2d7951 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -158,13 +158,15 @@ static int initialize_otg_port(struct platform_device *pdev)
 	v |= MX51_USB_PLL_DIV_24_MHZ;
 	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
 	iounmap(usb_base);
-	return 0;
+
+	mdelay(10);
+
+	return mx51_initialize_usb_hw(0, MXC_EHCI_INTERNAL_PHY);
 }
 
 static struct mxc_usbh_platform_data dr_utmi_config = {
 	.init   = initialize_otg_port,
 	.portsc = MXC_EHCI_UTMI_16BIT,
-	.flags  = MXC_EHCI_INTERNAL_PHY,
 };
 
 /*   PCBID2  PCBID1 PCBID0  STATE
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 5fd20e9..a138787 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
-obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
deleted file mode 100644
index 06fb3a4..0000000
--- a/arch/arm/plat-mxc/ehci.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
- * Copyright (C) 2010 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- * for more details.
- */
-
-#include <linux/platform_device.h>
-
-#include <mach/hardware.h>
-#include <mach/mxc_ehci.h>
-
-int mxc_initialize_usb_hw(int port, unsigned int flags)
-{
-#if defined(CONFIG_SOC_IMX25)
-	if (cpu_is_mx25())
-		return mx25_initialize_usb_hw(port, flags);
-#endif /* if defined(CONFIG_SOC_IMX25) */
-#if defined(CONFIG_ARCH_MX3)
-	if (cpu_is_mx31())
-		return mx31_initialize_usb_hw(port, flags);
-	if (cpu_is_mx35())
-		return mx35_initialize_usb_hw(port, flags);
-#endif /* CONFIG_ARCH_MX3 */
-#ifdef CONFIG_MACH_MX27
-	if (cpu_is_mx27())
-		return mx27_initialize_usb_hw(port, flags);
-#endif /* CONFIG_MACH_MX27 */
-#ifdef CONFIG_SOC_IMX51
-	if (cpu_is_mx51())
-		return mx51_initialize_usb_hw(port, flags);
-#endif
-	printk(KERN_WARNING
-		"%s() unable to setup USBCONTROL for this CPU\n", __func__);
-	return -EINVAL;
-}
-EXPORT_SYMBOL(mxc_initialize_usb_hw);
-
diff --git a/arch/arm/plat-mxc/include/mach/mxc_ehci.h b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
index 7e555a1f..2c159dc 100644
--- a/arch/arm/plat-mxc/include/mach/mxc_ehci.h
+++ b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
@@ -44,12 +44,9 @@ struct mxc_usbh_platform_data {
 	int (*exit)(struct platform_device *pdev);
 
 	unsigned int		 portsc;
-	unsigned int		 flags;
 	struct otg_transceiver	*otg;
 };
 
-int mxc_initialize_usb_hw(int port, unsigned int flags);
-
 int mx51_initialize_usb_hw(int port, unsigned int flags);
 int mx25_initialize_usb_hw(int port, unsigned int flags);
 int mx31_initialize_usb_hw(int port, unsigned int flags);
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index c8e360d..25c8c10 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -203,11 +203,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		mdelay(10);
 	}
 
-	/* setup specific usb hw */
-	ret = mxc_initialize_usb_hw(pdev->id, pdata->flags);
-	if (ret < 0)
-		goto err_init;
-
 	ehci = hcd_to_ehci(hcd);
 
 	/* EHCI registers start@offset 0x100 */
-- 
1.7.2.3
