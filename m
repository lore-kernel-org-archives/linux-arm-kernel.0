From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:29 +0200
Subject: [PATCH 16/16] ARM: at91/dt: Add Acme Arietta G25
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-17-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a minimum Device Tree for Acme Arietta G25.
http://acme.systems/arietta

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Sergio Tanzilli <tanzilli@acmesystems.it>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/at91-acme-arietta.dts | 75 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-acme-arietta.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8c3da289a00b..96a169e6ea56 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -31,6 +31,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	at91sam9n12ek.dtb \
 	at91sam9rlek.dtb \
 	at91-ariag25.dtb \
+	at91-acme-arietta.dtb \
 	at91-cosino_mega2560.dtb \
 	at91-kizboxmini.dtb \
 	at91sam9g15ek.dtb \
diff --git a/arch/arm/boot/dts/at91-acme-arietta.dts b/arch/arm/boot/dts/at91-acme-arietta.dts
new file mode 100644
index 000000000000..142d588ad6bf
--- /dev/null
+++ b/arch/arm/boot/dts/at91-acme-arietta.dts
@@ -0,0 +1,75 @@
+/*
+ * Device Tree file for Arietta G25
+ * This device tree is minimal, to activate more peripherals, see:
+ * http://dts.acmesystems.it/arietta/
+ */
+/dts-v1/;
+#include "at91sam9g25.dtsi"
+/ {
+	model = "Acme Systems Arietta G25";
+	compatible = "acme,ariettag25", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x20000000 0x8000000>;
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			mmc0: mmc at f0008000 {
+				pinctrl-0 = <
+				  &pinctrl_mmc0_slot0_clk_cmd_dat0
+				  &pinctrl_mmc0_slot0_dat1_3>;
+				status = "okay";
+
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+				};
+			};
+
+			usb2: gadget at f803c000 {
+				status = "okay";
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			rtc at fffffeb0 {
+				status = "okay";
+			};
+		};
+
+		usb0: ohci at 00600000 {
+			status = "okay";
+			num-ports = <3>;
+		};
+
+		usb1: ehci at 00700000 {
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		arietta_led {
+			label = "arietta_led";
+			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>; /* PB8 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
-- 
2.1.4
