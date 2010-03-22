From: hjk@linutronix.de (Hans J. Koch)
Date: Mon, 22 Mar 2010 20:27:49 +0100
Subject: [PATCH 05/07] Basic IO mappings for mach-tcc8k
In-Reply-To: <20100322191900.GF2040@bluebox.local>
References: <20100322191900.GF2040@bluebox.local>
Message-ID: <20100322192748.GK2040@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Map the IO ranges of TCC8xxx peripherals.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile        |    2 +-
 arch/arm/mach-tcc8k/io.c            |   82 +++++++++++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/io.h |   53 ++++++++++++++++++++++
 3 files changed, 136 insertions(+), 1 deletions(-)
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
index 0000000..1187fca
--- /dev/null
+++ b/arch/arm/mach-tcc8k/io.c
@@ -0,0 +1,82 @@
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/tlb.h>
+#include <asm/mach/map.h>
+#include <asm/io.h>
+
+#include <mach/tcc8k-regs.h>
+
+/*
+ * The machine specific code may provide the extra mapping besides the
+ * default mapping provided here.
+ */
+static struct map_desc tcc8k_io_desc[] __initdata = {
+	{
+		.virtual	= CS1_BASE_VIRT,	/* CS1 (CS8900) */
+		.pfn		= __phys_to_pfn(CS1_BASE),
+		.length		= CS1_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= AHB_PERI_BASE_VIRT,	/* AHB peripherals */
+		.pfn		= __phys_to_pfn(AHB_PERI_BASE),
+		.length		= AHB_PERI_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= APB0_PERI_BASE_VIRT,	/* APB peripherals */
+		.pfn		= __phys_to_pfn(APB0_PERI_BASE),
+		.length		= APB0_PERI_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= APB1_PERI_BASE_VIRT,	/* APB peripherals */
+		.pfn		= __phys_to_pfn(APB1_PERI_BASE),
+		.length		= APB1_PERI_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= EXT_MEM_CTRL_BASE_VIRT, /* Ext. mem.contr. */
+		.pfn		= __phys_to_pfn(EXT_MEM_CTRL_BASE),
+		.length		= EXT_MEM_CTRL_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= INT_SRAM_BASE_VIRT,	/* Internal SRAM */
+		.pfn		= __phys_to_pfn(INT_SRAM_BASE),
+		.length		= INT_SRAM_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= DATA_TCM_BASE_VIRT,	/* Data TCM */
+		.pfn		= __phys_to_pfn(DATA_TCM_BASE),
+		.length		= DATA_TCM_SIZE,
+		.type		= MT_DEVICE
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
+	local_flush_tlb_all();
+	flush_cache_all();
+}
+
diff --git a/arch/arm/plat-tcc/include/mach/io.h b/arch/arm/plat-tcc/include/mach/io.h
new file mode 100644
index 0000000..7d84370
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/io.h
@@ -0,0 +1,53 @@
+/*
+ * Based on:    linux/include/asm-arm/arch-sa1100/io.h
+ * Author : <linux@telechips.com>
+ * Created: June 10, 2008
+ * Description: IO definitions for TCC8300 processors and boards
+ *
+ * Copyright (C) 1997-1999 Russell King
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Modifications for mainline (C) 2009 Hans J. Koch <hjk@linutronix.de>
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
+#define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
+#define __mem_pci(a)		(a)
+
+/*
+ * ----------------------------------------------------------------------------
+ * I/O mapping
+ * ----------------------------------------------------------------------------
+ */
+
+#define PCIO_BASE	0
+
+/* Address Map of Internal Peripherials (Base 0x80000000) */
+#define IO_PHYS_A			0x80000000
+#define IO_OFFSET_A			0x70000000 /* Virtual IO = 0xF0000000 */
+#define IO_SIZE_A			0x100000
+#define IO_VIRT_A			(IO_PHYS + IO_OFFSET)
+#define IO_ADDRESS_A(pa)	((pa) + IO_OFFSET)
+#define IO_P2V_A(pa)		((pa) + IO_OFFSET)
+#define IO_V2P_A(va)		((va) - IO_OFFSET)
+
+/* Address Map of Internal Peripherials (Base 0x90000000) */
+#define IO_PHYS_B			0x90000000
+#define IO_OFFSET_B			0x61000000 /* Virtual IO = 0xF1000000 */
+#define IO_SIZE_B			0x100000
+#define IO_VIRT_B			(IO_PHYS + IO_OFFSET)
+#define IO_ADDRESS_B(pa)	((pa) + IO_OFFSET)
+#define IO_P2V_B(pa)		((pa) + IO_OFFSET)
+#define IO_V2P_B(va)		((va) - IO_OFFSET)
+
+#endif
-- 
1.6.3.3
