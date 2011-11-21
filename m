From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 21 Nov 2011 21:58:33 +0100
Subject: [PATCHv2] Initial DT support for SIMpad devices.
Message-ID: <1321909114-25355-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---

V2: 
- make localbus "simple-bus" compatible.
- add soc compatible entry to board.
- add sample partition table to DTS.
- fix flash bus width.
- switch to DT initialization of flash.

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/sa1110.dtsi                      |   72 +++++++++++++++++++
 arch/arm/boot/dts/simpad.dts                       |   75 ++++++++++++++++++++
 arch/arm/mach-sa1100/Kconfig                       |   13 ++++
 arch/arm/mach-sa1100/Makefile.boot                 |    1 +
 arch/arm/mach-sa1100/simpad.c                      |   27 +++++++-
 6 files changed, 188 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/sa1110.dtsi
 create mode 100644 arch/arm/boot/dts/simpad.dts

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 5b14518..cbe7046 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -34,6 +34,7 @@ qcom	Qualcomm, Inc.
 ramtron	Ramtron International
 samsung	Samsung Semiconductor
 schindler	Schindler
+siemens	SIEMENS
 simtek
 sirf	SiRF Technology, Inc.
 stericsson	ST-Ericsson
diff --git a/arch/arm/boot/dts/sa1110.dtsi b/arch/arm/boot/dts/sa1110.dtsi
new file mode 100644
index 0000000..af0dc7c
--- /dev/null
+++ b/arch/arm/boot/dts/sa1110.dtsi
@@ -0,0 +1,72 @@
+/*
+ * sa1110.dtsi - Device Tree Include file for Intel SA1110 SoC
+ *
+ *  Copyright (C) 2011 Jochen Friedrich <jochen@scram.de>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Intel SA1110 SoC";
+	compatible = "intel,sa1110";
+	interrupt-parent = <&aic>;
+
+	cpus {
+		cpu at 0 {
+			compatible = "intel,sa1110";
+		};
+	};
+
+	localbus {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = <
+			0x0 0x0 0x00000000 0x08000000
+			0x1 0x0 0x08000000 0x08000000
+			0x2 0x0 0x10000000 0x08000000
+			0x3 0x0 0x18000000 0x08000000
+			0x4 0x0 0x40000000 0x08000000
+			0x5 0x0 0x48000000 0x08000000
+		>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		uart0: serial at 0x80010000 {
+			compatible = "intel,sa1100-uart";
+			reg = <0x80010000 0x24>;
+			interrupts = <15>;
+			status = "disabled";
+		};
+
+		uart1: serial at 0x80030000 {
+			compatible = "intel,sa1100-uart";
+			reg = <0x80030000 0x24>;
+			interrupts = <16>;
+			status = "disabled";
+		};
+
+		uart2: serial at 0x80050000 {
+			compatible = "intel,sa1100-uart";
+			reg = <0x80050000 0x24>;
+			interrupts = <17>;
+			status = "disabled";
+		};
+
+		aic: interrupt-controller at 0x90050000 {
+			compatible = "intel,sa1110-icr";
+			reg = <0x90050000 0x24>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/simpad.dts b/arch/arm/boot/dts/simpad.dts
new file mode 100644
index 0000000..4e5fbde
--- /dev/null
+++ b/arch/arm/boot/dts/simpad.dts
@@ -0,0 +1,75 @@
+/dts-v1/;
+/include/ "sa1110.dtsi"
+
+/ {
+	model = "SIEMENS, SIMpad";
+	compatible = "siemens,simpad", "intel,sa1110";
+
+	aliases {
+		serial0 = &uart2;
+		serial1 = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x08000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttySA0";
+	};
+
+	localbus {
+		flash at 0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x08000000>;
+			bank-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x00000000 0x00040000>;
+			};
+			partition at 40000 {
+				label = "u-boot-env";
+				reg = <0x00040000 0x00020000>;
+			};
+			partition at 60000 {
+				label = "dtb";
+				reg = <0x00060000 0x00020000>;
+			};
+			partition at 80000 {
+				label = "kernel";
+				reg = <0x00080000 0x00200000>;
+			};
+			partition at 280000 {
+				label = "rootfs";
+				reg = <0x00280000 0x07d80000>;
+			};
+		};
+
+		flash at 1,0 {
+			compatible = "cfi-flash";
+			reg = <1 0 0x08000000>;
+			bank-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			partition at 0 {
+				label = "home";
+				reg = <0x00000000 0x08000000>;
+			};
+		};
+	};
+
+	soc {
+		uart0: serial at 0x80010000 {
+			status = "okay";
+		};
+
+		uart2: serial at 0x80050000 {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 42625e4..31238c3 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -157,6 +157,19 @@ config SA1100_SIMPAD
 	  like CL4 in additional it has a PCMCIA-Slot. For more information
 	  visit <http://www.usa.siemens.com/> or <http://www.siemens.ch/>.
 
+config SA1100_SIMPAD_DT
+	bool "Simpad with device tree support"
+	select CPU_FREQ_SA1110
+	select SA1100_SIMPAD
+	select USE_OF
+	help
+	  The SIEMENS webpad SIMpad is based on the StrongARM 1110. There
+	  are two different versions CL4 and SL4. CL4 has 32MB RAM and 16MB
+	  FLASH. The SL4 version got 64 MB RAM and 32 MB FLASH and a
+	  PCMCIA-Slot. The version for the Germany Telecom (DTAG) is the same
+	  like CL4 in additional it has a PCMCIA-Slot. For more information
+	  visit <http://www.usa.siemens.com/> or <http://www.siemens.ch/>.
+
 config SA1100_SSP
 	tristate "Generic PIO SSP"
 	help
diff --git a/arch/arm/mach-sa1100/Makefile.boot b/arch/arm/mach-sa1100/Makefile.boot
index 5a616f6..1d17767 100644
--- a/arch/arm/mach-sa1100/Makefile.boot
+++ b/arch/arm/mach-sa1100/Makefile.boot
@@ -6,3 +6,4 @@ endif
 params_phys-y	:= 0xc0000100
 initrd_phys-y	:= 0xc0800000
 
+dtb-$(CONFIG_SA1100_SIMPAD_DT)		+= simpad.dtb
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index d3c9d2b..fb8b224 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -10,6 +10,7 @@
 #include <linux/string.h> 
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
@@ -151,6 +152,7 @@ static struct sa1100_port_fns simpad_port_fns __initdata = {
 };
 
 
+#ifndef CONFIG_OF
 static struct mtd_partition simpad_partitions[] = {
 	{
 		.name       = "SIMpad boot firmware",
@@ -186,6 +188,7 @@ static struct resource simpad_flash_resources [] = {
 		.flags     = IORESOURCE_MEM,
 	}
 };
+#endif
 
 static struct mcp_plat_data simpad_mcp_data = {
 	.mccr0		= MCCR0_ADM,
@@ -211,8 +214,9 @@ static void __init simpad_map_io(void)
 
 	sa1100_register_uart_fns(&simpad_port_fns);
 	sa1100_register_uart(0, 3);  /* serial interface */
