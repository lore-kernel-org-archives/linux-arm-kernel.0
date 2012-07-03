From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Tue,  3 Jul 2012 16:27:46 +0200
Subject: [PATCH] arm: at91: Add new board
Message-ID: <1341325666-5425-1-git-send-email-jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'd like to add support for our "CDU" board based up on Telit's module GE863 Pro3.
It has more uarts, leds, another nand partitioning.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 arch/arm/boot/dts/cdu.dtsi |  126 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/cdu.dtsi

diff --git a/arch/arm/boot/dts/cdu.dtsi b/arch/arm/boot/dts/cdu.dtsi
new file mode 100644
index 0000000..0f9ed04
--- /dev/null
+++ b/arch/arm/boot/dts/cdu.dtsi
@@ -0,0 +1,126 @@
+/*
+ * cdu.dtsi - Device Tree file for AKsignal CDU
+ *
+ * Copyright (C) 2012 AKsignal Brno,
+ *               2012 Jiri Prchal <jiri.prchal@aksignal.cz>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "at91sam9260.dtsi"
+
+/ {
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <6000000>;
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 ubi.mtd=4 root=ubi0:rootfs rootfstype=ubifs";
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
+				linux,rs485-enabled-at-boot-time;
+				rs485-rts-delay = <0 0>;
+				};
+
+			usart2: serial at fffb8000 {
+				status = "okay";
+				linux,rs485-enabled-at-boot-time;
+				rs485-rts-delay = <0 0>;
+			};
+
+			usart3: serial at fffd0000 {
+				status = "okay";
+				linux,rs485-enabled-at-boot-time;
+				rs485-rts-delay = <0 0>;
+			};
+
+			macb0: ethernet at fffbc000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioC 15 0>;
+				status = "okay";
+			};
+		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <2>;
+			status = "okay";
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			status = "okay";
+
+			bootstrap at 0 {
+				label = "bootstrap";
+				reg = <0x0 0x40000>;
+			};
+
+			uboot at 40000 {
+				label = "uboot";
+				reg = <0x40000 0x80000>;
+			};
+			ubootenv at c0000 {
+				label = "ubootenv";
+				reg = <0xc0000 0x40000>;
+			};
+			kernel at 100000 {
+				label = "kernel";
+				reg = <0x100000 0x400000>;
+			};
+			rootfs at 500000 {
+				label = "rootfs";
+				reg = <0x500000 0x7b00000>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		red {
+			gpios = <&pioC 10 0>;
+			linux,default-trigger = "none";
+		};
+
+		green {
+			gpios = <&pioA 5 1>;
+			linux,default-trigger = "none";
+			default-state = "on";
+		};
+
+		yellow {
+			gpios = <&pioB 20 1>;
+			linux,default-trigger = "none";
+		};
+
+		blue {
+			gpios = <&pioB 21 1>;
+			linux,default-trigger = "none";
+		};
+	};
+};
-- 
1.7.7
