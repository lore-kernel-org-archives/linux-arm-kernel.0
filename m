From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Mar 2012 16:11:03 +0530
Subject: [PATCH V3 5/7] ARM: SPEAr3xx: Add device-tree support to SPEAr3xx
 architecture
In-Reply-To: <cover.1333017183.git.viresh.kumar@st.com>
References: <cover.1333017183.git.viresh.kumar@st.com>
Message-ID: <c64379ae6e00c89ba1eb313b825862a9fb37a347.1333017183.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a generic target for SPEAr3xx machines that can be configured
via the device-tree. Currently the following devices are supported via the
devicetree:

- VIC interrupts
- PL011 UART
- PL061 GPIO
- PL110 CLCD
- SP805 WDT
- Synopsys DW I2C
- Synopsys DW ethernet
- ST FSMC-NAND
- ST SPEAR-SMI
- ST SPEAR-KEYBOARD
- ST SPEAR-RTC
- ARASAN SDHCI-SPEAR
- SPEAR-EHCI
- SPEAR-OHCI

Other peripheral devices will follow in later patches.

This also removes IO_ADDRESS macro and creates 16 MB static mappings instead of
4K for individual peripherals. This is done to have efficient TLB lookup for any
I/O windows that are located closely together. ioremap() on this range will
return this mapping only instead of creating another.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 Documentation/arm/SPEAr/overview.txt            |   13 +-
 Documentation/devicetree/bindings/arm/spear.txt |   18 +++
 arch/arm/boot/dts/spear300-evb.dts              |  179 +++++++++++++++++++++++
 arch/arm/boot/dts/spear300.dtsi                 |   72 +++++++++
 arch/arm/boot/dts/spear310-evb.dts              |  107 ++++++++++++++
 arch/arm/boot/dts/spear310.dtsi                 |   75 ++++++++++
 arch/arm/boot/dts/spear320-evb.dts              |  108 ++++++++++++++
 arch/arm/boot/dts/spear320.dtsi                 |   90 ++++++++++++
 arch/arm/boot/dts/spear3xx.dtsi                 |  136 +++++++++++++++++
 arch/arm/mach-spear3xx/Kconfig                  |   34 +----
 arch/arm/mach-spear3xx/Makefile                 |   13 +--
 arch/arm/mach-spear3xx/Makefile.boot            |    4 +
 arch/arm/mach-spear3xx/clock.c                  |  103 ++++++++------
 arch/arm/mach-spear3xx/include/mach/generic.h   |   29 +---
 arch/arm/mach-spear3xx/include/mach/hardware.h  |    3 -
 arch/arm/mach-spear3xx/include/mach/spear.h     |    9 +-
 arch/arm/mach-spear3xx/spear300.c               |   97 +++++++++----
 arch/arm/mach-spear3xx/spear300_evb.c           |   75 ----------
 arch/arm/mach-spear3xx/spear310.c               |  126 ++++++++++++++---
 arch/arm/mach-spear3xx/spear310_evb.c           |   81 ----------
 arch/arm/mach-spear3xx/spear320.c               |  127 ++++++++++++++---
 arch/arm/mach-spear3xx/spear320_evb.c           |   79 ----------
 arch/arm/mach-spear3xx/spear3xx.c               |  127 ++++++++---------
 arch/arm/plat-spear/Kconfig                     |    3 +-
 24 files changed, 1222 insertions(+), 486 deletions(-)
 create mode 100644 arch/arm/boot/dts/spear300-evb.dts
 create mode 100644 arch/arm/boot/dts/spear300.dtsi
 create mode 100644 arch/arm/boot/dts/spear310-evb.dts
 create mode 100644 arch/arm/boot/dts/spear310.dtsi
 create mode 100644 arch/arm/boot/dts/spear320-evb.dts
 create mode 100644 arch/arm/boot/dts/spear320.dtsi
 create mode 100644 arch/arm/boot/dts/spear3xx.dtsi
 delete mode 100644 arch/arm/mach-spear3xx/spear300_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear310_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear320_evb.c

diff --git a/Documentation/arm/SPEAr/overview.txt b/Documentation/arm/SPEAr/overview.txt
index 253a35c..28a9af9 100644
--- a/Documentation/arm/SPEAr/overview.txt
+++ b/Documentation/arm/SPEAr/overview.txt
@@ -17,14 +17,14 @@ Introduction
   SPEAr (Platform)
 	- SPEAr3XX (3XX SOC series, based on ARM9)
 		- SPEAr300 (SOC)
-			- SPEAr300_EVB (Evaluation Board)
+			- SPEAr300 Evaluation Board
 		- SPEAr310 (SOC)
-			- SPEAr310_EVB (Evaluation Board)
+			- SPEAr310 Evaluation Board
 		- SPEAr320 (SOC)
-			- SPEAr320_EVB (Evaluation Board)
+			- SPEAr320 Evaluation Board
 	- SPEAr6XX (6XX SOC series, based on ARM9)
 		- SPEAr600 (SOC)
-			- SPEAr600_EVB (Evaluation Board)
+			- SPEAr600 Evaluation Board
 	- SPEAr13XX (13XX SOC series, based on ARM CORTEXA9)
 		- SPEAr1300 (SOC)
 
@@ -51,10 +51,11 @@ Introduction
   Common file for machines of spear3xx family is mach-spear3xx/spear3xx.c and for
   spear6xx is mach-spear6xx/spear6xx.c. mach-spear* also contain soc/machine
   specific files, like spear300.c, spear310.c, spear320.c and spear600.c.
-  mach-spear* also contains board specific files for each machine type.
+  mach-spear* doesn't contains board specific files as they fully support
+  Flattened Device Tree.
 
 
   Document Author
   ---------------
 
-  Viresh Kumar, (c) 2010 ST Microelectronics
+  Viresh Kumar <viresh.kumar@st.com>, (c) 2010-2012 ST Microelectronics
diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
index f8e54f0..aa5f355 100644
--- a/Documentation/devicetree/bindings/arm/spear.txt
+++ b/Documentation/devicetree/bindings/arm/spear.txt
@@ -6,3 +6,21 @@ Boards with the ST SPEAr600 SoC shall have the following properties:
 Required root node property:
 
 compatible = "st,spear600";
