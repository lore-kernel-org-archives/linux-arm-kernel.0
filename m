From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:51:36 +0200
Subject: [PATCH 5/7 v6] Basic IO mappings for mach-tcc8k
In-Reply-To: <20100526174240.GC2006@bluebox.local>
References: <20100526174240.GC2006@bluebox.local>
Message-ID: <20100526175136.GH2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Map the IO ranges of TCC8xxx peripherals.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile        |    2 +-
 arch/arm/mach-tcc8k/io.c            |   63 +++++++++++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/io.h |   23 +++++++++++++
 3 files changed, 87 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/io.c
 create mode 100644 arch/arm/plat-tcc/include/mach/io.h

diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index 5673868..09552e2 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -3,5 +3,5 @@
 #
 
 # Common support
-obj-y += clock.o irq.o time.o
+obj-y += clock.o irq.o time.o io.o
 
diff --git a/arch/arm/mach-tcc8k/io.c b/arch/arm/mach-tcc8k/io.c
new file mode 100644
index 0000000..57825a0
--- /dev/null
+++ b/arch/arm/mach-tcc8k/io.c
@@ -0,0 +1,63 @@
+/*
+ * linux/arch/arm/mach-tcc8k/io.c
+ *
+ * (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * derived from TCC83xx io.c
+ * Copyright (C) Telechips, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/tcc8k-regs.h>
+
+/*
+ * The machine specific code may provide the extra mapping besides the
+ * default mapping provided here.
+ */
+static struct map_desc tcc8k_io_desc[] __initdata = {
+	{
+		.virtual	= (unsigned long)CS1_BASE_VIRT,
+		.pfn		= __phys_to_pfn(CS1_BASE),
+		.length		= CS1_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)AHB_PERI_BASE_VIRT,
+		.pfn		= __phys_to_pfn(AHB_PERI_BASE),
+		.length		= AHB_PERI_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)APB0_PERI_BASE_VIRT,
+		.pfn		= __phys_to_pfn(APB0_PERI_BASE),
+		.length		= APB0_PERI_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)APB1_PERI_BASE_VIRT,
+		.pfn		= __phys_to_pfn(APB1_PERI_BASE),
+		.length		= APB1_PERI_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXT_MEM_CTRL_BASE_VIRT,
+		.pfn		= __phys_to_pfn(EXT_MEM_CTRL_BASE),
+		.length		= EXT_MEM_CTRL_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+/*
+ * Maps common IO regions for tcc8k.
+ *
+ */
+void __init tcc8k_map_common_io(void)
+{
+	iotable_init(tcc8k_io_desc, ARRAY_SIZE(tcc8k_io_desc));
+}
+
diff --git a/arch/arm/plat-tcc/include/mach/io.h b/arch/arm/plat-tcc/include/mach/io.h
new file mode 100644
index 0000000..3e911d3
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/io.h
@@ -0,0 +1,23 @@
+/*
+ * IO definitions for TCC8000 processors and boards
+ *
+ * Copyright (C) 1997-1999 Russell King
+ * Copyright (C) 2008-2009 Telechips
+ * Copyright (C) 2010 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GNU Public License version 2.
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)			__typesafe_io(a)
+#define __mem_pci(a)		(a)
+
+#endif
-- 
1.6.3.3
