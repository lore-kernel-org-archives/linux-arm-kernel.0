From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:24 +0000
Subject: [PATCH v3 13/14] picoxcell: add support for the onchip SRAM
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-14-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The onchip SRAM is a 128KB SRAM that is shared with the picoArray
DSP array. Use a generic allocator based on the mach-davinci SRAM
allocator to provide allocations from this SRAM.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-picoxcell/Kconfig             |    9 ++++
 arch/arm/mach-picoxcell/Makefile            |    1 +
 arch/arm/mach-picoxcell/include/mach/sram.h |   28 +++++++++++
 arch/arm/mach-picoxcell/sram.c              |   66 +++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/include/mach/sram.h
 create mode 100644 arch/arm/mach-picoxcell/sram.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 85f9c97..c803b28 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -596,6 +596,7 @@ config ARCH_PICOXCELL
 	select TICK_ONESHOT
 	select CPU_V6
 	select HAVE_TCM
+	select GENERIC_ALLOCATOR
 	help
 	  This enables support for systems based on the Picochip picoXcell
 	  family of Femtocell devices.
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index 671cadc..a0b197c 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -26,4 +26,13 @@ config PC3X3_STOP_WDT_IN_SUSPEND
 	  to keep running. If you say no here, make sure that the watchdog uses
 	  the pretimeout mode and mark the watchdog as a wakeup source.
 
+config PICOXCELL_SRAM
+	bool "Support SRAM in Linux"
+	default y
+	help
+	  Say yes here to add support for allocations from the onchip SRAM.
+	  This SRAM is low latency and is 128KB in size. The SRAM is also
+	  accessible by the picoArray so care needs to be taken when using this
+	  in combination with picoArray firmware that utilizes the SRAM.
+
 endmenu
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 7ed0d7c..6f2a5b8 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PICOXCELL_PC3X2)	+= pc3x2.o
 obj-$(CONFIG_PICOXCELL_PC3X3)	+= pc3x3.o
+obj-$(CONFIG_PICOXCELL_SRAM)	+= sram.o
diff --git a/arch/arm/mach-picoxcell/include/mach/sram.h b/arch/arm/mach-picoxcell/include/mach/sram.h
new file mode 100644
index 0000000..4cd1a71
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/sram.h
@@ -0,0 +1,28 @@
+/*
+ * mach/sram.h - picoxcell simple SRAM allocator
+ *
+ * Adapted from the DaVinci SRAM allocator by David Brownell. picoXcell always
+ * has 128KB of SRAM at the same address so the allocator is a bit simpler
+ * than for DaVinci.
+ *
+ * Copyright (C) 2010 Jamie Iles
+ * Copyright (C) 2009 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __PICOXCELL_SRAM_H__
+#define __PICOXCELL_SRAM_H__
+
+/*
+ * Granularity of SRAM allocations. With 128KB, 512 bytes seems like a
+ * reasonable granularity.
+ */
+#define SRAM_GRANULARITY		512
+
+void *sram_alloc(size_t len, dma_addr_t *dma);
+void sram_free(void *addr, size_t len);
+
+#endif /* __PICOXCELL_SRAM_H__ */
diff --git a/arch/arm/mach-picoxcell/sram.c b/arch/arm/mach-picoxcell/sram.c
new file mode 100644
index 0000000..4c290d1
--- /dev/null
+++ b/arch/arm/mach-picoxcell/sram.c
@@ -0,0 +1,66 @@
+/*
+ * mach-picoxcell/sram.c - picoxcell simple SRAM allocator
+ *
+ * Adapted from the DaVinci SRAM allocator by David Brownell. picoXcell always
+ * has 128KB of SRAM at the same address so the allocator is a bit simpler
+ * than for DaVinci.
+ *
+ * Copyright (C) 2010 Jamie Iles
+ * Copyright (C) 2009 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/genalloc.h>
+
+#include <mach/hardware.h>
+#include <mach/sram.h>
+
+static struct gen_pool *sram_pool;
+
+void *sram_alloc(size_t len, dma_addr_t *dma)
+{
+	unsigned long vaddr;
+
+	if (dma)
+		*dma = 0;
+
+	if (!sram_pool)
+		return NULL;
+
+	vaddr = gen_pool_alloc(sram_pool, len);
+	if (!vaddr)
+		return NULL;
+
+	if (dma)
+		*dma = SRAM_BASE + (vaddr - SRAM_VIRT);
+
+	return (void *)vaddr;
+
+}
+EXPORT_SYMBOL(sram_alloc);
+
+void sram_free(void *addr, size_t len)
+{
+	gen_pool_free(sram_pool, (unsigned long)addr, len);
+}
+EXPORT_SYMBOL(sram_free);
+
+static int __init sram_init(void)
+{
+	int ret;
+
+	sram_pool = gen_pool_create(ilog2(SRAM_GRANULARITY), -1);
+	if (!sram_pool)
+		return -ENOMEM;
+
+	ret = gen_pool_add(sram_pool, SRAM_VIRT, SRAM_SIZE, -1);
+	WARN_ON(ret < 0);
+
+	return ret;
+}
+core_initcall(sram_init);
-- 
1.7.2.3
