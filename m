From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Fri, 20 Apr 2012 13:57:33 +0200
Subject: [PATCH] ARM: at91: add kizbox board dt support.
Message-ID: <4F914F2D.70807@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch adds support for the kizbox board (based on at91sam9g20 SoC)


Best Regards,

Boris

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/kizbox.dts     |  138 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile.boot |    1 +
 2 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kizbox.dts

diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
new file mode 100644
index 0000000..57479dc
--- /dev/null
+++ b/arch/arm/boot/dts/kizbox.dts
@@ -0,0 +1,138 @@
+/*
+ * kizbox.dts - Device Tree file for Overkiz Kizbox board
+ *
+ * Copyright (C) 2012 Boris BREZILLON <linux-arm@overkiz.com>
+ *
+ * Licensed under GPLv2.
+ */
+/dts-v1/;
+/include/ "at91sam9g20.dtsi"
+
+/ {
+
+	model = "Overkiz kizbox";
+	compatible = "overkiz,kizbox", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "panic=5 ubi.mtd=1 rootfstype=ubifs root=ubi0:root";
+	};
+
+	memory {
+		reg = <0x20000000 0x2000000>;
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
+				phy-mode = "mii";
+				status = "okay";
+			};
+
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			status = "okay";
+
+			bootloaderkernel at 0 {
+				label = "bootloader-kernel";
+				reg = <0x0 0xc0000>;
+			};
+
+			ubi at c0000 {
+				label = "ubi";
+				reg = <0xc0000 0x7f40000>;
+			};
+
+		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <1>;
+			status = "okay";
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+
+		pcf8563 at 51 {
+			/* nxp pcf8563 rtc */
+			compatible = "pcf8563";
+			reg = <0x51>;
+		};
+
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1g {
+			label = "led1:green";
+			gpios = <&pioB 0 1>;
+			linux,default-trigger = "none";
+		};
+
+		led1r {
+			label = "led1:red";
+			gpios = <&pioB 1 1>;
+			linux,default-trigger = "none";
+		};
+
+		led2g {
+			label = "led2:green";
+			gpios = <&pioB 2 1>;
+			linux,default-trigger = "none";
+			default-state = "on";
+		};
+
+		led2r {
+			label = "led2:red";
+			gpios = <&pioB 3 1>;
+			linux,default-trigger = "none";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset {
+			label = "reset";
+			gpios = <&pioB 30 1>;
+			linux,code = <0x100>;
+			gpio-key,wakeup;
+		};
+
+		mode {
+			label = "mode";
+			gpios = <&pioB 31 1>;
+			linux,code = <0x101>;
+			gpio-key,wakeup;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 0c6e0e9..c36e2df 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -22,6 +22,7 @@ dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9263ek.dtb
 # sam9g20
 dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek_2mmc.dtb
+dtb-$(CONFIG_MACH_AT91SAM_DT) += kizbox.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9g20.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9g20.dtb
 # sam9g45
-- 
1.7.4.1