+
+Boards with the ST SPEAr300 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "st,spear300";
+
+Boards with the ST SPEAr310 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "st,spear310";
+
+Boards with the ST SPEAr320 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "st,spear320";
diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
new file mode 100644
index 0000000..f2ee991
--- /dev/null
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -0,0 +1,179 @@
+/*
+ * DTS file for SPEAr300 Evaluation Baord
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "spear300.dtsi"
+
+/ {
+	model = "ST SPEAr300 Evaluation Board";
+	compatible = "st,spear300-evb", "st,spear300";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	ahb {
+		clcd at 60000000 {
+			status = "okay";
+		};
+
+		fsmc: flash at 94000000 {
+			status = "okay";
+		};
+
+		gmac: eth at e0800000 {
+			status = "okay";
+		};
+
+		sdhci at 70000000 {
+			int-gpio = <&gpio1 0 0>;
+			power-gpio = <&gpio1 2 1>;
+			status = "okay";
+		};
+
+		smi: flash at fc000000 {
+			status = "okay";
+		};
+
+		spi0: spi at d0100000 {
+			status = "okay";
+		};
+
+		ehci at e1800000 {
+			status = "okay";
+		};
+
+		ohci at e1900000 {
+			status = "okay";
+		};
+
+		ohci at e2100000 {
+			status = "okay";
+		};
+
+		apb {
+			gpio0: gpio at fc980000 {
+			       status = "okay";
+			};
+
+			gpio1: gpio at a9000000 {
+			       status = "okay";
+			};
+
+			i2c0: i2c at d0180000 {
+			       status = "okay";
+			};
+
+			kbd at a0000000 {
+				linux,keymap = < 0x00010000
+						 0x00020100
+						 0x00030200
+						 0x00040300
+						 0x00050400
+						 0x00060500
+						 0x00070600
+						 0x00080700
+						 0x00090800
+						 0x000a0001
+						 0x000c0101
+						 0x000d0201
+						 0x000e0301
+						 0x000f0401
+						 0x00100501
+						 0x00110601
+						 0x00120701
+						 0x00130801
+						 0x00140002
+						 0x00150102
+						 0x00160202
+						 0x00170302
+						 0x00180402
+						 0x00190502
+						 0x001a0602
+						 0x001b0702
+						 0x001c0802
+						 0x001d0003
+						 0x001e0103
+						 0x001f0203
+						 0x00200303
+						 0x00210403
+						 0x00220503
+						 0x00230603
+						 0x00240703
+						 0x00250803
+						 0x00260004
+						 0x00270104
+						 0x00280204
+						 0x00290304
+						 0x002a0404
+						 0x002b0504
+						 0x002c0604
+						 0x002d0704
+						 0x002e0804
+						 0x002f0005
+						 0x00300105
+						 0x00310205
+						 0x00320305
+						 0x00330405
+						 0x00340505
+						 0x00350605
+						 0x00360705
+						 0x00370805
+						 0x00380006
+						 0x00390106
+						 0x003a0206
+						 0x003b0306
+						 0x003c0406
+						 0x003d0506
+						 0x003e0606
+						 0x003f0706
+						 0x00400806
+						 0x00410007
+						 0x00420107
+						 0x00430207
+						 0x00440307
+						 0x00450407
+						 0x00460507
+						 0x00470607
+						 0x00480707
+						 0x00490807
+						 0x004a0008
+						 0x004b0108
+						 0x004c0208
+						 0x004d0308
+						 0x004e0408
+						 0x004f0508
+						 0x00500608
+						 0x00510708
+						 0x00520808 >;
+			       autorepeat;
+			       st,mode = <0>;
+			       status = "okay";
+			};
+
+			rtc at fc900000 {
+			       status = "okay";
+			};
+
+			serial at d0000000 {
+			       status = "okay";
+			};
+
+			wdt at fc880000 {
+			       status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
new file mode 100644
index 0000000..f9fcbf4
--- /dev/null
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -0,0 +1,72 @@
+/*
+ * DTS file for SPEAr300 SoC
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "spear3xx.dtsi"
+
+/ {
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0x60000000 0x60000000 0x50000000
+			  0xd0000000 0xd0000000 0x30000000>;
+
+		clcd at 60000000 {
+			compatible = "arm,clcd-pl110", "arm,primecell";
+			reg = <0x60000000 0x1000>;
+			interrupts = <30>;
+			status = "disabled";
+		};
+
+		fsmc: flash at 94000000 {
+			compatible = "st,spear600-fsmc-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x94000000 0x1000	/* FSMC Register */
+			       0x80000000 0x0010>;	/* NAND Base */
+			reg-names = "fsmc_regs", "nand_data";
+			st,ale-off = <0x20000>;
+			st,cle-off = <0x10000>;
+			status = "disabled";
+		};
+
+		sdhci at 70000000 {
+			compatible = "st,sdhci-spear";
+			reg = <0x70000000 0x100>;
+			interrupts = <1>;
+			status = "disabled";
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0xa0000000 0xa0000000 0x10000000
+				  0xd0000000 0xd0000000 0x30000000>;
+
+			gpio1: gpio at a9000000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0xa9000000 0x1000>;
+				status = "disabled";
+			};
+
+			kbd at a0000000 {
+				compatible = "st,spear300-kbd";
+				reg = <0xa0000000 0x1000>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
new file mode 100644
index 0000000..ec19d7b
--- /dev/null
+++ b/arch/arm/boot/dts/spear310-evb.dts
@@ -0,0 +1,107 @@
+/*
+ * DTS file for SPEAr310 Evaluation Baord
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "spear310.dtsi"
+
+/ {
+	model = "ST SPEAr310 Evaluation Board";
+	compatible = "st,spear310-evb", "st,spear310";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	ahb {
+		fsmc: flash at 44000000 {
+			status = "okay";
+		};
+
+		gmac: eth at e0800000 {
+			status = "okay";
+		};
+
+		smi: flash at fc000000 {
+			status = "okay";
+			clock-rate=<50000000>;
+
+			flash at f8000000 {
+				label = "m25p64";
+				reg = <0xf8000000 0x800000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				st,smi-fast-mode;
+			};
+		};
+
+		spi0: spi at d0100000 {
+			status = "okay";
+		};
+
+		ehci at e1800000 {
+			status = "okay";
+		};
+
+		ohci at e1900000 {
+			status = "okay";
+		};
+
+		ohci at e2100000 {
+			status = "okay";
+		};
+
+		apb {
+			gpio0: gpio at fc980000 {
+			       status = "okay";
+			};
+
+			i2c0: i2c at d0180000 {
+			       status = "okay";
+			};
+
+			rtc at fc900000 {
+			       status = "okay";
+			};
+
+			serial at d0000000 {
+			       status = "okay";
+			};
+
+			serial at b2000000 {
+			       status = "okay";
+			};
+
+			serial at b2080000 {
+			       status = "okay";
+			};
+
+			serial at b2100000 {
+			       status = "okay";
+			};
+
+			serial at b2180000 {
+			       status = "okay";
+			};
+
+			serial at b2200000 {
+			       status = "okay";
+			};
+
+			wdt at fc880000 {
+			       status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
new file mode 100644
index 0000000..dc7fa14
--- /dev/null
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -0,0 +1,75 @@
+/*
+ * DTS file for SPEAr310 SoC
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "spear3xx.dtsi"
+
+/ {
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0x40000000 0x40000000 0x10000000
+			  0xb0000000 0xb0000000 0x10000000
+			  0xd0000000 0xd0000000 0x30000000>;
+
+		fsmc: flash at 44000000 {
+			compatible = "st,spear600-fsmc-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x44000000 0x1000	/* FSMC Register */
+			       0x40000000 0x0010>;	/* NAND Base */
+			reg-names = "fsmc_regs", "nand_data";
+			st,ale-off = <0x10000>;
+			st,cle-off = <0x20000>;
+			status = "disabled";
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0xb0000000 0xb0000000 0x10000000
+				  0xd0000000 0xd0000000 0x30000000>;
+
+			serial at b2000000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xb2000000 0x1000>;
+				status = "disabled";
+			};
+
+			serial at b2080000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xb2080000 0x1000>;
+				status = "disabled";
+			};
+
+			serial at b2100000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xb2100000 0x1000>;
+				status = "disabled";
+			};
+
+			serial at b2180000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xb2180000 0x1000>;
+				status = "disabled";
+			};
+
+			serial at b2200000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xb2200000 0x1000>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
new file mode 100644
index 0000000..5681a97
--- /dev/null
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -0,0 +1,108 @@
+/*
+ * DTS file for SPEAr320 Evaluation Baord
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "spear320.dtsi"
+
+/ {
+	model = "ST SPEAr300 Evaluation Board";
+	compatible = "st,spear300-evb", "st,spear300";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	ahb {
+		clcd at 90000000 {
+			status = "okay";
+		};
+
+		fsmc: flash at 4c000000 {
+			status = "okay";
+		};
+
+		gmac: eth at e0800000 {
+			status = "okay";
+		};
+
+		sdhci at 70000000 {
+			power-gpio = <&gpio0 2 1>;
+			power_always_enb;
+			status = "okay";
+		};
+
+		smi: flash at fc000000 {
+			status = "okay";
+		};
+
+		spi0: spi at d0100000 {
+			status = "okay";
+		};
+
+		spi1: spi at a5000000 {
+			status = "okay";
+		};
+
+		spi2: spi at a6000000 {
+			status = "okay";
+		};
+
+		ehci at e1800000 {
+			status = "okay";
+		};
+
+		ohci at e1900000 {
+			status = "okay";
+		};
+
+		ohci at e2100000 {
+			status = "okay";
+		};
+
+		apb {
+			gpio0: gpio at fc980000 {
+			       status = "okay";
+			};
+
+			i2c0: i2c at d0180000 {
+			       status = "okay";
+			};
+
+			i2c1: i2c at a7000000 {
+			       status = "okay";
+			};
+
+			rtc at fc900000 {
+			       status = "okay";
+			};
+
+			serial at d0000000 {
+			       status = "okay";
+			};
+
+			serial at a3000000 {
+			       status = "okay";
+			};
+
+			serial at a4000000 {
+			       status = "okay";
+			};
+
+			wdt at fc880000 {
+			       status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
new file mode 100644
index 0000000..9a0267a
--- /dev/null
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -0,0 +1,90 @@
+/*
+ * DTS file for SPEAr320 SoC
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "spear3xx.dtsi"
+
+/ {
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0x40000000 0x40000000 0x70000000
+			  0xd0000000 0xd0000000 0x30000000>;
+
+		clcd at 90000000 {
+			compatible = "arm,clcd-pl110", "arm,primecell";
+			reg = <0x90000000 0x1000>;
+			interrupts = <33>;
+			status = "disabled";
+		};
+
+		fsmc: flash at 4c000000 {
+			compatible = "st,spear600-fsmc-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x4c000000 0x1000	/* FSMC Register */
+			       0x50000000 0x0010>;	/* NAND Base */
+			reg-names = "fsmc_regs", "nand_data";
+			st,ale-off = <0x20000>;
+			st,cle-off = <0x10000>;
+			status = "disabled";
+		};
+
+		sdhci at 70000000 {
+			compatible = "st,sdhci-spear";
+			reg = <0x70000000 0x100>;
+			interrupts = <29>;
+			status = "disabled";
+		};
+
+		spi1: spi at a5000000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0xa5000000 0x1000>;
+			status = "disabled";
+		};
+
+		spi2: spi at a6000000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0xa6000000 0x1000>;
+			status = "disabled";
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0xa0000000 0xa0000000 0x10000000
+				  0xd0000000 0xd0000000 0x30000000>;
+
+			i2c1: i2c at a7000000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0xa7000000 0x1000>;
+				status = "disabled";
+			};
+
+			serial at a3000000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xa3000000 0x1000>;
+				status = "disabled";
+			};
+
+			serial at a4000000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xa4000000 0x1000>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/spear3xx.dtsi
new file mode 100644
index 0000000..924a6f6
--- /dev/null
+++ b/arch/arm/boot/dts/spear3xx.dtsi
@@ -0,0 +1,136 @@
+/*
+ * DTS file for all SPEAr3xx SoCs
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&vic>;
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x40000000>;
+	};
+
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0xd0000000 0xd0000000 0x30000000>;
+
+		vic: interrupt-controller at f1100000 {
+			compatible = "arm,pl190-vic";
+			interrupt-controller;
+			reg = <0xf1100000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		gmac: eth at e0800000 {
+			compatible = "st,spear600-gmac";
+			reg = <0xe0800000 0x8000>;
+			interrupts = <23 22>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			status = "disabled";
+		};
+
+		smi: flash at fc000000 {
+			compatible = "st,spear600-smi";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xfc000000 0x1000>;
+			interrupts = <9>;
+			status = "disabled";
+		};
+
+		spi0: spi at d0100000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0xd0100000 0x1000>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+
+		ehci at e1800000 {
+			compatible = "st,spear600-ehci", "usb-ehci";
+			reg = <0xe1800000 0x1000>;
+			interrupts = <26>;
+			status = "disabled";
+		};
+
+		ohci at e1900000 {
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe1900000 0x1000>;
+			interrupts = <25>;
+			status = "disabled";
+		};
+
+		ohci at e2100000 {
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe2100000 0x1000>;
+			interrupts = <27>;
+			status = "disabled";
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0xd0000000 0xd0000000 0x30000000>;
+
+			gpio0: gpio at fc980000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xfc980000 0x1000>;
+				interrupts = <11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			i2c0: i2c at d0180000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0xd0180000 0x1000>;
+				interrupts = <21>;
+				status = "disabled";
+			};
+
+			rtc at fc900000 {
+				compatible = "st,spear-rtc";
+				reg = <0xfc900000 0x1000>;
+				interrupts = <10>;
+				status = "disabled";
+			};
+
+			serial at d0000000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xd0000000 0x1000>;
+				interrupts = <19>;
+				status = "disabled";
+			};
+
+			wdt at fc880000 {
+				compatible = "arm,sp805", "arm,primecell";
+				reg = <0xfc880000 0x1000>;
+				interrupts = <12>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-spear3xx/Kconfig b/arch/arm/mach-spear3xx/Kconfig
index 2cee6b0..d9fe11c 100644
--- a/arch/arm/mach-spear3xx/Kconfig
+++ b/arch/arm/mach-spear3xx/Kconfig
@@ -5,39 +5,19 @@
 if ARCH_SPEAR3XX
 
 menu "SPEAr3xx Implementations"
-config BOARD_SPEAR300_EVB
-	bool "SPEAr300 Evaluation Board"
-	select MACH_SPEAR300
-	help
-	  Supports ST SPEAr300 Evaluation Board
-
-config BOARD_SPEAR310_EVB
-	bool "SPEAr310 Evaluation Board"
-	select MACH_SPEAR310
-	help
-	  Supports ST SPEAr310 Evaluation Board
-
-config BOARD_SPEAR320_EVB
-	bool "SPEAr320 Evaluation Board"
-	select MACH_SPEAR320
-	help
-	  Supports ST SPEAr320 Evaluation Board
-
-endmenu
-
 config MACH_SPEAR300
-	bool "SPEAr300"
+	bool "SPEAr300 Machine support with Device Tree"
 	help
-	  Supports ST SPEAr300 Machine
+	  Supports ST SPEAr300 machine configured via the device-tree
 
 config MACH_SPEAR310
-	bool "SPEAr310"
+	bool "SPEAr310 Machine support with Device Tree"
 	help
-	  Supports ST SPEAr310 Machine
+	  Supports ST SPEAr310 machine configured via the device-tree
 
 config MACH_SPEAR320
-	bool "SPEAr320"
+	bool "SPEAr320 Machine support with Device Tree"
 	help
-	  Supports ST SPEAr320 Machine
-
+	  Supports ST SPEAr320 machine configured via the device-tree
+endmenu
 endif #ARCH_SPEAR3XX
diff --git a/arch/arm/mach-spear3xx/Makefile b/arch/arm/mach-spear3xx/Makefile
index b248624..17b5d83 100644
--- a/arch/arm/mach-spear3xx/Makefile
+++ b/arch/arm/mach-spear3xx/Makefile
@@ -3,24 +3,13 @@
 #
 
 # common files
-obj-y	+= spear3xx.o clock.o
+obj-$(CONFIG_ARCH_SPEAR3XX)	+= spear3xx.o clock.o
 
 # spear300 specific files
 obj-$(CONFIG_MACH_SPEAR300) += spear300.o
 
-# spear300 boards files
-obj-$(CONFIG_BOARD_SPEAR300_EVB) += spear300_evb.o
-
-
 # spear310 specific files
 obj-$(CONFIG_MACH_SPEAR310) += spear310.o
 
-# spear310 boards files
-obj-$(CONFIG_BOARD_SPEAR310_EVB) += spear310_evb.o
-
-
 # spear320 specific files
 obj-$(CONFIG_MACH_SPEAR320) += spear320.o
-
-# spear320 boards files
-obj-$(CONFIG_BOARD_SPEAR320_EVB) += spear320_evb.o
diff --git a/arch/arm/mach-spear3xx/Makefile.boot b/arch/arm/mach-spear3xx/Makefile.boot
index 4674a4c..d93e217 100644
--- a/arch/arm/mach-spear3xx/Makefile.boot
+++ b/arch/arm/mach-spear3xx/Makefile.boot
@@ -1,3 +1,7 @@
 zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
+
+dtb-$(CONFIG_MACH_SPEAR300)	+= spear300-evb.dtb
+dtb-$(CONFIG_MACH_SPEAR310)	+= spear310-evb.dtb
+dtb-$(CONFIG_MACH_SPEAR320)	+= spear320-evb.dtb
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 47d4535..9293c14 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of_platform.h>
 #include <asm/mach-types.h>
 #include <plat/clock.h>
 #include <mach/misc_regs.h>
@@ -673,11 +674,11 @@ static struct clk_lookup spear_clk_lookups[] = {
 	CLKDEV_INIT(NULL, "osc_32k_clk", &osc_32k_clk),
 	CLKDEV_INIT(NULL, "osc_24m_clk", &osc_24m_clk),
 	/* clock derived from 32 KHz osc clk */
