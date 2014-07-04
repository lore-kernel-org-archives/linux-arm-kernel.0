From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  4 Jul 2014 15:31:36 -0300
Subject: [PATCH 2/3] ARM: mvebu: Add support for the network controller in
 Armada 375 SoC
In-Reply-To: <1404498697-21978-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1404498697-21978-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1404498697-21978-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the support for the network controller in Marvell
Armada 375 SoC devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index fb92551..5e897d2 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -151,6 +151,37 @@
 				      <0xc100 0x100>;
 			};
 
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "marvell,orion-mdio";
+				reg = <0xc0054 0x4>;
+			};
+
+			/* Network controller */
+			pp2 at f0000 {
+				compatible = "marvell,armada-375-pp2";
+				reg = <0xf0000 0xa000>, /* Packet Processor regs */
+				      <0xc0000 0x3060>, /* LMS regs */
+				      <0xc4000 0x100>,  /* eth0 regs */
+				      <0xc5000 0x100>;  /* eth1 regs */
+				clocks = <&gateclk 3>, <&gateclk 19>;
+				clock-names = "pp_clk", "gop_clk";
+				status = "disabled";
+
+				eth0: ethernet at c4000 {
+					interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+					port-id = <0>;
+					status = "disabled";
+				};
+
+				eth1: ethernet at c5000 {
+					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+					port-id = <1>;
+					status = "disabled";
+				};
+			};
+
 			spi0: spi at 10600 {
 				compatible = "marvell,orion-spi";
 				reg = <0x10600 0x50>;
-- 
1.9.1
