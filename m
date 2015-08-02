From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  2 Aug 2015 23:55:51 +0200
Subject: [PATCH 1/4] ARM: nomadik: move hog code to use DT hogs
Message-ID: <1438552551-4480-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of introducing a board-specific DT node for biasing the
MMC/SD and SATA ports, use the new device tree hogs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 18 +++++++++--------
 arch/arm/boot/dts/ste-nomadik-s8815.dts | 18 +++++++++--------
 arch/arm/mach-nomadik/cpu-8815.c        | 36 ---------------------------------
 3 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 3d25dba143a5..0e167ed2857b 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -131,6 +131,16 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				/*
+				 * This will turn off SATA so that MMC/SD
+				 * can thrive
+				 */
+				mmcsd-gpio {
+					gpio-hog;
+					gpios = <2 0x0>;
+					output-low;
+					line-name = "SATA EN";
+				};
 			};
 		};
 	};
@@ -141,12 +151,4 @@
 			wp-gpios = <&stmpe_gpio44 18 GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-	/* Custom board node with GPIO pins to active etc */
-	usb-s8815 {
-		/* This will turn off SATA so that MMC/SD can thrive */
-		mmcsd-gpio {
-			gpios = <&stmpe_gpio44 2 0x1>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 3c140d05f796..edcfe2413ee7 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -19,6 +19,16 @@
 		serial1 = &uart1;
 	};
 
+	gpio3: gpio at 101e7000 {
+		/* This hog will bias the MMC/SD card detect line */
+		mmcsd-gpio {
+			gpio-hog;
+			gpios = <16 0x0>;
+			output-low;
+			line-name = "card detect bias";
+		};
+	};
+
 	src at 101e0000 {
 		/* These chrystal drivers are not used on this board */
 		disable-sxtalo;
@@ -109,14 +119,6 @@
 		};
 	};
 
-	/* Custom board node with GPIO pins to active etc */
-	usb-s8815 {
-		/* This will bias the MMC/SD card detect line */
-		mmcsd-gpio {
-			gpios = <&gpio3 16 0x1>;
-		};
-	};
-
 	/* The user LED on the board is set up to be used for heartbeat */
 	leds {
 		compatible = "gpio-leds";
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 9bda46f1fab7..82831dc6122f 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -26,10 +26,8 @@
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -109,40 +107,6 @@ static void cpu8815_restart(enum reboot_mode mode, const char *cmd)
 	writel(1, srcbase + 0x18);
 }
 
-/*
- * This GPIO pin turns on a line that is used to detect card insertion
- * on this board.
- */
-static int __init cpu8815_mmcsd_init(void)
-{
-	struct device_node *cdbias;
-	int gpio, err;
-
-	cdbias = of_find_node_by_path("/usb-s8815/mmcsd-gpio");
-	if (!cdbias) {
-		pr_info("could not find MMC/SD card detect bias node\n");
-		return 0;
-	}
-	gpio = of_get_gpio(cdbias, 0);
-	if (gpio < 0) {
-		pr_info("could not obtain MMC/SD card detect bias GPIO\n");
-		return 0;
-	}
-	err = gpio_request(gpio, "card detect bias");
-	if (err) {
-		pr_info("failed to request card detect bias GPIO %d\n", gpio);
-		return -ENODEV;
-	}
-	err = gpio_direction_output(gpio, 0);
-	if (err){
-		pr_info("failed to set GPIO %d as output, low\n", gpio);
-		return err;
-	}
-	pr_info("enabled USB-S8815 CD bias GPIO %d, low\n", gpio);
-	return 0;
-}
-device_initcall(cpu8815_mmcsd_init);
-
 static const char * cpu8815_board_compat[] = {
 	"st,nomadik-nhk-15",
 	"calaosystems,usb-s8815",
-- 
2.4.3
