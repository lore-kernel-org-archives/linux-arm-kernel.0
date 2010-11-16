From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 16 Nov 2010 16:04:08 +0100
Subject: [PATCH v4] arm & sh: factorised duplicated clkdev.c
Message-ID: <1289919848-23262-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

factorise some generic infrastructure to assist looking up struct clks
for the ARM & SH architecture.

as the code is identical at 99%

put the arch specific code for allocation as example in asm/clkdev.h

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
---
Hi,

	rebase against v2.6.37-rc1

Best Regards,
J.
 arch/arm/Kconfig                              |   42 +++---
 arch/arm/common/Kconfig                       |    4 -
 arch/arm/common/Makefile                      |    1 -
 arch/arm/common/clkdev.c                      |  179 -------------------------
 arch/arm/include/asm/clkdev.h                 |   22 +---
 arch/arm/mach-bcmring/clock.c                 |    3 +-
 arch/arm/mach-bcmring/core.c                  |    2 +-
 arch/arm/mach-davinci/clock.h                 |    2 +-
 arch/arm/mach-ep93xx/clock.c                  |    2 +-
 arch/arm/mach-imx/clock-imx1.c                |    3 +-
 arch/arm/mach-imx/clock-imx21.c               |    2 +-
 arch/arm/mach-imx/clock-imx27.c               |    2 +-
 arch/arm/mach-integrator/core.c               |    3 +-
 arch/arm/mach-integrator/impd1.c              |    3 +-
 arch/arm/mach-integrator/integrator_cp.c      |    3 +-
 arch/arm/mach-lpc32xx/clock.c                 |    3 +-
 arch/arm/mach-mmp/clock.h                     |    2 +-
 arch/arm/mach-mx25/clock.c                    |    3 +-
 arch/arm/mach-mx3/clock-imx31.c               |    2 +-
 arch/arm/mach-mx3/clock-imx35.c               |    3 +-
 arch/arm/mach-mx5/clock-mx51.c                |    2 +-
 arch/arm/mach-mxc91231/clock.c                |    2 +-
 arch/arm/mach-nomadik/clock.c                 |    2 +-
 arch/arm/mach-nuc93x/clock.h                  |    2 +-
 arch/arm/mach-omap1/clock.c                   |    2 +-
 arch/arm/mach-omap2/dpll3xxx.c                |    2 +-
 arch/arm/mach-pnx4008/clock.c                 |    3 +-
 arch/arm/mach-pxa/clock.c                     |    2 +-
 arch/arm/mach-pxa/clock.h                     |    2 +-
 arch/arm/mach-realview/core.c                 |    3 +-
 arch/arm/mach-shmobile/Kconfig                |    6 +-
 arch/arm/mach-shmobile/clock-sh7367.c         |    2 +-
 arch/arm/mach-shmobile/clock-sh7372.c         |    2 +-
 arch/arm/mach-shmobile/clock-sh7377.c         |    2 +-
 arch/arm/mach-tcc8k/clock.c                   |    3 +-
 arch/arm/mach-tegra/clock.c                   |    2 +-
 arch/arm/mach-tegra/clock.h                   |    2 +-
 arch/arm/mach-tegra/tegra2_clocks.c           |    3 +-
 arch/arm/mach-u300/clock.c                    |    2 +-
 arch/arm/mach-ux500/clock.c                   |    3 +-
 arch/arm/mach-versatile/core.c                |    3 +-
 arch/arm/mach-vexpress/ct-ca9x4.c             |    3 +-
 arch/arm/mach-vexpress/v2m.c                  |    3 +-
 arch/arm/mach-w90x900/clock.h                 |    2 +-
 arch/arm/plat-omap/Kconfig                    |    4 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +-
 arch/arm/plat-spear/include/plat/clock.h      |    2 +-
 arch/arm/plat-stmp3xxx/clock.c                |    2 +-
 arch/sh/Kconfig                               |    2 +-
 arch/sh/boards/mach-highlander/setup.c        |    2 +-
 arch/sh/include/asm/clkdev.h                  |   38 +++---
 arch/sh/kernel/Makefile                       |    2 +-
 arch/sh/kernel/clkdev.c                       |  171 -----------------------
 arch/sh/kernel/cpu/clock-cpg.c                |    2 +-
 arch/sh/kernel/cpu/clock.c                    |   16 ---
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c          |    2 +-
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    2 +
 drivers/clk/Kconfig                           |    4 +
 drivers/clk/Makefile                          |    2 +
 drivers/clk/clkdev.c                          |  176 ++++++++++++++++++++++++
 include/linux/clkdev.h                        |   36 +++++
 73 files changed, 328 insertions(+), 507 deletions(-)
 delete mode 100644 arch/arm/common/clkdev.c
 delete mode 100644 arch/sh/kernel/clkdev.c
 create mode 100644 drivers/clk/Kconfig
 create mode 100644 drivers/clk/Makefile
 create mode 100644 drivers/clk/clkdev.c
 create mode 100644 include/linux/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db524e7..a2ec279 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -221,7 +221,7 @@ config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	select ARM_AMBA
 	select ARCH_HAS_CPUFREQ
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
@@ -231,7 +231,7 @@ config ARCH_INTEGRATOR
 config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARM_AMBA
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -245,7 +245,7 @@ config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
 	select ARM_AMBA
 	select ARM_VIC
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -259,7 +259,7 @@ config ARCH_VEXPRESS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_TIMER_SP804
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	select ICST
@@ -280,7 +280,7 @@ config ARCH_BCMRING
 	depends on MMU
 	select CPU_V6
 	select ARM_AMBA
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
@@ -327,7 +327,7 @@ config ARCH_EP93XX
 	select CPU_ARM920T
 	select ARM_AMBA
 	select ARM_VIC
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_USES_GETTIMEOFFSET
@@ -347,14 +347,14 @@ config ARCH_MXC
 	bool "Freescale MXC/iMX-based"
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
 config ARCH_STMP3XXX
 	bool "Freescale STMP3xxx"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select USB_ARCH_HAS_EHCI