+#ifndef CONFIG_OF
 	sa1100_register_uart(1, 1);  /* DECT             */
-
+#endif
 	// Reassign UART 1 pins
 	GAFR |= GPIO_UART_TXD | GPIO_UART_RXD;
 	GPDR |= GPIO_UART_TXD | GPIO_LDD13 | GPIO_LDD15;
@@ -379,8 +383,10 @@ static int __init simpad_init(void)
 
 	pm_power_off = simpad_power_off;
 
+#ifndef CONFIG_OF
 	sa11x0_register_mtd(&simpad_flash_data, simpad_flash_resources,
 			      ARRAY_SIZE(simpad_flash_resources));
+#endif
 	sa11x0_register_mcp(&simpad_mcp_data);
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
@@ -392,6 +398,25 @@ static int __init simpad_init(void)
 
 arch_initcall(simpad_init);
 
+#ifdef CONFIG_OF
+static void __init simpad_dt_device_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *simpad_dt_board_compat[] __initconst = {
+	"siemens,simpad",
+	NULL
+};
+
+DT_MACHINE_START(simpad_dt, "SIMpad")
+	.timer		= &sa1100_timer,
+	.map_io		= simpad_map_io,
+	.init_irq	= sa1100_init_irq,
+	.init_machine	= simpad_dt_device_init,
+	.dt_compat	= simpad_dt_board_compat,
+MACHINE_END
+#endif
 
 MACHINE_START(SIMPAD, "Simpad")
 	/* Maintainer: Holger Freyther */
-- 
1.7.7.3
