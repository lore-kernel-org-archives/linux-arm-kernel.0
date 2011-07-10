From: ccross@android.com (Colin Cross)
Date: Sun, 10 Jul 2011 15:19:34 -0700
Subject: [PATCH 2/2] ARM: tegra: remove copy-and-pasted usb platform data from
	boards
In-Reply-To: <1310336374-31727-1-git-send-email-ccross@android.com>
References: <1310336374-31727-1-git-send-email-ccross@android.com>
Message-ID: <1310336374-31727-2-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

trimslice and paz00 both have functionally identical platform
data for the tegra-ehci driver.  Move the platform data into
devices.c, and remove it from all the board files.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/board-paz00.c     |   26 --------------------------
 arch/arm/mach-tegra/board-trimslice.c |   19 -------------------
 arch/arm/mach-tegra/devices.c         |   28 ++++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 465768e..ea2f79c 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -26,7 +26,6 @@
 #include <linux/pda_power.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/tegra_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -36,7 +35,6 @@
 #include <mach/iomap.h>
 #include <mach/irqs.h>
 #include <mach/sdhci.h>
-#include <mach/usb_phy.h>
 #include <mach/gpio.h>
 
 #include "board.h"
@@ -80,32 +78,8 @@ static void paz00_i2c_init(void)
 	platform_device_register(&tegra_i2c_device4);
 }
 
-static struct tegra_ulpi_config ulpi_phy_config = {
-		.reset_gpio = TEGRA_ULPI_RST,
-		.clk = "cdev2",
-};
-
-static struct tegra_ehci_platform_data tegra_ehci_pdata[] = {
-		[0] = {
-			.operating_mode = TEGRA_USB_OTG,
-			.power_down_on_bus_suspend = 1,
-		},
-		[1] = {
-			.phy_config = &ulpi_phy_config,
-			.operating_mode = TEGRA_USB_HOST,
-			.power_down_on_bus_suspend = 1,
-		},
-		[2] = {
-			.operating_mode = TEGRA_USB_HOST,
-			.power_down_on_bus_suspend = 1,
-		},
-};
-
 static void paz00_usb_init(void)
 {
-	tegra_ehci2_device.dev.platform_data = &tegra_ehci_pdata[1];
-	tegra_ehci3_device.dev.platform_data = &tegra_ehci_pdata[2];
-
 	platform_device_register(&tegra_ehci2_device);
 	platform_device_register(&tegra_ehci3_device);
 }
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index e1d7e67..89a6d2a 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -24,7 +24,6 @@
 #include <linux/serial_8250.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/tegra_usb.h>
 #include <linux/gpio.h>
 
 #include <asm/mach-types.h>
@@ -33,7 +32,6 @@
 
 #include <mach/iomap.h>
 #include <mach/sdhci.h>
-#include <mach/usb_phy.h>
 #include <mach/gpio.h>
 
 #include "board.h"
@@ -110,28 +108,12 @@ static void trimslice_i2c_init(void)
 				ARRAY_SIZE(trimslice_i2c3_board_info));
 }
 
-struct tegra_ulpi_config ehci2_phy_config = {
-	.reset_gpio = TRIMSLICE_GPIO_USB2_RST,
-	.clk = "cdev2",
-};
-
-static struct tegra_ehci_platform_data ehci_ulpi_data = {
-	.operating_mode = TEGRA_USB_HOST,
-	.phy_config = &ehci2_phy_config,
-};
-
-static struct tegra_ehci_platform_data ehci_utmi_data = {
-	.operating_mode = TEGRA_USB_HOST,
-};
-
 static void trimslice_usb_init(void)
 {
 	int err;
 
-	tegra_ehci3_device.dev.platform_data = &ehci_utmi_data;
 	platform_device_register(&tegra_ehci3_device);
 
-	tegra_ehci2_device.dev.platform_data = &ehci_ulpi_data;
 	platform_device_register(&tegra_ehci2_device);
 
 	err = gpio_request_one(TRIMSLICE_GPIO_USB1_MODE, GPIOF_OUT_INIT_HIGH,
@@ -141,7 +123,6 @@ static void trimslice_usb_init(void)
 		return;
 	}
 
-	tegra_ehci1_device.dev.platform_data = &ehci_utmi_data;
 	platform_device_register(&tegra_ehci1_device);
 }
 
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 066eaf9..57e35d2 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -23,10 +23,13 @@
 #include <linux/fsl_devices.h>
 #include <linux/serial_8250.h>
 #include <linux/i2c-tegra.h>
+#include <linux/platform_data/tegra_usb.h>
 #include <asm/pmu.h>
 #include <mach/irqs.h>
 #include <mach/iomap.h>
 #include <mach/dma.h>
+#include <mach/usb_phy.h>
+#include "gpio-names.h"
 
 static struct resource i2c_resource1[] = {
 	[0] = {
@@ -351,6 +354,28 @@ static struct resource tegra_usb3_resources[] = {
 	},
 };
 
+static struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config = {
+	/* All existing boards use GPIO PV0 for phy reset */
+	.reset_gpio = TEGRA_GPIO_PV0,
+	.clk = "cdev2",
+};
+
+static struct tegra_ehci_platform_data tegra_ehci1_pdata = {
+	.operating_mode = TEGRA_USB_OTG,
+	.power_down_on_bus_suspend = 1,
+};
+
+static struct tegra_ehci_platform_data tegra_ehci2_pdata = {
+	.phy_config = &tegra_ehci2_ulpi_phy_config,
+	.operating_mode = TEGRA_USB_HOST,
+	.power_down_on_bus_suspend = 1,
+};
+
+static struct tegra_ehci_platform_data tegra_ehci3_pdata = {
+	.operating_mode = TEGRA_USB_HOST,
+	.power_down_on_bus_suspend = 1,
+};
+
 static u64 tegra_ehci_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device tegra_ehci1_device = {
@@ -359,6 +384,7 @@ struct platform_device tegra_ehci1_device = {
 	.dev	= {
 		.dma_mask	= &tegra_ehci_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &tegra_ehci1_pdata,
 	},
 	.resource = tegra_usb1_resources,
 	.num_resources = ARRAY_SIZE(tegra_usb1_resources),
@@ -370,6 +396,7 @@ struct platform_device tegra_ehci2_device = {
 	.dev	= {
 		.dma_mask	= &tegra_ehci_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &tegra_ehci2_pdata,
 	},
 	.resource = tegra_usb2_resources,
 	.num_resources = ARRAY_SIZE(tegra_usb2_resources),
@@ -381,6 +408,7 @@ struct platform_device tegra_ehci3_device = {
 	.dev	= {
 		.dma_mask	= &tegra_ehci_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &tegra_ehci3_pdata,
 	},
 	.resource = tegra_usb3_resources,
 	.num_resources = ARRAY_SIZE(tegra_usb3_resources),
-- 
1.7.4.1
