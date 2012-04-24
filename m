From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 10:58:20 +0100
Subject: [PATCH 7.1/15] ARM: ux500: Enable the SMSC9115 on Snowball via Device
 Tree
In-Reply-To: <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
Message-ID: <4F96793C.9080709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 24 Apr 2012 10:53:18 +0100
Subject: [PATCH 07.1/15] ARM: ux500: Enable the SMSC9115 on Snowball via Device Tree

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
 arch/arm/boot/dts/snowball.dts |   22 ++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

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
index 0ba0955..56f8a76 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -72,17 +72,19 @@
 
 	soc-u9500 {
 		external-bus at 50000000 {
-			compatible = "simple-bus";
-			reg = <0x50000000 0x10000000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			ethernet at 50000000 {
-				compatible = "smsc,9111";
-				reg = <0x50000000 0x10000>;
-				interrupts = <12 0x4>;
+			status = "okay";
+
+			ethernet at 0 {
+				compatible = "smsc,lan9115";
+				reg = <0 0x10000>;
+				interrupts = <12 0x1>;
 				interrupt-parent = <&gpio4>;
+
+				reg-shift = <1>;
+				reg-io-width = <2>;
+				smsc,force-internal-phy;
+				smsc,irq-active-high;
+				smsc,irq-push-pull;
 			};
 		};
 
-- 
1.7.9.1
