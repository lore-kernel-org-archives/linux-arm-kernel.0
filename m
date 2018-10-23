From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 23 Oct 2018 21:42:03 +0530
Subject: [PATCH] arm64: dts: allwinner: a64: Add device node for Mali-400 GPU
Message-ID: <20181023161203.2956-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Allwinner A64 has Mali-400MP2.

All interrupt lines are mentioned in the manual so used the same.
Used 408MHz as assigned clock rate used by BSP, so used the same as
well.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
- Modules was able to load it on 4.19. 

 .../bindings/gpu/arm,mali-utgard.txt          |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 63cd91176a68..a0ee62a5b221 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -11,6 +11,7 @@ Required properties:
       + allwinner,sun4i-a10-mali
       + allwinner,sun7i-a20-mali
       + allwinner,sun8i-h3-mali
+      + allwinner,sun50i-a64-mali
       + allwinner,sun50i-h5-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f82e6b165d57..2db3aa151902 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -812,6 +812,31 @@
 			};
 		};
 
+		mali: gpu at 1c40000 {
+			compatible = "allwinner,sun50i-a64-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pmu";
+			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_BUS_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <408000000>;
+		};
+
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.18.0.321.gffc6fa0e3