-	CLKDEV_INIT("rtc-spear", NULL, &rtc_clk),
+	CLKDEV_INIT("fc900000.rtc", NULL, &rtc_clk),
 	/* clock derived from 24 MHz osc clk */
 	CLKDEV_INIT(NULL, "pll1_clk", &pll1_clk),
 	CLKDEV_INIT(NULL, "pll3_48m_clk", &pll3_48m_clk),
-	CLKDEV_INIT("wdt", NULL, &wdt_clk),
+	CLKDEV_INIT("fc880000.wdt", NULL, &wdt_clk),
 	/* clock derived from pll1 clk */
 	CLKDEV_INIT(NULL, "cpu_clk", &cpu_clk),
 	CLKDEV_INIT(NULL, "ahb_clk", &ahb_clk),
@@ -686,7 +687,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	CLKDEV_INIT(NULL, "gpt0_synth_clk", &gpt0_synth_clk),
 	CLKDEV_INIT(NULL, "gpt1_synth_clk", &gpt1_synth_clk),
 	CLKDEV_INIT(NULL, "gpt2_synth_clk", &gpt2_synth_clk),
-	CLKDEV_INIT("uart", NULL, &uart_clk),
+	CLKDEV_INIT("d0000000.serial", NULL, &uart_clk),
 	CLKDEV_INIT("firda", NULL, &firda_clk),
 	CLKDEV_INIT("gpt0", NULL, &gpt0_clk),
 	CLKDEV_INIT("gpt1", NULL, &gpt1_clk),
