From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:27 +0800
Subject: [PATCH 7/8] ARM: dts: append DTS file of pxa168
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DTS files of both PXA168 and aspenite are appended.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/boot/dts/pxa168-aspenite.dts |   38 +++++++++++++
 arch/arm/boot/dts/pxa168.dtsi         |   96 +++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa168-aspenite.dts
 create mode 100644 arch/arm/boot/dts/pxa168.dtsi

diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/pxa168-aspenite.dts
new file mode 100644
index 0000000..e762fac
--- /dev/null
+++ b/arch/arm/boot/dts/pxa168-aspenite.dts
@@ -0,0 +1,38 @@
+/*
+ *  Copyright (C) 2012 Marvell Technology Group Ltd.
+ *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/include/ "pxa168.dtsi"
+
+/ {
+	model = "Marvell PXA168 Aspenite Development Board";
+	compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
+	};
+
+	memory {
+		reg = <0x00000000 0x04000000>;
+	};
+
+	soc {
+		apb at d4000000 {
+			uart1: uart at d4017000 {
+				status = "okay";
+			};
+			twsi1: i2c at d4011000 {
+				status = "okay";
+			};
+			rtc: rtc at d4010000 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
new file mode 100644
index 0000000..e624c10
--- /dev/null
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -0,0 +1,96 @@
+/*
+ *  Copyright (C) 2012 Marvell Technology Group Ltd.
+ *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+	};
+
+	intc: intc-interrupt-controller at d4282000 {
+		compatible = "mrvl,mmp-intc", "mrvl,intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xd4282000 0x1000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		apb at d4000000 {	/* APB */
+			compatible = "mrvl,apb-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4000000 0x00200000>;
+			ranges;
+
+			uart1: uart at d4017000 {
+				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				reg = <0xd4017000 0x1000>;
+				interrupts = <27>;
+				status = "disabled";
+			};
+
+			uart2: uart at d4018000 {
+				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				reg = <0xd4018000 0x1000>;
+				interrupts = <28>;
+				status = "disabled";
+			};
+
+			uart3: uart at d4026000 {
+				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				reg = <0xd4026000 0x1000>;
+				interrupts = <29>;
+				status = "disabled";
+			};
+
+			gpio: gpio at d4019000 {
+				compatible = "mrvl,mmp-gpio", "mrvl,pxa-gpio";
+				reg = <0xd4019000 0x1000>;
+				interrupts = <49>;
+				gpio-controller;
+				#gpio-cells = <1>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				mrvl,gpio-irq0 = <17>;
+				mrvl,gpio-irq1 = <18>;
+			};
+
+			twsi1: i2c at d4011000 {
+				compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+				reg = <0xd4011000 0x1000>;
+				interrupts = <7>;
+				mrvl,i2c-mode = "fast";
+				status = "disabled";
+			};
+
+			twsi2: i2c at d4025000 {
+				compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+				reg = <0xd4025000 0x1000>;
+				interrupts = <58>;
+				status = "disabled";
+			};
+
+			rtc: rtc at d4010000 {
+				compatible = "mrvl,mmp-rtc";
+				reg = <0xd4010000 0x1000>;
+				interrupts = <6 5>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
1.7.0.4
