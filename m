From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 20:50:14 +0000
Subject: [PATCH V4 05/11] ARM: kirkwood: nsa310: convert to pinctrl
In-Reply-To: <cover.1359232975.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359232975.git.jason@lakedaemon.net>
Message-ID: <655862a52c4f90a3f90a566824b495c2017c3c5b.1359232975.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-nsa310.dts | 99 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c     |  3 --
 arch/arm/mach-kirkwood/board-nsa310.c | 26 ---------
 arch/arm/mach-kirkwood/common.h       |  6 ---
 4 files changed, 99 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index dbb3551..3a178cf 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -16,6 +16,105 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-0 = < &pmx_led_esata_green
+				      &pmx_led_esata_red
+				      &pmx_led_usb_green
+				      &pmx_led_usb_red
+				      &pmx_usb_power_off
+				      &pmx_led_sys_green
+				      &pmx_led_sys_red
+				      &pmx_btn_reset
+				      &pmx_btn_copy
+				      &pmx_led_copy_green
+				      &pmx_led_copy_red
+				      &pmx_led_hdd_green
+				      &pmx_led_hdd_red
+				      &pmx_unknown
+				      &pmx_btn_power
+				      &pmx_pwr_off >;
+			pinctrl-names = "default";
+
+			pmx_led_esata_green: pmx-led-esata-green {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_esata_red: pmx-led-esata-red {
+				marvell,pins = "mpp13";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_usb_green: pmx-led-usb-green {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_usb_red: pmx-led-usb-red {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+
+			pmx_usb_power_off: pmx-usb-power-off {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_green: pmx-led-sys-green {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_red: pmx-led-sys-red {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_reset: pmx-btn-reset {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_copy: pmx-btn-copy {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_green: pmx-led-copy-green {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_red: pmx-led-copy-red {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd_green: pmx-led-hdd-green {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd_red: pmx-led-hdd-red {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+
+			pmx_unknown: pmx-unknown {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_power: pmx-btn-power {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+
+			pmx_pwr_off: pmx-pwr-off {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+		};
 
 		serial at 12000 {
 			clock-frequency = <200000000>;
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 8eac548..8b35157 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -141,9 +141,6 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("usi,topkick"))
 		usi_topkick_init();
 
-	if (of_machine_is_compatible("zyxel,nsa310"))
-		nsa310_init();
-
 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
index 0b99533..55ade93 100644
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -13,32 +13,6 @@
 #include <mach/kirkwood.h>
 #include <linux/of.h>
 #include "common.h"
-#include "mpp.h"
-
-static unsigned int nsa310_mpp_config[] __initdata = {
-	MPP12_GPIO, /* led esata green */
-	MPP13_GPIO, /* led esata red */
-	MPP15_GPIO, /* led usb green */
-	MPP16_GPIO, /* led usb red */
-	MPP21_GPIO, /* control usb power off */
-	MPP28_GPIO, /* led sys green */
-	MPP29_GPIO, /* led sys red */
-	MPP36_GPIO, /* key reset */
-	MPP37_GPIO, /* key copy */
-	MPP39_GPIO, /* led copy green */
-	MPP40_GPIO, /* led copy red */
-	MPP41_GPIO, /* led hdd green */
-	MPP42_GPIO, /* led hdd red */
-	MPP44_GPIO, /* ?? */
-	MPP46_GPIO, /* key power */
-	MPP48_GPIO, /* control power off */
-	0
-};
-
-void __init nsa310_init(void)
-{
-	kirkwood_mpp_conf(nsa310_mpp_config);
-}
 
 static int __init nsa310_pci_init(void)
 {
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index e956d02..1c42cb8 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -130,12 +130,6 @@ void ns2_init(void);
 static inline void ns2_init(void) {};
 #endif
 
-#ifdef CONFIG_MACH_NSA310_DT
-void nsa310_init(void);
-#else
-static inline void nsa310_init(void) {};
-#endif
-
 #ifdef CONFIG_MACH_OPENBLOCKS_A6_DT
 void openblocks_a6_init(void);
 #else
-- 
1.8.1.1
