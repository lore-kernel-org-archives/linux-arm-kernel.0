From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Tue, 23 Jun 2015 18:50:01 +0300
Subject: [PATCH 1/4] ARM: rcm-k1879xb1: Add support for K1879XB1 SoC
In-Reply-To: <1435074604-19312-1-git-send-email-andrew@ncrmnt.org>
References: <1435074604-19312-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <1435074604-19312-2-git-send-email-andrew@ncrmnt.org>
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
 arch/arm/Kconfig                                   |  18 +++
 arch/arm/Kconfig.debug                             |   5 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/mach-rcm-k1879xb1/Kconfig                 |   0
 arch/arm/mach-rcm-k1879xb1/Makefile                |   2 +
 arch/arm/mach-rcm-k1879xb1/Makefile.boot           |   4 +
 arch/arm/mach-rcm-k1879xb1/board-dt.c              | 152 +++++++++++++++++++++
 arch/arm/mach-rcm-k1879xb1/cpuidle.c               |  48 +++++++
 arch/arm/mach-rcm-k1879xb1/include/mach/hardware.h |  75 ++++++++++
 .../mach-rcm-k1879xb1/include/mach/uncompress.h    |  54 ++++++++
 10 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Kconfig
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Makefile
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Makefile.boot
 create mode 100644 arch/arm/mach-rcm-k1879xb1/board-dt.c
 create mode 100644 arch/arm/mach-rcm-k1879xb1/cpuidle.c
 create mode 100644 arch/arm/mach-rcm-k1879xb1/include/mach/hardware.h
 create mode 100644 arch/arm/mach-rcm-k1879xb1/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..2de4d2a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -619,6 +619,24 @@ config ARCH_PXA
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
+config ARCH_RCM_K1879XB1
+	bool "RC Module K1879XB1YA"
+	depends on MMU
+	select CPU_V6
+        select ARM_AMBA
+	select ARM_VIC
+	select SPARSE_IRQ
+	select GENERIC_GPIO
+	select COMMON_CLK
+	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_OHCI
+	select ARCH_REQUIRE_GPIOLIB
+	select NEED_MACH_GPIO_H
+	select GENERIC_CLOCKEVENTS
+	select CLKSRC_ARM_DIT
+	help
+	  Support for RC Module's K1879X SoCs
+
 config ARCH_SHMOBILE_LEGACY
 	bool "Renesas ARM SoCs (non-multiplatform)"
 	select ARCH_SHMOBILE
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c12ffb..48ee54c 100644
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
@@ -1417,6 +1418,7 @@ config DEBUG_UART_PHYS
 	default 0xfffb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
 	default 0xfffe8600 if DEBUG_UART_BCM63XX
 	default 0xfffff700 if ARCH_IOP33X
+	default 0x2002b000 if ARCH_RCM_K1879XB1
 	depends on ARCH_EP93XX || \
 	        DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
@@ -1511,6 +1513,7 @@ config DEBUG_UART_VIRT
 	default 0xfefff700 if ARCH_IOP33X
 	default 0xff003000 if DEBUG_U300_UART
 	default 0xffd01000 if DEBUG_HIP01_UART
