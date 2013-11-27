From: denis@eukrea.com (Denis Carikli)
Date: Wed, 27 Nov 2013 16:39:30 +0100
Subject: =?UTF-8?q?=5BPATCH=202/3=5D=20ARM=3A=20dts=3A=20mbimxsd53=20Add=20backlight=20and=20LCD=20regulator=2E?=
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Message-ID: <1385566771-366-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree at vger.kernel.org
Cc: linux-pwm at vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi       |    7 +++
 .../imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts  |   64 ++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts

diff --git a/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi b/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
index cb40cf3..bad044f 100644
--- a/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
+++ b/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
@@ -35,6 +35,13 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	pmic: mc34708 at 8 {
+		compatible = "fsl,mc34708";
+		reg = <0x8>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 0x4>;
+	};
+
 	pcf8563 at 51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
diff --git a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..b9eceae
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx53-eukrea-mbimxsd53-baseboard.dts"
+
+/ {
+	backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&reg_lvds_backlight_3v3>;
+		pwms = <&mc13xxx_pwm 0 16000>;
+		brightness-levels = <0 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
+	mc13xxx_pwm: pwm {
+		compatible = "fsl,mc34708-pwm";
+		mfd = <&pmic>;
+		#pwm-cells = <2>;
+	};
+
+	reg_lvds_backlight_3v3: lvds-backlight-en {
+		  compatible = "regulator-fixed";
+		  pinctrl-names = "default";
+		  pinctrl-0 = <&pinctrl_reg_lvds_backlight>;
+		  regulator-name = "lvds-3v3";
+		  regulator-min-microvolt = <3300000>;
+		  regulator-max-microvolt = <3300000>;
+		  gpios = <&gpio4 4 0>;
+		  enable-active-high;
+	};
+
+	reg_lcd_3v3: lcd-en {
+		  compatible = "regulator-fixed";
+		  pinctrl-names = "default";
+		  pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		  regulator-name = "lcd-3v3";
+		  regulator-min-microvolt = <3300000>;
+		  regulator-max-microvolt = <3300000>;
+		  gpios = <&gpio4 20 0>;
+		  enable-active-high;
+	  };
+};
+
+&iomuxc {
+	imx53-eukrea {
+		pinctrl_reg_lcd_3v3: reg_lcd_3v3grp {
+			fsl,pins = <MX53_PAD_DI0_PIN4__GPIO4_20 0x80000000>;
+		};
+
+		pinctrl_reg_lvds_backlight: reg_lvds_backlightgrp {
+			fsl,pins = <MX53_PAD_GPIO_14__GPIO4_4 0x80000000>;
+		};
+	};
+};
-- 
1.7.9.5
