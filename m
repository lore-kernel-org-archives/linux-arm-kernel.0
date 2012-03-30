From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 16:59:55 -0600
Subject: [PATCH 02/11] ARM: tegra: Remove VBUS_GPIO handling from board files
In-Reply-To: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1333148404-17691-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Instead of having board files manually request and initialize USB VBUS
GPIOs, fill in the USB driver's platform data and have it do it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-seaboard.c  |   17 ++++-------------
 arch/arm/mach-tegra/board-trimslice.c |   15 +++++----------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index 0e2957f..e6642c6 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/platform_data/tegra_usb.h>
 
 #include <sound/wm8903.h>
 
@@ -185,20 +186,10 @@ static struct i2c_board_info __initdata wm8903_device = {
 
 static int seaboard_ehci_init(void)
 {
-	int gpio_status;
+	struct tegra_ehci_platform_data *pdata;
 
-	gpio_status = gpio_request(TEGRA_GPIO_USB1, "VBUS_USB1");
-	if (gpio_status < 0) {
-		pr_err("VBUS_USB1 request GPIO FAILED\n");
-		WARN_ON(1);
-	}
-
-	gpio_status = gpio_direction_output(TEGRA_GPIO_USB1, 1);
-	if (gpio_status < 0) {
-		pr_err("VBUS_USB1 request GPIO DIRECTION FAILED\n");
-		WARN_ON(1);
-	}
-	gpio_set_value(TEGRA_GPIO_USB1, 1);
+	pdata = tegra_ehci1_device.dev.platform_data;
+	pdata->vbus_gpio = TEGRA_GPIO_USB1;
 
 	platform_device_register(&tegra_ehci1_device);
 	platform_device_register(&tegra_ehci3_device);
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index ba2e047..7a21cf5 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/tegra_usb.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
@@ -110,19 +111,13 @@ static void trimslice_i2c_init(void)
 
 static void trimslice_usb_init(void)
 {
-	int err;
+	struct tegra_ehci_platform_data *pdata;
 
-	platform_device_register(&tegra_ehci3_device);
+	pdata = tegra_ehci1_device.dev.platform_data;
+	pdata->vbus_gpio = TRIMSLICE_GPIO_USB1_MODE;
 
+	platform_device_register(&tegra_ehci3_device);
 	platform_device_register(&tegra_ehci2_device);
-
-	err = gpio_request_one(TRIMSLICE_GPIO_USB1_MODE, GPIOF_OUT_INIT_HIGH,
-			       "usb1mode");
-	if (err) {
-		pr_err("TrimSlice: failed to obtain USB1 mode gpio: %d\n", err);
-		return;
-	}
-
 	platform_device_register(&tegra_ehci1_device);
 }
 
-- 
1.7.0.4
