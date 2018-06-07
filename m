From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu,  7 Jun 2018 20:00:55 +0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
Message-ID: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
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

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 54b0139e978d..a6193240259d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -160,10 +160,31 @@
 				compatible = "maxim,max7310";
 				reg = <0x34>;
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
+
+			isl29023 at 44 {
+				compatible = "isil,isl29023";
+				reg = <0x44>;
+				interrupt-parent = <&gpio5>;
+				interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+			};
+
+			mag3110 at 0e {
+				compatible = "fsl,mag3110";
+				reg = <0x0e>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <29 IRQ_TYPE_EDGE_RISING>;
+			};
+
+			mma8451 at 1c {
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
