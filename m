From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 28 Oct 2012 19:31:11 +0100
Subject: [PATCH v3 6/6] ARM: AT91: Add AT91RM9200EK board device tree
In-Reply-To: <1351449071-5763-1-git-send-email-manabian@gmail.com>
References: <1351449071-5763-1-git-send-email-manabian@gmail.com>
Message-ID: <1351449071-5763-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/Makefile         |  2 +
 arch/arm/boot/dts/at91rm9200ek.dts | 78 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91rm9200ek.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3bf4f53..64c4e7b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,6 +1,8 @@
 ifeq ($(CONFIG_OF),y)
 
 # Keep at91 dtb files sorted alphabetically for each SoC
+# rm9200
+dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 # sam9260
 dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
 dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
new file mode 100644
index 0000000..d8a680b
--- /dev/null
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -0,0 +1,78 @@
+/*
+ * at91rm9200ek.dts - Device Tree file for Atmel AT91RM9200 evaluation kit
+ *
+ *  Copyright (C) 2012 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+/include/ "at91rm9200.dtsi"
+
+/ {
+	model = "Atmel AT91RM9200 evaluation kit";
+	compatible = "atmel,at91rm9200ek", "atmel,at91rm9200";
+
+	memory {
+		reg = <0x20000000 0x4000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <18432000>;
+		};
+	};
+
+	ahb {
+		apb {
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			usart1: serial at fffc4000 {
+				pinctrl-0 =
+						<&pinctrl_uart1
+						 &pinctrl_uart1_rts_cts
+						 &pinctrl_uart1_dtr_dsr
+						 &pinctrl_uart1_dcd
+						 &pinctrl_uart1_ri>;
+				status = "okay";
+			};
+
+			usb1: gadget at fffb0000 {
+				atmel,vbus-gpio = <&pioD 4 0>;
+				status = "okay";
+			};
+		};
+
+		usb0: ohci at 00300000 {
+			num-ports = <2>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		ds2 {
+			label = "green";
+			gpios = <&pioB 0 0x1>;
+			linux,default-trigger = "mmc0";
+		};
+
+		ds4 {
+			label = "yellow";
+			gpios = <&pioB 1 0x1>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		ds6 {
+			label = "red";
+			gpios = <&pioB 2 0x1>;
+		};
+	};
+};
-- 
1.8.0
