From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 May 2013 21:05:54 +0800
Subject: [PATCH 2/3] ARM: imx: Select GENERIC_ALLOCATOR
In-Reply-To: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
References: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1368018355-26014-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 657eee7 (media: coda: use genalloc API) the following build
error happens with imx_v4_v5_defconfig:

drivers/built-in.o: In function 'coda_remove':
clk-composite.c:(.text+0x112180): undefined reference to 'gen_pool_free'
drivers/built-in.o: In function 'coda_probe':
clk-composite.c:(.text+0x112310): undefined reference to 'of_get_named_gen_pool'
clk-composite.c:(.text+0x1123f4): undefined reference to 'gen_pool_alloc'
clk-composite.c:(.text+0x11240c): undefined reference to 'gen_pool_virt_to_phys'
clk-composite.c:(.text+0x112458): undefined reference to 'dev_get_gen_pool'

Select GENERIC_ALLOCATOR and get rid of the custom IRAM_ALLOC.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig              |    5 +--
 arch/arm/mach-imx/Makefile             |    1 -
 arch/arm/mach-imx/iram_alloc.c         |   73 --------------------------------
 include/linux/platform_data/imx-iram.h |   41 ------------------
 4 files changed, 1 insertion(+), 119 deletions(-)
 delete mode 100644 arch/arm/mach-imx/iram_alloc.c
 delete mode 100644 include/linux/platform_data/imx-iram.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 78f795d..ba44328 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -5,6 +5,7 @@ config ARCH_MXC
 	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select MULTI_IRQ_HANDLER
@@ -61,10 +62,6 @@ config MXC_ULPI
 config ARCH_HAS_RNGA
 	bool
 
-config IRAM_ALLOC
-	bool
-	select GENERIC_ALLOCATOR
-
 config HAVE_IMX_ANATOP
 	bool
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 9309589..70ae7c4 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
 
-obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
diff --git a/arch/arm/mach-imx/iram_alloc.c b/arch/arm/mach-imx/iram_alloc.c
deleted file mode 100644
index e05cf40..0000000
--- a/arch/arm/mach-imx/iram_alloc.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/genalloc.h>
-#include "linux/platform_data/imx-iram.h"
-
-static unsigned long iram_phys_base;
-static void __iomem *iram_virt_base;
-static struct gen_pool *iram_pool;
-
-static inline void __iomem *iram_phys_to_virt(unsigned long p)
-{
-	return iram_virt_base + (p - iram_phys_base);
-}
-
-void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr)
-{
-	if (!iram_pool)
-		return NULL;
-
-	*dma_addr = gen_pool_alloc(iram_pool, size);
-	pr_debug("iram alloc - %dB at 0x%lX\n", size, *dma_addr);
-	if (!*dma_addr)
-		return NULL;
-	return iram_phys_to_virt(*dma_addr);
-}
-EXPORT_SYMBOL(iram_alloc);
-
-void iram_free(unsigned long addr, unsigned int size)
-{
-	if (!iram_pool)
-		return;
-
-	gen_pool_free(iram_pool, addr, size);
-}
-EXPORT_SYMBOL(iram_free);
-
-int __init iram_init(unsigned long base, unsigned long size)
-{
-	iram_phys_base = base;
-
-	iram_pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!iram_pool)
-		return -ENOMEM;
-
-	gen_pool_add(iram_pool, base, size, -1);
-	iram_virt_base = ioremap(iram_phys_base, size);
-	if (!iram_virt_base)
-		return -EIO;
-
-	pr_debug("i.MX IRAM pool: %ld KB at 0x%p\n", size / 1024, iram_virt_base);
-	return 0;
-}
diff --git a/include/linux/platform_data/imx-iram.h b/include/linux/platform_data/imx-iram.h
deleted file mode 100644
index 022690c..0000000
--- a/include/linux/platform_data/imx-iram.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-#include <linux/errno.h>
-
-#ifdef CONFIG_IRAM_ALLOC
-
-int __init iram_init(unsigned long base, unsigned long size);
-void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr);
-void iram_free(unsigned long dma_addr, unsigned int size);
-
-#else
-
-static inline int __init iram_init(unsigned long base, unsigned long size)
-{
-	return -ENOMEM;
-}
-
-static inline void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr)
-{
-	return NULL;
-}
-
-static inline void iram_free(unsigned long base, unsigned long size) {}
-
-#endif
-- 
1.7.9.5
