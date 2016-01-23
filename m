From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 23 Jan 2016 22:37:17 +0200
Subject: [PATCH] ARM: DTS: kirkwood-openrd: provide template for RS-232/485
 configuration
Message-ID: <1453581437-14135-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some OpenRD boards have RS-232 and RS-486 connectors wired, but using them
needs a custom DTB as the current DTB configures SD card slot instead.

This patch adds documentation into the DTS on how to change
the configuration.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/kirkwood-openrd.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
index f65b727..24f1d30 100644
--- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
+++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
@@ -40,7 +40,7 @@
 			pinctrl-0 = <&pmx_select28 &pmx_sdio_cd &pmx_select34>;
 			pinctrl-names = "default";
 
-			pmx_select28: pmx-select-rs232-rs484 {
+			pmx_select28: pmx-select-rs232-rs485 {
 				marvell,pins = "mpp28";
 				marvell,function = "gpio";
 			};
@@ -65,10 +65,39 @@
 			status = "okay";
 			cd-gpios = <&gpio0 29 9>;
 		};
+		gpio at 10100 {
+			p28 {
+				gpio-hog;
+				gpios = <28 GPIO_ACTIVE_HIGH>;
+				/*
+				 * SelRS232or485 selects between RS-232 or RS-485
+				 * mode for the second UART.
+				 *
+				 * Low: RS-232
+				 * High: RS-485
+				 *
+				 * To use the second UART, you need to change also
+				 * the SelUARTorSD.
+				 */
+				output-low;
+				line-name = "SelRS232or485";
+			};
+		};
 		gpio at 10140 {
 			p2 {
 				gpio-hog;
 				gpios = <2 GPIO_ACTIVE_HIGH>;
+				/*
+				 * SelUARTorSD selects between the second UART
+				 * (serial at 12100) and SD (mvsdio at 90000).
+				 *
+				 * Low: UART
+				 * High: SD
+				 *
+				 * When changing this line make sure the newly
+				 * selected device node is enabled and the
+				 * previously selected device node is disabled.
+				 */
 				output-high; /* Select SD by default */
 				line-name = "SelUARTorSD";
 			};
-- 
2.4.0
