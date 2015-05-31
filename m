From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 31 May 2015 11:15:08 +0200
Subject: [PATCH v3 4/4] ARM: dts: sun7i: Add A20 SRAM and SRAM controller
In-Reply-To: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1433063708-11726-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 has a few SRAM that can be mapped either to a device or to the CPU,
with the mapping being controlled by a SRAM controller.

Add the SRAM controller, the SRAM that it drives and the section that can
be used by the various devices.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 25bd4f1d393c..6a63f30c9a69 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -534,6 +534,42 @@
 		#size-cells = <1>;
 		ranges;
 
+		sram-controller at 01c00000 {
+			compatible = "allwinner,sun4i-a10-sram-controller";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_a: sram at 00000000 {
+				compatible = "mmio-sram";
+				reg = <0x00000000 0xc000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00000000 0xc000>;
+
+				emac_sram: sram-section at 8000 {
+					compatible = "allwinner,sun4i-a10-sram-a3-a4";
+					reg = <0x8000 0x4000>;
+					status = "disabled";
+				};
+			};
+
+			sram_d: sram at 00010000 {
+				compatible = "mmio-sram";
+				reg = <0x00010000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00010000 0x1000>;
+
+				otg_sram: sram-section at 0000 {
+					compatible = "allwinner,sun4i-a10-sram-d";
+					reg = <0x0000 0x1000>;
+					status = "disabled";
+				};
+			};
+		};
+
 		nmi_intc: interrupt-controller at 01c00030 {
 			compatible = "allwinner,sun7i-a20-sc-nmi";
 			interrupt-controller;
@@ -583,6 +619,7 @@
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 17>;
+			allwinner,sram = <&emac_sram 1>;
 			status = "disabled";
 		};
 
-- 
2.4.1
