From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:57 +0100
Subject: [PATCH 08/21] ARM: ux500: create MCDE node to collect resources
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-9-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we need to connect resources such as pin mappings and clocks
when deleting board files, we create a MCDE node even though there
is no driver for it. As it is only using standard bindings right
now, this does not matter much. When a proper driver is written
for the MCDE, it can augment this node with custom properties.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 50ff5ab372d8..e0853ea02df2 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -1002,6 +1002,23 @@
 			status = "disabled";
 		};
 
+		mcde at a0350000 {
+			compatible = "stericsson,mcde";
+			reg = <0xa0350000 0x1000>, /* MCDE */
+			      <0xa0351000 0x1000>, /* DSI link 1 */
+			      <0xa0352000 0x1000>, /* DSI link 2 */
+			      <0xa0353000 0x1000>; /* DSI link 3 */
+			interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
+				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
+				 <&prcmu_clk PRCMU_PLLDSI>, /* HDMI clock */
+				 <&prcmu_clk PRCMU_DSI0CLK>, /* DSI 0 */
+				 <&prcmu_clk PRCMU_DSI1CLK>, /* DSI 1 */
+				 <&prcmu_clk PRCMU_DSI0ESCCLK>, /* TVout clock 0 */
+				 <&prcmu_clk PRCMU_DSI1ESCCLK>, /* TVout clock 1 */
+				 <&prcmu_clk PRCMU_DSI2ESCCLK>; /* TVout clock 2 */
+		};
+
 		cryp at a03cb000 {
 			compatible = "stericsson,ux500-cryp";
 			reg = <0xa03cb000 0x1000>;
-- 
1.8.3.1
