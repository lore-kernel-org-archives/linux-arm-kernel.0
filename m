From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 13 Sep 2012 21:24:45 +0530
Subject: [PATCH 2/2] ARM: dts: AM33XX: Add lis331dlh device tree data to
 am335x-evm
In-Reply-To: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
References: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
Message-ID: <1347551685-19781-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lis331dlh device tree data to am335x-evm.dts. In AM335x EVM
lis331dlh accelerometer is connected to I2C2 bus. So this patch
change the status to "okay" to use I2C2 bus. Also added all the
required platform data to am335x-evm.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 9fb59c5..9e5a878 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -47,6 +47,15 @@
 			};
 		};
 
+		i2c2: i2c at 4802a000 {
+			status = "okay";
+			clock-frequency = <400000>;
+
+			lis331dlh: lis331dlh at 18 {
+				reg = <0x18>;
+			};
+		};
+
 		dcan1: d_can at 481d0000 {
 			status = "okay";
 			pinctrl-names = "default";
@@ -61,6 +70,39 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-boot-on;
 	};
+
+	lis3_reg: fixedregulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "lis3_reg";
+		regulator-boot-on;
+	};
+};
+
+&lis331dlh {
+	compatible = "st,lis3lv02d-i2c";
+	Vdd-supply = <&lis3_reg>;
+	Vdd_IO-supply = <&lis3_reg>;
+
+	st,click-single-x;
+	st,click-single-y;
+	st,click-single-z;
+	st,click-thresh-x = <10>;
+	st,click-thresh-y = <10>;
+	st,click-thresh-z = <10>;
+	st,irq1-click;
+	st,irq2-click;
+	st,wakeup-x-lo;
+	st,wakeup-x-hi;
+	st,wakeup-y-lo;
+	st,wakeup-y-hi;
+	st,wakeup-z-lo;
+	st,wakeup-z-hi;
+	st,min-limit-x = <120>;
+	st,min-limit-y = <120>;
+	st,min-limit-z = <140>;
+	st,max-limit-x = <550>;
+	st,max-limit-y = <550>;
+	st,max-limit-z = <750>;
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.9.5
