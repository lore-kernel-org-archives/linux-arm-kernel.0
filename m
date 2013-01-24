From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Thu, 24 Jan 2013 16:25:20 +0530
Subject: [PATCH 6/6] ARM: davinci: da850: add tps6507x regulator DT data
In-Reply-To: <1359024920-32190-1-git-send-email-manishv.b@ti.com>
References: <1359024920-32190-1-git-send-email-manishv.b@ti.com>
Message-ID: <1359024920-32190-7-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tps6507x regulator device tree data to da850-evm by
adding regulator consumers with tightened constraints
and regulator-name.TPS6507x regulator handle can be obtained
by using this regulator name.
Regulator constraints are added as per da850 board file.

Regulator names are given as per maximum output voltage the
regulator is capable to provide.
for e.g. regulator name for dcdc1 is "VDCDC1_3.3V".
Also, add tps6507x PMIC I2C slave device under I2C0 node.

Tested on da850-evm.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts |   64 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 3d8290a..605a13e 100755
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -29,8 +29,72 @@
 		};
 		i2c0 at 1c22000 {
 			status = "okay";
+
+			tps: tps at 48 {
+				reg = <0x48>;
+			};
 		};
 	};
+
+	vbat: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+};
+
+/include/ "tps6507x.dtsi"
+
+&tps {
+        vdcdc1_2-supply = <&vbat>;
+        vdcdc3-supply = <&vbat>;
+        vldo1_2-supply = <&vbat>;
+
+        regulators {
+                vdcdc1_reg: regulator at 0 {
+                        regulator-name = "VDCDC1_3.3V";
+                        regulator-min-microvolt = <3150000>;
+                        regulator-max-microvolt = <3450000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                };
+
+                vdcdc2_reg: regulator at 1 {
+                        regulator-name = "VDCDC2_3.3V";
+                        regulator-min-microvolt = <1710000>;
+                        regulator-max-microvolt = <3450000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                        ti,defdcdc_default = <1>;
+                };
+
+                vdcdc3_reg: regulator at 2 {
+                        regulator-name = "VDCDC3_1.2V";
+                        regulator-min-microvolt = <950000>;
+                        regulator-max-microvolt = <1350000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                        ti,defdcdc_default = <1>;
+                };
+
+                ldo1_reg: regulator at 3 {
+                        regulator-name = "LDO1_1.8V";
+                        regulator-min-microvolt = <1710000>;
+                        regulator-max-microvolt = <1890000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                };
+
+                ldo2_reg: regulator at 4 {
+                        regulator-name = "LDO2_1.2V";
+                        regulator-min-microvolt = <1140000>;
+                        regulator-max-microvolt = <1320000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                };
+        };
 };
 &pmx_core {
 	pinctrl-names = "default";
-- 
1.7.4.1
