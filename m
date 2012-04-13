From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 16:42:05 -0600
Subject: [PATCH 4/5] ARM: tegra: don't hard-code USB ULPI PHY reset_gpio
In-Reply-To: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
References: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1334356926-4275-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Not all boards use GPIO_PV0 as the ULPI PHY reset signal. Instead of
hard-coding this GPIO into devices.c, make the board files set it
explicitly. This will allow the PHY code to differentiate between set and
unset values, and hence know when to read the value from device tree.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-paz00.c     |    2 ++
 arch/arm/mach-tegra/board-trimslice.c |    2 ++
 arch/arm/mach-tegra/devices.c         |    5 ++---
 arch/arm/mach-tegra/devices.h         |    4 ++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index aebfa40..e31317d 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -159,6 +159,8 @@ static void paz00_i2c_init(void)
 
 static void paz00_usb_init(void)
 {
+	tegra_ehci2_ulpi_phy_config.reset_gpio = TEGRA_ULPI_RST;
+
 	platform_device_register(&tegra_ehci2_device);
 	platform_device_register(&tegra_ehci3_device);
 }
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 7a21cf5..c6edfe0 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -116,6 +116,8 @@ static void trimslice_usb_init(void)
 	pdata = tegra_ehci1_device.dev.platform_data;
 	pdata->vbus_gpio = TRIMSLICE_GPIO_USB1_MODE;
 
+	tegra_ehci2_ulpi_phy_config.reset_gpio = TEGRA_GPIO_PV0;
+
 	platform_device_register(&tegra_ehci3_device);
 	platform_device_register(&tegra_ehci2_device);
 	platform_device_register(&tegra_ehci1_device);
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 2d8dfa2..c70e65f 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -439,9 +439,8 @@ static struct resource tegra_usb3_resources[] = {
 	},
 };
 
-static struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config = {
-	/* All existing boards use GPIO PV0 for phy reset */
-	.reset_gpio = TEGRA_GPIO_PV0,
+struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config = {
+	.reset_gpio = -1,
 	.clk = "cdev2",
 };
 
diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devices.h
index 138c642..4f50527 100644
--- a/arch/arm/mach-tegra/devices.h
+++ b/arch/arm/mach-tegra/devices.h
@@ -22,6 +22,10 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/tegra_usb.h>
 
+#include <mach/usb_phy.h>
+
+extern struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config;
+
 extern struct tegra_ehci_platform_data tegra_ehci1_pdata;
 extern struct tegra_ehci_platform_data tegra_ehci2_pdata;
 extern struct tegra_ehci_platform_data tegra_ehci3_pdata;
-- 
1.7.0.4
