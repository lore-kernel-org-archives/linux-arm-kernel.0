From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 Apr 2012 18:01:13 +0200
Subject: [PATCH 3/9] ARM: at91: add at91sam9g20ek boards dt support
In-Reply-To: <20120411153515.GK16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
Message-ID: <1334160079-30831-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add both board revision support 1mmc and 2mmc and use a dtsi for common part.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9g20ek.dts         |   29 ++++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   29 ++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  142 +++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile.boot            |    2 +
 4 files changed, 202 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek_common.dtsi

diff --git a/arch/arm/boot/dts/at91sam9g20ek.dts b/arch/arm/boot/dts/at91sam9g20ek.dts
new file mode 100644
index 0000000..e5324bf
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9g20ek.dts
@@ -0,0 +1,29 @@
+/*
+ * at91sam9g20ek.dts - Device Tree file for Atmel at91sam9g20ek board
+ *
+ * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2.
+ */
+/dts-v1/;
+/include/ "at91sam9g20ek_common.dtsi"
+
+/ {
+	model = "Atmel at91sam9g20ek";
+	compatible = "atmel,at91sam9g20ek", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	leds {
+		compatible = "gpio-leds";
+
+		ds1 {
+			label = "ds1";
+			gpios = <&pioA 9 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		ds5 {
+			label = "ds5";
+			gpios = <&pioA 6 1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
new file mode 100644
index 0000000..f1b2e14
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
@@ -0,0 +1,29 @@
+/*
+ * at91sam9g20ek_2mmc.dts - Device Tree file for Atmel at91sam9g20ek 2 MMC board
+ *
+ * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2.
+ */
+/dts-v1/;
+/include/ "at91sam9g20ek_common.dtsi"
+
+/ {
+	model = "Atmel at91sam9g20ek 2 mmc";
+	compatible = "atmel,at91sam9g20ek_2mmc", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	leds {
+		compatible = "gpio-leds";
+
+		ds1 {
+			label = "ds1";
+			gpios = <&pioB 9 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		ds5 {
+			label = "ds5";
+			gpios = <&pioB 8 1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
new file mode 100644
index 0000000..b06c0db
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -0,0 +1,142 @@
+/*
+ * at91sam9g20ek_common.dtsi - Device Tree file for Atmel at91sam9g20ek board
+ *
+ * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2.
+ */
+/include/ "at91sam9g20.dtsi"
+
+/ {
+
+	chosen {
+		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
+	};
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
+			usart0: serial at fffb0000 {
+				status = "okay";
+			};
+
+			usart1: serial at fffb4000 {
+				status = "okay";
+			};
+
+			macb0: ethernet at fffc4000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioC 5 0>;
+				status = "okay";
+			};
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			status = "okay";
+
+			at91bootstrap at 0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x20000>;
+			};
+
+			barebox at 20000 {
+				label = "barebox";
+				reg = <0x20000 0x40000>;
+			};
+
+			bareboxenv at 60000 {
+				label = "bareboxenv";
+				reg = <0x60000 0x20000>;
+			};
+
+			bareboxenv2 at 80000 {
+				label = "bareboxenv2";
+				reg = <0x80000 0x20000>;
+			};
+
+			oftree at 80000 {
+				label = "oftree";
+				reg = <0xa0000 0x20000>;
+			};
+
+			kernel at a0000 {
+				label = "kernel";
+				reg = <0xc0000 0x400000>;
+			};
+
+			rootfs at 4a0000 {
+				label = "rootfs";
+				reg = <0x4c0000 0x7800000>;
+			};
+
+			data at 7ca0000 {
+				label = "data";
+				reg = <0x7cc0000 0x8340000>;
+			};
+		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <2>;
+			status = "okay";
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+
+		24c512 at 50 {
+			compatible = "24c512";
+			reg = <0x50>;
+		};
+
+		wm8731 at 1b {
+			compatible = "wm8731";
+			reg = <0x1b>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		btn3 {
+			label = "Buttin 3";
+			gpios = <&pioA 30 1>;
+			linux,code = <0x103>;
+			gpio-key,wakeup;
+		};
+
+		btn4 {
+			label = "Buttin 4";
+			gpios = <&pioA 31 1>;
+			linux,code = <0x104>;
+			gpio-key,wakeup;
+		};
+	};
+};
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index bdf9841..30d6c10 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -17,6 +17,8 @@ endif
 # sam9260
 dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9260.dtb
 # sam9g20
+dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek.dtb
+dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek_2mmc.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9g20.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9g20.dtb
 # sam9g45
-- 
1.7.9.1