@@ -472,7 +472,7 @@ config ARCH_LPC32XX
 	select HAVE_IDE
 	select ARM_AMBA
 	select USB_ARCH_HAS_OHCI
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
@@ -506,7 +506,7 @@ config ARCH_MMP
 	bool "Marvell PXA168/910/MMP2"
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
@@ -539,7 +539,7 @@ config ARCH_W90X900
 	bool "Nuvoton W90X900 CPU"
 	select CPU_ARM926T
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
@@ -553,7 +553,7 @@ config ARCH_W90X900
 config ARCH_NUC93X
 	bool "Nuvoton NUC93X CPU"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	help
 	  Support for Nuvoton (Winbond logic dept.) NUC93X MCU,The NUC93X is a
 	  low-power and high performance MPEG-4/JPEG multimedia controller chip.
@@ -564,7 +564,7 @@ config ARCH_TEGRA
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ARCH_HAS_BARRIERS if CACHE_L2X0
 	select ARCH_HAS_CPUFREQ
 	help
@@ -574,7 +574,7 @@ config ARCH_TEGRA
 config ARCH_PNX4008
 	bool "Philips Nexperia PNX4008 Mobile"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ARCH_USES_GETTIMEOFFSET
 	help
 	  This enables support for Philips PNX4008 mobile platform.
@@ -584,7 +584,7 @@ config ARCH_PXA
 	depends on MMU
 	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
