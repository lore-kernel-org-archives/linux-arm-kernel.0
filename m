From: adam.yh.lee@gmail.com (Adam YH Lee)
Date: Thu,  9 Jul 2015 15:37:57 -0700
Subject: [PATCH v2] ARM: dts: configure regulators for Gumstix Pepper
Message-ID: <1436481477-18002-1-git-send-email-adam.yh.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boot process is halting in midway because some of the necessary voltage
regulators are deemed unused and subsequently powered off, leading to
a completely unresponsive system.

Most of the device nodes had correct voltage regulator attachments.
Yet these nodes had to set stricter enforcement on them through
'regulator-boot-on' and 'regulator-always-on' to function correctly.

The consumers of the regulators this commit affect are the followings:

	DCDC1: vdd_1v8 system supply, USB-PHY, and ADC
	DCDC2: Core domain
	DCDC3: MPU core domain
	 LDO1: RTC
	 LDO2: 3v3 IO domain
	 LDO3: USB-PHY; not a boot-time requirement
	 LDO4: LCD [16:23]

All but LDO3 need to be always-on for the system to be functional.

Additionally regulator-name properties have been added for the kernel to
display the name from the schematic. This will improve diagnostics.

Signed-off-by: Adam YH Lee <adam.yh.lee@gmail.com>
---
 arch/arm/boot/dts/am335x-pepper.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 0d35ab6..661f835 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -438,6 +438,7 @@
 	regulators {
 		dcdc1_reg: regulator at 0 {
 			/* VDD_1V8 system supply */
+			regulator-always-on;
 		};
 
 		dcdc2_reg: regulator at 1 {
@@ -446,6 +447,7 @@
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1325000>;
 			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		dcdc3_reg: regulator at 2 {
@@ -454,25 +456,32 @@
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1150000>;
 			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		ldo1_reg: regulator at 3 {
 			/* VRTC 1.8V always-on supply */
+			regulator-name = "vrtc,vdds";
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator at 4 {
 			/* 3.3V rail */
+			regulator-name = "vdd_3v3aux";
+			regulator-always-on;
 		};
 
 		ldo3_reg: regulator at 5 {
 			/* VDD_3V3A 3.3V rail */
+			regulator-name = "vdd_3v3a";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
 		ldo4_reg: regulator at 6 {
 			/* VDD_3V3B 3.3V rail */
+			regulator-name = "vdd_3v3b";
+			regulator-always-on;
 		};
 	};
 };
-- 
2.1.4
