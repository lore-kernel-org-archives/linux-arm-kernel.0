From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jan 2016 12:12:04 +0100
Subject: [PATCH 5/6] ARM: realview: add flash devices to the PB1176 DTS
In-Reply-To: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1453806725-4880-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the flash memories and ROM to the PB1175 DTS file.
The secure flash is marked as "disabled" by default so as to
protect the user from overwriting the boot monitor.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 1bc64cda819e..b7d727ef1868 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -106,6 +106,31 @@
 		clock-frequency = <0>;
 	};
 
+	flash at 30000000 {
+		compatible = "arm,versatile-flash", "cfi-flash";
+		reg = <0x30000000 0x4000000>;
+		bank-width = <4>;
+	};
+
+	fpga_flash at 38000000 {
+		compatible = "arm,versatile-flash", "cfi-flash";
+		reg = <0x38000000 0x800000>;
+		bank-width = <4>;
+	};
+
+	/*
+	 * The "secure flash" contains things like the boot
+	 * monitor so we don't want people to accidentally
+	 * screw this up. Mark the device tree node disabled
+	 * by default.
+	 */
+	secflash at 3c000000 {
+		compatible = "arm,versatile-flash", "cfi-flash";
+		reg = <0x3c000000 0x4000000>;
+		bank-width = <4>;
+		status = "disabled";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -297,6 +322,13 @@
 			clocks = <&uartclk>, <&pclk>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		/* Direct-mapped development chip ROM */
+		pb1176_rom at 10200000 {
+			compatible = "direct-mapped";
+			reg = <0x10200000 0x4000>;
+			bank-width = <1>;
+		};
 	};
 
 	/* These peripherals are inside the FPGA rather than the DevChip */
-- 
2.4.3
