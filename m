From: saeed@marvell.com (Saeed Bishara)
Date: Tue, 24 Nov 2009 19:33:52 +0200
Subject: [PATCH 2/3] Add Tauros2 L2 cache controller support
In-Reply-To: <1259084033-7283-2-git-send-email-saeed@marvell.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
Message-ID: <1259084033-7283-3-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lennert Buytenhek <buytenh@marvell.com>

Support for the Tauros2 L2 cache controller as used with the PJ1
and PJ4 CPUs.

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/configs/dove_defconfig               |    4 +-
 arch/arm/include/asm/hardware/cache-tauros2.h |   11 +
 arch/arm/mach-dove/common.c                   |    4 +
 arch/arm/mm/Kconfig                           |    9 +
 arch/arm/mm/Makefile                          |    2 +-
 arch/arm/mm/cache-tauros2.c                   |  263 +++++++++++++++++++++++++
 6 files changed, 291 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/cache-tauros2.h
 create mode 100644 arch/arm/mm/cache-tauros2.c

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index f2d1ea0..837bb52 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32-rc6
-# Tue Nov 24 13:48:39 2009
+# Tue Nov 24 13:51:23 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -207,6 +207,8 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
+CONFIG_OUTER_CACHE=y
+CONFIG_CACHE_TAUROS2=y
 CONFIG_ARM_L1_CACHE_SHIFT=5
 # CONFIG_ARM_ERRATA_411920 is not set
 
