From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 1 Feb 2013 11:45:55 -0600
Subject: [PATCHv3 for soc 1/4] arm: socfpga: Add new device tree source for
 actual socfpga HW
In-Reply-To: <1359740758-29703-1-git-send-email-dinguyen@altera.com>
References: <1359740758-29703-1-git-send-email-dinguyen@altera.com>
Message-ID: <1359740758-29703-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Up to this point, support for socfpga has only been on a virtual
platform. Now that actual hardware is available, we add the appropriate
device tree source files.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Tested-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Pavel Machek <pavel@denx.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/socfpga.dtsi         |   22 ++++++------
 arch/arm/boot/dts/socfpga_cyclone5.dts |   30 ++++++++++++++--
 arch/arm/boot/dts/socfpga_vt.dts       |   60 ++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c        |    1 -
 4 files changed, 98 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_vt.dts

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 19aec42..936d230 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -25,6 +25,10 @@
 		ethernet0 = &gmac0;
 		serial0 = &uart0;
 		serial1 = &uart1;
+		timer0 = &timer0;
+		timer1 = &timer1;
+		timer2 = &timer2;
+		timer3 = &timer3;
 	};
 
 	cpus {
@@ -98,47 +102,41 @@
 			interrupts = <1 13 0xf04>;
 		};
 
-		timer0: timer at ffc08000 {
+		timer0: timer0 at ffc08000 {
 			compatible = "snps,dw-apb-timer-sp";
 			interrupts = <0 167 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffc08000 0x1000>;
 		};
 
-		timer1: timer at ffc09000 {
+		timer1: timer1 at ffc09000 {
 			compatible = "snps,dw-apb-timer-sp";
 			interrupts = <0 168 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffc09000 0x1000>;
 		};
 
-		timer2: timer at ffd00000 {
+		timer2: timer2 at ffd00000 {
 			compatible = "snps,dw-apb-timer-osc";
 			interrupts = <0 169 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffd00000 0x1000>;
 		};
 
-		timer3: timer at ffd01000 {
+		timer3: timer3 at ffd01000 {
 			compatible = "snps,dw-apb-timer-osc";
 			interrupts = <0 170 4>;
-			clock-frequency = <200000000>;
 			reg = <0xffd01000 0x1000>;
 		};
 
-		uart0: uart at ffc02000 {
+		uart0: serial0 at ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x1000>;
-			clock-frequency = <7372800>;
 			interrupts = <0 162 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 		};
 
-		uart1: uart at ffc03000 {
+		uart1: serial1 at ffc03000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc03000 0x1000>;
-			clock-frequency = <7372800>;
 			interrupts = <0 163 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index ab7e4a9..7ad3cc6 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -20,7 +20,7 @@
 
 / {
 	model = "Altera SOCFPGA Cyclone V";
-	compatible = "altr,socfpga-cyclone5";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
 		bootargs = "console=ttyS0,57600";
@@ -29,6 +29,32 @@
 	memory {
 		name = "memory";
 		device_type = "memory";
-		reg = <0x0 0x10000000>; /* 256MB */
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+
+	soc {
+		timer0 at ffc08000 {
+			clock-frequency = <100000000>;
+		};
+
+		timer1 at ffc09000 {
+			clock-frequency = <100000000>;
+		};
+
+		timer2 at ffd00000 {
+			clock-frequency = <25000000>;
+		};
+
+		timer3 at ffd01000 {
+			clock-frequency = <25000000>;
+		};
+
+		serial0 at ffc02000 {
+			clock-frequency = <100000000>;
+		};
+
+		serial1 at ffc03000 {
+			clock-frequency = <100000000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
new file mode 100644
index 0000000..a0c6c65
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -0,0 +1,60 @@
+/*
+ *  Copyright (C) 2013 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+/include/ "socfpga.dtsi"
+
+/ {
+	model = "Altera SOCFPGA VT";
+	compatible = "altr,socfpga-vt", "altr,socfpga";
+
+	chosen {
+		bootargs = "console=ttyS0,57600";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1 GB */
+	};
+
+	soc {
+		timer0 at ffc08000 {
+			clock-frequency = <7000000>;
+		};
+
+		timer1 at ffc09000 {
+			clock-frequency = <7000000>;
+		};
+
+		timer2 at ffd00000 {
+			clock-frequency = <7000000>;
+		};
+
+		timer3 at ffd01000 {
+			clock-frequency = <7000000>;
+		};
+
+		serial0 at ffc02000 {
+			clock-frequency = <7372800>;
+		};
+
+		serial1 at ffc03000 {
+			clock-frequency = <7372800>;
+		};
+	};
+};
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 6732924..94aa6ad 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -98,7 +98,6 @@ static void __init socfpga_cyclone5_init(void)
 
 static const char *altera_dt_match[] = {
 	"altr,socfpga",
-	"altr,socfpga-cyclone5",
 	NULL
 };
 
-- 
1.7.9.5
