From: tim.schendekehl@egnite.de (Tim Schendekehl)
Date: Tue, 24 Apr 2012 16:32:37 +0200
Subject: [PATCH v3] Ethernut 5 board support
Message-ID: <4F96B985.50807@egnite.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Ethernut 5 open hardware design, based
on Atmel's AT91SAM9XE512 SoC.

Signed-off-by: Tim Schendekehl <tim.schendekehl@egnite.de>
---
V3:
 - More specific compatible property for nxp,pcf8563.
 - Remove pmmc i2c-device.

 arch/arm/boot/dts/ethernut5.dts |   84 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/ethernut5.dts

diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
new file mode 100644
index 0000000..35c3830
--- /dev/null
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -0,0 +1,84 @@
+/*
+ * ethernut5.dts - Device Tree file for Ethernut 5 board
+ *
+ * Copyright (C) 2012 egnite GmbH <info@egnite.de>
+ *
+ * Licensed under GPLv2.
+ */
+/dts-v1/;
+/include/ "at91sam9260.dtsi"
+
+/ {
+	model = "Ethernut 5";
+	compatible = "egnite,ethernut5", "atmel,at91sam9260", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/mtdblock0 mtdparts=atmel_nand:128m(root),896m(data) rw rootfstype=jffs2";
+	};
+
+	memory {
+		reg = <0x20000000 0x08000000>;
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
+			gpios = <0
+				 &pioC 14 0
+				 0
+				>;
+
+			root at 0 {
+				label = "root";
+				reg = <0x0 0x08000000>;
+			};
+
+			data at 20000 {
+				label = "data";
+				reg = <0x08000000 0x38000000>;
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
+		pcf8563 at 50 {
+			compatible = "nxp,pcf8563";
+			reg = <0x51>;
+		};
+	};
+};
-- 
1.7.1
