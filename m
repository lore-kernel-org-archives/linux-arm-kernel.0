From: sr@denx.de (Stefan Roese)
Date: Fri, 16 Mar 2012 14:03:23 +0100
Subject: [PATCH v5] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
Message-ID: <1331903003-14045-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a generic target for SPEAr600 board that can be
configured via the device-tree. Currently the following devices
are supported via the devicetree:

- VIC interrupts
- PL011 UART
- PL061 GPIO
- Synopsys DW I2C
- Synopsys DW ethernet

Other peripheral devices (e.g. SMI flash, FSMC NAND flash etc) will
follow in later patches.

Only the spear600-evb is currently supported. Other SPEAr600
based boards will follow later.

Since the current mainline SPEAr600 code only supports the SPEAr600
evaluation board, with nearly zero peripheral devices (only UART
and GPIO), it makes sense to switch over to DT based configuration
completely now. So this patch also removes all non-DT stuff, mainly
platform device data. The files spear600.c and spear600_evb.c are
removed completely.

Signed-off-by: Stefan Roese <sr@denx.de>
Acked-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
v5:
- Disabled all non-core devices in spear600.dtsi
- Enabled used devices in spear600-evb.dts
- Added values to ranges property for busses

v4:
- Added memory node to all dts/dtsi files
- Reorganizes bus topology in the dtsi file, to match the
  real SoC layout

v3:
- Removed non-DT SPEAr600 board support completely
- Removed OF_DEV_AUXDATA and changed clkdev instead, since we
  don't support non-DT targets any more
- Changed gmac0 -> gmac etc for single instance devices in the
  dts
- Added max memory size to memory node (instead of 0)
- Dropped mac-address property
- Removed some headers from spear6xx.c

v2:
- Added DT support to spear6xx.c instead of creating board-dt.c
- Removed UART (PL011) and GPIO (PL061) platform data for
  devicetree board port. This works now via DT probing
- Added OF_DEV_AUXDATA for clock device name matching for some
  device drivers
- Removed sper600.c file completely
- Added DW I2C and ethernet nodes to the dts files
- Added other DT nodes (SMI, FSMC, ECHI, OHCI), currently disabled
  since the corresponding device drivers don't support DT probing
- Removed Linaro/FSL copyright notice from SPEAr DT files (copy-paste cruft)
- Many smaller modification to the dts/dtsi files
- Changed Documentation/devicetree/bindings/arm/spear.txt to match
  the changed bindings


 Documentation/devicetree/bindings/arm/spear.txt |    8 ++
 arch/arm/boot/dts/spear600-evb.dts              |   47 ++++++
 arch/arm/boot/dts/spear600.dtsi                 |  174 +++++++++++++++++++++++
 arch/arm/mach-spear6xx/Kconfig                  |    7 +-
 arch/arm/mach-spear6xx/Makefile                 |    6 -
 arch/arm/mach-spear6xx/clock.c                  |   14 +-
 arch/arm/mach-spear6xx/spear600.c               |   25 ----
 arch/arm/mach-spear6xx/spear600_evb.c           |   54 -------
 arch/arm/mach-spear6xx/spear6xx.c               |  132 +++++------------
 9 files changed, 276 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 arch/arm/boot/dts/spear600-evb.dts
 create mode 100644 arch/arm/boot/dts/spear600.dtsi
 delete mode 100644 arch/arm/mach-spear6xx/spear600.c
 delete mode 100644 arch/arm/mach-spear6xx/spear600_evb.c

diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
new file mode 100644
index 0000000..f8e54f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear.txt
@@ -0,0 +1,8 @@
+ST SPEAr Platforms Device Tree Bindings
+---------------------------------------
+
+Boards with the ST SPEAr600 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "st,spear600";
diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
new file mode 100644
index 0000000..636292e
--- /dev/null
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2012 Stefan Roese <sr@denx.de>
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
+/include/ "spear600.dtsi"
+
+/ {
+	model = "ST SPEAr600 Evaluation Board";
+	compatible = "st,spear600-evb", "st,spear600";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x10000000>;
+	};
+
+	ahb {
+		gmac: ethernet at e0800000 {
+			phy-mode = "gmii";
+			status = "okay";
+		};
+
+		apb {
+			serial at d0000000 {
+				status = "okay";
+			};
+
+			serial at d0080000 {
+				status = "okay";
+			};
+
+			i2c at d0200000 {
+				clock-frequency = <400000>;
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
new file mode 100644
index 0000000..ebe0885
--- /dev/null
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -0,0 +1,174 @@
+/*
+ * Copyright 2012 Stefan Roese <sr@denx.de>
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
+	compatible = "st,spear600";
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
+		vic0: interrupt-controller at f1100000 {
+			compatible = "arm,pl190-vic";
+			interrupt-controller;
+			reg = <0xf1100000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		vic1: interrupt-controller at f1000000 {
+			compatible = "arm,pl190-vic";
+			interrupt-controller;
+			reg = <0xf1000000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		gmac: ethernet at e0800000 {
+			compatible = "st,spear600-gmac";
+			reg = <0xe0800000 0x8000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <24 23>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			status = "disabled";
+		};
+
+		fsmc: flash at d1800000 {
+			compatible = "st,spear600-fsmc-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd1800000 0x1000	/* FSMC Register */
+			       0xd2000000 0x4000>;	/* NAND Base */
+			reg-names = "fsmc_regs", "nand_data";
+			st,ale-off = <0x20000>;
+			st,cle-off = <0x10000>;
+			status = "disabled";
+		};
+
+		smi: flash at fc000000 {
+			compatible = "st,spear600-smi";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xfc000000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <12>;
+			status = "disabled";
+		};
+
+		ehci at e1800000 {
+			compatible = "st,spear600-ehci", "usb-ehci";
+			reg = <0xe1800000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <27>;
+			status = "disabled";
+		};
+
+		ehci at e2000000 {
+			compatible = "st,spear600-ehci", "usb-ehci";
+			reg = <0xe2000000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <29>;
+			status = "disabled";
+		};
+
+		ohci at e1900000 {
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe1900000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <26>;
+			status = "disabled";
+		};
+
+		ohci at e2100000 {
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe2100000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <28>;
+			status = "disabled";
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0xd0000000 0xd0000000 0x30000000>;
+
+			serial at d0000000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xd0000000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <24>;
+				status = "disabled";
+			};
+
+			serial at d0080000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xd0080000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <25>;
+				status = "disabled";
+			};
+
+			/* local/cpu GPIO */
+			gpio0: gpio at f0100000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0xf0100000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <18>;
+			};
+
+			/* basic GPIO */
+			gpio1: gpio at fc980000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0xfc980000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <19>;
+			};
+
+			/* appl GPIO */
+			gpio2: gpio at d8100000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0xd8100000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <4>;
+			};
+
+			i2c at d0200000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0xd0200000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <28>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
index ff4ae5b..fbe298b 100644
--- a/arch/arm/mach-spear6xx/Kconfig
+++ b/arch/arm/mach-spear6xx/Kconfig
@@ -5,11 +5,12 @@
 if ARCH_SPEAR6XX
 
 menu "SPEAr6xx Implementations"
-config BOARD_SPEAR600_EVB
-	bool "SPEAr600 Evaluation Board"
+config BOARD_SPEAR600_DT
+	bool "SPEAr600 generic board configured via device-tree"
 	select MACH_SPEAR600
+	select USE_OF
 	help
-	  Supports ST SPEAr600 Evaluation Board
+	  Supports ST SPEAr600 boards configured via the device-tree
 
 endmenu
 
diff --git a/arch/arm/mach-spear6xx/Makefile b/arch/arm/mach-spear6xx/Makefile
index cc1a4d8..76e5750 100644
--- a/arch/arm/mach-spear6xx/Makefile
+++ b/arch/arm/mach-spear6xx/Makefile
@@ -4,9 +4,3 @@
 
 # common files
 obj-y	+= clock.o spear6xx.o
-
-# spear600 specific files
-obj-$(CONFIG_MACH_SPEAR600) += spear600.o
-
-# spear600 boards files
-obj-$(CONFIG_BOARD_SPEAR600_EVB) += spear600_evb.o
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index ac70e0d..358f280 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -641,8 +641,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
 	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
 	{ .con_id = "gpt3_synth_clk",	.clk = &gpt3_synth_clk},
