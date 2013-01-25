From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 20:53:54 +0000
Subject: [PATCH V3 2/8] ARM: kirkwood: topkick: convert to pinctrl
In-Reply-To: <cover.1359146831.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359146831.git.jason@lakedaemon.net>
Message-ID: <f6d483f3fb83826bce16f956afa013f0bcf11f52.1359146831.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-topkick.dts     | 88 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-usi_topkick.c | 42 --------------
 2 files changed, 88 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 23c2ddc..d959873 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
 
 / {
 	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
@@ -16,6 +17,93 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			/*
+			 * GPIO LED layout
+			 *
+			 *       /-SYS_LED(2)
+			 *       |
+			 *       |   /-DISK_LED
+			 *       |   |
+			 *       |   |   /-WLAN_LED(2)
+			 *       |   |   |
+			 * [SW] [*] [*] [*]
+			 */
+
+			/*
+			 * Switch positions
+			 *
+			 *     /-SW_LEFT(2)
+			 *     |
+			 *     |   /-SW_IDLE
+			 *     |   |
+			 *     |   |   /-SW_RIGHT
+			 *     |   |   |
+			 * PS [L] [I] [R] LEDS
+			 */
+			pinctrl-0 = < &pmx_led_disk_yellow
+				      &pmx_sata0_pwr_enable
+				      &pmx_led_sys_red
+				      &pmx_led_sys_blue
+				      &pmx_led_wifi_green
+				      &pmx_sw_left
+				      &pmx_sw_right
+				      &pmx_sw_idle
+				      &pmx_sw_left2
+				      &pmx_led_wifi_yellow >;
+			pinctrl-names = "default";
+
+			pmx_led_disk_yellow: pmx-led-disk-yellow {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+
+			pmx_sata0_pwr_enable: pmx-sata0-pwr-enable {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_red: pmx-led-sys-red {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_blue: pmx-led-sys-blue {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_wifi_green: pmx-led-wifi-green {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_sw_left: pmx-sw-left {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+
+			pmx_sw_right: pmx-sw-right {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_sw_idle: pmx-sw-idle {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+
+			pmx_sw_left2: pmx-sw-left2 {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_wifi_yellow: pmx-led-wifi-yellow {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+		};
+
 		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "ok";
diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
index 95f0711..1cc04ec 100644
--- a/arch/arm/mach-kirkwood/board-usi_topkick.c
+++ b/arch/arm/mach-kirkwood/board-usi_topkick.c
@@ -15,57 +15,15 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data topkick_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
-/*
- * GPIO LED layout
- *
- *       /-SYS_LED(2)
- *       |
- *       |   /-DISK_LED
- *       |   |
- *       |   |   /-WLAN_LED(2)
- *       |   |   |
- * [SW] [*] [*] [*]
- */
-
-/*
- * Switch positions
- *
- *     /-SW_LEFT
- *     |
- *     |   /-SW_IDLE
- *     |   |
- *     |   |   /-SW_RIGHT
- *     |   |   |
- * PS [L] [I] [R] LEDS
- */
-
-static unsigned int topkick_mpp_config[] __initdata = {
-	MPP21_GPIO,	/* DISK_LED           (low active) - yellow */
-	MPP36_GPIO,	/* SATA0 power enable (high active) */
-	MPP37_GPIO,	/* SYS_LED2           (low active) - red */
-	MPP38_GPIO,	/* SYS_LED            (low active) - blue */
-	MPP39_GPIO,	/* WLAN_LED           (low active) - green */
-	MPP43_GPIO,	/* SW_LEFT            (low active) */
-	MPP44_GPIO,     /* SW_RIGHT           (low active) */
-	MPP45_GPIO,	/* SW_IDLE            (low active) */
-	MPP46_GPIO,     /* SW_LEFT            (low active) */
-	MPP48_GPIO,	/* WLAN_LED2          (low active) - yellow */
-	0
-};
-
 void __init usi_topkick_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_mpp_conf(topkick_mpp_config);
-
-
 	kirkwood_ge00_init(&topkick_ge00_data);
 }
-- 
1.8.1.1
