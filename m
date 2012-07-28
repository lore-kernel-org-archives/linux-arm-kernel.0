From: zonque@gmail.com (Daniel Mack)
Date: Sat, 28 Jul 2012 12:07:41 +0200
Subject: [PATCH v3 9/9] ARM: pxa: add .dtsi files
In-Reply-To: <1343470061-16879-1-git-send-email-zonque@gmail.com>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
Message-ID: <1343470061-16879-10-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds .dtsi files to describe the PXA SoCs. pxa3xx simply augments
pxa2xx. Not all devices are listed yet, and it will need some time to
get all the drivers ported.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 132 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pxa3xx.dtsi |  27 +++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 arch/arm/boot/dts/pxa2xx.dtsi
 create mode 100644 arch/arm/boot/dts/pxa3xx.dtsi

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
new file mode 100644
index 0000000..4fe3b91
--- /dev/null
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -0,0 +1,132 @@
+/*
+ * pxa2xx.dtsi - Device Tree Include file for Marvell PXA2xx family SoC
+ *
+ * Copyright (C) 2011 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell PXA2xx family SoC";
+	compatible = "marvell,pxa2xx";
+	interrupt-parent = <&pxairq>;
+
+	aliases {
+		serial0 = &ffuart;
+		serial1 = &btuart;
+		serial2 = &stuart;
+		serial3 = &hwuart;
+		i2c0 = &pwri2c;
+		i2c1 = &pxai2c1;
+	};
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,xscale";
+		};
+	};
+
+	pxabus {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pxairq: interrupt-controller at 40d00000 {
+			#interrupt-cells = <1>;
+			compatible = "marvell,pxa-intc";
+			interrupt-controller;
+			interrupt-parent;
+			mrvl,intc-nr-irqs = <56>;
+			reg = <0x40d00000 0xd0>;
+		};
+
+		gpio: gpio at 40e00000 {
+			compatible = "mrvl,pxa-gpio";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0x40e00000 0x10000>;
+			gpio-controller;
+			#gpio-cells = <0x2>;
+			interrupts = <10>;
+			interrupt-names = "gpio_mux";
+			interrupt-controller;
+			#interrupt-cells = <0x2>;
+			ranges;
+
+			gcb0: gpio at 40e00000 {
+				reg = <0x40e00000 0x4>;
+			};
+
+			gcb1: gpio at 40e00004 {
+				reg = <0x40e00004 0x4>;
+			};
+
+			gcb2: gpio at 40e00008 {
+				reg = <0x40e00008 0x4>;
+			};
+			gcb3: gpio at 40e0000c {
+				reg = <0x40e0000c 0x4>;
+			};
+		};
+
+		ffuart: uart at 40100000 {
+			compatible = "mrvl,pxa-uart";
+			reg = <0x40100000 0x30>;
+			interrupts = <22>;
+			status = "disabled";
+		};
+
+		btuart: uart at 40200000 {
+			compatible = "mrvl,pxa-uart";
+			reg = <0x40200000 0x30>;
+			interrupts = <21>;
+			status = "disabled";
+		};
+
+		stuart: uart at 40700000 {
+			compatible = "mrvl,pxa-uart";
+			reg = <0x40700000 0x30>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+
+		hwuart: uart at 41100000 {
+			compatible = "mrvl,pxa-uart";
+			reg = <0x41100000 0x30>;
+			interrupts = <7>;
+			status = "disabled";
+		};
+
+		pxai2c1: i2c at 40301680 {
+			compatible = "mrvl,pxa-i2c";
+			reg = <0x40301680 0x30>;
+			interrupts = <18>;
+			#address-cells = <0x1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		usb0: ohci at 4c000000 {
+			compatible = "mrvl,pxa-ohci";
+			reg = <0x4c000000 0x10000>;
+			interrupts = <3>;
+			status = "disabled";
+		};
+
+		mmc0: mmc at 41100000 {
+			compatible = "mrvl,pxa-mmc";
+			reg = <0x41100000 0x1000>;
+			interrupts = <23>;
+			status = "disabled";
+		};
+
+		rtc at 40900000 {
+			compatible = "marvell,pxa-rtc";
+			reg = <0x40900000 0x3c>;
+			interrupts = <30 31>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
new file mode 100644
index 0000000..41e0a42
--- /dev/null
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -0,0 +1,27 @@
+/* The pxa3xx skeleton simply augments the 2xx version */
+/include/ "pxa2xx.dtsi"
+
+/ {
+	model = "Marvell PXA3xx familiy SoC";
+	compatible = "marvell,pxa3xx";
+
+	pxabus {
+		pwri2c: i2c at 40f500c0 {
+			compatible = "mrvl,pwri2c";
+			reg = <0x40f500c0 0x30>;
+			interrupts = <6>;
+			#address-cells = <0x1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		nand0: nand at 43100000 {
+			compatible = "marvell,pxa3xx-nand";
+			reg = <0x43100000 90>;
+			interrupts = <45>;
+			#address-cells = <1>;
+			#size-cells = <1>;	
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.11.2
