From: sr@denx.de (Stefan Roese)
Date: Tue, 13 Mar 2012 15:47:12 +0100
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
Message-ID: <1331650032-15274-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a generic target for SPEAr600 board that can be
configured via the device-tree. Currently only interrupts are
configured via device-tree. Other peripheral devices (e.g.
ethernet, I2C, SMI flash, FSMC NAND flash etc) will follow in
later patches.

Only the spear600-evb is currently supported. Other SPEAr600
based boards will follow later.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Viresh Kumar <viresh.kumar@st.com>
---
 Documentation/devicetree/bindings/arm/spear.txt |    6 ++
 arch/arm/boot/dts/spear600-evb.dts              |   23 +++++++
 arch/arm/boot/dts/spear600.dtsi                 |   49 +++++++++++++++
 arch/arm/mach-spear6xx/Kconfig                  |    7 +++
 arch/arm/mach-spear6xx/Makefile                 |    1 +
 arch/arm/mach-spear6xx/board-dt.c               |   75 +++++++++++++++++++++++
 6 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 arch/arm/boot/dts/spear600-evb.dts
 create mode 100644 arch/arm/boot/dts/spear600.dtsi
 create mode 100644 arch/arm/mach-spear6xx/board-dt.c

diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
new file mode 100644
index 0000000..8e9f83e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear.txt
@@ -0,0 +1,6 @@
+ST SPEAr Platforms Device Tree Bindings
+---------------------------------------
+
+SPEAr600 EVB (Evaluation Board)
+Required root node properties:
+    - compatible = "st,spear600-evb";
diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
new file mode 100644
index 0000000..f92d099
--- /dev/null
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
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
+	compatible = "st,spear600-evb";
+	#address-cells = <1>;
+	#size-cells = <1>;
+};
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
new file mode 100644
index 0000000..82b086d
--- /dev/null
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
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
index cc1a4d8..e2d79b8 100644
--- a/arch/arm/mach-spear6xx/Makefile
+++ b/arch/arm/mach-spear6xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_MACH_SPEAR600) += spear600.o
 
 # spear600 boards files
 obj-$(CONFIG_BOARD_SPEAR600_EVB) += spear600_evb.o
+obj-$(CONFIG_BOARD_SPEAR600_DT) += board-dt.o
diff --git a/arch/arm/mach-spear6xx/board-dt.c b/arch/arm/mach-spear6xx/board-dt.c
new file mode 100644
index 0000000..ee4ff33
--- /dev/null
+++ b/arch/arm/mach-spear6xx/board-dt.c
@@ -0,0 +1,75 @@
+/*
+ * arch/arm/mach-spear6xx/board-dt.c
+ *
+ * Generic SPEAr600 platform support
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * Copyright 2012 Stefan Roese <sr@denx.de>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <asm/hardware/vic.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/hardware.h>
+
+static struct amba_device *amba_devs[] __initdata = {
+	&gpio_device[0],
+	&gpio_device[1],
+	&gpio_device[2],
+	&uart_device[0],
+	&uart_device[1],
+};
+
+static struct platform_device *plat_devs[] __initdata = {
+};
+
+static void __init spear600_dt_init(void)
+{
+	unsigned int i;
+
+	/* call spear600 machine init function */
+	spear600_init();
+
+	/* Add Platform Devices */
+	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
+
+	/* Add Amba Devices */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+}
+
+static const char *spear600_dt_board_compat[] = {
+	"st,spear600-evb",
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
+DT_MACHINE_START(SPEAR600_DT, "ST-SPEAR600-DT")
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
