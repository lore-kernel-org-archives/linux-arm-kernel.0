From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 14 Sep 2017 22:52:50 +0800
Subject: [PATCH v4 5/6] ARM: sun8i: h3: add support for the thermal sensor in
 H3
In-Reply-To: <20170914145251.21784-1-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
Message-ID: <20170914145251.21784-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have gained the support for the thermal sensor in H3, we can now
add its device nodes to the device tree.

Add them to the H3 device tree.

The calibration data of the thermal sensor is still not added, as
it's currently not used, and the SID node is not added yet.

The H5 thermal sensor has some differences, and will be added furtherly.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v4:
- Mention calibration data in commit message.
Changes in v3:
- Clock name changes.
- Splited out thermal zone addition.

 arch/arm/boot/dts/sun8i-h3.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index b36f9f423c39..3220da3ad790 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -72,6 +72,23 @@
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&ths>;
+	};
+
+	soc {
+		ths: thermal-sensor at 1c25000 {
+			compatible = "allwinner,sun8i-h3-ths";
+			reg = <0x01c25000 0x100>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_THS>;
+			#thermal-sensor-cells = <0>;
+			#io-channel-cells = <0>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.13.5