diff --git a/arch/arm/include/asm/hardware/cache-tauros2.h b/arch/arm/include/asm/hardware/cache-tauros2.h
new file mode 100644
index 0000000..dacfde9
--- /dev/null
+++ b/arch/arm/include/asm/hardware/cache-tauros2.h
@@ -0,0 +1,11 @@
+/*
+ * arch/arm/plat-orion/include/plat/cache-tauros2.h
+ *
+ * Copyright (C) 2008 Marvell Semiconductor
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+extern void __init tauros2_init(void);
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index a9248ce..bf66b13 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -20,6 +20,7 @@
 #include <linux/mv643xx_i2c.h>
 #include <linux/ata_platform.h>
 #include <linux/spi/orion_spi.h>
+#include <asm/hardware/cache-tauros2.h>
 #include <asm/page.h>
 #include <asm/setup.h>
 #include <asm/timex.h>
@@ -760,6 +761,9 @@ void __init dove_init(void)
 	printk(KERN_INFO "Dove 88AP510 SoC, ");
 	printk(KERN_INFO "TCLK = %dMHz\n", (tclk + 499999) / 1000000);
 
+#ifdef CONFIG_CACHE_TAUROS2
+	tauros2_init();
+#endif
 	dove_setup_cpu_mbus();
 
 	dove_ge00_shared_data.t_clk = tclk;
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 1549863..4958ef2 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -764,6 +764,15 @@ config CACHE_L2X0
 	help
 	  This option enables the L2x0 PrimeCell.
 
+config CACHE_TAUROS2
+	bool "Enable the Tauros2 L2 cache controller"
+	depends on ARCH_DOVE
+	default y
+	select OUTER_CACHE
+	help
+	  This option enables the Tauros2 L2 cache controller (as
+	  found on PJ1/PJ4).
+
 config CACHE_XSC3L2
 	bool "Enable the L2 cache on XScale3"
 	depends on CPU_XSC3
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 055cb2a..06bcf2e 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -87,4 +87,4 @@ obj-$(CONFIG_CPU_V7)		+= proc-v7.o
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
-
+obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
new file mode 100644
index 0000000..5086865
--- /dev/null
+++ b/arch/arm/mm/cache-tauros2.c
@@ -0,0 +1,263 @@
+/*
+ * arch/arm/mm/cache-tauros2.c - Tauros2 L2 cache controller support
+ *
+ * Copyright (C) 2008 Marvell Semiconductor
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * References:
+ * - PJ1 CPU Core Datasheet,
+ *   Document ID MV-S104837-01, Rev 0.7, January 24 2008.
+ * - PJ4 CPU Core Datasheet,
+ *   Document ID MV-S105190-00, Rev 0.7, March 14 2008.
+ */
+
+#include <linux/init.h>
+#include <asm/cacheflush.h>
+#include <asm/hardware/cache-tauros2.h>
+
+
+/*
+ * When Tauros2 is used on a CPU that supports the v7 hierarchical
+ * cache operations, the cache handling code in proc-v7.S takes care
+ * of everything, including handling DMA coherency.
+ *
+ * So, we only need to register outer cache operations here if we're
+ * being used on a pre-v7 CPU, and we only need to build support for
+ * outer cache operations into the kernel image if the kernel has been
+ * configured to support a pre-v7 CPU.
+ */
+#if __LINUX_ARM_ARCH__ < 7
+/*
+ * Low-level cache maintenance operations.
+ */
+static inline void tauros2_clean_pa(unsigned long addr)
+{
+	__asm__("mcr p15, 1, %0, c7, c11, 3" : : "r" (addr));
+}
+
+static inline void tauros2_clean_inv_pa(unsigned long addr)
+{
+	__asm__("mcr p15, 1, %0, c7, c15, 3" : : "r" (addr));
+}
+
+static inline void tauros2_inv_pa(unsigned long addr)
+{
+	__asm__("mcr p15, 1, %0, c7, c7, 3" : : "r" (addr));
+}
+
+
+/*
+ * Linux primitives.
+ *
+ * Note that the end addresses passed to Linux primitives are
+ * noninclusive.
+ */
+#define CACHE_LINE_SIZE		32
+
+static void tauros2_inv_range(unsigned long start, unsigned long end)
+{
+	/*
+	 * Clean and invalidate partial first cache line.
+	 */
+	if (start & (CACHE_LINE_SIZE - 1)) {
+		tauros2_clean_inv_pa(start & ~(CACHE_LINE_SIZE - 1));
+		start = (start | (CACHE_LINE_SIZE - 1)) + 1;
+	}
+
+	/*
+	 * Clean and invalidate partial last cache line.
+	 */
+	if (end & (CACHE_LINE_SIZE - 1)) {
+		tauros2_clean_inv_pa(end & ~(CACHE_LINE_SIZE - 1));
+		end &= ~(CACHE_LINE_SIZE - 1);
+	}
+
+	/*
+	 * Invalidate all full cache lines between 'start' and 'end'.
+	 */
+	while (start < end) {
+		tauros2_inv_pa(start);
+		start += CACHE_LINE_SIZE;
+	}
+
+	dsb();
+}
+
+static void tauros2_clean_range(unsigned long start, unsigned long end)
+{
+	start &= ~(CACHE_LINE_SIZE - 1);
+	while (start < end) {
+		tauros2_clean_pa(start);
+		start += CACHE_LINE_SIZE;
+	}
+
+	dsb();
+}
+
+static void tauros2_flush_range(unsigned long start, unsigned long end)
+{
+	start &= ~(CACHE_LINE_SIZE - 1);
+	while (start < end) {
+		tauros2_clean_inv_pa(start);
+		start += CACHE_LINE_SIZE;
+	}
+
+	dsb();
+}
+#endif
+
+static inline u32 __init read_extra_features(void)
+{
+	u32 u;
+
+	__asm__("mrc p15, 1, %0, c15, c1, 0" : "=r" (u));
+
+	return u;
+}
+
+static inline void __init write_extra_features(u32 u)
+{
+	__asm__("mcr p15, 1, %0, c15, c1, 0" : : "r" (u));
+}
+
+static void __init disable_l2_prefetch(void)
+{
+	u32 u;
+
+	/*
+	 * Read the CPU Extra Features register and verify that the
+	 * Disable L2 Prefetch bit is set.
+	 */
+	u = read_extra_features();
+	if (!(u & 0x01000000)) {
+		printk(KERN_INFO "Tauros2: Disabling L2 prefetch.\n");
+		write_extra_features(u | 0x01000000);
+	}
+}
+
+static inline int __init cpuid_scheme(void)
+{
+	extern int processor_id;
+
+	return !!((processor_id & 0x000f0000) == 0x000f0000);
+}
+
+static inline u32 __init read_mmfr3(void)
+{
+	u32 mmfr3;
+
+	__asm__("mrc p15, 0, %0, c0, c1, 7\n" : "=r" (mmfr3));
+
+	return mmfr3;
+}
+
+static inline u32 __init read_actlr(void)
+{
+	u32 actlr;
+
+	__asm__("mrc p15, 0, %0, c1, c0, 1\n" : "=r" (actlr));
+
+	return actlr;
+}
+
+static inline void __init write_actlr(u32 actlr)
+{
+	__asm__("mcr p15, 0, %0, c1, c0, 1\n" : : "r" (actlr));
+}
+
+void __init tauros2_init(void)
+{
+	extern int processor_id;
+	char *mode;
+
+	disable_l2_prefetch();
+
+#ifdef CONFIG_CPU_32v5
+	if ((processor_id & 0xff0f0000) == 0x56050000) {
+		u32 feat;
+
+		/*
+		 * v5 CPUs with Tauros2 have the L2 cache enable bit
+		 * located in the CPU Extra Features register.
+		 */
+		feat = read_extra_features();
+		if (!(feat & 0x00400000)) {
+			printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
+			write_extra_features(feat | 0x00400000);
+		}
+
+		mode = "ARMv5";
+		outer_cache.inv_range = tauros2_inv_range;
+		outer_cache.clean_range = tauros2_clean_range;
+		outer_cache.flush_range = tauros2_flush_range;
+	}
+#endif
+
+#ifdef CONFIG_CPU_32v6
+	/*
+	 * Check whether this CPU lacks support for the v7 hierarchical
+	 * cache ops.  (PJ4 is in its v6 personality mode if the MMFR3
+	 * register indicates no support for the v7 hierarchical cache
+	 * ops.)
+	 */
+	if (cpuid_scheme() && (read_mmfr3() & 0xf) == 0) {
+		/*
+		 * When Tauros2 is used in an ARMv6 system, the L2
+		 * enable bit is in the ARMv6 ARM-mandated position
+		 * (bit [26] of the System Control Register).
+		 */
+		if (!(get_cr() & 0x04000000)) {
+			printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
+			adjust_cr(0x04000000, 0x04000000);
+		}
+
+		mode = "ARMv6";
+		outer_cache.inv_range = tauros2_inv_range;
+		outer_cache.clean_range = tauros2_clean_range;
+		outer_cache.flush_range = tauros2_flush_range;
+	}
+#endif
+
+#ifdef CONFIG_CPU_32v7
+	/*
+	 * Check whether this CPU has support for the v7 hierarchical
+	 * cache ops.  (PJ4 is in its v7 personality mode if the MMFR3
+	 * register indicates support for the v7 hierarchical cache
+	 * ops.)
+	 *
+	 * (Although strictly speaking there may exist CPUs that
+	 * implement the v7 cache ops but are only ARMv6 CPUs (due to
+	 * not complying with all of the other ARMv7 requirements),
+	 * there are no real-life examples of Tauros2 being used on
+	 * such CPUs as of yet.)
+	 */
+	if (cpuid_scheme() && (read_mmfr3() & 0xf) == 1) {
+		u32 actlr;
+
+		/*
+		 * When Tauros2 is used in an ARMv7 system, the L2
+		 * enable bit is located in the Auxiliary System Control
+		 * Register (which is the only register allowed by the
+		 * ARMv7 spec to contain fine-grained cache control bits).
+		 */
+		actlr = read_actlr();
+		if (!(actlr & 0x00000002)) {
+			printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
+			write_actlr(actlr | 0x00000002);
+		}
+
+		mode = "ARMv7";
+	}
+#endif
+
+	if (mode == NULL) {
+		printk(KERN_CRIT "Tauros2: Unable to detect CPU mode.\n");
+		return;
+	}
+
+	printk(KERN_INFO "Tauros2: L2 cache support initialised "
+			 "in %s mode.\n", mode);
+}
-- 
1.6.0.4
