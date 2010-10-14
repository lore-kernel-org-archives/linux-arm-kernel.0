From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 14 Oct 2010 11:56:45 +0200
Subject: [PATCH] mach-cpuimx27: workaround USB PHY detection problem
Message-ID: <1287050205-15026-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-imx/mach-cpuimx27.c |   58 +++++++++++++++++++++++++++---------
 1 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index ea62afa..f740582 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -215,13 +215,56 @@ static struct platform_device serial_device = {
 };
 #endif
 
+static int otg_mode_host;
+
+static int __init eukrea_cpuimx27_otg_mode(char *options)
+{
+	if (!strcmp(options, "host"))
+		otg_mode_host = 1;
+	else if (!strcmp(options, "device"))
+		otg_mode_host = 0;
+	else
+		pr_info("otg_mode neither \"host\" nor \"device\". "
+			"Defaulting to device\n");
+	return 0;
+}
+__setup("otg_mode=", eukrea_cpuimx27_otg_mode);
+
 #if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
+/*
+ * special init sequence which workarounds USBH2 USB PHY detection problems
+ * when both H2 and OTG port are configured as hosts
+ */
+static int usbh2_phy_init(struct platform_device *pdev) {
+	uint32_t temp;
+
+	if (otg_mode_host) {
+		/* configure USBCTRL */
+		temp = readl(MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR) + 0x600);
+		temp &= ~((3 << 21) | 1);
+		temp |= (1 << 5) | (1 << 16) | (1 << 19) | (1 << 11)| (1 << 20);
+		writel(temp, MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR) + 0x600);
+
+		/* configure PORTSC1 */
+		temp = 2 << 30;
+		writel(temp, MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR) + 0x584);
+
+		/* reset controller */
+		temp = readl(MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR) + 0x540);
+		temp |= 0x02;
+		writel(temp, MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR) + 0x540);
+	}
+
+	return 0;
+}
+
 static struct mxc_usbh_platform_data usbh2_pdata = {
+	.init = usbh2_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
@@ -232,21 +275,6 @@ static struct fsl_usb2_platform_data otg_device_pdata = {
 	.phy_mode       = FSL_USB2_PHY_ULPI,
 };
 
-static int otg_mode_host;
-
-static int __init eukrea_cpuimx27_otg_mode(char *options)
-{
-	if (!strcmp(options, "host"))
-		otg_mode_host = 1;
-	else if (!strcmp(options, "device"))
-		otg_mode_host = 0;
-	else
-		pr_info("otg_mode neither \"host\" nor \"device\". "
-			"Defaulting to device\n");
-	return 0;
-}
-__setup("otg_mode=", eukrea_cpuimx27_otg_mode);
-
 static void __init eukrea_cpuimx27_init(void)
 {
 	mxc_gpio_setup_multiple_pins(eukrea_cpuimx27_pins,
-- 
1.7.0.4