@@ -699,81 +700,95 @@ static struct clk_lookup spear_clk_lookups[] = {
 	CLKDEV_INIT(NULL, "usbh.1_clk", &usbh1_clk),
 	/* clock derived from ahb clk */
 	CLKDEV_INIT(NULL, "apb_clk", &apb_clk),
-	CLKDEV_INIT("i2c_designware.0", NULL, &i2c_clk),
+	CLKDEV_INIT("d0180000.i2c", NULL, &i2c_clk),
 	CLKDEV_INIT("dma", NULL, &dma_clk),
 	CLKDEV_INIT("jpeg", NULL, &jpeg_clk),
-	CLKDEV_INIT("gmac", NULL, &gmac_clk),
-	CLKDEV_INIT("smi", NULL, &smi_clk),
+	CLKDEV_INIT("e0800000.eth", NULL, &gmac_clk),
+	CLKDEV_INIT("fc000000.flash", NULL, &smi_clk),
 	CLKDEV_INIT("c3", NULL, &c3_clk),
 	/* clock derived from apb clk */
 	CLKDEV_INIT("adc", NULL, &adc_clk),
-	CLKDEV_INIT("ssp-pl022.0", NULL, &ssp0_clk),
-	CLKDEV_INIT("gpio", NULL, &gpio_clk),
+	CLKDEV_INIT("d0100000.spi", NULL, &ssp0_clk),
+	CLKDEV_INIT("fc980000.gpio", NULL, &gpio_clk),
 };
 
 /* array of all spear 300 clock lookups */
 #ifdef CONFIG_MACH_SPEAR300
 static struct clk_lookup spear300_clk_lookups[] = {
-	CLKDEV_INIT("clcd", NULL, &clcd_clk),
-	CLKDEV_INIT("fsmc", NULL, &fsmc_clk),
-	CLKDEV_INIT("gpio1", NULL, &gpio1_clk),
-	CLKDEV_INIT("keyboard", NULL, &kbd_clk),
-	CLKDEV_INIT("sdhci", NULL, &sdhci_clk),
+	CLKDEV_INIT("60000000.clcd", NULL, &clcd_clk),
+	CLKDEV_INIT("94000000.flash", NULL, &fsmc_clk),
+	CLKDEV_INIT("a9000000.gpio", NULL, &gpio1_clk),
+	CLKDEV_INIT("a0000000.kbd", NULL, &kbd_clk),
+	CLKDEV_INIT("70000000.sdhci", NULL, &sdhci_clk),
 };
+
+void __init spear300_clk_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
+		clk_register(&spear_clk_lookups[i]);
+
+	for (i = 0; i < ARRAY_SIZE(spear300_clk_lookups); i++)
+		clk_register(&spear300_clk_lookups[i]);
+
+	clk_init();
+}
 #endif
 
 /* array of all spear 310 clock lookups */
 #ifdef CONFIG_MACH_SPEAR310
 static struct clk_lookup spear310_clk_lookups[] = {
-	CLKDEV_INIT("fsmc", NULL, &fsmc_clk),
+	CLKDEV_INIT("44000000.flash", NULL, &fsmc_clk),
 	CLKDEV_INIT(NULL, "emi", &emi_clk),
-	CLKDEV_INIT("uart1", NULL, &uart1_clk),
-	CLKDEV_INIT("uart2", NULL, &uart2_clk),
-	CLKDEV_INIT("uart3", NULL, &uart3_clk),
-	CLKDEV_INIT("uart4", NULL, &uart4_clk),
-	CLKDEV_INIT("uart5", NULL, &uart5_clk),
+	CLKDEV_INIT("b2000000.serial", NULL, &uart1_clk),
+	CLKDEV_INIT("b2080000.serial", NULL, &uart2_clk),
+	CLKDEV_INIT("b2100000.serial", NULL, &uart3_clk),
+	CLKDEV_INIT("b2180000.serial", NULL, &uart4_clk),
+	CLKDEV_INIT("b2200000.serial", NULL, &uart5_clk),
 };
+
+void __init spear310_clk_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
+		clk_register(&spear_clk_lookups[i]);
+
+	for (i = 0; i < ARRAY_SIZE(spear310_clk_lookups); i++)
+		clk_register(&spear310_clk_lookups[i]);
+
+	clk_init();
+}
 #endif
 
 /* array of all spear 320 clock lookups */
 #ifdef CONFIG_MACH_SPEAR320
 static struct clk_lookup spear320_clk_lookups[] = {
-	CLKDEV_INIT("clcd", NULL, &clcd_clk),
-	CLKDEV_INIT("fsmc", NULL, &fsmc_clk),
-	CLKDEV_INIT("i2c_designware.1", NULL, &i2c1_clk),
+	CLKDEV_INIT("90000000.clcd", NULL, &clcd_clk),
+	CLKDEV_INIT("4c000000.flash", NULL, &fsmc_clk),
+	CLKDEV_INIT("a7000000.i2c", NULL, &i2c1_clk),
 	CLKDEV_INIT(NULL, "emi", &emi_clk),
 	CLKDEV_INIT("pwm", NULL, &pwm_clk),
-	CLKDEV_INIT("sdhci", NULL, &sdhci_clk),
+	CLKDEV_INIT("70000000.sdhci", NULL, &sdhci_clk),
 	CLKDEV_INIT("c_can_platform.0", NULL, &can0_clk),
 	CLKDEV_INIT("c_can_platform.1", NULL, &can1_clk),
-	CLKDEV_INIT("ssp-pl022.1", NULL, &ssp1_clk),
-	CLKDEV_INIT("ssp-pl022.2", NULL, &ssp2_clk),
-	CLKDEV_INIT("uart1", NULL, &uart1_clk),
-	CLKDEV_INIT("uart2", NULL, &uart2_clk),
+	CLKDEV_INIT("a5000000.spi", NULL, &ssp1_clk),
+	CLKDEV_INIT("a6000000.spi", NULL, &ssp2_clk),
+	CLKDEV_INIT("a3000000.serial", NULL, &uart1_clk),
+	CLKDEV_INIT("a4000000.serial", NULL, &uart2_clk),
 };
-#endif
 
