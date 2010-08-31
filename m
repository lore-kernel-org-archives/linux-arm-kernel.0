From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 31 Aug 2010 13:16:42 +0200
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
Message-ID: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

factorise some generic infrastructure to assist looking up struct clks
for the ARM & SH architecture.

as the code is identical at 99%

put the arch specific code for allocation as example in asm/lookup_clkdev.h

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/Kconfig                                   |   40 +++---
 arch/arm/common/Kconfig                            |    4 -
 arch/arm/common/Makefile                           |    1 -
 arch/arm/include/asm/lookup_clkdev.h               |   23 +++
 arch/arm/mach-shmobile/Kconfig                     |    6 +-
 arch/arm/plat-omap/Kconfig                         |    4 +-
 arch/sh/Kconfig                                    |    2 +-
 arch/sh/include/asm/lookup_clkdev.h                |   29 ++++
 arch/sh/kernel/Makefile                            |    2 +-
 arch/sh/kernel/clkdev.c                            |  169 --------------------
 arch/sh/kernel/cpu/clock.c                         |   16 --
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/clk/Kconfig                                |    4 +
 drivers/clk/Makefile                               |    2 +
 .../common/clkdev.c => drivers/clk/lookup_clkdev.c |   18 ++-
 16 files changed, 100 insertions(+), 224 deletions(-)
 create mode 100644 arch/arm/include/asm/lookup_clkdev.h
 create mode 100644 arch/sh/include/asm/lookup_clkdev.h
 delete mode 100644 arch/sh/kernel/clkdev.c
 create mode 100644 drivers/clk/Kconfig
 create mode 100644 drivers/clk/Makefile
 rename arch/arm/common/clkdev.c => drivers/clk/lookup_clkdev.c (89%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7ed21f..e7ef725 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -221,7 +221,7 @@ config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	select ARM_AMBA
 	select ARCH_HAS_CPUFREQ
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
@@ -231,7 +231,7 @@ config ARCH_INTEGRATOR
 config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARM_AMBA
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -245,7 +245,7 @@ config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
 	select ARM_AMBA
 	select ARM_VIC
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -259,7 +259,7 @@ config ARCH_VEXPRESS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_TIMER_SP804
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	select ICST
@@ -281,7 +281,7 @@ config ARCH_BCMRING
 	depends on MMU
 	select CPU_V6
 	select ARM_AMBA
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
@@ -328,7 +328,7 @@ config ARCH_EP93XX
 	select CPU_ARM920T
 	select ARM_AMBA
 	select ARM_VIC
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_USES_GETTIMEOFFSET
@@ -348,14 +348,14 @@ config ARCH_MXC
 	bool "Freescale MXC/iMX-based"
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
 config ARCH_STMP3XXX
 	bool "Freescale STMP3xxx"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select USB_ARCH_HAS_EHCI
@@ -473,7 +473,7 @@ config ARCH_LPC32XX
 	select HAVE_IDE
 	select ARM_AMBA
 	select USB_ARCH_HAS_OHCI
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
@@ -507,7 +507,7 @@ config ARCH_MMP
 	bool "Marvell PXA168/910/MMP2"
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
@@ -539,7 +539,7 @@ config ARCH_W90X900
 	bool "Nuvoton W90X900 CPU"
 	select CPU_ARM926T
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
@@ -553,7 +553,7 @@ config ARCH_W90X900
 config ARCH_NUC93X
 	bool "Nuvoton NUC93X CPU"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	help
 	  Support for Nuvoton (Winbond logic dept.) NUC93X MCU,The NUC93X is a
 	  low-power and high performance MPEG-4/JPEG multimedia controller chip.
@@ -564,7 +564,7 @@ config ARCH_TEGRA
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ARCH_HAS_BARRIERS if CACHE_L2X0
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
@@ -573,7 +573,7 @@ config ARCH_TEGRA
 config ARCH_PNX4008
 	bool "Philips Nexperia PNX4008 Mobile"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ARCH_USES_GETTIMEOFFSET
 	help
 	  This enables support for Philips PNX4008 mobile platform.
@@ -583,7 +583,7 @@ config ARCH_PXA
 	depends on MMU
 	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
@@ -767,7 +767,7 @@ config ARCH_U300
 	select ARM_AMBA
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_GPIO
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
@@ -777,7 +777,7 @@ config ARCH_U8500
 	select CPU_V7
 	select ARM_AMBA
 	select GENERIC_CLOCKEVENTS
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for ST-Ericsson's Ux500 architecture
@@ -787,7 +787,7 @@ config ARCH_NOMADIK
 	select ARM_AMBA
 	select ARM_VIC
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	help
@@ -799,7 +799,7 @@ config ARCH_DAVINCI
 	select ARCH_REQUIRE_GPIOLIB
 	select ZONE_DMA
 	select HAVE_IDE
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_ALLOCATOR
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
@@ -819,7 +819,7 @@ config PLAT_SPEAR
 	bool "ST SPEAr"
 	select ARM_AMBA
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	help
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 0a34c81..778655f 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -37,7 +37,3 @@ config SHARP_PARAM
 
 config SHARP_SCOOP
 	bool
-
-config COMMON_CLKDEV
-	bool
-	select HAVE_CLK
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e6e8664..799e140 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -16,4 +16,3 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
diff --git a/arch/arm/include/asm/lookup_clkdev.h b/arch/arm/include/asm/lookup_clkdev.h
new file mode 100644
index 0000000..d57f7a6
--- /dev/null
+++ b/arch/arm/include/asm/lookup_clkdev.h
@@ -0,0 +1,23 @@
+/*
+ *  arch/arm/common/clkdev.c
+ *
+ *  Copyright (C) 2008 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+
+#ifndef __LOOKUP_CLK_DEV__
+#define __LOOKUP_CLK_DEV__
+
+#include <mach/clkdev.h>
+
+static __inline__ struct clk_lookup_alloc *arch_kzalloc(size_t size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+#endif /* __LOOKUP_CLK_DEV__ */
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 54b479c..e4e964b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -6,7 +6,7 @@ config ARCH_SH7367
 	bool "SH-Mobile G3 (SH7367)"
 	select CPU_V6
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
 
@@ -14,7 +14,7 @@ config ARCH_SH7377
 	bool "SH-Mobile G4 (SH7377)"
 	select CPU_V7
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
 
@@ -22,7 +22,7 @@ config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
 	select CPU_V7
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e39a417..daba55a 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -11,13 +11,13 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4"
-	select COMMON_CLKDEV
+	select LOOKUP_CLKDEV
 	help
 	  "Systems based on omap24xx, omap34xx or omap44xx"
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 33990fa..6b7d206 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -8,7 +8,7 @@ mainmenu "Linux/SuperH Kernel Configuration"
 config SUPERH
 	def_bool y
 	select EMBEDDED
-	select HAVE_CLK
+	select LOOKUP_CLKDEV
 	select HAVE_IDE if HAS_IOPORT
 	select HAVE_MEMBLOCK
 	select HAVE_OPROFILE
diff --git a/arch/sh/include/asm/lookup_clkdev.h b/arch/sh/include/asm/lookup_clkdev.h
new file mode 100644
index 0000000..9ac7b10
--- /dev/null
+++ b/arch/sh/include/asm/lookup_clkdev.h
@@ -0,0 +1,29 @@
+/*
+ *  Copyright (C) 2010 Paul Mundt <lethal@linux-sh.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+
+#ifndef __LOOKUP_CLK_DEV__
+#define __LOOKUP_CLK_DEV__
+
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <asm/clock.h>
+
+static __inline__ struct clk_lookup_alloc *arch_kzalloc(size_t size)
+{
+	if (!slab_is_available())
+		return alloc_bootmem_low_pages(size);
+	else
+		return kzalloc(size, GFP_KERNEL);
+}
+
+#define __clk_put(clk)
+#define __clk_get(clk) ({ 1; })
+
+#endif /* __LOOKUP_CLK_DEV__ */
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index e25f3c6..e4fe614 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -11,7 +11,7 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
-obj-y	:= clkdev.o debugtraps.o dma-nommu.o dumpstack.o 		\
+obj-y	:= debugtraps.o dma-nommu.o dumpstack.o 			\
 	   idle.o io.o irq.o						\
 	   irq_$(BITS).o machvec.o nmi_debug.o process.o		\
 	   process_$(BITS).o ptrace_$(BITS).o				\
diff --git a/arch/sh/kernel/clkdev.c b/arch/sh/kernel/clkdev.c
deleted file mode 100644
index befc255..0000000
--- a/arch/sh/kernel/clkdev.c
+++ /dev/null
@@ -1,169 +0,0 @@
-/*
- * arch/sh/kernel/clkdev.c
- *
- * Cloned from arch/arm/common/clkdev.c:
- *
- *  Copyright (C) 2008 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Helper for the clk API to assist looking up a struct clk.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/string.h>
-#include <linux/mutex.h>
-#include <linux/clk.h>
-#include <linux/slab.h>
-#include <linux/bootmem.h>
-#include <linux/mm.h>
-#include <asm/clock.h>
-#include <asm/clkdev.h>
-
-static LIST_HEAD(clocks);
-static DEFINE_MUTEX(clocks_mutex);
-
-/*
- * Find the correct struct clk for the device and connection ID.
- * We do slightly fuzzy matching here:
- *  An entry with a NULL ID is assumed to be a wildcard.
- *  If an entry has a device ID, it must match
- *  If an entry has a connection ID, it must match
- * Then we take the most specific entry - with the following
- * order of precedence: dev+con > dev only > con only.
- */
-static struct clk *clk_find(const char *dev_id, const char *con_id)
-{
-	struct clk_lookup *p;
-	struct clk *clk = NULL;
-	int match, best = 0;
-
-	list_for_each_entry(p, &clocks, node) {
-		match = 0;
-		if (p->dev_id) {
-			if (!dev_id || strcmp(p->dev_id, dev_id))
-				continue;
-			match += 2;
-		}
-		if (p->con_id) {
-			if (!con_id || strcmp(p->con_id, con_id))
-				continue;
-			match += 1;
-		}
-		if (match == 0)
-			continue;
-
-		if (match > best) {
-			clk = p->clk;
-			best = match;
-		}
-	}
-	return clk;
-}
-
-struct clk *clk_get_sys(const char *dev_id, const char *con_id)
-{
-	struct clk *clk;
-
-	mutex_lock(&clocks_mutex);
-	clk = clk_find(dev_id, con_id);
-	mutex_unlock(&clocks_mutex);
-
-	return clk ? clk : ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get_sys);
-
-void clkdev_add(struct clk_lookup *cl)
-{
-	mutex_lock(&clocks_mutex);
-	list_add_tail(&cl->node, &clocks);
-	mutex_unlock(&clocks_mutex);
-}
-EXPORT_SYMBOL(clkdev_add);
-
-void __init clkdev_add_table(struct clk_lookup *cl, size_t num)
-{
-	mutex_lock(&clocks_mutex);
-	while (num--) {
-		list_add_tail(&cl->node, &clocks);
-		cl++;
-	}
-	mutex_unlock(&clocks_mutex);
-}
-
-#define MAX_DEV_ID	20
-#define MAX_CON_ID	16
-
-struct clk_lookup_alloc {
-	struct clk_lookup cl;
-	char	dev_id[MAX_DEV_ID];
-	char	con_id[MAX_CON_ID];
-};
-
-struct clk_lookup * __init_refok
-clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
-{
-	struct clk_lookup_alloc *cla;
-
-	if (!slab_is_available())
-		cla = alloc_bootmem_low_pages(sizeof(*cla));
-	else
-		cla = kzalloc(sizeof(*cla), GFP_KERNEL);
-
-	if (!cla)
-		return NULL;
-
-	cla->cl.clk = clk;
-	if (con_id) {
-		strlcpy(cla->con_id, con_id, sizeof(cla->con_id));
-		cla->cl.con_id = cla->con_id;
-	}
-
-	if (dev_fmt) {
-		va_list ap;
-
-		va_start(ap, dev_fmt);
-		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
-		cla->cl.dev_id = cla->dev_id;
-		va_end(ap);
-	}
-
-	return &cla->cl;
-}
-EXPORT_SYMBOL(clkdev_alloc);
-
-int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
-	struct device *dev)
-{
-	struct clk *r = clk_get(dev, id);
-	struct clk_lookup *l;
-
-	if (IS_ERR(r))
-		return PTR_ERR(r);
-
-	l = clkdev_alloc(r, alias, alias_dev_name);
-	clk_put(r);
-	if (!l)
-		return -ENODEV;
-	clkdev_add(l);
-	return 0;
-}
-EXPORT_SYMBOL(clk_add_alias);
-
-/*
- * clkdev_drop - remove a clock dynamically allocated
- */
-void clkdev_drop(struct clk_lookup *cl)
-{
-	mutex_lock(&clocks_mutex);
-	list_del(&cl->node);
-	mutex_unlock(&clocks_mutex);
-	kfree(cl);
-}
-EXPORT_SYMBOL(clkdev_drop);
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 50f887d..4187cf4 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -48,20 +48,4 @@ int __init clk_init(void)
 	return ret;
 }
 
