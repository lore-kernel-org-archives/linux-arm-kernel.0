From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:18 -0400
Subject: [PATCH 07/19] ARM: mach-davinci: remove arch specific special handling
	for ioremap
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-8-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

A generic version should replace this later.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-davinci/Makefile          |    2 +-
 arch/arm/mach-davinci/include/mach/io.h |    8 -----
 arch/arm/mach-davinci/io.c              |   48 -------------------------------
 3 files changed, 1 insertions(+), 57 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/io.c

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 0b87a1ca2b..d6a8879aa6 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -4,7 +4,7 @@
 #
 
 # Common objects
-obj-y 			:= time.o clock.o serial.o io.o psc.o \
+obj-y 			:= time.o clock.o serial.o psc.o \
 			   gpio.o dma.o usb.o common.o sram.o aemif.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
index d1b954955c..b2267d1e1a 100644
--- a/arch/arm/mach-davinci/include/mach/io.h
+++ b/arch/arm/mach-davinci/include/mach/io.h
@@ -21,12 +21,4 @@
 #define __mem_pci(a)		(a)
 #define __mem_isa(a)		(a)
 
-#ifndef __ASSEMBLER__
-#define __arch_ioremap		davinci_ioremap
-#define __arch_iounmap		davinci_iounmap
-
-void __iomem *davinci_ioremap(unsigned long phys, size_t size,
-			      unsigned int type);
-void davinci_iounmap(volatile void __iomem *addr);
-#endif
 #endif /* __ASM_ARCH_IO_H */
diff --git a/arch/arm/mach-davinci/io.c b/arch/arm/mach-davinci/io.c
deleted file mode 100644
index 8ea60a8b24..0000000000
--- a/arch/arm/mach-davinci/io.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * DaVinci I/O mapping code
- *
- * Copyright (C) 2005-2006 Texas Instruments
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/io.h>
-
-#include <asm/tlb.h>
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-
-/*
- * Intercept ioremap() requests for addresses in our fixed mapping regions.
- */
-void __iomem *davinci_ioremap(unsigned long p, size_t size, unsigned int type)
-{
-	struct map_desc *desc = davinci_soc_info.io_desc;
-	int desc_num = davinci_soc_info.io_desc_num;
-	int i;
-
-	for (i = 0; i < desc_num; i++, desc++) {
-		unsigned long iophys = __pfn_to_phys(desc->pfn);
-		unsigned long iosize = desc->length;
-
-		if (p >= iophys && (p + size) <= (iophys + iosize))
-			return __io(desc->virtual + p - iophys);
-	}
-
-	return __arm_ioremap_caller(p, size, type,
-					__builtin_return_address(0));
-}
-EXPORT_SYMBOL(davinci_ioremap);
-
-void davinci_iounmap(volatile void __iomem *addr)
-{
-	unsigned long virt = (unsigned long)addr;
-
-	if (virt >= VMALLOC_START && virt < VMALLOC_END)
-		__iounmap(addr);
-}
-EXPORT_SYMBOL(davinci_iounmap);
-- 
1.7.7-rc0
