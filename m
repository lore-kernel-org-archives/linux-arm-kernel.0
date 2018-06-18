From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 18 Jun 2018 11:15:44 +0300
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
Message-ID: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following sensors are on I2C3 on the baseboard:
* isil,isl29023 light sensor
* fsl,mag3110 magnetometer
* fsl,mma8451 accelerometer

Added under i2cmux/i2c at 1 because they're not otherwise accessible.

These are all supported by iio with following configs:
* CONFIG_SENSORS_ISL29018
* CONFIG_MAG3110
* CONFIG_MMA8452

Tested with raw reads from iio sysfs.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Changes since v1:
 * adjusted node names (Fabio)

Link: https://lkml.org/lkml/2018/6/7/970

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 0e28e36ddbb2..a59a0fd1eb02 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -153,10 +153,31 @@
 				compatible = "maxim,max7310";
 				reg = <0x34>;
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
+
+			light-sensor at 44 {
+				compatible = "isil,isl29023";
+				reg = <0x44>;
+				interrupt-parent = <&gpio5>;
+				interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+			};
+
+			magnetometer at e {
+				compatible = "fsl,mag3110";
+				reg = <0x0e>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <29 IRQ_TYPE_EDGE_RISING>;
+			};
+
+			accelerometer at 1c {
+				compatible = "fsl,mma8451";
+				reg = <0x1c>;
+				interrupt-parent = <&gpio6>;
+				interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+			};
 		};
 	};
 };
 
 &ipu1_csi0_from_ipu1_csi0_mux {
-- 
2.17.1
