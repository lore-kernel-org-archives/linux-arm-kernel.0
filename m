From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 21:45:35 +0100
Subject: [PATCH 6/6] ARM: nomadik: device tree for NHK15 board
In-Reply-To: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
References: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1414788335-28334-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a device tree for the Nomadik NHK15 development kit
board.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/arm/ste-nomadik.txt        |   6 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            | 151 +++++++++++++++++++++
 arch/arm/mach-nomadik/cpu-8815.c                   |   1 +
 4 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/ste-nomadik-nhk15.dts

diff --git a/Documentation/devicetree/bindings/arm/ste-nomadik.txt b/Documentation/devicetree/bindings/arm/ste-nomadik.txt
index 6256ec31666d..2fdff5a806cf 100644
--- a/Documentation/devicetree/bindings/arm/ste-nomadik.txt
+++ b/Documentation/devicetree/bindings/arm/ste-nomadik.txt
@@ -10,6 +10,12 @@ Required root node property: src
 
 Boards with the Nomadik SoC include:
 
+Nomadik NHK-15 board manufactured by ST Microelectronics:
+
+Required root node property:
+
+compatible="st,nomadik-nhk-15";
+
 S8815 "MiniKit" manufactured by Calao Systems:
 
 Required root node property:
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89cafa1ab..50bb73ec2b7d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -274,7 +274,8 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
 	imx28-tx28.dtb
-dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb
+dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb \
+	ste-nomadik-nhk15.dtb
 dtb-$(CONFIG_ARCH_NSPIRE) += nspire-cx.dtb \
 	nspire-tp.dtb \
 	nspire-clp.dtb
diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
new file mode 100644
index 000000000000..a8c00ee7522a
--- /dev/null
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -0,0 +1,151 @@
+/*
+ * Device Tree for the ST-Ericsson Nomadik S8815 board
+ * Produced by Calao Systems
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "ste-nomadik-stn8815.dtsi"
+
+/ {
+	model = "Nomadik STN8815NHK";
+	compatible = "st,nomadik-nhk-15";
+
+	chosen {
+		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
+	};
+
+	aliases {
+		stmpe-i2c0 = &stmpe0;
+		stmpe-i2c1 = &stmpe1;
+	};
+
+	pinctrl {
+		stmpe2401_1 {
+			stmpe2401_1_nhk_mode: stmpe2401_1_nhk {
+				nhk_cfg1 {
+					ste,pins = "GPIO76_B20"; // IRQ line
+					ste,input = <0>;
+				};
+				nhk_cfg2 {
+					ste,pins = "GPIO77_B8"; // reset line
+					ste,output = <1>;
+				};
+			};
+		};
+		stmpe2401_2 {
+			stmpe2401_2_nhk_mode: stmpe2401_2_nhk {
+				nhk_cfg1 {
+					ste,pins = "GPIO78_A8"; // IRQ line
+					ste,input = <0>;
+				};
+				nhk_cfg2 {
+					ste,pins = "GPIO79_C9"; // reset line
+					ste,output = <1>;
+				};
+			};
+		};
+	};
+
+	src at 101e0000 {
+		/* These chrystal outputs are not used on this board */
+		disable-sxtalo;
+		disable-mxtalo;
+	};
+
+	/* This is where the interrupt is routed on the NHK-15 debug board */
+	external-bus at 34000000 {
+		compatible = "simple-bus";
+		reg = <0x34000000 0x1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x34000000 0x1000000>;
+		ethernet at 300 {
+			compatible = "smsc,lan91c111";
+			reg = <0x300 0x0fd00>;
+			reg-io-width = <2>;
+			reset-gpios = <&stmpe_gpio44 10 GPIO_ACTIVE_HIGH>;
+			interrupt-parent = <&stmpe_gpio44>;
+			interrupts = <11 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	i2c0 {
+		stmpe0: stmpe2401 at 43 {
+			compatible = "st,stmpe2401";
+			reg = <0x43>;
+			reset-gpios = <&gpio2 13 GPIO_ACTIVE_LOW>; // GPIO77
+			interrupts = <12 IRQ_TYPE_EDGE_FALLING>; // GPIO76
+			interrupt-parent = <&gpio2>;
+			interrupt-controller;
+			wakeup-source;
+			pinctrl-names = "default";
+			pinctrl-0 = <&stmpe2401_1_nhk_mode>;
+			stmpe_gpio43: stmpe_gpio {
+				compatible = "st,stmpe-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				/* Some pins in alternate functions */
+				st,norequest-mask = <0xf0f002>;
+			};
+			stmpe_keypad {
+				compatible = "st,stmpe-keypad";
+				debounce-interval = <64>;
+				st,scan-count = <8>;
+				st,no-autorepeat;
+				keypad,num-rows = <8>;
+				keypad,num-columns = <8>;
+				linux,keymap = <0x00020072 // Vol down
+						0x00030073 // Vol up
+						0x0100009e // Back
+						0x010100e3 // TV out
+						0x01020098 // Lock
+						0x0103013b // Start
+						0x020000a3 // Next
+						0x020100a4 // Play
+						0x020200a5 // Prev
+						0x02030160 // OK
+						0x03000069 // Left
+						0x0301006a // Right
+						0x03020067 // Up
+						0x0303006c>; // Down
+			};
+		};
+		stmpe1: stmpe2401 at 44 {
+			compatible = "st,stmpe2401";
+			reg = <0x44>;
+			reset-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>; // GPIO79
+			interrupts = <14 IRQ_TYPE_EDGE_FALLING>; // GPIO78
+			interrupt-parent = <&gpio2>;
+			interrupt-controller;
+			wakeup-source;
+			pinctrl-names = "default";
+			pinctrl-0 = <&stmpe2401_2_nhk_mode>;
+			stmpe_gpio44: stmpe_gpio {
+				compatible = "st,stmpe-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+	};
+
+	amba {
+		mmcsd: sdi at 101f6000 {
+			cd-gpios = <&stmpe_gpio44 7 GPIO_ACTIVE_LOW>;
+			wp-gpios = <&stmpe_gpio44 18 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* Custom board node with GPIO pins to active etc */
+	usb-s8815 {
+		/* This will turn off SATA so that MMC/SD can thrive */
+		mmcsd-gpio {
+			gpios = <&stmpe_gpio44 2 0x1>;
+		};
+	};
+};
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 9116ca476d7c..9bda46f1fab7 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -144,6 +144,7 @@ static int __init cpu8815_mmcsd_init(void)
 device_initcall(cpu8815_mmcsd_init);
 
 static const char * cpu8815_board_compat[] = {
+	"st,nomadik-nhk-15",
 	"calaosystems,usb-s8815",
 	NULL,
 };
-- 
1.9.3
