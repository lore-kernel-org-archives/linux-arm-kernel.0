From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:52 +0100
Subject: [PATCH 4/7] ARM: mmp: remove remaining legacy pxa-dma support
In-Reply-To: <1448465875-435039-1-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
Message-ID: <1448465875-435039-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All drivers have stopped using this code, so we can just
as well stop initializing it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/include/mach/dma.h | 13 -------------
 arch/arm/mach-mmp/mmp2.c             |  2 --
 arch/arm/mach-mmp/pxa168.c           |  2 --
 arch/arm/mach-mmp/pxa910.c           |  2 --
 arch/arm/plat-pxa/Makefile           |  2 +-
 5 files changed, 1 insertion(+), 20 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/dma.h

diff --git a/arch/arm/mach-mmp/include/mach/dma.h b/arch/arm/mach-mmp/include/mach/dma.h
deleted file mode 100644
index 1d6914544da4..000000000000
--- a/arch/arm/mach-mmp/include/mach/dma.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/dma.h
- */
-
-#ifndef __ASM_MACH_DMA_H
-#define __ASM_MACH_DMA_H
-
-#include <mach/addr-map.h>
-
-#define DMAC_REGS_VIRT	(APB_VIRT_BASE + 0x00000)
-
-#include <plat/dma.h>
-#endif /* __ASM_MACH_DMA_H */
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index c8914ef21f7f..82eb53f5136a 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -25,7 +25,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
@@ -111,7 +110,6 @@ static int __init mmp2_init(void)
 #endif
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
-		pxa_init_dma(IRQ_MMP2_DMA_RIQ, 16);
 		mmp2_clk_init(APB_PHYS_BASE + 0x50000,
 			      AXI_PHYS_BASE + 0x82800,
 			      APB_PHYS_BASE + 0x15000);
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 53f21554ae63..7367f4b079e4 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -24,7 +24,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
 #include <mach/irqs.h>
-#include <mach/dma.h>
 #include <mach/devices.h>
 #include <mach/mfp.h>
 #include <linux/dma-mapping.h>
@@ -56,7 +55,6 @@ static int __init pxa168_init(void)
 	if (cpu_is_pxa168()) {
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa168_mfp_addr_map);
-		pxa_init_dma(IRQ_PXA168_DMA_INT0, 32);
 		pxa168_clk_init(APB_PHYS_BASE + 0x50000,
 				AXI_PHYS_BASE + 0x82800,
 				APB_PHYS_BASE + 0x15000);
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 545404261327..15f7be01fed8 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -23,7 +23,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
 #include <mach/pm-pxa910.h>
@@ -97,7 +96,6 @@ static int __init pxa910_init(void)
 #endif
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa910_mfp_addr_map);
-		pxa_init_dma(IRQ_PXA910_DMA_INT0, 32);
 		pxa910_clk_init(APB_PHYS_BASE + 0x50000,
 				AXI_PHYS_BASE + 0x82800,
 				APB_PHYS_BASE + 0x15000,
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 1fc941944912..e507aebbef52 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -2,7 +2,7 @@
 # Makefile for code common across different PXA processor families
 #
 
-obj-y	:= dma.o
+obj-$(CONFIG_ARCH_PXA)		:= dma.o
 
 obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
-- 
2.1.0.rc2
