From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Jun 2017 10:52:22 -0700
Subject: [PATCH v2 2/7] ARM: Add Broadcom Brahma-B15 readahead cache support
In-Reply-To: <20170623175227.19743-1-f.fainelli@gmail.com>
References: <20170623175227.19743-1-f.fainelli@gmail.com>
Message-ID: <20170623175227.19743-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Broadcom Brahma-B15 CPU readahead cache
controller. This cache controller sits between the L2 and the memory bus
and its purpose is to provide a friendler burst size towards the DDR
interface than the native cache line size.

The readahead cache is mostly transparent, except for
flush_kern_cache_all, which is precisely what we are overriding here.

The readahead cache only intercepts reads, and does invalidate on
writes (IOW), as such, some data can remain stale in any of its buffers, such
that we need to flush it, which is an operation that needs to happen in
a particular order:

- disable the readahead cache
- flush it
- call the appropriate cache-v7.S function
- re-enable

This patch tries to minimize the impact to the cache-v7.S file by only
providing a stub in case CONFIG_CACHE_B15_RAC is enabled (default for
ARCH_BRCMSTB since it is the current user).

Signed-off-by: Alamy Liu <alamyliu@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/glue-cache.h             |   4 +
 arch/arm/include/asm/hardware/cache-b15-rac.h |  10 ++
 arch/arm/mm/Kconfig                           |   8 ++
 arch/arm/mm/Makefile                          |   1 +
 arch/arm/mm/cache-b15-rac.c                   | 177 ++++++++++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 arch/arm/include/asm/hardware/cache-b15-rac.h
 create mode 100644 arch/arm/mm/cache-b15-rac.c

diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index 01c3d92624e5..8d1f498e5dd8 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -117,6 +117,10 @@
 # endif
 #endif
 
+#if defined(CONFIG_CACHE_B15_RAC)
+# define MULTI_CACHE 1
+#endif
+
 #if defined(CONFIG_CPU_V7M)
 #  define MULTI_CACHE 1
 #endif
diff --git a/arch/arm/include/asm/hardware/cache-b15-rac.h b/arch/arm/include/asm/hardware/cache-b15-rac.h
new file mode 100644
index 000000000000..3d43ec06fd35
--- /dev/null
+++ b/arch/arm/include/asm/hardware/cache-b15-rac.h
@@ -0,0 +1,10 @@
+#ifndef __ASM_ARM_HARDWARE_CACHE_B15_RAC_H
+#define __ASM_ARM_HARDWARE_CACHE_B15_RAC_H
+
+#ifndef __ASSEMBLY__
+
+void b15_flush_kern_cache_all(void);
+
+#endif
+
+#endif
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c6c4c9c8824b..cf7db07c98f4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -904,6 +904,14 @@ config OUTER_CACHE_SYNC
 	  The outer cache has a outer_cache_fns.sync function pointer
 	  that can be used to drain the write buffer of the outer cache.
 
+config CACHE_B15_RAC
+	bool "Enable the Broadcom Brahma-B15 read-ahead cache controller"
+	depends on ARCH_BRCMSTB
+	default y
+	help
+	  This option enables the Broadcom Brahma-B15 read-ahead cache
+	  controller. If disabled, the read-ahead cache remains off.
+
 config CACHE_FEROCEON_L2
 	bool "Enable the Feroceon L2 cache controller"
 	depends on ARCH_MV78XX0 || ARCH_MVEBU
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index b3dea80715b4..0d7937e884f8 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -102,6 +102,7 @@ AFLAGS_proc-v6.o	:=-Wa,-march=armv6
 AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
 
 obj-$(CONFIG_OUTER_CACHE)	+= l2c-common.o
+obj-$(CONFIG_CACHE_B15_RAC)	+= cache-b15-rac.o
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o l2c-l2x0-resume.o
 obj-$(CONFIG_CACHE_L2X0_PMU)	+= cache-l2x0-pmu.o
diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
new file mode 100644
index 000000000000..679d44f003fd
--- /dev/null
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -0,0 +1,177 @@
+/*
+ * Broadcom Brahma-B15 CPU read-ahead cache management functions
+ *
+ * Copyright (C) 2015-2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/of_address.h>
+
+#include <asm/cacheflush.h>
+#include <asm/hardware/cache-b15-rac.h>
+
+extern void v7_flush_kern_cache_all(void);
+
+/* RAC register offsets, relative to the HIF_CPU_BIUCTRL register base */
+#define RAC_CONFIG0_REG			(0x78)
+#define  RACENPREF_MASK			(0x3)
+#define  RACPREFINST_SHIFT		(0)
+#define  RACENINST_SHIFT		(2)
+#define  RACPREFDATA_SHIFT		(4)
+#define  RACENDATA_SHIFT		(6)
+#define  RAC_CPU_SHIFT			(8)
+#define  RACCFG_MASK			(0xff)
+#define RAC_CONFIG1_REG			(0x7c)
+#define RAC_FLUSH_REG			(0x80)
+#define  FLUSH_RAC			(1 << 0)
+
+/* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
+#define RAC_DATA_INST_EN_MASK		(1 << RACPREFINST_SHIFT | \
+					 RACENPREF_MASK << RACENINST_SHIFT | \
+					 1 << RACPREFDATA_SHIFT | \
+					 RACENPREF_MASK << RACENDATA_SHIFT)
+
+#define RAC_ENABLED			0
+
+static void __iomem *b15_rac_base;
+static DEFINE_SPINLOCK(rac_lock);
+
+/* Initialization flag to avoid checking for b15_rac_base, and to prevent
+ * multi-platform kernels from crashing here as well.
+ */
+static unsigned long b15_rac_flags;
+
+static inline u32 __b15_rac_disable(void)
+{
+	u32 val = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
+	__raw_writel(0, b15_rac_base + RAC_CONFIG0_REG);
+	dmb();
+	return val;
+}
+
+static inline void __b15_rac_flush(void)
+{
+	u32 reg;
+
+	__raw_writel(FLUSH_RAC, b15_rac_base + RAC_FLUSH_REG);
+	do {
+		/* This dmb() is required to force the Bus Interface Unit
+		 * to clean oustanding writes, and forces an idle cycle
+		 * to be inserted.
+		 */
+		dmb();
+		reg = __raw_readl(b15_rac_base + RAC_FLUSH_REG);
+	} while (reg & FLUSH_RAC);
+}
+
+static inline u32 b15_rac_disable_and_flush(void)
+{
+	u32 reg;
+
+	reg = __b15_rac_disable();
+	__b15_rac_flush();
+	return reg;
+}
+
+static inline void __b15_rac_enable(u32 val)
+{
+	__raw_writel(val, b15_rac_base + RAC_CONFIG0_REG);
+	/* dsb() is required here to be consistent with __flush_icache_all() */
+	dsb();
+}
+
+#define BUILD_RAC_CACHE_OP(name, bar)				\
+void b15_flush_##name(void)					\
+{								\
+	unsigned int do_flush;					\
+	u32 val = 0;						\
+								\
+	spin_lock(&rac_lock);					\
+	do_flush = test_bit(RAC_ENABLED, &b15_rac_flags);	\
+	if (do_flush)						\
+		val = b15_rac_disable_and_flush();		\
+	v7_flush_##name();					\
+	if (!do_flush)						\
+		bar;						\
+	else							\
+		__b15_rac_enable(val);				\
+	spin_unlock(&rac_lock);					\
+}
+
+#define nobarrier
+
+/* The readahead cache present in the Brahma-B15 CPU is a special piece of
+ * hardware after the integrated L2 cache of the B15 CPU complex whose purpose
+ * is to prefetch instruction and/or data with a line size of either 64 bytes
+ * or 256 bytes. The rationale is that the data-bus of the CPU interface is
+ * optimized for 256-bytes transactions, and enabling the readahead cache
+ * provides a significant performance boost we want it enabled (typically
+ * twice the performance for a memcpy benchmark application).
+ *
+ * The readahead cache is transparent for Modified Virtual Addresses
+ * cache maintenance operations: ICIMVAU, DCIMVAC, DCCMVAC, DCCMVAU and
+ * DCCIMVAC.
+ *
+ * It is however not transparent for the following cache maintenance
+ * operations: DCISW, DCCSW, DCCISW, ICIALLUIS and ICIALLU which is precisely
+ * what we are patching here with our BUILD_RAC_CACHE_OP here.
+ */
+BUILD_RAC_CACHE_OP(kern_cache_all, nobarrier);
+
+static void b15_rac_enable(void)
+{
+	unsigned int cpu;
+	u32 enable = 0;
+
+	for_each_possible_cpu(cpu)
+		enable |= (RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT));
+
+	b15_rac_disable_and_flush();
+	__b15_rac_enable(enable);
+}
+
+static int __init b15_rac_init(void)
+{
+	struct device_node *dn;
+	int ret = 0, cpu;
+	u32 reg, en_mask = 0;
+
+	dn = of_find_compatible_node(NULL, NULL, "brcm,brcmstb-cpu-biu-ctrl");
+	if (!dn)
+		return -ENODEV;
+
+	if (WARN(num_possible_cpus() > 4, "RAC only supports 4 CPUs\n"))
+		goto out;
+
+	b15_rac_base = of_iomap(dn, 0);
+	if (!b15_rac_base) {
+		pr_err("failed to remap BIU control base\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	spin_lock(&rac_lock);
+	reg = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
+	for_each_possible_cpu(cpu)
+		en_mask |= ((1 << RACPREFDATA_SHIFT) << (cpu * RAC_CPU_SHIFT));
+	WARN(reg & en_mask, "Read-ahead cache not previously disabled\n");
+
+	b15_rac_enable();
+	set_bit(RAC_ENABLED, &b15_rac_flags);
+	spin_unlock(&rac_lock);
+
+	pr_info("Broadcom Brahma-B15 readahead cache at: 0x%p\n",
+		b15_rac_base + RAC_CONFIG0_REG);
+
+out:
+	of_node_put(dn);
+	return ret;
+}
+arch_initcall(b15_rac_init);
-- 
2.9.3