+	default 0xf802b000 if ARCH_RCM_K1879XB1
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 985227c..9beb65f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -184,6 +184,7 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
+machine-$(CONFIG_ARCH_RCM_K1879XB1)	+= rcm-k1879xb1
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
diff --git a/arch/arm/mach-rcm-k1879xb1/Kconfig b/arch/arm/mach-rcm-k1879xb1/Kconfig
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/mach-rcm-k1879xb1/Makefile b/arch/arm/mach-rcm-k1879xb1/Makefile
new file mode 100644
index 0000000..324af07
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/Makefile
@@ -0,0 +1,2 @@
+obj-y += board-dt.o cpuidle.o
+
diff --git a/arch/arm/mach-rcm-k1879xb1/Makefile.boot b/arch/arm/mach-rcm-k1879xb1/Makefile.boot
new file mode 100644
index 0000000..4075590
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/Makefile.boot
@@ -0,0 +1,4 @@
+   zreladdr-y   := 0x40008000
+params_phys-y   := 0x40000100
+initrd_phys-y   := 0x40800000
+
diff --git a/arch/arm/mach-rcm-k1879xb1/board-dt.c b/arch/arm/mach-rcm-k1879xb1/board-dt.c
new file mode 100644
index 0000000..00084ad
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/board-dt.c
@@ -0,0 +1,152 @@
+/*
+ *  arch/arm/mach-rcm-k1879/board-dt.c
+ *
+ *  Copyright (C) 2011-2015 RC Module
+ *
+ *  Sergey Mironov <ierton@gmail.com>
+ *  Andrew Andrianov <andrew@ncrmnt.org>
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
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/map.h>
+#include <asm/mach/arch.h>
+#include <mach/hardware.h>
+
+static struct map_desc k1879_io_desc[] __initdata = {
+	{
+		.virtual	= RCM_K1879_AREA0_VIRT_BASE,
+		.pfn		= __phys_to_pfn(RCM_K1879_AREA0_PHYS_BASE),
+		.length		= RCM_K1879_AREA0_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= RCM_K1879_AREA1_VIRT_BASE,
+		.pfn		= __phys_to_pfn(RCM_K1879_AREA1_PHYS_BASE),
+		.length		= RCM_K1879_AREA1_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __iomem *g_k1879_mif;
+
+static void __iomem *k1879_mif_base(void)
+{
+	BUG_ON(!g_k1879_mif);
+	return g_k1879_mif;
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
+static void __init k1879_map_io(void)
+{
+	iotable_init(k1879_io_desc, ARRAY_SIZE(k1879_io_desc));
+}
+
+static const struct of_device_id i2c_of_match[] __initconst = {
+	{ .compatible = "rcm,i2c-ocores", },
+	{}
+};
+
+static void __init setup_i2c_fixup(u64 base,
+				   void (*fixup_handler)(unsigned int irq,
+							 struct irq_desc *desc))
+{
+	struct device_node *np;
+	int irq;
+
+	np = of_find_matching_node_by_address(NULL, i2c_of_match, base);
+	BUG_ON(!np);
+	irq = of_irq_get(np, 0);
+	irq_set_handler(irq, fixup_handler);
+}
+
+static void __init k1879_dt_mach_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	g_k1879_mif = ioremap_nocache(RCM_K1879_MIF_PHYS_BASE,
+				      RCM_K1879_MIF_SIZE);
+	BUG_ON(!g_k1879_mif);
+
+	/* Setup i2c interrupt fixups */
+	setup_i2c_fixup(RCM_K1879_GRI2C0_PHYS_BASE, k1879_level_irq_i2c0_fixup);
+	setup_i2c_fixup(RCM_K1879_GRI2C1_PHYS_BASE, k1879_level_irq_i2c1_fixup);
+	setup_i2c_fixup(RCM_K1879_GRI2C2_PHYS_BASE, k1879_level_irq_i2c2_fixup);
+	setup_i2c_fixup(RCM_K1879_GRI2C3_PHYS_BASE, k1879_level_irq_i2c3_fixup);
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
+void k1879_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* The recommended way to do a soft-reboot on this platform
+	   is write directly to watchdog registers and cause an immediate
+	   system reboot
+	*/
+	void __iomem *regs;
+
+	pr_info("k1879: Requested system restart\n");
+	regs = ioremap_nocache(0x20025000, 0xfff);
+	iowrite32(1, (regs + 0xf00));
+	iowrite32(1, (regs + 0xf04));
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
+	.map_io                 = k1879_map_io,
+	.init_machine           = k1879_dt_mach_init,
+	.dt_compat              = k1879_dt_match,
+	.restart                = k1879_restart
+MACHINE_END
diff --git a/arch/arm/mach-rcm-k1879xb1/cpuidle.c b/arch/arm/mach-rcm-k1879xb1/cpuidle.c
new file mode 100644
index 0000000..7c621b6
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/cpuidle.c
@@ -0,0 +1,48 @@
+/*
+ * CPU idle for RC Module K1879XB1YA SoC
+ *
+ * Copyright (C) 2015 RC Module.
+ * http://www.module.ru/
+ *
+ * Andrew Andrianov <andrew@ncrmnt.org>
+ *
+ * Based on Davinci CPU idle code
+ * (arch/arm/mach-davinci/cpuidle.c)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/cpuidle.h>
+#include <asm/cpuidle.h>
+
+/*
+ * We only enable WFI here, since DDR will enter self-refresh
+ * on it's own when it can (bootloader takes care to configure that)
+ */
+
+static struct cpuidle_driver rcm_idle_driver = {
+	.name			= "rcm_k1879xb1_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.state_count		= 1,
+};
+
+static int __init rcm_cpuidle_probe(struct platform_device *pdev)
+{
+	return cpuidle_register(&rcm_idle_driver, NULL);
+}
+
+static struct platform_driver rcm_cpuidle_driver = {
+	.driver = {
+		.name	= "cpuidle-rcm-k1879xb1",
+	},
+};
+
+static int __init rcm_cpuidle_init(void)
+{
+	return platform_driver_probe(&rcm_cpuidle_driver, rcm_cpuidle_probe);
+}
+device_initcall(rcm_cpuidle_init);
diff --git a/arch/arm/mach-rcm-k1879xb1/include/mach/hardware.h b/arch/arm/mach-rcm-k1879xb1/include/mach/hardware.h
new file mode 100644
index 0000000..66c5b65
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/include/mach/hardware.h
@@ -0,0 +1,75 @@
+/*
+ *  arch/arm/mach-rcm-k1879/include/mach/hardware.h
+ *
+ *  Copyright (C) 2011-2015 RC Module
+ *
+ *  Sergey Mironov <ierton@gmail.com>
+ *  Andrew Andrianov <andrew@ncrmnt.org>
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
+ */
+
+#ifndef ASM_RCM_K1879_HARDWARE_H
+#define ASM_RCM_K1879_HARDWARE_H
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
+/*
+ * Bare minimum required to bring up the board.
+ * The rest comes from DeviceTree
+ */
+
+#define RCM_K1879_UART0_OFF            0x0002b000
+#define RCM_K1879_UART0_PHYS_BASE      RCM_K1879_PHYS(AREA0, RCM_K1879_UART0_OFF)
+#define RCM_K1879_UART0_VIRT_BASE      RCM_K1879_VIRT(AREA0, RCM_K1879_UART0_OFF)
+
+#define RCM_K1879_GRI2C1_OFF           0x00021000
+#define RCM_K1879_GRI2C1_PHYS_BASE     RCM_K1879_PHYS(AREA0, RCM_K1879_GRI2C1_OFF)
+#define RCM_K1879_GRI2C1_VIRT_BASE     RCM_K1879_VIRT(AREA0, RCM_K1879_GRI2C1_OFF)
+
+#define RCM_K1879_GRI2C2_OFF           0x00026000
+#define RCM_K1879_GRI2C2_PHYS_BASE     RCM_K1879_PHYS(AREA0, RCM_K1879_GRI2C2_OFF)
+#define RCM_K1879_GRI2C2_VIRT_BASE     RCM_K1879_VIRT(AREA0, RCM_K1879_GRI2C2_OFF)
+
+#define RCM_K1879_GRI2C3_OFF           0x0002d000
+#define RCM_K1879_GRI2C3_PHYS_BASE     RCM_K1879_PHYS(AREA0, RCM_K1879_GRI2C3_OFF)
+#define RCM_K1879_GRI2C3_VIRT_BASE     RCM_K1879_VIRT(AREA0, RCM_K1879_GRI2C3_OFF)
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
+#define RCM_K1879_GRI2C0_OFF           0x00171000
+#define RCM_K1879_GRI2C0_PHYS_BASE     RCM_K1879_PHYS(AREA1, RCM_K1879_GRI2C0_OFF)
+
+#define RCM_K1879_MIF_I2C_INT_TYPE_ENA  0x94
+#define RCM_K1879_MIF_I2C_INT_TYPE      0x98
+#define RCM_K1879_MIF_I2C_INT_ENA       0x9C
+#define RCM_K1879_MIF_I2C_INT_STAT      0xA0
+#define RCM_K1879_SCTL_INT_P_OUT        0x08
+
+#endif
diff --git a/arch/arm/mach-rcm-k1879xb1/include/mach/uncompress.h b/arch/arm/mach-rcm-k1879xb1/include/mach/uncompress.h
new file mode 100644
index 0000000..5f4e500
--- /dev/null
+++ b/arch/arm/mach-rcm-k1879xb1/include/mach/uncompress.h
@@ -0,0 +1,54 @@
+/*
+ *  arch/arm/mach-rcm-k1879/include/mach/uncompress.h
+ *
+ *  Copyright (C) 2011 RC Module
+ *
+ *  Sergey Mironov <ierton@gmail.com>
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
+ */
+
+#ifndef ASM_ARM_ARCH_IO_H
+#define ASM_ARM_ARCH_IO_H
+
+#include <mach/hardware.h>
+
+#define UART_THR ((volatile unsigned char *)(RCM_K1879_UART0_PHYS_BASE + 0x0))
+#define UART_LSR ((volatile unsigned char *)(RCM_K1879_UART0_PHYS_BASE + 0x14))
+
+#define LSR_THRE	0x20
+
+static void putc(const char c)
+{
+	int i;
+
+	for (i = 0; i < 0x1000; i++) {
+		/* Transmit fifo not full? */
+		if (*UART_LSR & LSR_THRE)
+			break;
+	}
+
+	*UART_THR = c;
+}
+
+static void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
+
+#endif
+
-- 
2.1.4
