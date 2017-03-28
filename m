From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 29 Mar 2017 01:30:13 +0800
Subject: [RFC PATCH 3/3] ARM: sun8i: h3: add support for the thermal sensor in
 H3
In-Reply-To: <20170328173013.16539-1-icenowy@aosc.io>
References: <20170328173013.16539-1-icenowy@aosc.io>
Message-ID: <20170328173013.16539-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have gained the support for the thermal sensor in H3, we can now
add its device nodes to the device tree.

Add them to the H3 device tree.

The H5 thermal sensor has some differences, and will be added furtherly.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index b36f9f423c39..552217bb9266 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -72,6 +72,32 @@
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&ths>;
+	};
+
+	soc {
+		ths: ths at 01c25000 {
+			compatible = "allwinner,sun8i-h3-ths";
+			reg = <0x01c25000 0x100>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "ths";
+			resets = <&ccu RST_BUS_THS>;
+			#thermal-sensor-cells = <0>;
+			#io-channel-cells = <0>;
+		};
+	};
+
+	thermal-zones {
+		cpu_thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.12.0