@@ -761,7 +761,7 @@ config ARCH_TCC_926
 	bool "Telechips TCC ARM926-based systems"
 	select CPU_ARM926T
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Telechips TCC ARM926-based systems.
@@ -785,7 +785,7 @@ config ARCH_U300
 	select ARM_AMBA
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_GPIO
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
@@ -795,7 +795,7 @@ config ARCH_U8500
 	select CPU_V7
 	select ARM_AMBA
 	select GENERIC_CLOCKEVENTS
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for ST-Ericsson's Ux500 architecture
@@ -805,7 +805,7 @@ config ARCH_NOMADIK
 	select ARM_AMBA
 	select ARM_VIC
 	select CPU_ARM926T
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	help
@@ -817,7 +817,7 @@ config ARCH_DAVINCI
 	select ARCH_REQUIRE_GPIOLIB
 	select ZONE_DMA
 	select HAVE_IDE
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select GENERIC_ALLOCATOR
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
@@ -837,7 +837,7 @@ config PLAT_SPEAR
 	bool "ST SPEAr"
 	select ARM_AMBA
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
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
diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
deleted file mode 100644
index e2b2bb6..0000000
--- a/arch/arm/common/clkdev.c
+++ /dev/null
@@ -1,179 +0,0 @@
-/*
- *  arch/arm/common/clkdev.c
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
-
-#include <asm/clkdev.h>
-#include <mach/clkdev.h>
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
-
-		if (match > best) {
-			clk = p->clk;
-			if (match != 3)
-				best = match;
-			else
-				break;
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
-	if (clk && !__clk_get(clk))
-		clk = NULL;
-	mutex_unlock(&clocks_mutex);
-
-	return clk ? clk : ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get_sys);
-
-struct clk *clk_get(struct device *dev, const char *con_id)
-{
-	const char *dev_id = dev ? dev_name(dev) : NULL;
-
-	return clk_get_sys(dev_id, con_id);
-}
-EXPORT_SYMBOL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-	__clk_put(clk);
-}
-EXPORT_SYMBOL(clk_put);
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
-struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
-	const char *dev_fmt, ...)
-{
-	struct clk_lookup_alloc *cla;
-
-	cla = kzalloc(sizeof(*cla), GFP_KERNEL);
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
diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index b56c138..765d332 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -12,23 +12,13 @@
 #ifndef __ASM_CLKDEV_H
 #define __ASM_CLKDEV_H
 
-struct clk;
-struct device;
+#include <linux/slab.h>
 
-struct clk_lookup {
-	struct list_head	node;
-	const char		*dev_id;
-	const char		*con_id;
-	struct clk		*clk;
-};
+#include <mach/clkdev.h>
 
-struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
-	const char *dev_fmt, ...);
-
-void clkdev_add(struct clk_lookup *cl);
-void clkdev_drop(struct clk_lookup *cl);
-
-void clkdev_add_table(struct clk_lookup *, size_t);
-int clk_add_alias(const char *, const char *, char *, struct device *);
+static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
 
 #endif
diff --git a/arch/arm/mach-bcmring/clock.c b/arch/arm/mach-bcmring/clock.c
index 14bafc3..ad237a4 100644
--- a/arch/arm/mach-bcmring/clock.c
+++ b/arch/arm/mach-bcmring/clock.c
@@ -21,13 +21,12 @@
 #include <linux/string.h>
 #include <linux/clk.h>
 #include <linux/spinlock.h>
+#include <linux/clkdev.h>
 #include <mach/csp/hw_cfg.h>
 #include <mach/csp/chipcHw_def.h>
 #include <mach/csp/chipcHw_reg.h>
 #include <mach/csp/chipcHw_inline.h>
 
-#include <asm/clkdev.h>
-
 #include "clock.h"
 
 #define clk_is_primary(x)       ((x)->type & CLK_TYPE_PRIMARY)
diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index d3f959e..ed96ef4 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -30,10 +30,10 @@
 #include <linux/amba/bus.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/clkdev.h>
 
 #include <mach/csp/mm_addr.h>
 #include <mach/hardware.h>
-#include <asm/clkdev.h>
 #include <linux/io.h>
 #include <asm/irq.h>
 #include <asm/hardware/arm_timer.h>
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 1109998..0dd2203 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -68,7 +68,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/list.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #define PLLSTAT_GOSTAT	BIT(0)
 #define PLLCMD_GOSET	BIT(0)
diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index ef06c66..ca4de71 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -19,10 +19,10 @@
 #include <linux/string.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
+#include <linux/clkdev.h>
 
 #include <mach/hardware.h>
 
-#include <asm/clkdev.h>
 #include <asm/div64.h>
 
 
diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
index daca30b..3938a56 100644
--- a/arch/arm/mach-imx/clock-imx1.c
+++ b/arch/arm/mach-imx/clock-imx1.c
@@ -22,8 +22,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include <mach/clock.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
index cf15ea5..d705655 100644
--- a/arch/arm/mach-imx/clock-imx21.c
+++ b/arch/arm/mach-imx/clock-imx21.c
@@ -21,11 +21,11 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/clkdev.h>
 
 #include <mach/clock.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <asm/clkdev.h>
 #include <asm/div64.h>
 
 #define IO_ADDR_CCM(off)	(MX21_IO_ADDRESS(MX21_CCM_BASE_ADDR + (off)))
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 98a25ba..ca1017b 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -21,8 +21,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <asm/div64.h>
 
 #include <mach/clock.h>
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 8f4fb6d..b8e884b 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -21,9 +21,8 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
 #include <linux/io.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
-#include <mach/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/irq.h>
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index fd684bf..5db574f 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -22,9 +22,8 @@
 #include <linux/amba/clcd.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
-#include <mach/clkdev.h>
 #include <asm/hardware/icst.h>
 #include <mach/lm.h>
 #include <mach/impd1.h>
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 6258c90..9403d2f 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -21,9 +21,8 @@
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
-#include <mach/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/irq.h>
diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 32d6379..da0e649 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -90,10 +90,9 @@
 #include <linux/clk.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/clkdev.h>
 
 #include <mach/hardware.h>
-#include <asm/clkdev.h>
-#include <mach/clkdev.h>
 #include <mach/platform.h>
 #include "clock.h"
 #include "common.h"
diff --git a/arch/arm/mach-mmp/clock.h b/arch/arm/mach-mmp/clock.h
index 016ae94..9b027d7 100644
--- a/arch/arm/mach-mmp/clock.h
+++ b/arch/arm/mach-mmp/clock.h
@@ -6,7 +6,7 @@
  *  published by the Free Software Foundation.
  */
 
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 struct clkops {
 	void			(*enable)(struct clk *);
diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 9e4a557..00dcb08 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -21,8 +21,7 @@
 #include <linux/list.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include <mach/clock.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 109e98f..1cd8b40 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -23,8 +23,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <asm/div64.h>
 
 #include <mach/clock.h>
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 61e4a31..819dd80 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -21,8 +21,7 @@
 #include <linux/list.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include <mach/clock.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 8ac36d8..5975edb 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -14,8 +14,8 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <asm/div64.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-mxc91231/clock.c b/arch/arm/mach-mxc91231/clock.c
index 5c85075..9fab505 100644
--- a/arch/arm/mach-mxc91231/clock.c
+++ b/arch/arm/mach-mxc91231/clock.c
@@ -2,12 +2,12 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/clkdev.h>
 
 #include <mach/clock.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 
-#include <asm/clkdev.h>
 #include <asm/bug.h>
 #include <asm/div64.h>
 
diff --git a/arch/arm/mach-nomadik/clock.c b/arch/arm/mach-nomadik/clock.c
index 89f793a..48a59f2 100644
--- a/arch/arm/mach-nomadik/clock.c
+++ b/arch/arm/mach-nomadik/clock.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/clk.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include "clock.h"
 
 /*
diff --git a/arch/arm/mach-nuc93x/clock.h b/arch/arm/mach-nuc93x/clock.h
index 18e51be..4de1f1d 100644
--- a/arch/arm/mach-nuc93x/clock.h
+++ b/arch/arm/mach-nuc93x/clock.h
@@ -10,7 +10,7 @@
  * the Free Software Foundation; either version 2 of the License.
  */
 
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 void nuc93x_clk_enable(struct clk *clk, int enable);
 void clks_register(struct clk_lookup *clks, size_t num);
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index b8c7fb9..84ef704 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -17,9 +17,9 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach-types.h>
-#include <asm/clkdev.h>
 
 #include <plat/cpu.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index ed8d330..ebb888f 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -26,10 +26,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
+#include <linux/clkdev.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
-#include <asm/clkdev.h>
 
 #include "clock.h"
 #include "prm.h"
diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index 9d1975f..a4a3819 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -21,8 +21,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include <mach/hardware.h>
 #include <mach/clock.h>
diff --git a/arch/arm/mach-pxa/clock.c b/arch/arm/mach-pxa/clock.c
index abba008..4e4a84b 100644
--- a/arch/arm/mach-pxa/clock.c
+++ b/arch/arm/mach-pxa/clock.c
@@ -11,8 +11,8 @@
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <mach/pxa2xx-regs.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index d848874..12cc0e8 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -1,4 +1,4 @@
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 struct clkops {
 	void			(*enable)(struct clk *);
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 07c0815..3d915b1 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -30,8 +30,8 @@
 #include <linux/ata_platform.h>
 #include <linux/amba/mmci.h>
 #include <linux/gfp.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <asm/system.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -47,7 +47,6 @@
 
 #include <asm/hardware/gic.h>
 
-#include <mach/clkdev.h>
 #include <mach/platform.h>
 #include <mach/irqs.h>
 #include <plat/timer-sp.h>
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 51dcd59..6329333 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -6,7 +6,7 @@ config ARCH_SH7367
 	bool "SH-Mobile G3 (SH7367)"
 	select CPU_V6
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
 
@@ -14,7 +14,7 @@ config ARCH_SH7377
 	bool "SH-Mobile G4 (SH7377)"
 	select CPU_V7
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
 
@@ -22,7 +22,7 @@ config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
 	select CPU_V7
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
 
diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmobile/clock-sh7367.c
index 9f78729..6b186ae 100644
--- a/arch/arm/mach-shmobile/clock-sh7367.c
+++ b/arch/arm/mach-shmobile/clock-sh7367.c
@@ -20,8 +20,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/sh_clk.h>
+#include <linux/clkdev.h>
 #include <mach/common.h>
-#include <asm/clkdev.h>
 
 /* SH7367 registers */
 #define RTFRQCR    0xe6150000
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 7db31e6..fd3be8e 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -20,8 +20,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/sh_clk.h>
+#include <linux/clkdev.h>
 #include <mach/common.h>
-#include <asm/clkdev.h>
 
 /* SH7372 registers */
 #define FRQCRA		0xe6150000
diff --git a/arch/arm/mach-shmobile/clock-sh7377.c b/arch/arm/mach-shmobile/clock-sh7377.c
index f91395a..9594246 100644
--- a/arch/arm/mach-shmobile/clock-sh7377.c
+++ b/arch/arm/mach-shmobile/clock-sh7377.c
@@ -20,8 +20,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/sh_clk.h>
+#include <linux/clkdev.h>
 #include <mach/common.h>
-#include <asm/clkdev.h>
 
 /* SH7377 registers */
 #define RTFRQCR    0xe6150000
diff --git a/arch/arm/mach-tcc8k/clock.c b/arch/arm/mach-tcc8k/clock.c
index ba32a15..3970a9c 100644
--- a/arch/arm/mach-tcc8k/clock.c
+++ b/arch/arm/mach-tcc8k/clock.c
@@ -12,8 +12,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
-
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include <mach/clock.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index ae19f95..77948e0 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/regulator/consumer.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include "clock.h"
 #include "board.h"
diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
index 94fd859..083a4cf 100644
--- a/arch/arm/mach-tegra/clock.h
+++ b/arch/arm/mach-tegra/clock.h
@@ -21,7 +21,7 @@
 #define __MACH_TEGRA_CLOCK_H
 
 #include <linux/list.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #define DIV_BUS			(1 << 0)
 #define DIV_U71			(1 << 1)
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index ae3b308..f0dae6d 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -24,8 +24,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/hrtimer.h>
-
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include <mach/iomap.h>
 
diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
index 7458fc6..fabcc49 100644
--- a/arch/arm/mach-u300/clock.c
+++ b/arch/arm/mach-u300/clock.c
@@ -25,8 +25,8 @@
 #include <linux/timer.h>
 #include <linux/io.h>
 #include <linux/seq_file.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/syscon.h>
 
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 1675047..531de5c 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -13,8 +13,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 #include <plat/mtu.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..8c1ca1d 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -31,8 +31,8 @@
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/leds.h>
@@ -46,7 +46,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <plat/timer-sp.h>
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index fd25ccd..f4455e3 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -8,8 +8,8 @@
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -18,7 +18,6 @@
 #include <asm/pmu.h>
 #include <asm/smp_twd.h>
 
-#include <mach/clkdev.h>
 #include <mach/ct-ca9x4.h>
 
 #include <plat/timer-sp.h>
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 7eaa232..d374a78 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -11,15 +11,14 @@
 #include <linux/spinlock.h>
 #include <linux/sysdev.h>
 #include <linux/usb/isp1760.h>
+#include <linux/clkdev.h>
 
-#include <asm/clkdev.h>
 #include <asm/sizes.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_timer.h>
 
-#include <mach/clkdev.h>
 #include <mach/motherboard.h>
 
 #include <plat/timer-sp.h>
diff --git a/arch/arm/mach-w90x900/clock.h b/arch/arm/mach-w90x900/clock.h
index c56ddab..b88a1b1 100644
--- a/arch/arm/mach-w90x900/clock.h
+++ b/arch/arm/mach-w90x900/clock.h
@@ -10,7 +10,7 @@
  * the Free Software Foundation; either version 2 of the License.
  */
 
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 void nuc900_clk_enable(struct clk *clk, int enable);
 void nuc900_subclk_enable(struct clk *clk, int enable);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 92c5bb7..c940843 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -11,13 +11,13 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4"
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index bb937f3..4b2028a 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -8,7 +8,7 @@
 #ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_CLKDEV_OMAP_H
 #define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_CLKDEV_OMAP_H
 
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 struct omap_clk {
 	u16				cpu;
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 298bafc..2572260 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -15,7 +15,7 @@
 #define __PLAT_CLOCK_H
 
 #include <linux/list.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <linux/types.h>
 
 /* clk structure flags */
diff --git a/arch/arm/plat-stmp3xxx/clock.c b/arch/arm/plat-stmp3xxx/clock.c
index e593a2a..2e712e1 100644
--- a/arch/arm/plat-stmp3xxx/clock.c
+++ b/arch/arm/plat-stmp3xxx/clock.c
@@ -25,9 +25,9 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach-types.h>
-#include <asm/clkdev.h>
 #include <mach/platform.h>
 #include <mach/regs-clkctrl.h>
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7f217b3..b31b097 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -1,7 +1,7 @@
 config SUPERH
 	def_bool y
 	select EMBEDDED
-	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	select HAVE_IDE if HAS_IOPORT
 	select HAVE_MEMBLOCK
 	select HAVE_OPROFILE
diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
index a5ecfba..87618c9 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -24,10 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/m66592.h>
+#include <linux/clkdev.h>
 #include <net/ax88796.h>
 #include <asm/machvec.h>
 #include <mach/highlander.h>
-#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/heartbeat.h>
 #include <asm/io.h>
diff --git a/arch/sh/include/asm/clkdev.h b/arch/sh/include/asm/clkdev.h
index 5645f35..6ba9186 100644
--- a/arch/sh/include/asm/clkdev.h
+++ b/arch/sh/include/asm/clkdev.h
@@ -1,9 +1,5 @@
 /*
- *  arch/sh/include/asm/clkdev.h
- *
- * Cloned from arch/arm/include/asm/clkdev.h:
- *
- *  Copyright (C) 2008 Russell King.
+ *  Copyright (C) 2010 Paul Mundt <lethal@linux-sh.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -11,25 +7,25 @@
  *
  * Helper for the clk API to assist looking up a struct clk.
  */
-#ifndef __ASM_CLKDEV_H
-#define __ASM_CLKDEV_H
 
-struct clk;
+#ifndef __CLKDEV__H_
+#define __CLKDEV__H_
 
-struct clk_lookup {
-	struct list_head	node;
-	const char		*dev_id;
-	const char		*con_id;
-	struct clk		*clk;
-};
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
 
-struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
-	const char *dev_fmt, ...);
+#include <asm/clock.h>
 
-void clkdev_add(struct clk_lookup *cl);
-void clkdev_drop(struct clk_lookup *cl);
+static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
+{
+	if (!slab_is_available())
+		return alloc_bootmem_low_pages(size);
+	else
+		return kzalloc(size, GFP_KERNEL);
+}
 
-void clkdev_add_table(struct clk_lookup *, size_t);
-int clk_add_alias(const char *, const char *, char *, struct device *);
+#define __clk_put(clk)
+#define __clk_get(clk) ({ 1; })
 
-#endif
+#endif /* __CLKDEV_H__ */
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 8eed6a4..cf65221 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -11,7 +11,7 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
-obj-y	:= clkdev.o debugtraps.o dma-nommu.o dumpstack.o 		\
+obj-y	:= debugtraps.o dma-nommu.o dumpstack.o 		\
 	   idle.o io.o irq.o irq_$(BITS).o kdebugfs.o			\
 	   machvec.o nmi_debug.o process.o				\
 	   process_$(BITS).o ptrace.o ptrace_$(BITS).o			\
diff --git a/arch/sh/kernel/clkdev.c b/arch/sh/kernel/clkdev.c
deleted file mode 100644
index 1f800ef..0000000
--- a/arch/sh/kernel/clkdev.c
+++ /dev/null
@@ -1,171 +0,0 @@
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
-	struct clk_lookup_alloc *cla = container_of(cl, struct clk_lookup_alloc, cl);
-
-	mutex_lock(&clocks_mutex);
-	list_del(&cl->node);
-	mutex_unlock(&clocks_mutex);
-	kfree(cla);
-}
-EXPORT_SYMBOL(clkdev_drop);
diff --git a/arch/sh/kernel/cpu/clock-cpg.c b/arch/sh/kernel/cpu/clock-cpg.c
index e2f63d6..dd0e0f2 100644
--- a/arch/sh/kernel/cpu/clock-cpg.c
+++ b/arch/sh/kernel/cpu/clock-cpg.c
@@ -2,7 +2,7 @@
 #include <linux/compiler.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 
 static struct clk master_clk = {
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
 
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
index 4eabc68..6c1492b 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index 71291ae..93c6460 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -21,7 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 
 /* SH7343 registers */
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index 7ce5bbc..049dc06 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -21,7 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 
 /* SH7366 registers */
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index 2030f3d..9d23a36 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -21,7 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/hwblk.h>
 #include <cpu/sh7722.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
index d3938f0..55493cd 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
@@ -22,7 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/hwblk.h>
 #include <cpu/sh7723.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 0fe2e93..3e34ac0 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -22,7 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/hwblk.h>
 #include <cpu/sh7724.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index ce39a2a..e073e3e 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
index 1f1df48..599630f 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 #include <asm/io.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
index 62d7063..8894926 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 #include <asm/io.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index c3e458a..2d96024 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -14,7 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/cpufreq.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 #include <cpu/sh7785.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index 597c9fb..42e403b 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index 4f70df6..1afdb93 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 
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
index f3ebb30..bf15ce7 100644
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
index 0000000..4168c88
--- /dev/null
+++ b/drivers/clk/Kconfig
@@ -0,0 +1,4 @@
+
+config CLKDEV_LOOKUP
+	bool
+	select HAVE_CLK
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
new file mode 100644
index 0000000..07613fa
--- /dev/null
+++ b/drivers/clk/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
new file mode 100644
index 0000000..0fc0a79
--- /dev/null
+++ b/drivers/clk/clkdev.c
@@ -0,0 +1,176 @@
+/*
+ * drivers/clk/clkdev.c
+ *
+ *  Copyright (C) 2008 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+
+static LIST_HEAD(clocks);
+static DEFINE_MUTEX(clocks_mutex);
+
+/*
+ * Find the correct struct clk for the device and connection ID.
+ * We do slightly fuzzy matching here:
+ *  An entry with a NULL ID is assumed to be a wildcard.
+ *  If an entry has a device ID, it must match
+ *  If an entry has a connection ID, it must match
+ * Then we take the most specific entry - with the following
+ * order of precedence: dev+con > dev only > con only.
+ */
+static struct clk *clk_find(const char *dev_id, const char *con_id)
+{
+	struct clk_lookup *p;
+	struct clk *clk = NULL;
+	int match, best = 0;
+
+	list_for_each_entry(p, &clocks, node) {
+		match = 0;
+		if (p->dev_id) {
+			if (!dev_id || strcmp(p->dev_id, dev_id))
+				continue;
+			match += 2;
+		}
+		if (p->con_id) {
+			if (!con_id || strcmp(p->con_id, con_id))
+				continue;
+			match += 1;
+		}
+
+		if (match > best) {
+			clk = p->clk;
+			if (match != 3)
+				best = match;
+			else
+				break;
+		}
+	}
+	return clk;
+}
+
+struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+{
+	struct clk *clk;
+
+	mutex_lock(&clocks_mutex);
+	clk = clk_find(dev_id, con_id);
+	if (clk && !__clk_get(clk))
+		clk = NULL;
+	mutex_unlock(&clocks_mutex);
+
+	return clk ? clk : ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get_sys);
+
+struct clk *clk_get(struct device *dev, const char *con_id)
+{
+	const char *dev_id = dev ? dev_name(dev) : NULL;
+
+	return clk_get_sys(dev_id, con_id);
+}
+EXPORT_SYMBOL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+	__clk_put(clk);
+}
+EXPORT_SYMBOL(clk_put);
+
+void clkdev_add(struct clk_lookup *cl)
+{
+	mutex_lock(&clocks_mutex);
+	list_add_tail(&cl->node, &clocks);
+	mutex_unlock(&clocks_mutex);
+}
+EXPORT_SYMBOL(clkdev_add);
+
+void __init clkdev_add_table(struct clk_lookup *cl, size_t num)
+{
+	mutex_lock(&clocks_mutex);
+	while (num--) {
+		list_add_tail(&cl->node, &clocks);
+		cl++;
+	}
+	mutex_unlock(&clocks_mutex);
+}
+
+#define MAX_DEV_ID	20
+#define MAX_CON_ID	16
+
+struct clk_lookup_alloc {
+	struct clk_lookup cl;
+	char	dev_id[MAX_DEV_ID];
+	char	con_id[MAX_CON_ID];
+};
+
+struct clk_lookup * __init_refok
+clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+{
+	struct clk_lookup_alloc *cla;
+
+	cla = __clkdev_alloc(sizeof(*cla));
+	if (!cla)
+		return NULL;
+
+	cla->cl.clk = clk;
+	if (con_id) {
+		strlcpy(cla->con_id, con_id, sizeof(cla->con_id));
+		cla->cl.con_id = cla->con_id;
+	}
+
+	if (dev_fmt) {
+		va_list ap;
+
+		va_start(ap, dev_fmt);
+		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
+		cla->cl.dev_id = cla->dev_id;
+		va_end(ap);
+	}
+
+	return &cla->cl;
+}
+EXPORT_SYMBOL(clkdev_alloc);
+
+int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
+	struct device *dev)
+{
+	struct clk *r = clk_get(dev, id);
+	struct clk_lookup *l;
+
+	if (IS_ERR(r))
+		return PTR_ERR(r);
+
+	l = clkdev_alloc(r, alias, alias_dev_name);
+	clk_put(r);
+	if (!l)
+		return -ENODEV;
+	clkdev_add(l);
+	return 0;
+}
+EXPORT_SYMBOL(clk_add_alias);
+
+/*
+ * clkdev_drop - remove a clock dynamically allocated
+ */
+void clkdev_drop(struct clk_lookup *cl)
+{
+	mutex_lock(&clocks_mutex);
+	list_del(&cl->node);
+	mutex_unlock(&clocks_mutex);
+	kfree(cl);
+}
+EXPORT_SYMBOL(clkdev_drop);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
new file mode 100644
index 0000000..457bcb0
--- /dev/null
+++ b/include/linux/clkdev.h
@@ -0,0 +1,36 @@
+/*
+ *  include/linux/clkdev.h
+ *
+ *  Copyright (C) 2008 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+#ifndef __CLKDEV_H
+#define __CLKDEV_H
+
+#include <asm/clkdev.h>
+
+struct clk;
+struct device;
+
+struct clk_lookup {
+	struct list_head	node;
+	const char		*dev_id;
+	const char		*con_id;
+	struct clk		*clk;
+};
+
+struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
+	const char *dev_fmt, ...);
+
+void clkdev_add(struct clk_lookup *cl);
+void clkdev_drop(struct clk_lookup *cl);
+
+void clkdev_add_table(struct clk_lookup *, size_t);
+int clk_add_alias(const char *, const char *, char *, struct device *);
+
+#endif
-- 
1.7.1