-void __init spear3xx_clk_init(void)
+void __init spear320_clk_init(void)
 {
-	int i, cnt;
-	struct clk_lookup *lookups;
-
-	if (machine_is_spear300()) {
-		cnt = ARRAY_SIZE(spear300_clk_lookups);
-		lookups = spear300_clk_lookups;
-	} else if (machine_is_spear310()) {
-		cnt = ARRAY_SIZE(spear310_clk_lookups);
-		lookups = spear310_clk_lookups;
-	} else {
-		cnt = ARRAY_SIZE(spear320_clk_lookups);
-		lookups = spear320_clk_lookups;
-	}
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
 		clk_register(&spear_clk_lookups[i]);
 
-	for (i = 0; i < cnt; i++)
-		clk_register(&lookups[i]);
+	for (i = 0; i < ARRAY_SIZE(spear320_clk_lookups); i++)
+		clk_register(&spear320_clk_lookups[i]);
 
 	clk_init();
 }
+#endif
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 14276e5..84ee2bb 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -31,16 +31,13 @@
 #define SPEAR_GPT0_CHAN1_IRQ	SPEAR3XX_IRQ_CPU_GPT1_2
 
 /* Add spear3xx family device structure declarations here */
-extern struct amba_device spear3xx_gpio_device;
-extern struct amba_device spear3xx_uart_device;
 extern struct sys_timer spear3xx_timer;
+extern struct pl022_ssp_controller pl022_plat_data;
 
 /* Add spear3xx family function declarations here */
-void __init spear3xx_clk_init(void);
 void __init spear_setup_timer(void);
 void __init spear3xx_map_io(void);
-void __init spear3xx_init_irq(void);
-void __init spear3xx_init(void);
+void __init spear3xx_dt_init_irq(void);
 
 void spear_restart(char, const char *);
 
@@ -99,9 +96,6 @@ extern struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50;
 
 /* spear300 declarations */
 #ifdef CONFIG_MACH_SPEAR300
-/* Add spear300 machine device structure declarations here */
-extern struct amba_device spear300_gpio1_device;
-
 /* pad mux modes */
 extern struct pmx_mode spear300_nand_mode;
 extern struct pmx_mode spear300_nor_mode;
@@ -133,16 +127,13 @@ extern struct pmx_dev spear300_pmx_telecom_sdhci_4bit;
 extern struct pmx_dev spear300_pmx_telecom_sdhci_8bit;
 extern struct pmx_dev spear300_pmx_gpio1;
 
-/* Add spear300 machine function declarations here */
-void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
-		u8 pmx_dev_count);
+/* Add spear300 machine declarations here */
+void __init spear300_clk_init(void);
 
 #endif /* CONFIG_MACH_SPEAR300 */
 
 /* spear310 declarations */
 #ifdef CONFIG_MACH_SPEAR310
-/* Add spear310 machine device structure declarations here */
-
 /* pad mux devices */
 extern struct pmx_dev spear310_pmx_emi_cs_0_1_4_5;
 extern struct pmx_dev spear310_pmx_emi_cs_2_3;
@@ -153,16 +144,13 @@ extern struct pmx_dev spear310_pmx_fsmc;
 extern struct pmx_dev spear310_pmx_rs485_0_1;
 extern struct pmx_dev spear310_pmx_tdm0;
 
-/* Add spear310 machine function declarations here */
-void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
-		u8 pmx_dev_count);
+/* Add spear310 machine declarations here */
+void __init spear310_clk_init(void);
 
 #endif /* CONFIG_MACH_SPEAR310 */
 
 /* spear320 declarations */
 #ifdef CONFIG_MACH_SPEAR320
-/* Add spear320 machine device structure declarations here */
-
 /* pad mux modes */
 extern struct pmx_mode spear320_auto_net_smii_mode;
 extern struct pmx_mode spear320_auto_net_mii_mode;
@@ -193,9 +181,8 @@ extern struct pmx_dev spear320_pmx_smii0;
 extern struct pmx_dev spear320_pmx_smii1;
 extern struct pmx_dev spear320_pmx_i2c1;
 
-/* Add spear320 machine function declarations here */
-void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
-		u8 pmx_dev_count);
+/* Add spear320 machine declarations here */
+void __init spear320_clk_init(void);
 
 #endif /* CONFIG_MACH_SPEAR320 */
 
diff --git a/arch/arm/mach-spear3xx/include/mach/hardware.h b/arch/arm/mach-spear3xx/include/mach/hardware.h
index 4660c0d8..defa374 100644
--- a/arch/arm/mach-spear3xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear3xx/include/mach/hardware.h
@@ -17,7 +17,4 @@
 #include <plat/hardware.h>
 #include <mach/spear.h>
 
-/* Vitual to physical translation of statically mapped space */
-#define IO_ADDRESS(x)		(x | 0xF0000000)
-
 #endif /* __MACH_HARDWARE_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear.h b/arch/arm/mach-spear3xx/include/mach/spear.h
index 63fd983..8e3900a 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear.h
@@ -25,8 +25,9 @@
 
 /* ICM1 - Low speed connection */
 #define SPEAR3XX_ICM1_2_BASE		UL(0xD0000000)
+#define VA_SPEAR3XX_ICM1_2_BASE		UL(0xFD000000)
 #define SPEAR3XX_ICM1_UART_BASE		UL(0xD0000000)
-#define VA_SPEAR3XX_ICM1_UART_BASE	IO_ADDRESS(SPEAR3XX_ICM1_UART_BASE)
+#define VA_SPEAR3XX_ICM1_UART_BASE	(VA_SPEAR3XX_ICM1_2_BASE | SPEAR3XX_ICM1_UART_BASE)
 #define SPEAR3XX_ICM1_ADC_BASE		UL(0xD0080000)
 #define SPEAR3XX_ICM1_SSP_BASE		UL(0xD0100000)
 #define SPEAR3XX_ICM1_I2C_BASE		UL(0xD0180000)
@@ -53,11 +54,11 @@
 #define SPEAR3XX_ICM3_ML1_2_BASE	UL(0xF0000000)
 #define SPEAR3XX_ML1_TMR_BASE		UL(0xF0000000)
 #define SPEAR3XX_ML1_VIC_BASE		UL(0xF1100000)
-#define VA_SPEAR3XX_ML1_VIC_BASE	IO_ADDRESS(SPEAR3XX_ML1_VIC_BASE)
 
 /* ICM3 - Basic Subsystem */
 #define SPEAR3XX_ICM3_SMEM_BASE		UL(0xF8000000)
 #define SPEAR3XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
+#define VA_SPEAR3XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
 #define SPEAR3XX_ICM3_DMA_BASE		UL(0xFC400000)
 #define SPEAR3XX_ICM3_SDRAM_CTRL_BASE	UL(0xFC600000)
 #define SPEAR3XX_ICM3_TMR0_BASE		UL(0xFC800000)
@@ -65,9 +66,9 @@
 #define SPEAR3XX_ICM3_RTC_BASE		UL(0xFC900000)
 #define SPEAR3XX_ICM3_GPIO_BASE		UL(0xFC980000)
 #define SPEAR3XX_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
-#define VA_SPEAR3XX_ICM3_SYS_CTRL_BASE	IO_ADDRESS(SPEAR3XX_ICM3_SYS_CTRL_BASE)
+#define VA_SPEAR3XX_ICM3_SYS_CTRL_BASE	(VA_SPEAR3XX_ICM3_SMI_CTRL_BASE | SPEAR3XX_ICM3_SYS_CTRL_BASE)
 #define SPEAR3XX_ICM3_MISC_REG_BASE	UL(0xFCA80000)
-#define VA_SPEAR3XX_ICM3_MISC_REG_BASE	IO_ADDRESS(SPEAR3XX_ICM3_MISC_REG_BASE)
+#define VA_SPEAR3XX_ICM3_MISC_REG_BASE	(VA_SPEAR3XX_ICM3_SMI_CTRL_BASE | SPEAR3XX_ICM3_MISC_REG_BASE)
 #define SPEAR3XX_ICM3_TMR1_BASE		UL(0xFCB00000)
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index adee72b..c876c6a 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -3,8 +3,8 @@
  *
  * SPEAr300 machine source file
  *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -13,10 +13,9 @@
 
 #define pr_fmt(fmt) "SPEAr300: " fmt
 
-#include <linux/types.h>
-#include <linux/amba/pl061.h>
-#include <linux/ptrace.h>
-#include <asm/irq.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/vic.h>
+#include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
@@ -425,24 +424,35 @@ static struct spear_shirq shirq_ras1 = {
 	},
 };
 
