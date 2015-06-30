From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Tue, 30 Jun 2015 18:15:03 +0300
Subject: [PATCH v2 1/5] ARM: rcm-k1879xb1: Add support for K1879XB1 SoC
In-Reply-To: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
References: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <1435677307-6526-2-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for RC Module's
K1879XB1YA SoC.

K1879XB1YA is a hybrid SoC with one ARM1176JZF-S
core running linux and one NeuroMatrix DSP core.

http://www.module.ru/en/catalog/micro/mikroshema_dekodera_cifrovogo_televizionnogo_signala_sbis_k1879hb1ya/
http://www.module.ru/en/catalog/micro/micro_pc/

Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
---
 arch/arm/Kconfig                      |   2 +
 arch/arm/Kconfig.debug                |   3 +-
 arch/arm/Makefile                     |   1 +
 arch/arm/mach-rcm-k1879xb1/Kconfig    |  10 +++
 arch/arm/mach-rcm-k1879xb1/Makefile   |   2 +
 arch/arm/mach-rcm-k1879xb1/board-dt.c | 146 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-rcm-k1879xb1/hardware.h |  48 +++++++++++
 7 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Kconfig
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Makefile
 create mode 100644 arch/arm/mach-rcm-k1879xb1/board-dt.c
 create mode 100644 arch/arm/mach-rcm-k1879xb1/hardware.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..ca38bcf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -906,6 +906,8 @@ source "arch/arm/mach-mmp/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
 
+source "arch/arm/mach-rcm-k1879xb1/Kconfig"
+
 source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c12ffb..efcb7fc 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1318,7 +1318,8 @@ config DEBUG_UART_8250
 		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
 		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
 		ARCH_IOP33X || ARCH_IXP4XX || \
