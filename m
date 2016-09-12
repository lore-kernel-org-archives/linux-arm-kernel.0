From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Mon, 12 Sep 2016 20:12:44 +0200
Subject: [PATCH v5 2/5] dts: sun8i-h3: split off RTS/CTS for UART1 in seperate
 pinmux
In-Reply-To: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
References: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473703967-21356-3-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This was done to make UART1-3 on H3 consistent, and less complicated to
enable UART1-3 on the breakout header on the several H3 board (notably
Orange Pi's). This patch adds a bit of complexity for the existing Banana
Pi, which already had the RTS/CTS associated on UART1.

The RTS/CTS for UART2-3 could be defined in the same way, but since
there is no actual use case for them at the moment, they are left out.

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts |  2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index f3b1d5f..06fddaa 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -185,7 +185,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>;
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 665fa32..742bced 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -367,8 +367,15 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart1_pins_a: uart1 at 0 {
-				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
+			uart1_pins: uart1 {
+				allwinner,pins = "PG6", "PG7";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart1_rts_cts_pins: uart1_rts_cts {
+				allwinner,pins = "PG8", "PG9";
 				allwinner,function = "uart1";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.7.4
