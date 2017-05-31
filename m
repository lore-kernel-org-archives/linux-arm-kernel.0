From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 May 2017 15:58:20 +0800
Subject: [PATCH v2 2/6] ARM: sun8i: a83t: Add device node for PRCM
In-Reply-To: <20170531075824.657-1-wens@csie.org>
References: <20170531075824.657-1-wens@csie.org>
Message-ID: <20170531075824.657-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T's PRCM has the same set of clocks and resets as the A64.
However, a few dividers are different. And due to the lack of a low
speed 32.768 kHz oscillator, a few of the clock parents are different.

The PRCM also has controls for various power domains. These are not
supported yet, neither in software nor in the device tree binding.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 1dc4cfe81534..49aeb56970ba 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -270,5 +270,15 @@
 			#interrupt-cells = <3>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
+
+		r_ccu: clock at 1f01400 {
+			compatible = "allwinner,sun8i-a83t-r-ccu";
+			reg = <0x01f01400 0x400>;
+			clocks = <&osc24M>, <&osc16Md512>, <&osc16M>,
+				 <&ccu 6>;
+			clock-names = "hosc", "losc", "iosc", "pll-periph";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.11.0
