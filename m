From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Jan 2016 11:06:48 +0100
Subject: [PATCH 1/2] ARM: dts: at91: sama5d4ek: add phy address and IRQ for
 macb0
Message-ID: <1453889209-13742-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

On SAMA5D4EK board, the Ethernet doesn't work after resuming from the suspend
state.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
[nicolas.ferre at atmel.com: adapt to newer kernel]
Fixes: 38153a017896 ("ARM: at91/dt: sama5d4: add dts for sama5d4 xplained board")
Cc: <stable@vger.kernel.org> # 4.1+
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d4ek.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 2d4a33100af6..4e98cda97403 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -160,8 +160,15 @@
 			};
 
 			macb0: ethernet at f8020000 {
+				pinctrl-0 = <&pinctrl_macb0_rmii &pinctrl_macb0_phy_irq>;
 				phy-mode = "rmii";
 				status = "okay";
+
+				ethernet-phy at 1 {
+					reg = <0x1>;
+					interrupt-parent = <&pioE>;
+					interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+				};
 			};
 
 			mmc1: mmc at fc000000 {
@@ -193,6 +200,10 @@
 
 			pinctrl at fc06a000 {
 				board {
+					pinctrl_macb0_phy_irq: macb0_phy_irq {
+						atmel,pins =
+							<AT91_PIOE 1 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
 					pinctrl_mmc0_cd: mmc0_cd {
 						atmel,pins =
 							<AT91_PIOE 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
-- 
2.1.3
