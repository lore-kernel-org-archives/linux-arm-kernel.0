From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Aug 2018 13:38:49 +0800
Subject: [PATCH] arm64: dts: allwinner: h5: Add device node for Mali-450 GPU
Message-ID: <20180824053849.7666-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H5 has a Mali-450 GPU with 4 Pixel Processor cores.

Interestingly, while the datasheet lists an interrupt line for the GPU's
PMU, the hardware block itself doesn't seem to have it. Reads from the
PMU address range all return zero, and writes are ignored.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This was tested with ARM's kernel driver from 

    https://github.com/superna9999/meson_gx_mali_450

patched with sunxi glue, and userspace driver from

    https://github.com/rockchip-linux/libmali

es2gears achieves ~60 fps once the PMU is removed.

---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 62d646baac3c..b41dc1aab67d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -92,6 +92,49 @@
 			     <GIC_PPI 10
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	soc {
+		mali: gpu at 1e80000 {
+			compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
+			reg = <0x01e80000 0x30000>;
+			/*
+			 * While the datasheet lists an interrupt for the
+			 * PMU, the actual silicon does not have the PMU
+			 * block. Reads all return zero, and writes are
+			 * ignored.
+			 */
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pp2",
+					  "ppmmu2",
+					  "pp3",
+					  "ppmmu3",
+					  "pmu";
+			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_BUS_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <384000000>;
+		};
+	};
 };
 
 &ccu {
-- 
2.18.0