-		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
+		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC || \
+		ARCH_RCM_K1879XB1
 
 # Compatibility options for BCM63xx
 config DEBUG_UART_BCM63XX
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 985227c..f3352ee 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -185,6 +185,7 @@ machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
+machine-$(CONFIG_ARCH_RCM_K1879XB1)	+= rcm-k1879xb1
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
diff --git a/arch/arm/mach-rcm-k1879xb1/Kconfig b/arch/arm/mach-rcm-k1879xb1/Kconfig
new file mode 100644
index 0000000..3defee0
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/Kconfig
@@ -0,0 +1,10 @@
+menuconfig ARCH_RCM_K1879XB1
+	bool "RC Module K1879XB1YA"
+	depends on MMU
+	depends on ARCH_MULTI_V6
+	select CPU_V6
+	select ARM_TIMER_SP804
+	select ARM_VIC
+	select ARM_AMBA
+	help
+	  Support for RC Module's K1879X SoCs
diff --git a/arch/arm/mach-rcm-k1879xb1/Makefile b/arch/arm/mach-rcm-k1879xb1/Makefile
new file mode 100644
index 0000000..c28fc14
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/Makefile
@@ -0,0 +1,2 @@
+obj-y += board-dt.o
+
diff --git a/arch/arm/mach-rcm-k1879xb1/board-dt.c b/arch/arm/mach-rcm-k1879xb1/board-dt.c
new file mode 100644
index 0000000..48d3835
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/board-dt.c
@@ -0,0 +1,145 @@
+/*
+ *  arch/arm/mach-rcm-k1879/board-dt.c
+ *
+ *  Copyright (C) 2011-2015 RC Module
+ *
+ *  Sergey Mironov <ierton@gmail.com>
+ *  Andrew Andrianov <andrew@ncrmnt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/map.h>
+#include <asm/mach/arch.h>
+#include "hardware.h"
+
+static void __iomem *k1879_mif;
+static void __iomem *k1879_wdt;
+
+static void __iomem *k1879_mif_base(void)
+{
+	BUG_ON(!k1879_mif);
+	return k1879_mif;
+}
+
+static void __iomem *k1879_sctl_base(void)
+{
+	return (void __iomem *)RCM_K1879_SCTL_VIRT_BASE;
+}
+
+static void k1879_level_irq_i2c0_fixup(unsigned int irq, struct irq_desc *desc)
+{
+	writel(1, k1879_mif_base() + RCM_K1879_MIF_I2C_INT_STAT);
+	handle_level_irq(irq, desc);
+}
+
+static void k1879_level_irq_i2c1_fixup(unsigned int irq, struct irq_desc *desc)
+{
+	writel(1 << 0, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
+	handle_level_irq(irq, desc);
+}
+
+static void k1879_level_irq_i2c2_fixup(unsigned int irq, struct irq_desc *desc)
+{
+	writel(1 << 1, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
+	handle_level_irq(irq, desc);
+}
+
+static void k1879_level_irq_i2c3_fixup(unsigned int irq, struct irq_desc *desc)
+{
+	writel(1 << 2, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
+	handle_level_irq(irq, desc);
+}
+
+static void (*k1879_i2c_fixups[])(unsigned int irq, struct irq_desc *desc) = {
+	k1879_level_irq_i2c0_fixup,
+	k1879_level_irq_i2c1_fixup,
+	k1879_level_irq_i2c2_fixup,
+	k1879_level_irq_i2c3_fixup
+};
+
+static void __init setup_i2c_fixups(void)
+{
+	struct device_node *np;
+	int irq;
+	u32 fixup_id = -1;
+
+	for_each_compatible_node(np, NULL, "rcm,i2c-ocores") {
+		int ret = of_property_read_u32(np, "rcm-irq-fixup-id",
+					       &fixup_id);
+
+		if (ret) {
+			pr_warn("k1879xb1: rcm-irq-fixup-id invalid: %d\n",
+				ret);
+			continue;
+		}
+		if (fixup_id >= ARRAY_SIZE(k1879_i2c_fixups)) {
+			pr_warn("k1879xb1: rcm-irq-fixup-id %d too big\n",
+				fixup_id);
+			continue;
+		}
+		irq = of_irq_get(np, 0);
+		irq_set_handler(irq, k1879_i2c_fixups[fixup_id]);
+	}
+}
+
+static void __init k1879_dt_mach_init(void)
+{
+	struct device_node *np;
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	k1879_mif = ioremap(RCM_K1879_MIF_PHYS_BASE,
+			    RCM_K1879_MIF_SIZE);
+	BUG_ON(!k1879_mif);
+
+	np = of_find_compatible_node(NULL, NULL, "arm,sp805");
+	WARN_ON(!np);
+	if (np)
+		k1879_wdt = of_iomap(np, 0);
+
+	/* Setup i2c interrupt fixups */
+	setup_i2c_fixups();
+
+	/* I2C0 (Internal, HDMI) needs some extra love */
+	do {
+		void __iomem *mif;
+
+		mif = k1879_mif_base();
+		writel(1, mif + RCM_K1879_MIF_I2C_INT_TYPE_ENA);
+		writel(1, mif + RCM_K1879_MIF_I2C_INT_TYPE);
+		writel(1, mif + RCM_K1879_MIF_I2C_INT_ENA);
+	} while (0);
+}
+
+static void k1879_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* The recommended way to do a soft-reboot on this platform
+	   is write directly to watchdog registers and cause an immediate
+	   watchdog restart
+	*/
+
+	if (!k1879_wdt) {
+		pr_err("k1879xb1: WDT regs were not properly mapped - reboot manually\n");
+		return;
+	}
+	iowrite32(1, (k1879_wdt + 0xf00));
+	iowrite32(1, (k1879_wdt + 0xf04));
+	/* Goodbye! */
+}
+
+static const char * const k1879_dt_match[] = {
+	"rcm,mb7707",
+	"rcm,k1879xb1ya",
+	NULL
+};
+
+DT_MACHINE_START(K1879, "RC Module K1879XB1YA (Device Tree)")
+	.init_machine           = k1879_dt_mach_init,
+	.dt_compat              = k1879_dt_match,
+	.restart                = k1879_restart
+MACHINE_END
diff --git a/arch/arm/mach-rcm-k1879xb1/hardware.h b/arch/arm/mach-rcm-k1879xb1/hardware.h
new file mode 100644
index 0000000..2977ed7
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/hardware.h
@@ -0,0 +1,48 @@
+/*
+ *  arch/arm/mach-rcm-k1879/board-dt.c
+ *
+ *  Copyright (C) 2011-2015 RC Module
+ *
+ *  Sergey Mironov <ierton@gmail.com>
+ *  Andrew Andrianov <andrew@ncrmnt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef HARDWARE_H
+#define HARDWARE_H
+
+/*
+ * This is the bare minimum required for arch code only.
+ * The rest comes from DeviceTree
+ */
+
+#define RCM_K1879_PHYS(bus, off)        (RCM_K1879_##bus##_PHYS_BASE + (off))
+#define RCM_K1879_VIRT(bus, off)        (RCM_K1879_##bus##_VIRT_BASE + (off))
+
+/* Areas of system memory space */
+#define RCM_K1879_AREA0_PHYS_BASE      0x20000000
+#define RCM_K1879_AREA0_SIZE           SZ_512K
+#define RCM_K1879_AREA0_VIRT_BASE      0xf8000000
+
+#define RCM_K1879_AREA1_PHYS_BASE      0x80000000
+#define RCM_K1879_AREA1_SIZE           SZ_2M
+#define RCM_K1879_AREA1_VIRT_BASE      0xf8100000
+
+#define RCM_K1879_SCTL_OFF             0x0003c000
+#define RCM_K1879_SCTL_PHYS_BASE       RCM_K1879_PHYS(AREA0, RCM_K1879_SCTL_OFF)
+#define RCM_K1879_SCTL_VIRT_BASE       RCM_K1879_VIRT(AREA0, RCM_K1879_SCTL_OFF)
+#define RCM_K1879_SCTL_SIZE            0x1000
+
+#define RCM_K1879_MIF_OFF              0x00172000
+#define RCM_K1879_MIF_PHYS_BASE        RCM_K1879_PHYS(AREA1, RCM_K1879_MIF_OFF)
+#define RCM_K1879_MIF_SIZE             0x100
+
+#define RCM_K1879_MIF_I2C_INT_TYPE_ENA  0x94
+#define RCM_K1879_MIF_I2C_INT_TYPE      0x98
+#define RCM_K1879_MIF_I2C_INT_ENA       0x9C
+#define RCM_K1879_MIF_I2C_INT_STAT      0xA0
+#define RCM_K1879_SCTL_INT_P_OUT        0x08
+
+#endif
-- 
2.1.4
