From: lars.persson@axis.com (Lars Persson)
Date: Wed, 10 Feb 2016 13:41:55 +0100
Subject: [PATCH 6/8] arm: initial machine port for artpec-6 SoC
In-Reply-To: <cover.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
Message-ID: <fa3483f1a388e443245084c3b5e9aa1ad2f61392.1455107681.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic machine port for the Artpec-6 SoC from Axis
Communications.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/arm/Kconfig                     |  2 ++
 arch/arm/Makefile                    |  1 +
 arch/arm/mach-artpec/Kconfig         | 22 ++++++++++++
 arch/arm/mach-artpec/Makefile        |  1 +
 arch/arm/mach-artpec/board-artpec6.c | 66 ++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+)
 create mode 100644 arch/arm/mach-artpec/Kconfig
 create mode 100644 arch/arm/mach-artpec/Makefile
 create mode 100644 arch/arm/mach-artpec/board-artpec6.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f799e5..e1565dd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -724,6 +724,8 @@ source "arch/arm/mach-mvebu/Kconfig"
 
 source "arch/arm/mach-alpine/Kconfig"
 
+source "arch/arm/mach-artpec/Kconfig"
+
 source "arch/arm/mach-asm9260/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fe25410..4eb24c6 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -154,6 +154,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_ALPINE)		+= alpine
+machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_AT91)		+= at91
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
diff --git a/arch/arm/mach-artpec/Kconfig b/arch/arm/mach-artpec/Kconfig
new file mode 100644
index 0000000..eaa73d6
--- /dev/null
+++ b/arch/arm/mach-artpec/Kconfig
@@ -0,0 +1,22 @@
+menuconfig ARCH_ARTPEC
+	bool "Axis Communications ARM based ARTPEC SoCs" if ARCH_MULTI_V7
+
+if ARCH_ARTPEC
+
+config MACH_ARTPEC6
+	bool "Axis ARTPEC-6 ARM Cortex A9 Platform" if ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select ARM_PSCI
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_ARCH_TIMER
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if SMP
+	select SPARSE_IRQ
+	select USE_OF
+	help
+	  Support for Axis ARTPEC-6 ARM Cortex A9 Platform
+
+endif
diff --git a/arch/arm/mach-artpec/Makefile b/arch/arm/mach-artpec/Makefile
new file mode 100644
index 0000000..78325f0
--- /dev/null
+++ b/arch/arm/mach-artpec/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MACH_ARTPEC6)		:= board-artpec6.o
diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
new file mode 100644
index 0000000..6d7a59f
--- /dev/null
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -0,0 +1,66 @@
+/*
+ * ARTPEC-6 device support.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/clocksource.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/smp.h>
+#include <asm/smp_scu.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/psci.h>
+#include <linux/arm-smccc.h>
+
+#define ARTPEC6_DMACFG 0xf8000010
+#define ARTPEC6_DMACFG_UARTS_BURST 0xff
+
+#define SECURE_OP_L2C_WRITEREG 0xb4000001
+
+static void __init artpec6_init_machine(void)
+{
+	void __iomem *dmacfg;
+
+	/* Use PL011 DMA Burst Request signal instead of DMA Single Request */
+	dmacfg = ioremap(ARTPEC6_DMACFG, 4);
+	if (dmacfg) {
+		__raw_writel(ARTPEC6_DMACFG_UARTS_BURST, dmacfg);
+		iounmap(dmacfg);
+	}
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SECURE_OP_L2C_WRITEREG, reg, val, 0,
+		      0, 0, 0, 0, &res);
+
+	WARN_ON(res.a0);
+}
+
+static const char * const artpec6_dt_match[] = {
+	"axis,artpec6",
+	NULL
+};
+
+DT_MACHINE_START(ARTPEC6, "Axis ARTPEC-6 Platform")
+	.l2c_aux_val	= 0x0C000000,
+	.l2c_aux_mask	= 0xF3FFFFFF,
+	.l2c_write_sec  = artpec6_l2c310_write_sec,
+	.init_irq	= irqchip_init,
+	.init_machine	= artpec6_init_machine,
+	.dt_compat	= artpec6_dt_match,
+MACHINE_END
-- 
2.1.4
