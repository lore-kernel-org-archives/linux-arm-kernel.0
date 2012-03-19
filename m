From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 14:09:52 -0600
Subject: [PATCH] ARM: tegra: Fix device tree AUXDATA for USB/EHCI
Message-ID: <1332187792-14651-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4a53f4e "USB: ehci-tegra: add probing through device tree" added
AUXDATA for Tegra's USB/EHCI controller. However, it pointed the platform
data at a location containing the address of the intended platform data,
rather than the platform data itself. This change fixes that.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
Cc: <stable@vger.kernel.org> # 3.3
---
 arch/arm/mach-tegra/board-dt-tegra20.c |    6 +++---
 arch/arm/mach-tegra/devices.c          |    7 +++----
 arch/arm/mach-tegra/devices.h          |    5 +++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index e20b419..0952494 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -68,11 +68,11 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S2_BASE, "tegra-i2s.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-das", TEGRA_APB_MISC_DAS_BASE, "tegra-das", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB_BASE, "tegra-ehci.0",
-		       &tegra_ehci1_device.dev.platform_data),
+		       &tegra_ehci1_pdata),
 	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB2_BASE, "tegra-ehci.1",
-		       &tegra_ehci2_device.dev.platform_data),
+		       &tegra_ehci2_pdata),
 	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB3_BASE, "tegra-ehci.2",
-		       &tegra_ehci3_device.dev.platform_data),
+		       &tegra_ehci3_pdata),
 	{}
 };
 
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 7a2a02d..5f6b867 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -23,7 +23,6 @@
 #include <linux/fsl_devices.h>
 #include <linux/serial_8250.h>
 #include <linux/i2c-tegra.h>
-#include <linux/platform_data/tegra_usb.h>
 #include <asm/pmu.h>
 #include <mach/irqs.h>
 #include <mach/iomap.h>
@@ -446,18 +445,18 @@ static struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config = {
 	.clk = "cdev2",
 };
 
-static struct tegra_ehci_platform_data tegra_ehci1_pdata = {
+struct tegra_ehci_platform_data tegra_ehci1_pdata = {
 	.operating_mode = TEGRA_USB_OTG,
 	.power_down_on_bus_suspend = 1,
 };
 
-static struct tegra_ehci_platform_data tegra_ehci2_pdata = {
+struct tegra_ehci_platform_data tegra_ehci2_pdata = {
 	.phy_config = &tegra_ehci2_ulpi_phy_config,
 	.operating_mode = TEGRA_USB_HOST,
 	.power_down_on_bus_suspend = 1,
 };
 
-static struct tegra_ehci_platform_data tegra_ehci3_pdata = {
+struct tegra_ehci_platform_data tegra_ehci3_pdata = {
 	.operating_mode = TEGRA_USB_HOST,
 	.power_down_on_bus_suspend = 1,
 };
diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devices.h
index 873ecb2..ec45567 100644
--- a/arch/arm/mach-tegra/devices.h
+++ b/arch/arm/mach-tegra/devices.h
@@ -20,6 +20,11 @@
 #define __MACH_TEGRA_DEVICES_H
 
 #include <linux/platform_device.h>
+#include <linux/platform_data/tegra_usb.h>
+
+extern struct tegra_ehci_platform_data tegra_ehci1_pdata;
+extern struct tegra_ehci_platform_data tegra_ehci2_pdata;
+extern struct tegra_ehci_platform_data tegra_ehci3_pdata;
 
 extern struct platform_device tegra_gpio_device;
 extern struct platform_device tegra_pinmux_device;
-- 
1.7.0.4