-/* Add spear300 specific devices here */
-/* arm gpio1 device registration */
-static struct pl061_platform_data gpio1_plat_data = {
-	.gpio_base	= 8,
-	.irq_base	= SPEAR300_GPIO1_INT_BASE,
+/* padmux devices to enable */
+static struct pmx_dev *spear300_evb_pmx_devs[] = {
+	/* spear3xx specific devices */
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp_cs,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_mii,
+	&spear3xx_pmx_uart0,
+
+	/* spear300 specific devices */
+	&spear300_pmx_fsmc_2_chips,
+	&spear300_pmx_clcd,
+	&spear300_pmx_telecom_sdhci_4bit,
+	&spear300_pmx_gpio1,
 };
 
-AMBA_APB_DEVICE(spear300_gpio1, "gpio1", 0, SPEAR300_GPIO_BASE,
-	{SPEAR300_VIRQ_GPIO1}, &gpio1_plat_data);
+/* Add SPEAr300 auxdata to pass platform data */
+static struct of_dev_auxdata spear300_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
+			&pl022_plat_data),
+	{}
+};
 
-/* spear300 routines */
-void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
-		u8 pmx_dev_count)
+static void __init spear300_dt_init(void)
 {
-	int ret = 0;
+	int ret = -EINVAL;
 
-	/* call spear3xx family common init function */
-	spear3xx_init();
+	of_platform_populate(NULL, of_default_bus_match_table,
+			spear300_auxdata_lookup, NULL);
 
 	/* shared irq registration */
 	shirq_ras1.regs.base = ioremap(SPEAR300_TELECOM_BASE, SZ_4K);
@@ -452,18 +462,45 @@ void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 			pr_err("Error registering Shared IRQ\n");
 	}
 
-	/* pmx initialization */
-	pmx_driver.mode = pmx_mode;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = pmx_dev_count;
+	if (of_machine_is_compatible("st,spear300-evb")) {
+		/* pmx initialization */
+		pmx_driver.mode = &spear300_photo_frame_mode;
+		pmx_driver.devs = spear300_evb_pmx_devs;
+		pmx_driver.devs_count = ARRAY_SIZE(spear300_evb_pmx_devs);
+
+		pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE, SZ_4K);
+		if (pmx_driver.base) {
+			ret = pmx_register(&pmx_driver);
+			if (ret)
+				pr_err("padmux: registration failed. err no: %d\n",
+						ret);
+			/* Free Mapping, device selection already done */
+			iounmap(pmx_driver.base);
+		}
 
-	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE, SZ_4K);
-	if (pmx_driver.base) {
-		ret = pmx_register(&pmx_driver);
 		if (ret)
-			pr_err("padmux: registration failed. err no: %d\n",
-					ret);
-		/* Free Mapping, device selection already done */
-		iounmap(pmx_driver.base);
+			pr_err("Initialization Failed");
 	}
 }
+
+static const char * const spear300_dt_board_compat[] = {
+	"st,spear300",
+	"st,spear300-evb",
+	NULL,
+};
+
+static void __init spear300_map_io(void)
+{
+	spear3xx_map_io();
+	spear300_clk_init();
+}
+
+DT_MACHINE_START(SPEAR300_DT, "ST SPEAr300 SoC with Flattened Device Tree")
+	.map_io		=	spear300_map_io,
+	.init_irq	=	spear3xx_dt_init_irq,
+	.handle_irq	=	vic_handle_irq,
+	.timer		=	&spear3xx_timer,
+	.init_machine	=	spear300_dt_init,
+	.restart	=	spear_restart,
+	.dt_compat	=	spear300_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
deleted file mode 100644
index 3462ab9..0000000
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/spear300_evb.c
- *
- * SPEAr300 evaluation board source file
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <asm/hardware/vic.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-#include <mach/generic.h>
-#include <mach/hardware.h>
-
-/* padmux devices to enable */
-static struct pmx_dev *pmx_devs[] = {
-	/* spear3xx specific devices */
-	&spear3xx_pmx_i2c,
-	&spear3xx_pmx_ssp_cs,
-	&spear3xx_pmx_ssp,
-	&spear3xx_pmx_mii,
-	&spear3xx_pmx_uart0,
-
-	/* spear300 specific devices */
-	&spear300_pmx_fsmc_2_chips,
-	&spear300_pmx_clcd,
-	&spear300_pmx_telecom_sdhci_4bit,
-	&spear300_pmx_gpio1,
-};
-
-static struct amba_device *amba_devs[] __initdata = {
-	/* spear3xx specific devices */
-	&spear3xx_gpio_device,
-	&spear3xx_uart_device,
-
-	/* spear300 specific devices */
-	&spear300_gpio1_device,
-};
-
-static struct platform_device *plat_devs[] __initdata = {
-	/* spear3xx specific devices */
-
-	/* spear300 specific devices */
-};
-
-static void __init spear300_evb_init(void)
-{
-	unsigned int i;
-
-	/* call spear300 machine init function */
-	spear300_init(&spear300_photo_frame_mode, pmx_devs,
-			ARRAY_SIZE(pmx_devs));
-
-	/* Add Platform Devices */
-	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
-
-	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
-}
-
-MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
-	.atag_offset	=	0x100,
-	.map_io		=	spear3xx_map_io,
-	.init_irq	=	spear3xx_init_irq,
-	.handle_irq	=	vic_handle_irq,
-	.timer		=	&spear3xx_timer,
-	.init_machine	=	spear300_evb_init,
-	.restart	=	spear_restart,
-MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index b7c2876..641fd4c 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -3,8 +3,8 @@
  *
  * SPEAr310 machine source file
  *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -13,8 +13,11 @@
 
 #define pr_fmt(fmt) "SPEAr310: " fmt
 
-#include <linux/ptrace.h>
-#include <asm/irq.h>
+#include <linux/amba/pl08x.h>
+#include <linux/amba/serial.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/vic.h>
+#include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
@@ -257,17 +260,79 @@ static struct spear_shirq shirq_intrcomm_ras = {
 	},
 };
 
-/* Add spear310 specific devices here */
+/* padmux devices to enable */
+static struct pmx_dev *spear310_evb_pmx_devs[] = {
+	/* spear3xx specific devices */
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_gpio_pin0,
+	&spear3xx_pmx_gpio_pin1,
+	&spear3xx_pmx_gpio_pin2,
+	&spear3xx_pmx_gpio_pin3,
+	&spear3xx_pmx_gpio_pin4,
+	&spear3xx_pmx_gpio_pin5,
+	&spear3xx_pmx_uart0,
+
+	/* spear310 specific devices */
+	&spear310_pmx_emi_cs_0_1_4_5,
+	&spear310_pmx_emi_cs_2_3,
+	&spear310_pmx_uart1,
+	&spear310_pmx_uart2,
+	&spear310_pmx_uart3_4_5,
+	&spear310_pmx_fsmc,
+	&spear310_pmx_rs485_0_1,
+	&spear310_pmx_tdm0,
+};
+
+/* uart devices plat data */
+static struct amba_pl011_data spear310_uart_data[] = {
+	{
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "uart1_tx",
+		.dma_rx_param = "uart1_rx",
+	}, {
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "uart2_tx",
+		.dma_rx_param = "uart2_rx",
+	}, {
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "uart3_tx",
+		.dma_rx_param = "uart3_rx",
+	}, {
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "uart4_tx",
+		.dma_rx_param = "uart4_rx",
+	}, {
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "uart5_tx",
+		.dma_rx_param = "uart5_rx",
+	},
+};
 
-/* spear310 routines */
-void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
-		u8 pmx_dev_count)
+/* Add SPEAr310 auxdata to pass platform data */
+static struct of_dev_auxdata spear310_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
+			&pl022_plat_data),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART1_BASE, NULL,
+			&spear310_uart_data[0]),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART2_BASE, NULL,
+			&spear310_uart_data[1]),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART3_BASE, NULL,
+			&spear310_uart_data[2]),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART4_BASE, NULL,
+			&spear310_uart_data[3]),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR310_UART5_BASE, NULL,
+			&spear310_uart_data[4]),
+	{}
+};
+
+static void __init spear310_dt_init(void)
 {
 	void __iomem *base;
 	int ret = 0;
 
-	/* call spear3xx family common init function */
-	spear3xx_init();
+	of_platform_populate(NULL, of_default_bus_match_table,
+			spear310_auxdata_lookup, NULL);
 
 	/* shared irq registration */
 	base = ioremap(SPEAR310_SOC_CONFIG_BASE, SZ_4K);
@@ -297,13 +362,38 @@ void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 			pr_err("Error registering Shared IRQ 4\n");
 	}
 
