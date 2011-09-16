From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:20 -0400
Subject: [PATCH 09/19] ARM: plat-omap: remove arch specific special handling
	for ioremap
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-10-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

A generic version should replace this later.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/plat-omap/Makefile          |    2 +-
 arch/arm/plat-omap/include/plat/io.h |    6 --
 arch/arm/plat-omap/io.c              |  141 ----------------------------------
 3 files changed, 1 insertions(+), 148 deletions(-)
 delete mode 100644 arch/arm/plat-omap/io.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index f0233e6abc..1db3f2f88c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o \
-	 usb.o fb.o io.o counter_32k.o
+	 usb.o fb.o counter_32k.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index d72ec85c97..92e6d53ed5 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -303,12 +303,6 @@ extern void omap2_init_common_infrastructure(void);
 extern void omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 
-#define __arch_ioremap	omap_ioremap
-#define __arch_iounmap	omap_iounmap
-
-void __iomem *omap_ioremap(unsigned long phys, size_t size, unsigned int type);
-void omap_iounmap(volatile void __iomem *addr);
-
 #endif
 
 #endif
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
deleted file mode 100644
index f1ecfa9fc6..0000000000
--- a/arch/arm/plat-omap/io.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * Common io.c file
- * This file is created by Russell King <rmk+kernel@arm.linux.org.uk>
- *
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/mm.h>
-
-#include <plat/omap7xx.h>
-#include <plat/omap1510.h>
-#include <plat/omap16xx.h>
-#include <plat/omap24xx.h>
-#include <plat/omap34xx.h>
-#include <plat/omap44xx.h>
-
-#define BETWEEN(p,st,sz)	((p) >= (st) && (p) < ((st) + (sz)))
-#define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
-
-/*
- * Intercept ioremap() requests for addresses in our fixed mapping regions.
- */
-void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
-{
-#ifdef CONFIG_ARCH_OMAP1
-	if (cpu_class_is_omap1()) {
-		if (BETWEEN(p, OMAP1_IO_PHYS, OMAP1_IO_SIZE))
-			return XLATE(p, OMAP1_IO_PHYS, OMAP1_IO_VIRT);
-	}
-	if (cpu_is_omap7xx()) {
-		if (BETWEEN(p, OMAP7XX_DSP_BASE, OMAP7XX_DSP_SIZE))
-			return XLATE(p, OMAP7XX_DSP_BASE, OMAP7XX_DSP_START);
-
-		if (BETWEEN(p, OMAP7XX_DSPREG_BASE, OMAP7XX_DSPREG_SIZE))
-			return XLATE(p, OMAP7XX_DSPREG_BASE,
-					OMAP7XX_DSPREG_START);
-	}
-	if (cpu_is_omap15xx()) {
-		if (BETWEEN(p, OMAP1510_DSP_BASE, OMAP1510_DSP_SIZE))
-			return XLATE(p, OMAP1510_DSP_BASE, OMAP1510_DSP_START);
-
-		if (BETWEEN(p, OMAP1510_DSPREG_BASE, OMAP1510_DSPREG_SIZE))
-			return XLATE(p, OMAP1510_DSPREG_BASE,
-					OMAP1510_DSPREG_START);
-	}
-	if (cpu_is_omap16xx()) {
-		if (BETWEEN(p, OMAP16XX_DSP_BASE, OMAP16XX_DSP_SIZE))
-			return XLATE(p, OMAP16XX_DSP_BASE, OMAP16XX_DSP_START);
-
-		if (BETWEEN(p, OMAP16XX_DSPREG_BASE, OMAP16XX_DSPREG_SIZE))
-			return XLATE(p, OMAP16XX_DSPREG_BASE,
-					OMAP16XX_DSPREG_START);
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP2
-	if (cpu_is_omap24xx()) {
-		if (BETWEEN(p, L3_24XX_PHYS, L3_24XX_SIZE))
-			return XLATE(p, L3_24XX_PHYS, L3_24XX_VIRT);
-		if (BETWEEN(p, L4_24XX_PHYS, L4_24XX_SIZE))
-			return XLATE(p, L4_24XX_PHYS, L4_24XX_VIRT);
-	}
-	if (cpu_is_omap2420()) {
-		if (BETWEEN(p, DSP_MEM_2420_PHYS, DSP_MEM_2420_SIZE))
-			return XLATE(p, DSP_MEM_2420_PHYS, DSP_MEM_2420_VIRT);
-		if (BETWEEN(p, DSP_IPI_2420_PHYS, DSP_IPI_2420_SIZE))
-			return XLATE(p, DSP_IPI_2420_PHYS, DSP_IPI_2420_SIZE);
-		if (BETWEEN(p, DSP_MMU_2420_PHYS, DSP_MMU_2420_SIZE))
-			return XLATE(p, DSP_MMU_2420_PHYS, DSP_MMU_2420_VIRT);
-	}
-	if (cpu_is_omap2430()) {
-		if (BETWEEN(p, L4_WK_243X_PHYS, L4_WK_243X_SIZE))
-			return XLATE(p, L4_WK_243X_PHYS, L4_WK_243X_VIRT);
-		if (BETWEEN(p, OMAP243X_GPMC_PHYS, OMAP243X_GPMC_SIZE))
-			return XLATE(p, OMAP243X_GPMC_PHYS, OMAP243X_GPMC_VIRT);
-		if (BETWEEN(p, OMAP243X_SDRC_PHYS, OMAP243X_SDRC_SIZE))
-			return XLATE(p, OMAP243X_SDRC_PHYS, OMAP243X_SDRC_VIRT);
-		if (BETWEEN(p, OMAP243X_SMS_PHYS, OMAP243X_SMS_SIZE))
-			return XLATE(p, OMAP243X_SMS_PHYS, OMAP243X_SMS_VIRT);
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_ti816x()) {
-		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
-			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
-	} else if (cpu_is_omap34xx()) {
-		if (BETWEEN(p, L3_34XX_PHYS, L3_34XX_SIZE))
-			return XLATE(p, L3_34XX_PHYS, L3_34XX_VIRT);
-		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
-			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
-		if (BETWEEN(p, OMAP34XX_GPMC_PHYS, OMAP34XX_GPMC_SIZE))
-			return XLATE(p, OMAP34XX_GPMC_PHYS, OMAP34XX_GPMC_VIRT);
-		if (BETWEEN(p, OMAP343X_SMS_PHYS, OMAP343X_SMS_SIZE))
-			return XLATE(p, OMAP343X_SMS_PHYS, OMAP343X_SMS_VIRT);
-		if (BETWEEN(p, OMAP343X_SDRC_PHYS, OMAP343X_SDRC_SIZE))
-			return XLATE(p, OMAP343X_SDRC_PHYS, OMAP343X_SDRC_VIRT);
-		if (BETWEEN(p, L4_PER_34XX_PHYS, L4_PER_34XX_SIZE))
-			return XLATE(p, L4_PER_34XX_PHYS, L4_PER_34XX_VIRT);
-		if (BETWEEN(p, L4_EMU_34XX_PHYS, L4_EMU_34XX_SIZE))
-			return XLATE(p, L4_EMU_34XX_PHYS, L4_EMU_34XX_VIRT);
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	if (cpu_is_omap44xx()) {
-		if (BETWEEN(p, L3_44XX_PHYS, L3_44XX_SIZE))
-			return XLATE(p, L3_44XX_PHYS, L3_44XX_VIRT);
-		if (BETWEEN(p, L4_44XX_PHYS, L4_44XX_SIZE))
-			return XLATE(p, L4_44XX_PHYS, L4_44XX_VIRT);
-		if (BETWEEN(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_SIZE))
-			return XLATE(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_VIRT);
-		if (BETWEEN(p, OMAP44XX_EMIF1_PHYS, OMAP44XX_EMIF1_SIZE))
-			return XLATE(p, OMAP44XX_EMIF1_PHYS,		\
-							OMAP44XX_EMIF1_VIRT);
-		if (BETWEEN(p, OMAP44XX_EMIF2_PHYS, OMAP44XX_EMIF2_SIZE))
-			return XLATE(p, OMAP44XX_EMIF2_PHYS,		\
-							OMAP44XX_EMIF2_VIRT);
-		if (BETWEEN(p, OMAP44XX_DMM_PHYS, OMAP44XX_DMM_SIZE))
-			return XLATE(p, OMAP44XX_DMM_PHYS, OMAP44XX_DMM_VIRT);
-		if (BETWEEN(p, L4_PER_44XX_PHYS, L4_PER_44XX_SIZE))
-			return XLATE(p, L4_PER_44XX_PHYS, L4_PER_44XX_VIRT);
-		if (BETWEEN(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_SIZE))
-			return XLATE(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_VIRT);
-	}
-#endif
-	return __arm_ioremap_caller(p, size, type, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(omap_ioremap);
-
-void omap_iounmap(volatile void __iomem *addr)
-{
-	unsigned long virt = (unsigned long)addr;
-
-	if (virt >= VMALLOC_START && virt < VMALLOC_END)
-		__iounmap(addr);
-}
-EXPORT_SYMBOL(omap_iounmap);
-- 
1.7.7-rc0
