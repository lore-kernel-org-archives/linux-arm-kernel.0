From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jan 2016 09:30:18 +0100
Subject: [PATCH] ARM: dts: at91: sama5d4_xplained: properly mux phy interrupt
Message-ID: <1452846618-17854-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No interrupt were received from the phy because PIOE 1 may not be properly
muxed. It prevented proper link detection, especially since commit
321beec5047a ("net: phy: Use interrupts when available in NOLINK state")
disables polling.

Cc: <stable@vger.kernel.org> # 4.4
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 131614f28e75..8cf9999cb0cd 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -86,6 +86,8 @@
 			macb0: ethernet at f8020000 {
 				phy-mode = "rmii";
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb0_rmii &pinctrl_macb0_phy_irq>;
 
 				phy0: ethernet-phy at 1 {
 					interrupt-parent = <&pioE>;
@@ -152,6 +154,10 @@
 						atmel,pins =
 							<AT91_PIOE 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
 					};
+					pinctrl_macb0_phy_irq: macb0_phy_irq_0 {
+						atmel,pins =
+							<AT91_PIOE 1 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
 				};
 			};
 		};
-- 
2.5.0