-	{ .dev_id = "uart0",		.clk = &uart0_clk},
-	{ .dev_id = "uart1",		.clk = &uart1_clk},
+	{ .dev_id = "d0000000.serial",	.clk = &uart0_clk},
+	{ .dev_id = "d0080000.serial",	.clk = &uart1_clk},
 	{ .dev_id = "firda",		.clk = &firda_clk},
 	{ .dev_id = "clcd",		.clk = &clcd_clk},
 	{ .dev_id = "gpt0",		.clk = &gpt0_clk},
@@ -655,20 +655,20 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "usbh.1_clk",	.clk = &usbh1_clk},
 	/* clock derived from ahb clk */
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
-	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
+	{ .dev_id = "d0200000.i2c",	.clk = &i2c_clk},
 	{ .dev_id = "dma",		.clk = &dma_clk},
 	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
 	{ .dev_id = "gmac",		.clk = &gmac_clk},
 	{ .dev_id = "smi",		.clk = &smi_clk},
-	{ .con_id = "fsmc",		.clk = &fsmc_clk},
+	{ .dev_id = "fsmc-nand",	.clk = &fsmc_clk},
 	/* clock derived from apb clk */
 	{ .dev_id = "adc",		.clk = &adc_clk},
 	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
 	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
 	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
-	{ .dev_id = "gpio0",		.clk = &gpio0_clk},
-	{ .dev_id = "gpio1",		.clk = &gpio1_clk},
-	{ .dev_id = "gpio2",		.clk = &gpio2_clk},
+	{ .dev_id = "f0100000.gpio",	.clk = &gpio0_clk},
+	{ .dev_id = "fc980000.gpio",	.clk = &gpio1_clk},
+	{ .dev_id = "d8100000.gpio",	.clk = &gpio2_clk},
 };
 
 void __init spear6xx_clk_init(void)
diff --git a/arch/arm/mach-spear6xx/spear600.c b/arch/arm/mach-spear6xx/spear600.c
deleted file mode 100644
index d0e6eea..0000000
--- a/arch/arm/mach-spear6xx/spear600.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/spear600.c
- *
- * SPEAr600 machine source file
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/ptrace.h>
-#include <asm/irq.h>
-#include <mach/generic.h>
-#include <mach/hardware.h>
-
-/* Add spear600 specific devices here */
-
-void __init spear600_init(void)
-{
-	/* call spear6xx family common init function */
-	spear6xx_init();
-}
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
deleted file mode 100644
index c6e4254..0000000
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/spear600_evb.c
- *
- * SPEAr600 evaluation board source file
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
-static struct amba_device *amba_devs[] __initdata = {
-	&gpio_device[0],
-	&gpio_device[1],
-	&gpio_device[2],
-	&uart_device[0],
-	&uart_device[1],
-};
-
-static struct platform_device *plat_devs[] __initdata = {
-};
-
-static void __init spear600_evb_init(void)
-{
-	unsigned int i;
-
-	/* call spear600 machine init function */
-	spear600_init();
-
-	/* Add Platform Devices */
-	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
-
-	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
-}
-
-MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
-	.atag_offset	=	0x100,
-	.map_io		=	spear6xx_map_io,
-	.init_irq	=	spear6xx_init_irq,
-	.handle_irq	=	vic_handle_irq,
-	.timer		=	&spear6xx_timer,
-	.init_machine	=	spear600_evb_init,
-	.restart	=	spear_restart,
-MACHINE_END
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index e0f6628..2ed8b14 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -6,111 +6,21 @@
  * Copyright (C) 2009 ST Microelectronics
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
  *