-	/* pmx initialization */
-	pmx_driver.base = base;
-	pmx_driver.mode = pmx_mode;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = pmx_dev_count;
+	if (of_machine_is_compatible("st,spear310-evb")) {
+		/* pmx initialization */
+		pmx_driver.base = base;
+		pmx_driver.mode = NULL;
+		pmx_driver.devs = spear310_evb_pmx_devs;
+		pmx_driver.devs_count = ARRAY_SIZE(spear310_evb_pmx_devs);
 
-	ret = pmx_register(&pmx_driver);
-	if (ret)
-		pr_err("padmux: registration failed. err no: %d\n", ret);
+		ret = pmx_register(&pmx_driver);
+		if (ret)
+			pr_err("padmux: registration failed. err no: %d\n",
+					ret);
+	}
 }
+
+static const char * const spear310_dt_board_compat[] = {
+	"st,spear310",
+	"st,spear310-evb",
+	NULL,
+};
+
+static void __init spear310_map_io(void)
+{
+	spear3xx_map_io();
+	spear310_clk_init();
+}
+
+DT_MACHINE_START(SPEAR310_DT, "ST SPEAr310 SoC with Flattened Device Tree")
+	.map_io		=	spear310_map_io,
+	.init_irq	=	spear3xx_dt_init_irq,
+	.handle_irq	=	vic_handle_irq,
+	.timer		=	&spear3xx_timer,
+	.init_machine	=	spear310_dt_init,
+	.restart	=	spear_restart,
+	.dt_compat	=	spear310_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
deleted file mode 100644
index f92c499..0000000
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/spear310_evb.c
- *
- * SPEAr310 evaluation board source file
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <asm/hardware/vic.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-#include <mach/generic.h>
-#include <mach/hardware.h>
-
-/* padmux devices to enable */
-static struct pmx_dev *pmx_devs[] = {
-	/* spear3xx specific devices */
-	&spear3xx_pmx_i2c,
-	&spear3xx_pmx_ssp,
-	&spear3xx_pmx_gpio_pin0,
-	&spear3xx_pmx_gpio_pin1,
-	&spear3xx_pmx_gpio_pin2,
-	&spear3xx_pmx_gpio_pin3,
-	&spear3xx_pmx_gpio_pin4,
-	&spear3xx_pmx_gpio_pin5,
-	&spear3xx_pmx_uart0,
-
-	/* spear310 specific devices */
-	&spear310_pmx_emi_cs_0_1_4_5,
-	&spear310_pmx_emi_cs_2_3,
-	&spear310_pmx_uart1,
-	&spear310_pmx_uart2,
-	&spear310_pmx_uart3_4_5,
-	&spear310_pmx_fsmc,
-	&spear310_pmx_rs485_0_1,
-	&spear310_pmx_tdm0,
-};
-
-static struct amba_device *amba_devs[] __initdata = {
-	/* spear3xx specific devices */
-	&spear3xx_gpio_device,
-	&spear3xx_uart_device,
-
-	/* spear310 specific devices */
-};
-
-static struct platform_device *plat_devs[] __initdata = {
-	/* spear3xx specific devices */
-
-	/* spear310 specific devices */
-};
-
-static void __init spear310_evb_init(void)
-{
-	unsigned int i;
-
-	/* call spear310 machine init function */
-	spear310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
-
-	/* Add Platform Devices */
-	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
-
-	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
-}
-
-MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
-	.atag_offset	=	0x100,
-	.map_io		=	spear3xx_map_io,
-	.init_irq	=	spear3xx_init_irq,
-	.handle_irq	=	vic_handle_irq,
-	.timer		=	&spear3xx_timer,
-	.init_machine	=	spear310_evb_init,
-	.restart	=	spear_restart,
-MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 7bd39c0..9c571d0 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -3,8 +3,8 @@
  *
  * SPEAr320 machine source file
  *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -13,8 +13,12 @@
 
 #define pr_fmt(fmt) "SPEAr320: " fmt
 
-#include <linux/ptrace.h>
-#include <asm/irq.h>
+#include <linux/amba/pl022.h>
+#include <linux/amba/pl08x.h>
+#include <linux/amba/serial.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/vic.h>
+#include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
@@ -510,17 +514,79 @@ static struct spear_shirq shirq_intrcomm_ras = {
 	},
 };
 
-/* Add spear320 specific devices here */
+/* padmux devices to enable */
+static struct pmx_dev *spear320_evb_pmx_devs[] = {
+	/* spear3xx specific devices */
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_mii,
+	&spear3xx_pmx_uart0,
+
+	/* spear320 specific devices */
+	&spear320_pmx_fsmc,
+	&spear320_pmx_sdhci,
+	&spear320_pmx_i2s,
+	&spear320_pmx_uart1,
+	&spear320_pmx_uart2,
+	&spear320_pmx_can,
+	&spear320_pmx_pwm0,
+	&spear320_pmx_pwm1,
+	&spear320_pmx_pwm2,
+	&spear320_pmx_mii1,
+};
+
+static struct pl022_ssp_controller spear320_ssp_data[] = {
+	{
+		.bus_id = 1,
+		.enable_dma = 1,
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "ssp1_tx",
+		.dma_rx_param = "ssp1_rx",
+		.num_chipselect = 2,
+	}, {
+		.bus_id = 2,
+		.enable_dma = 1,
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "ssp2_tx",
+		.dma_rx_param = "ssp2_rx",
+		.num_chipselect = 2,
+	}
+};
+
+static struct amba_pl011_data spear320_uart_data[] = {
+	{
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "uart1_tx",
+		.dma_rx_param = "uart1_rx",
+	}, {
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "uart2_tx",
+		.dma_rx_param = "uart2_rx",
+	},
+};
 
-/* spear320 routines */
-void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
-		u8 pmx_dev_count)
+/* Add SPEAr310 auxdata to pass platform data */
+static struct of_dev_auxdata spear320_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,pl022", SPEAR3XX_ICM1_SSP_BASE, NULL,
+			&pl022_plat_data),
+	OF_DEV_AUXDATA("arm,pl022", SPEAR320_SSP0_BASE, NULL,
+			&spear320_ssp_data[0]),
+	OF_DEV_AUXDATA("arm,pl022", SPEAR320_SSP1_BASE, NULL,
+			&spear320_ssp_data[1]),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR320_UART1_BASE, NULL,
+			&spear320_uart_data[0]),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR320_UART2_BASE, NULL,
+			&spear320_uart_data[1]),
+	{}
+};
+
+static void __init spear320_dt_init(void)
 {
 	void __iomem *base;
 	int ret = 0;
 
-	/* call spear3xx family common init function */
-	spear3xx_init();
+	of_platform_populate(NULL, of_default_bus_match_table,
+			spear320_auxdata_lookup, NULL);
 
 	/* shared irq registration */
 	base = ioremap(SPEAR320_SOC_CONFIG_BASE, SZ_4K);
@@ -544,13 +610,38 @@ void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 			pr_err("Error registering Shared IRQ 4\n");
 	}
 
-	/* pmx initialization */
-	pmx_driver.base = base;
-	pmx_driver.mode = pmx_mode;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = pmx_dev_count;
+	if (of_machine_is_compatible("st,spear320-evb")) {
+		/* pmx initialization */
+		pmx_driver.base = base;
+		pmx_driver.mode = &spear320_auto_net_mii_mode;
+		pmx_driver.devs = spear320_evb_pmx_devs;
+		pmx_driver.devs_count = ARRAY_SIZE(spear320_evb_pmx_devs);
 
-	ret = pmx_register(&pmx_driver);
-	if (ret)
-		pr_err("padmux: registration failed. err no: %d\n", ret);
+		ret = pmx_register(&pmx_driver);
+		if (ret)
+			pr_err("padmux: registration failed. err no: %d\n",
+					ret);
+	}
 }
