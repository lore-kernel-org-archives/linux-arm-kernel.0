From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 12:57:04 +0530
Subject: [PATCH V2 08/12] ST SPEAr: Added source files for SPEAr6xx machine
	family
In-Reply-To: <1269502028-12867-8-git-send-email-viresh.kumar@st.com>
References: <1269502028-12867-1-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-2-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-3-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-4-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-5-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-6-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-7-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-8-git-send-email-viresh.kumar@st.com>
Message-ID: <1269502028-12867-9-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear6xx/Kconfig        |   20 ++++
 arch/arm/mach-spear6xx/Kconfig600     |   17 ++++
 arch/arm/mach-spear6xx/Makefile       |   12 +++
 arch/arm/mach-spear6xx/Makefile.boot  |    3 +
 arch/arm/mach-spear6xx/spear600.c     |   25 +++++
 arch/arm/mach-spear6xx/spear600_evb.c |   51 +++++++++++
 arch/arm/mach-spear6xx/spear6xx.c     |  158 +++++++++++++++++++++++++++++++++
 7 files changed, 286 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear6xx/Kconfig
 create mode 100644 arch/arm/mach-spear6xx/Kconfig600
 create mode 100644 arch/arm/mach-spear6xx/Makefile
 create mode 100644 arch/arm/mach-spear6xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear6xx/spear600.c
 create mode 100644 arch/arm/mach-spear6xx/spear600_evb.c
 create mode 100644 arch/arm/mach-spear6xx/spear6xx.c

diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
new file mode 100644
index 0000000..bddba03
--- /dev/null
+++ b/arch/arm/mach-spear6xx/Kconfig
@@ -0,0 +1,20 @@
+#
+# SPEAr6XX Machine configuration file
+#
+
+if ARCH_SPEAR6XX
+
+choice
+	prompt "SPEAr6XX Family"
+	default MACH_SPEAR600
+
+config MACH_SPEAR600
+	bool "SPEAr600"
+	help
+	  Supports ST SPEAr600 Machine
+endchoice
+
+# Adding SPEAr6XX machine specific configuration files
+source "arch/arm/mach-spear6xx/Kconfig600"
+
+endif #ARCH_SPEAR6XX
diff --git a/arch/arm/mach-spear6xx/Kconfig600 b/arch/arm/mach-spear6xx/Kconfig600
new file mode 100644
index 0000000..9e19f65
--- /dev/null
+++ b/arch/arm/mach-spear6xx/Kconfig600
@@ -0,0 +1,17 @@
+#
+# SPEAr600 machine configuration file
+#
+
+if MACH_SPEAR600
+
+choice
+	prompt "SPEAr600 Boards"
+	default BOARD_SPEAR600_EVB
+
+config	BOARD_SPEAR600_EVB
+	bool "SPEAr600 Evaluation Board"
+	help
+	  Supports ST SPEAr600 Evaluation Board
+endchoice
+
+endif	#MACH_SPEAR600
diff --git a/arch/arm/mach-spear6xx/Makefile b/arch/arm/mach-spear6xx/Makefile
new file mode 100644
index 0000000..cc1a4d8
--- /dev/null
+++ b/arch/arm/mach-spear6xx/Makefile
@@ -0,0 +1,12 @@
+#
+# Makefile for SPEAr6XX machine series
+#
+
+# common files
+obj-y	+= clock.o spear6xx.o
+
+# spear600 specific files
+obj-$(CONFIG_MACH_SPEAR600) += spear600.o
+
+# spear600 boards files
+obj-$(CONFIG_BOARD_SPEAR600_EVB) += spear600_evb.o
diff --git a/arch/arm/mach-spear6xx/Makefile.boot b/arch/arm/mach-spear6xx/Makefile.boot
new file mode 100644
index 0000000..7a1f3c0
--- /dev/null
+++ b/arch/arm/mach-spear6xx/Makefile.boot
@@ -0,0 +1,3 @@
+zreladdr-y	:= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-spear6xx/spear600.c b/arch/arm/mach-spear6xx/spear600.c
new file mode 100644
index 0000000..5c484c4
--- /dev/null
+++ b/arch/arm/mach-spear6xx/spear600.c
@@ -0,0 +1,25 @@
+/*
+ * arch/arm/mach-spear6xx/spear600.c
+ *
+ * SPEAr600 machine source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/ptrace.h>
+#include <asm/irq.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Add spear600 specific devices here */
+
+void __init spear600_init(void)
+{
+	/* call spear6xx family common init function */
+	spear6xx_init();
+}
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
new file mode 100644
index 0000000..daff8d0
--- /dev/null
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -0,0 +1,51 @@
+/*
+ * arch/arm/mach-spear6xx/spear600_evb.c
+ *
+ * SPEAr600 evaluation board source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
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
+static void __init spear600_evb_init(void)
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
+MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
+	.boot_params	=	0x00000100,
+	.map_io		=	spear6xx_map_io,
+	.init_irq	=	spear6xx_init_irq,
+	.timer		=	&spear_sys_timer,
+	.init_machine	=	spear600_evb_init,
+MACHINE_END
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
new file mode 100644
index 0000000..b67e571
--- /dev/null
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -0,0 +1,158 @@
+/*
+ * arch/arm/mach-spear6xx/spear6xx.c
+ *
+ * SPEAr6XX machines common source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/amba/pl061.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/io.h>
+#include <asm/hardware/vic.h>
+#include <asm/irq.h>
+#include <asm/mach/arch.h>
+#include <mach/irqs.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Add spear6xx machines common devices here */
+/* uart device registeration */
+struct amba_device uart_device[] = {
+	{
+		.dev = {
+			.init_name = "uart0",
+		},
+		.res = {
+			.start = SPEAR6XX_ICM1_UART0_BASE,
+			.end = SPEAR6XX_ICM1_UART0_BASE +
+				SPEAR6XX_ICM1_UART0_SIZE - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_UART_0, NO_IRQ},
+	}, {
+		.dev = {
+			.init_name = "uart1",
+		},
+		.res = {
+			.start = SPEAR6XX_ICM1_UART1_BASE,
+			.end = SPEAR6XX_ICM1_UART1_BASE +
+				SPEAR6XX_ICM1_UART1_SIZE - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_UART_1, NO_IRQ},
+	}
+};
+
+/* gpio device registeration */
+static struct pl061_platform_data gpio_plat_data[] = {
+	{
+		.gpio_base	= 0,
+		.irq_base	= SPEAR_GPIO0_INT_BASE,
+	}, {
+		.gpio_base	= 8,
+		.irq_base	= SPEAR_GPIO1_INT_BASE,
+	}, {
+		.gpio_base	= 16,
+		.irq_base	= SPEAR_GPIO2_INT_BASE,
+	},
+};
+
+struct amba_device gpio_device[] = {
+	{
+		.dev = {
+			.init_name = "gpio0",
+			.platform_data = &gpio_plat_data[0],
+		},
+		.res = {
+			.start = SPEAR6XX_CPU_GPIO_BASE,
+			.end = SPEAR6XX_CPU_GPIO_BASE +
+				SPEAR6XX_CPU_GPIO_SIZE - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_LOCAL_GPIO, NO_IRQ},
+	}, {
+		.dev = {
+			.init_name = "gpio1",
+			.platform_data = &gpio_plat_data[1],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM3_GPIO_BASE,
+			.end = SPEAR6XX_ICM3_GPIO_BASE +
+				SPEAR6XX_ICM3_GPIO_SIZE - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_BASIC_GPIO, NO_IRQ},
+	}, {
+		.dev = {
+			.init_name = "gpio2",
+			.platform_data = &gpio_plat_data[2],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM2_GPIO_BASE,
+			.end = SPEAR6XX_ICM2_GPIO_BASE +
+				SPEAR6XX_ICM2_GPIO_SIZE - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_APPL_GPIO, NO_IRQ},
+	}
+};
+
+/* This will add devices, and do machine specific tasks */
+void __init spear6xx_init(void)
+{
+	/* nothing to do for now */
+}
+
+/* This will initialize vic */
+void __init spear6xx_init_irq(void)
+{
+	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_PRI_BASE, 0, ~0, 0);
+	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_SEC_BASE, 32, ~0, 0);
+}
+
+/* Following will create static virtual/physical mappings */
+static struct map_desc spear6xx_io_desc[] __initdata = {
+	{
+		.virtual	= VA_SPEAR6XX_ICM1_UART0_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_ICM1_UART0_BASE),
+		.length		= SPEAR6XX_ICM1_UART0_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR6XX_CPU_VIC_PRI_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_PRI_BASE),
+		.length		= SPEAR6XX_CPU_VIC_PRI_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR6XX_CPU_VIC_SEC_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_SEC_BASE),
+		.length		= SPEAR6XX_CPU_VIC_SEC_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR6XX_ICM3_SYS_CTRL_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_SYS_CTRL_BASE),
+		.length		= SPEAR6XX_ICM3_MISC_REG_BASE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR6XX_ICM3_MISC_REG_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_MISC_REG_BASE),
+		.length		= SPEAR6XX_ICM3_MISC_REG_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+/* This will create static memory mapping for selected devices */
+void __init spear6xx_map_io(void)
+{
+	iotable_init(spear6xx_io_desc, ARRAY_SIZE(spear6xx_io_desc));
+
+	/* This will initialize clock framework */
+	clk_init();
+}
-- 
1.6.0.2
