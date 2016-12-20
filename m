From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 20 Dec 2016 11:27:04 +0100
Subject: [PATCH 2/7] Documentation: DT: bindings: mfd: add documentation for
 Allwinner SoCs' GPADC MFD driver
In-Reply-To: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
Message-ID: <20161220102709.9504-3-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs all have an ADC that can also act as a thermal sensor
and sometimes as a touchscreen controller. If there is a touchscreen
controller, the first four channels can be used either for the ADC or
the touchscreen and the fifth channel is used for the thermal sensor.
If there is not a touchscreen controller, the one and only channel is
used for the thermal sensor.

The Allwinner SoCs already have an existing DT binding for the
touchscreen controller and thermal sensor for the sun4i-ts input driver
which does let the user use the ADC. To keep backward compatibility,
this MFD driver re-uses the same bindings as the sun4i-ts input driver
and will probe the required drivers to make the ADC and thermal sensor
work.

This patch adds the binding documentation for the MFD driver of the
Allwinner SoCs' GPADC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
new file mode 100644
index 0000000..bc4b4f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
@@ -0,0 +1,47 @@
+Allwinner SoCs' GPADC Device Tree bindings
+------------------------------------------
+
+The Allwinner SoCs all have an ADC that can also act as a thermal sensor and
+sometimes as a touchscreen controller. If there is a touchscreen controller, the
+first four channels can be used either for the ADC or the touchscreen and the
+fifth channel is used for the thermal sensor.
+If there is not a touchscreen controller, the one and only channel is used for
+the thermal sensor.
+
+Currently, the touchscreen controller does not have a driver using this ADC
+driver. The touchscreen controller is currently driven only by
+input/touchscreen/sun4i-ts.c which is absolutely incompatible with this driver.
+
+The Allwinner A10, A13 and A31 SoCs already have a DT binding for the
+aforementioned input driver, thus this MFD driver matches the existing DT
+binding (mfd/sun4i-gpadc.c).
+To keep DT binding compatibility, the MFD replaces the sun4i-ts input driver and
+probes required drivers (IIO GPADC driver (iio/adc/sun4i-gpadc-iio.c),
+iio-hwmon and soon the touchscreen driver) without the need for a DT binding for
+each driver.
+
+Required properties:
+ - compatible: one of:
+	- "allwinner,sun4i-a10-ts",
+	- "allwinner,sun5i-a13-ts",
+	- "allwinner,sun6i-a31-ts"
+ - #thermal-sensor-cells = <0>;
+
+Example:
+
+thermal-zones {
+	cpu_thermal {
+		thermal-sensors = <&rtp>;
+		[...]
+	};
+};
+
+soc at 01c00000 {
+	[...]
+	rtp: rtp at 01c25000 {
+		compatible = "allwinner,sun6i-a31-ts";
+		reg = <0x01c25000 0x100>;
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		#thermal-sensor-cells = <0>;
+	};
+};
-- 
2.9.3