-/*
- * Returns a clock. Note that we first try to use device id on the bus
- * and clock name. If this fails, we try to use clock name only.
- */
-struct clk *clk_get(struct device *dev, const char *con_id)
-{
-	const char *dev_id = dev ? dev_name(dev) : NULL;
-
-	return clk_get_sys(dev_id, con_id);
-}
-EXPORT_SYMBOL_GPL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL_GPL(clk_put);
 
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a2b902f..3d93b3a 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -111,4 +111,6 @@ source "drivers/xen/Kconfig"
 source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
+
+source "drivers/clk/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index ae47344..b0e30b2 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -115,3 +115,5 @@ obj-$(CONFIG_VLYNQ)		+= vlynq/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
 obj-y				+= ieee802154/
+#common clk code
+obj-y				+= clk/
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
new file mode 100644
index 0000000..cc5272c
--- /dev/null
+++ b/drivers/clk/Kconfig
@@ -0,0 +1,4 @@
+
+config LOOKUP_CLKDEV
+	bool
+	select HAVE_CLK
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
new file mode 100644
index 0000000..288d997
--- /dev/null
+++ b/drivers/clk/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_LOOKUP_CLKDEV)	+= lookup_clkdev.o
diff --git a/arch/arm/common/clkdev.c b/drivers/clk/lookup_clkdev.c
similarity index 89%
rename from arch/arm/common/clkdev.c
rename to drivers/clk/lookup_clkdev.c
index e2b2bb6..0a19626 100644
--- a/arch/arm/common/clkdev.c
+++ b/drivers/clk/lookup_clkdev.c
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/common/clkdev.c
+ * drivers/clk/lookup_clkdev.c
  *
  *  Copyright (C) 2008 Russell King.
  *
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 
 #include <asm/clkdev.h>
-#include <mach/clkdev.h>
+#include <asm/lookup_clkdev.h>
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
@@ -79,19 +79,23 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get_sys);
 
+/*
+ * Returns a clock. Note that we first try to use device id on the bus
+ * and clock name. If this fails, we try to use clock name only.
+ */
 struct clk *clk_get(struct device *dev, const char *con_id)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 
 	return clk_get_sys(dev_id, con_id);
 }
-EXPORT_SYMBOL(clk_get);
+EXPORT_SYMBOL_GPL(clk_get);
 
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
 }
-EXPORT_SYMBOL(clk_put);
+EXPORT_SYMBOL_GPL(clk_put);
 
 void clkdev_add(struct clk_lookup *cl)
 {
@@ -120,12 +124,12 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
-	const char *dev_fmt, ...)
+struct clk_lookup * __init_refok
+clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
 {
 	struct clk_lookup_alloc *cla;
 
-	cla = kzalloc(sizeof(*cla), GFP_KERNEL);
+	cla = arch_kzalloc(sizeof(*cla));
 	if (!cla)
 		return NULL;
 
-- 
1.7.1
