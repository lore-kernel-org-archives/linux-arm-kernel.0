From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 27 Jan 2015 15:10:15 +0100
Subject: [PATCH 8/9] ARM: berlin: add BG2Q node for the nand
In-Reply-To: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1422367816-4257-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the nand controller of the Marvell Berlin BG2Q
SoC. It uses the pxa3xx nand driver, with a dedicated compatible.

Also add the corresponding pinmuxing configuration.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index e2f61f27944e..f1bc614f0281 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -359,6 +359,11 @@
 			clocks = <&refclk>;
 			clock-names = "refclk";
 
+			nand_pmux: nand-pmux {
+				groups = "G0", "G1";
+				function = "nand";
+			};
+
 			twsi0_pmux: twsi0-pmux {
 				groups = "G6";
 				function = "twsi0";
@@ -429,6 +434,22 @@
 			status = "disabled";
 		};
 
+		nand0: nand at f00000 {
+			compatible = "marvell,berlin2-nand";
+			reg = <0xf00000 0x10000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_NFC>,
+				 <&chip CLKID_NFC_ECC>;
+			clock-names = "nfc", "ecc";
+
+			pinctrl-0 = <&nand_pmux>;
+			pinctrl-names = "default";
+
+			#address-cells = <1>;
+
+			status = "disabled";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.2.2
