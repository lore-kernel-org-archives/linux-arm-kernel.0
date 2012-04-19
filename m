From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Apr 2012 21:36:38 +0100
Subject: [PATCH 09/15] ARM: ux500: Correctly describe SMSC9115 for Snowball in
 DT
In-Reply-To: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334867804-31942-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we split the description of the external-bus at 50000000 over
two description files. In the more generic db8500 description file
we only specify the external-bus. Normally this would be used to
communicate with a NOR-flash device. On the Snowball however, the
SMSC9115 Ethernet chip occupies it. In the Snowball board specific
description file is where we actually specify that it is in fact the
Ethernet device which lives here.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi  |    9 +++++++++
 arch/arm/boot/dts/snowball.dts |   10 +++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 9e8ff2c..f633210 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -307,5 +307,14 @@
 			interrupts = <0 100 0x4>;
 			status = "disabled";
 		};
+
+		external-bus at 50000000 {
+			compatible = "simple-bus";
+			reg = <0x50000000 0x4000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x50000000 0x4000000>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 22b82cc..56f8a76 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -72,15 +72,11 @@
 
 	soc-u9500 {
 		external-bus at 50000000 {
-			compatible = "simple-bus";
-			reg = <0x50000000 0x10000000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+			status = "okay";
 
-			ethernet at 50000000 {
+			ethernet at 0 {
 				compatible = "smsc,lan9115";
-				reg = <0x50000000 0x10000>;
+				reg = <0 0x10000>;
 				interrupts = <12 0x1>;
 				interrupt-parent = <&gpio4>;
 
-- 
1.7.9.1
