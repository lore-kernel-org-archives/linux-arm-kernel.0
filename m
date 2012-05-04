From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:25 +0800
Subject: [PATCH v2 8/9] ARM: dts: refresh dts file for arch mmp
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-9-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append mmp2 and pxa910 dts files. Update PXA168 dts files for irq,
timer, gpio components.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/boot/dts/mmp2-brownstone.dts |   38 ++++++
 arch/arm/boot/dts/mmp2.dtsi           |  220 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pxa168.dtsi         |   67 ++++++++---
 arch/arm/boot/dts/pxa910-dkb.dts      |   38 ++++++
 arch/arm/boot/dts/pxa910.dtsi         |  140 +++++++++++++++++++++
 5 files changed, 487 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
 create mode 100644 arch/arm/boot/dts/mmp2.dtsi
 create mode 100644 arch/arm/boot/dts/pxa910-dkb.dts
 create mode 100644 arch/arm/boot/dts/pxa910.dtsi

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
new file mode 100644
index 0000000..153a4b2
--- /dev/null
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
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
+/include/ "mmp2.dtsi"
+
+/ {
+	model = "Marvell MMP2 Aspenite Development Board";
+	compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
+
+	chosen {
+		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
+	};
+
+	memory {
+		reg = <0x00000000 0x04000000>;
+	};
+
+	soc {
+		apb at d4000000 {
+			uart3: uart at d4018000 {
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
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
new file mode 100644
index 0000000..80f74e2
--- /dev/null
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -0,0 +1,220 @@
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
+		serial3 = &uart4;
+		i2c0 = &twsi1;
+		i2c1 = &twsi2;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		axi at d4200000 {	/* AXI */
+			compatible = "mrvl,axi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4200000 0x00200000>;
+			ranges;
+
+			intc: interrupt-controller at d4282000 {
+				compatible = "mrvl,mmp2-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0xd4282000 0x1000>;
+				mrvl,intc-nr-irqs = <64>;
+			};
+
+			intcmux4 at d4282150 {
+				compatible = "mrvl,mmp2-mux-intc";
+				interrupts = <4>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x150 0x4>, <0x168 0x4>;
+				reg-names = "mux status", "mux mask";
+				mrvl,intc-nr-irqs = <2>;
+			};
+
+			intcmux5: interrupt-controller at d4282154 {
+				compatible = "mrvl,mmp2-mux-intc";
+				interrupts = <5>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x154 0x4>, <0x16c 0x4>;
+				reg-names = "mux status", "mux mask";
+				mrvl,intc-nr-irqs = <2>;
+				mrvl,clr-mfp-irq = <1>;
+			};
+
+			intcmux9: interrupt-controller at d4282180 {
+				compatible = "mrvl,mmp2-mux-intc";
+				interrupts = <9>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x180 0x4>, <0x17c 0x4>;
+				reg-names = "mux status", "mux mask";
+				mrvl,intc-nr-irqs = <3>;
+			};
+
+			intcmux17: interrupt-controller at d4282158 {
+				compatible = "mrvl,mmp2-mux-intc";
+				interrupts = <17>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x158 0x4>, <0x170 0x4>;
+				reg-names = "mux status", "mux mask";
+				mrvl,intc-nr-irqs = <5>;
+			};
+
+			intcmux35: interrupt-controller at d428215c {
+				compatible = "mrvl,mmp2-mux-intc";
+				interrupts = <35>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x15c 0x4>, <0x174 0x4>;
+				reg-names = "mux status", "mux mask";
+				mrvl,intc-nr-irqs = <15>;
+			};
+
+			intcmux51: interrupt-controller at d4282160 {
+				compatible = "mrvl,mmp2-mux-intc";
+				interrupts = <51>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x160 0x4>, <0x178 0x4>;
+				reg-names = "mux status", "mux mask";
+				mrvl,intc-nr-irqs = <2>;
+			};
+
+			intcmux55: interrupt-controller at d4282188 {
+				compatible = "mrvl,mmp2-mux-intc";
+				interrupts = <55>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x188 0x4>, <0x184 0x4>;
+				reg-names = "mux status", "mux mask";
+				mrvl,intc-nr-irqs = <2>;
+			};
+		};
+
+		apb at d4000000 {	/* APB */
+			compatible = "mrvl,apb-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4000000 0x00200000>;
+			ranges;
+
+			timer0: timer at d4014000 {
+				compatible = "mrvl,mmp-timer";
+				reg = <0xd4014000 0x100>;
+				interrupts = <13>;
+			};
+
+			uart1: uart at d4030000 {
+				compatible = "mrvl,mmp-uart";
+				reg = <0xd4030000 0x1000>;
+				interrupts = <27>;
+				status = "disabled";
+			};
+
+			uart2: uart at d4017000 {
+				compatible = "mrvl,mmp-uart";
+				reg = <0xd4017000 0x1000>;
+				interrupts = <28>;
+				status = "disabled";
+			};
+
+			uart3: uart at d4018000 {
+				compatible = "mrvl,mmp-uart";
+				reg = <0xd4018000 0x1000>;
+				interrupts = <24>;
+				status = "disabled";
+			};
+
+			uart4: uart at d4016000 {
+				compatible = "mrvl,mmp-uart";
+				reg = <0xd4016000 0x1000>;
+				interrupts = <46>;
+				status = "disabled";
+			};
+
+			gpio at d4019000 {
+				compatible = "mrvl,mmp-gpio";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xd4019000 0x1000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupts = <49>;
+				interrupt-names = "gpio_mux";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				ranges;
+
+				gcb0: gpio at d4019000 {
+					reg = <0xd4019000 0x4>;
+				};
+
+				gcb1: gpio at d4019004 {
+					reg = <0xd4019004 0x4>;
+				};
+
+				gcb2: gpio at d4019008 {
+					reg = <0xd4019008 0x4>;
+				};
+
+				gcb3: gpio at d4019100 {
+					reg = <0xd4019100 0x4>;
+				};
+
+				gcb4: gpio at d4019104 {
+					reg = <0xd4019104 0x4>;
+				};
+
+				gcb5: gpio at d4019108 {
+					reg = <0xd4019108 0x4>;
+				};
+			};
+
+			twsi1: i2c at d4011000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4011000 0x1000>;
+				interrupts = <7>;
+				mrvl,i2c-fast-mode;
+				status = "disabled";
+			};
+
+			twsi2: i2c at d4025000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4025000 0x1000>;
+				interrupts = <58>;
+				status = "disabled";
+			};
+
+			rtc: rtc at d4010000 {
+				compatible = "mrvl,mmp-rtc";
+				reg = <0xd4010000 0x1000>;
+				interrupts = <1 0>;
+				interrupt-names = "rtc 1Hz", "rtc alarm";
+				interrupt-parent = <&intcmux5>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index d32d512..31a7186 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -18,13 +18,6 @@
 		i2c1 = &twsi2;
 	};
 
-	intc: intc-interrupt-controller at d4282000 {
-		compatible = "mrvl,mmp-intc", "mrvl,intc";
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		reg = <0xd4282000 0x1000>;
-	};
-
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -32,6 +25,23 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		axi at d4200000 {	/* AXI */
+			compatible = "mrvl,axi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4200000 0x00200000>;
+			ranges;
+
+			intc: interrupt-controller at d4282000 {
+				compatible = "mrvl,mmp-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0xd4282000 0x1000>;
+				mrvl,intc-nr-irqs = <64>;
+			};
+
+		};
+
 		apb at d4000000 {	/* APB */
 			compatible = "mrvl,apb-bus", "simple-bus";
 			#address-cells = <1>;
@@ -39,40 +49,65 @@
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			timer0: timer at d4014000 {
+				compatible = "mrvl,mmp-timer";
+				reg = <0xd4014000 0x100>;
+				interrupts = <13>;
+			};
+
 			uart1: uart at d4017000 {
-				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				compatible = "mrvl,mmp-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <27>;
 				status = "disabled";
 			};
 
 			uart2: uart at d4018000 {
-				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				compatible = "mrvl,mmp-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <28>;
 				status = "disabled";
 			};
 
 			uart3: uart at d4026000 {
-				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				compatible = "mrvl,mmp-uart";
 				reg = <0xd4026000 0x1000>;
 				interrupts = <29>;
 				status = "disabled";
 			};
 
-			gpio: gpio at d4019000 {
-				compatible = "mrvl,mmp-gpio", "mrvl,pxa-gpio";
+			gpio at d4019000 {
+				compatible = "mrvl,mmp-gpio";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0xd4019000 0x1000>;
+				gpio-controller;
+				#gpio-cells = <2>;
 				interrupts = <49>;
 				interrupt-names = "gpio_mux";
-				gpio-controller;
-				#gpio-cells = <1>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
+				ranges;
+
+				gcb0: gpio at d4019000 {
+					reg = <0xd4019000 0x4>;
+				};
+
+				gcb1: gpio at d4019004 {
+					reg = <0xd4019004 0x4>;
+				};
+
+				gcb2: gpio at d4019008 {
+					reg = <0xd4019008 0x4>;
+				};
+
+				gcb3: gpio at d4019100 {
+					reg = <0xd4019100 0x4>;
+				};
 			};
 
 			twsi1: i2c at d4011000 {
-				compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+				compatible = "mrvl,mmp-twsi";
 				reg = <0xd4011000 0x1000>;
 				interrupts = <7>;
 				mrvl,i2c-fast-mode;
@@ -80,7 +115,7 @@
 			};
 
 			twsi2: i2c at d4025000 {
-				compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+				compatible = "mrvl,mmp-twsi";
 				reg = <0xd4025000 0x1000>;
 				interrupts = <58>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
new file mode 100644
index 0000000..e92be5a
--- /dev/null
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
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
+/include/ "pxa910.dtsi"
+
+/ {
+	model = "Marvell PXA910 DKB Development Board";
+	compatible = "mrvl,pxa910-dkb", "mrvl,pxa910";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
+	};
+
+	memory {
+		reg = <0x00000000 0x10000000>;
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
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
new file mode 100644
index 0000000..aebf32d
--- /dev/null
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -0,0 +1,140 @@
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
+		i2c0 = &twsi1;
+		i2c1 = &twsi2;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		axi at d4200000 {	/* AXI */
+			compatible = "mrvl,axi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4200000 0x00200000>;
+			ranges;
+
+			intc: interrupt-controller at d4282000 {
+				compatible = "mrvl,mmp-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0xd4282000 0x1000>;
+				mrvl,intc-nr-irqs = <64>;
+			};
+
+		};
+
+		apb at d4000000 {	/* APB */
+			compatible = "mrvl,apb-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4000000 0x00200000>;
+			ranges;
+
+			timer0: timer at d4014000 {
+				compatible = "mrvl,mmp-timer";
+				reg = <0xd4014000 0x100>;
+				interrupts = <13>;
+			};
+
+			timer1: timer at d4016000 {
+				compatible = "mrvl,mmp-timer";
+				reg = <0xd4016000 0x100>;
+				interrupts = <29>;
+				status = "disabled";
+			};
+
+			uart1: uart at d4017000 {
+				compatible = "mrvl,mmp-uart";
+				reg = <0xd4017000 0x1000>;
+				interrupts = <27>;
+				status = "disabled";
+			};
+
+			uart2: uart at d4018000 {
+				compatible = "mrvl,mmp-uart";
+				reg = <0xd4018000 0x1000>;
+				interrupts = <28>;
+				status = "disabled";
+			};
+
+			uart3: uart at d4036000 {
+				compatible = "mrvl,mmp-uart";
+				reg = <0xd4036000 0x1000>;
+				interrupts = <59>;
+				status = "disabled";
+			};
+
+			gpio at d4019000 {
+				compatible = "mrvl,mmp-gpio";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xd4019000 0x1000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupts = <49>;
+				interrupt-names = "gpio_mux";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				ranges;
+
+				gcb0: gpio at d4019000 {
+					reg = <0xd4019000 0x4>;
+				};
+
+				gcb1: gpio at d4019004 {
+					reg = <0xd4019004 0x4>;
+				};
+
+				gcb2: gpio at d4019008 {
+					reg = <0xd4019008 0x4>;
+				};
+
+				gcb3: gpio at d4019100 {
+					reg = <0xd4019100 0x4>;
+				};
+			};
+
+			twsi1: i2c at d4011000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4011000 0x1000>;
+				interrupts = <7>;
+				mrvl,i2c-fast-mode;
+				status = "disabled";
+			};
+
+			twsi2: i2c at d4037000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4037000 0x1000>;
+				interrupts = <54>;
+				status = "disabled";
+			};
+
+			rtc: rtc at d4010000 {
+				compatible = "mrvl,mmp-rtc";
+				reg = <0xd4010000 0x1000>;
+				interrupts = <5 6>;
+				interrupt-names = "rtc 1Hz", "rtc alarm";
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
1.7.5.4
