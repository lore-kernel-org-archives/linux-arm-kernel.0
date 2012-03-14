From: sr@denx.de (Stefan Roese)
Date: Wed, 14 Mar 2012 16:00:32 +0100
Subject: [PATCH v2] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
Message-ID: <1331737232-25477-1-git-send-email-sr@denx.de>
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

Additionally the file spear600.c is deleted. It contained only
one empty function and is not needed. So lets just remove it.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
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
 arch/arm/boot/dts/spear600-evb.dts              |   30 +++++
 arch/arm/boot/dts/spear600.dtsi                 |  162 +++++++++++++++++++++++
 arch/arm/mach-spear6xx/Kconfig                  |    7 +
 arch/arm/mach-spear6xx/Makefile                 |    3 -
 arch/arm/mach-spear6xx/spear600.c               |   25 ----
 arch/arm/mach-spear6xx/spear600_evb.c           |    3 -
 arch/arm/mach-spear6xx/spear6xx.c               |   69 +++++++++-
 8 files changed, 270 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 arch/arm/boot/dts/spear600-evb.dts
 create mode 100644 arch/arm/boot/dts/spear600.dtsi
 delete mode 100644 arch/arm/mach-spear6xx/spear600.c

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
index 0000000..cbfda8d
--- /dev/null
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -0,0 +1,30 @@
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
+	soc {
+		gmac0: ethernet at e0800000 {
+			phy-mode = "gmii";
+		};
+
+		i2c at d0200000 {
+			clock-frequency = <400000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
new file mode 100644
index 0000000..e45e58f
--- /dev/null
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -0,0 +1,162 @@
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
+		reg = <0 0>; /* Filled by U-Boot */
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
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
+		serial at d0000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xd0000000 0x1000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <24>;
+		};
+
+		serial at d0080000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xd0080000 0x1000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <25>;
+		};
+
+		/* local/cpu GPIO */
+		gpio0: gpio at f0100000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0xf0100000 0x1000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <18>;
+		};
+
+		/* basic GPIO */
+		gpio1: gpio at fc980000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0xfc980000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <19>;
+		};
+
+		/* appl GPIO */
+		gpio2: gpio at d8100000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0xd8100000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <4>;
+		};
+
+		gmac0: ethernet at e0800000 {
+			compatible = "st,spear600-gmac";
+			reg = <0xe0800000 0x8000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <24 23>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			mac-address = [000000000000]; /* Filled in by U-Boot */
+		};
+
+		i2c at d0200000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xd0200000 0x1000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <28>;
+		};
+
+		fsmc0: flash at d1800000 {
+			status = "disabled";
+			compatible = "st,spear600-fsmc-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd1800000 0x1000	/* FSMC Register */
+			       0xd2000000 0x4000>;	/* NAND Base */
+			reg-names = "fsmc_regs", "nand_data";
+		};
+
+		smi0: flash at fc000000 {
+			status = "disabled";
+			compatible = "st,spear600-smi";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xfc000000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <12>;
+		};
+
+		ehci at e1800000 {
+			status = "disabled";
+			compatible = "st,spear600-ehci", "usb-ehci";
+			reg = <0xe1800000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <27>;
+		};
+
+		ehci at e2000000 {
+			status = "disabled";
+			compatible = "st,spear600-ehci", "usb-ehci";
+			reg = <0xe2000000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <29>;
+		};
+
+		ohci at e1900000 {
+			status = "disabled";
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe1900000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <26>;
+		};
+
+		ohci at e2100000 {
+			status = "disabled";
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe2100000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <28>;
+		};
+	};
+};
diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
index ff4ae5b..7777f72 100644
--- a/arch/arm/mach-spear6xx/Kconfig
+++ b/arch/arm/mach-spear6xx/Kconfig
@@ -11,6 +11,13 @@ config BOARD_SPEAR600_EVB
 	help
 	  Supports ST SPEAr600 Evaluation Board
 
+config BOARD_SPEAR600_DT
+	bool "SPEAr600 generic board configured via device-tree"
+	select MACH_SPEAR600
+	select USE_OF
+	help
+	  Supports ST SPEAr600 boards configured via the device-tree
+
 endmenu
 
 config MACH_SPEAR600
diff --git a/arch/arm/mach-spear6xx/Makefile b/arch/arm/mach-spear6xx/Makefile
index cc1a4d8..6f87c3a 100644
--- a/arch/arm/mach-spear6xx/Makefile
+++ b/arch/arm/mach-spear6xx/Makefile
@@ -5,8 +5,5 @@
 # common files
 obj-y	+= clock.o spear6xx.o
 
-# spear600 specific files
-obj-$(CONFIG_MACH_SPEAR600) += spear600.o
-
 # spear600 boards files
 obj-$(CONFIG_BOARD_SPEAR600_EVB) += spear600_evb.o
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
index c6e4254..c4949aa 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -32,9 +32,6 @@ static void __init spear600_evb_init(void)
 {
 	unsigned int i;
 
-	/* call spear600 machine init function */
-	spear600_init();
-
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index e0f6628..aca20f0 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2009 ST Microelectronics
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
  *
+ * Copyright 2012 Stefan Roese <sr@denx.de>
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -15,6 +17,10 @@
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <asm/hardware/vic.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
@@ -99,12 +105,6 @@ struct amba_device gpio_device[] = {
 	}
 };
 
-/* This will add devices, and do machine specific tasks */
-void __init spear6xx_init(void)
-{
-	/* nothing to do for now */
-}
-
 /* This will initialize vic */
 void __init spear6xx_init_irq(void)
 {
@@ -181,3 +181,60 @@ static void __init spear6xx_timer_init(void)
 struct sys_timer spear6xx_timer = {
 	.init = spear6xx_timer_init,
 };
+
+/*
+ * Devicetree specific init structs/functions:
+ * Once the SPEAr600 devicetree support has matured, we can remove
+ * spear600_evb.c and the non-devicetree support above in this file.
+ */
+
+/*
+ * Add auxdata so that clock name matching doesn't fail in device
+ * drivers
+ */
+struct of_dev_auxdata spear600_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,pl011", SPEAR6XX_ICM1_UART0_BASE,
+		       "uart0", NULL),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR6XX_ICM1_UART1_BASE,
+		       "uart1", NULL),
+	OF_DEV_AUXDATA("arm,pl061", SPEAR6XX_CPU_GPIO_BASE,
+		       "gpio0", NULL),
+	OF_DEV_AUXDATA("arm,pl061", SPEAR6XX_ICM3_GPIO_BASE,
+		       "gpio1", NULL),
+	OF_DEV_AUXDATA("arm,pl061", SPEAR6XX_ICM2_GPIO_BASE,
+		       "gpio2", NULL),
+	OF_DEV_AUXDATA("snps,designware-i2c", SPEAR6XX_ICM1_I2C_BASE,
+		       "i2c_designware.0", NULL),
+	{}
+};
+
+static void __init spear600_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     spear600_auxdata_lookup, NULL);
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
