From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:08 +0100
Subject: [PATCH 09/16] ARM: ux500: Provide regulator support for SMSC911x via
 Device Tree
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a fixed regulator for use by the SMSC911x Ethernet
chip driver into the db8500 Device Tree. It also references other
regulators required by the same device.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts   |   13 +++++++++++++
 arch/arm/configs/u8500_defconfig |    1 +
 drivers/mfd/db8500-prcmu.c       |    1 +
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 15ee419..ae3c367 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -20,6 +20,16 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	en_3v3_reg: en_3v3 {
+		compatible = "regulator-fixed";
+                regulator-name = "en-3v3-fixed-supply";
+                regulator-min-microvolt = <3300000>;
+                regulator-max-microvolt = <3300000>;
+                gpios = <&gpio0 26  0x4>; // 26
+                startup-delay-us = <5000>;
+                enable-active-high;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -81,6 +91,9 @@
 				reg = <0 0x10000>;
 				interrupts = <12 0x1>;
 				interrupt-parent = <&gpio4>;
+				vdd33a-supply = <&en_3v3_reg>;
+				vddvario-supply = <&db8500_vape_reg>;
+
 
 				reg-shift = <1>;
 				reg-io-width = <2>;
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index c6973c5..440152a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -75,6 +75,7 @@ CONFIG_AB5500_CORE=y
 CONFIG_AB8500_CORE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AB8500=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_GADGET=y
 CONFIG_AB8500_USB=y
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index d534449..40204e1 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2735,6 +2735,7 @@ static struct regulator_consumer_supply db8500_vape_consumers[] = {
 	REGULATOR_SUPPLY("vcore", "uart2"),
 	REGULATOR_SUPPLY("v-ape", "nmk-ske-keypad.0"),
 	REGULATOR_SUPPLY("v-hsi", "ste_hsi.0"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
 };
 
 static struct regulator_consumer_supply db8500_vsmps2_consumers[] = {
-- 
1.7.9.5