+ * Copyright 2012 Stefan Roese <sr@denx.de>
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/types.h>
-#include <linux/amba/pl061.h>
-#include <linux/ptrace.h>
-#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <asm/hardware/vic.h>
-#include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
-#include <mach/irqs.h>
-
-/* Add spear6xx machines common devices here */
-/* uart device registration */
-struct amba_device uart_device[] = {
-	{
-		.dev = {
-			.init_name = "uart0",
-		},
-		.res = {
-			.start = SPEAR6XX_ICM1_UART0_BASE,
-			.end = SPEAR6XX_ICM1_UART0_BASE + SZ_4K - 1,
-			.flags = IORESOURCE_MEM,
-		},
-		.irq = {IRQ_UART_0, NO_IRQ},
-	}, {
-		.dev = {
-			.init_name = "uart1",
-		},
-		.res = {
-			.start = SPEAR6XX_ICM1_UART1_BASE,
-			.end = SPEAR6XX_ICM1_UART1_BASE + SZ_4K - 1,
-			.flags = IORESOURCE_MEM,
-		},
-		.irq = {IRQ_UART_1, NO_IRQ},
-	}
-};
-
-/* gpio device registration */
-static struct pl061_platform_data gpio_plat_data[] = {
-	{
-		.gpio_base	= 0,
-		.irq_base	= SPEAR_GPIO0_INT_BASE,
-	}, {
-		.gpio_base	= 8,
-		.irq_base	= SPEAR_GPIO1_INT_BASE,
-	}, {
-		.gpio_base	= 16,
-		.irq_base	= SPEAR_GPIO2_INT_BASE,
-	},
-};
-
-struct amba_device gpio_device[] = {
-	{
-		.dev = {
-			.init_name = "gpio0",
-			.platform_data = &gpio_plat_data[0],
-		},
-		.res = {
-			.start = SPEAR6XX_CPU_GPIO_BASE,
-			.end = SPEAR6XX_CPU_GPIO_BASE + SZ_4K - 1,
-			.flags = IORESOURCE_MEM,
-		},
-		.irq = {IRQ_LOCAL_GPIO, NO_IRQ},
-	}, {
-		.dev = {
-			.init_name = "gpio1",
-			.platform_data = &gpio_plat_data[1],
-		},
-		.res = {
-			.start = SPEAR6XX_ICM3_GPIO_BASE,
-			.end = SPEAR6XX_ICM3_GPIO_BASE + SZ_4K - 1,
-			.flags = IORESOURCE_MEM,
-		},
-		.irq = {IRQ_BASIC_GPIO, NO_IRQ},
-	}, {
-		.dev = {
-			.init_name = "gpio2",
-			.platform_data = &gpio_plat_data[2],
-		},
-		.res = {
-			.start = SPEAR6XX_ICM2_GPIO_BASE,
-			.end = SPEAR6XX_ICM2_GPIO_BASE + SZ_4K - 1,
-			.flags = IORESOURCE_MEM,
-		},
-		.irq = {IRQ_APPL_GPIO, NO_IRQ},
-	}
-};
-
-/* This will add devices, and do machine specific tasks */
-void __init spear6xx_init(void)
-{
-	/* nothing to do for now */
-}
-
-/* This will initialize vic */
-void __init spear6xx_init_irq(void)
-{
-	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_PRI_BASE, 0, ~0, 0);
-	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_SEC_BASE, 32, ~0, 0);
-}
 
 /* Following will create static virtual/physical mappings */
 static struct map_desc spear6xx_io_desc[] __initdata = {
@@ -181,3 +91,33 @@ static void __init spear6xx_timer_init(void)
 struct sys_timer spear6xx_timer = {
 	.init = spear6xx_timer_init,
 };
+
+static void __init spear600_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *spear600_dt_board_compat[] = {
+	"st,spear600",
+	NULL
+};
+
+static const struct of_device_id vic_of_match[] __initconst = {
+	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
+	{ /* Sentinel */ }
+};
+
+static void __init spear6xx_dt_init_irq(void)
+{
+	of_irq_init(vic_of_match);
+}
+
+DT_MACHINE_START(SPEAR600_DT, "ST SPEAr600 (Flattened Device Tree)")
+	.map_io		=	spear6xx_map_io,
+	.init_irq	=	spear6xx_dt_init_irq,
+	.handle_irq	=	vic_handle_irq,
+	.timer		=	&spear6xx_timer,
+	.init_machine	=	spear600_dt_init,
+	.restart	=	spear_restart,
+	.dt_compat	=	spear600_dt_board_compat,
+MACHINE_END
-- 
1.7.9.2