+
+static const char * const spear320_dt_board_compat[] = {
+	"st,spear320",
+	"st,spear320-evb",
+	NULL,
+};
+
+static void __init spear320_map_io(void)
+{
+	spear3xx_map_io();
+	spear320_clk_init();
+}
+
+DT_MACHINE_START(SPEAR320_DT, "ST SPEAr320 SoC with Flattened Device Tree")
+	.map_io		=	spear320_map_io,
+	.init_irq	=	spear3xx_dt_init_irq,
+	.handle_irq	=	vic_handle_irq,
+	.timer		=	&spear3xx_timer,
+	.init_machine	=	spear320_dt_init,
+	.restart	=	spear_restart,
+	.dt_compat	=	spear320_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
deleted file mode 100644
index 105334a..0000000
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/spear320_evb.c
- *
- * SPEAr320 evaluation board source file
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <asm/hardware/vic.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-#include <mach/generic.h>
-#include <mach/hardware.h>
-
-/* padmux devices to enable */
-static struct pmx_dev *pmx_devs[] = {
-	/* spear3xx specific devices */
-	&spear3xx_pmx_i2c,
-	&spear3xx_pmx_ssp,
-	&spear3xx_pmx_mii,
-	&spear3xx_pmx_uart0,
-
-	/* spear320 specific devices */
-	&spear320_pmx_fsmc,
-	&spear320_pmx_sdhci,
-	&spear320_pmx_i2s,
-	&spear320_pmx_uart1,
-	&spear320_pmx_uart2,
-	&spear320_pmx_can,
-	&spear320_pmx_pwm0,
-	&spear320_pmx_pwm1,
-	&spear320_pmx_pwm2,
-	&spear320_pmx_mii1,
-};
-
-static struct amba_device *amba_devs[] __initdata = {
-	/* spear3xx specific devices */
-	&spear3xx_gpio_device,
-	&spear3xx_uart_device,
-
-	/* spear320 specific devices */
-};
-
-static struct platform_device *plat_devs[] __initdata = {
-	/* spear3xx specific devices */
-
-	/* spear320 specific devices */
-};
-
-static void __init spear320_evb_init(void)
-{
-	unsigned int i;
-
-	/* call spear320 machine init function */
-	spear320_init(&spear320_auto_net_mii_mode, pmx_devs,
-			ARRAY_SIZE(pmx_devs));
-
-	/* Add Platform Devices */
-	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
-
-	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
-}
-
-MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
-	.atag_offset	=	0x100,
-	.map_io		=	spear3xx_map_io,
-	.init_irq	=	spear3xx_init_irq,
-	.handle_irq	=	vic_handle_irq,
-	.timer		=	&spear3xx_timer,
-	.init_machine	=	spear320_evb_init,
-	.restart	=	spear_restart,
-MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index a236925..a94d8c1 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -3,8 +3,8 @@
  *
  * SPEAr3XX machines common source file
  *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -13,76 +13,14 @@
 
 #define pr_fmt(fmt) "SPEAr3xx: " fmt
 
-#include <linux/types.h>
-#include <linux/amba/pl061.h>
-#include <linux/ptrace.h>
+#include <linux/amba/pl022.h>
+#include <linux/amba/pl08x.h>
+#include <linux/of_irq.h>
 #include <linux/io.h>
 #include <asm/hardware/vic.h>
-#include <asm/irq.h>
-#include <asm/mach/arch.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
-/* Add spear3xx machines common devices here */
-/* gpio device registration */
-static struct pl061_platform_data gpio_plat_data = {
-	.gpio_base	= 0,
-	.irq_base	= SPEAR3XX_GPIO_INT_BASE,
-};
-
-AMBA_APB_DEVICE(spear3xx_gpio, "gpio", 0, SPEAR3XX_ICM3_GPIO_BASE,
-	{SPEAR3XX_IRQ_BASIC_GPIO}, &gpio_plat_data);
-
-/* uart device registration */
-AMBA_APB_DEVICE(spear3xx_uart, "uart", 0, SPEAR3XX_ICM1_UART_BASE,
-	{SPEAR3XX_IRQ_UART}, NULL);
-
-/* Do spear3xx familiy common initialization part here */
-void __init spear3xx_init(void)
-{
-	/* nothing to do for now */
-}
-
-/* This will initialize vic */
-void __init spear3xx_init_irq(void)
-{
-	vic_init((void __iomem *)VA_SPEAR3XX_ML1_VIC_BASE, 0, ~0, 0);
-}
-
-/* Following will create static virtual/physical mappings */
-struct map_desc spear3xx_io_desc[] __initdata = {
-	{
-		.virtual	= VA_SPEAR3XX_ICM1_UART_BASE,
-		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_UART_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= VA_SPEAR3XX_ML1_VIC_BASE,
-		.pfn		= __phys_to_pfn(SPEAR3XX_ML1_VIC_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= VA_SPEAR3XX_ICM3_SYS_CTRL_BASE,
-		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SYS_CTRL_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= VA_SPEAR3XX_ICM3_MISC_REG_BASE,
-		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_MISC_REG_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	},
-};
-
-/* This will create static memory mapping for selected devices */
-void __init spear3xx_map_io(void)
-{
-	iotable_init(spear3xx_io_desc, ARRAY_SIZE(spear3xx_io_desc));
-
-	/* This will initialize clock framework */
-	spear3xx_clk_init();
-}
-
 /* pad multiplexing support */
 /* devices */
 static struct pmx_dev_mode pmx_firda_modes[] = {
@@ -508,6 +446,51 @@ struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50 = {
 };
 #endif /* CONFIG_MACH_SPEAR310 || CONFIG_MACH_SPEAR320 */
 
+/* ssp device registration */
+struct pl022_ssp_controller pl022_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 1,
+	.dma_filter = pl08x_filter_id,
+	.dma_tx_param = "ssp0_tx",
+	.dma_rx_param = "ssp0_rx",
+	/*
+	 * This is number of spi devices that can be connected to spi. There are
+	 * two type of chipselects on which slave devices can work. One is chip
+	 * select provided by spi masters other is controlled through external
+	 * gpio's. We can't use chipselect provided from spi master (because as
+	 * soon as FIFO becomes empty, CS is disabled and transfer ends). So
+	 * this number now depends on number of gpios available for spi. each
+	 * slave on each master requires a separate gpio pin.
+	 */
+	.num_chipselect = 2,
+};
+
+/*
+ * Following will create 16MB static virtual/physical mappings
+ * PHYSICAL		VIRTUAL
+ * 0xD0000000		0xFD000000
+ * 0xFC000000		0xFC000000
+ */
+struct map_desc spear3xx_io_desc[] __initdata = {
+	{
+		.virtual	= VA_SPEAR3XX_ICM1_2_BASE,
+		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_2_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR3XX_ICM3_SMI_CTRL_BASE,
+		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SMI_CTRL_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	},
+};
+
+/* This will create static memory mapping for selected devices */
+void __init spear3xx_map_io(void)
+{
+	iotable_init(spear3xx_io_desc, ARRAY_SIZE(spear3xx_io_desc));
+}
+
 static void __init spear3xx_timer_init(void)
 {
 	char pclk_name[] = "pll3_48m_clk";
@@ -538,3 +521,13 @@ static void __init spear3xx_timer_init(void)
 struct sys_timer spear3xx_timer = {
 	.init = spear3xx_timer_init,
 };
+
+static const struct of_device_id vic_of_match[] __initconst = {
+	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
+	{ /* Sentinel */ }
+};
+
+void __init spear3xx_dt_init_irq(void)
+{
+	of_irq_init(vic_of_match);
+}
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 1bb3dbc..6c066fc 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -9,9 +9,10 @@ choice
 	default ARCH_SPEAR3XX
 
 config ARCH_SPEAR3XX
-	bool "SPEAr3XX"
+	bool "ST SPEAr3xx with Device Tree"
 	select ARM_VIC
 	select CPU_ARM926T
+	select USE_OF
 	help
 	  Supports for ARM's SPEAR3XX family
 
-- 
1.7.9
