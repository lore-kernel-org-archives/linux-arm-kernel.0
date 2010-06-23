From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:52:15 +0800
Subject: [PATCH 3/6] [ARM] Make __mem_pci() common to all ARM sub-architectures
In-Reply-To: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277293938-25804-4-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On all ARM sub-architectures, __mem_pci() is defined to be a 1:1
mapping, make it a common definition for all.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/io.h                  |    4 ++++
 arch/arm/mach-aaec2000/include/mach/io.h   |    2 --
 arch/arm/mach-at91/include/mach/io.h       |    2 --
 arch/arm/mach-bcmring/include/mach/io.h    |    2 --
 arch/arm/mach-clps711x/include/mach/io.h   |    2 --
 arch/arm/mach-cns3xxx/include/mach/io.h    |    2 --
 arch/arm/mach-davinci/include/mach/io.h    |    1 -
 arch/arm/mach-dove/include/mach/io.h       |    2 --
 arch/arm/mach-ep93xx/include/mach/io.h     |    2 --
 arch/arm/mach-footbridge/include/mach/io.h |    2 --
 arch/arm/mach-gemini/include/mach/io.h     |    2 --
 arch/arm/mach-h720x/include/mach/io.h      |    2 --
 arch/arm/mach-integrator/include/mach/io.h |    2 --
 arch/arm/mach-iop13xx/include/mach/io.h    |    1 -
 arch/arm/mach-iop32x/include/mach/io.h     |    2 --
 arch/arm/mach-iop33x/include/mach/io.h     |    2 --
 arch/arm/mach-ixp2000/include/mach/io.h    |    2 --
 arch/arm/mach-ixp23xx/include/mach/io.h    |    2 --
 arch/arm/mach-ixp4xx/include/mach/io.h     |    2 --
 arch/arm/mach-kirkwood/include/mach/io.h   |    2 --
 arch/arm/mach-ks8695/include/mach/io.h     |    2 --
 arch/arm/mach-l7200/include/mach/io.h      |    2 --
 arch/arm/mach-lh7a40x/include/mach/io.h    |    2 --
 arch/arm/mach-loki/include/mach/io.h       |    2 --
 arch/arm/mach-mmp/include/mach/io.h        |    2 --
 arch/arm/mach-msm/include/mach/io.h        |    2 --
 arch/arm/mach-mv78xx0/include/mach/io.h    |    2 --
 arch/arm/mach-netx/include/mach/io.h       |    2 --
 arch/arm/mach-nomadik/include/mach/io.h    |    2 --
 arch/arm/mach-ns9xxx/include/mach/io.h     |    1 -
 arch/arm/mach-nuc93x/include/mach/io.h     |    1 -
 arch/arm/mach-orion5x/include/mach/io.h    |    2 --
 arch/arm/mach-pnx4008/include/mach/io.h    |    2 --
 arch/arm/mach-pxa/include/mach/io.h        |    2 --
 arch/arm/mach-realview/include/mach/io.h   |    2 --
 arch/arm/mach-rpc/include/mach/io.h        |    2 --
 arch/arm/mach-s3c2410/include/mach/io.h    |    2 --
 arch/arm/mach-s3c24a0/include/mach/io.h    |    2 --
 arch/arm/mach-s3c64xx/include/mach/io.h    |    2 --
 arch/arm/mach-s5p6440/include/mach/io.h    |    2 --
 arch/arm/mach-s5p6442/include/mach/io.h    |    2 --
 arch/arm/mach-s5pc100/include/mach/io.h    |    2 --
 arch/arm/mach-s5pv210/include/mach/io.h    |    2 --
 arch/arm/mach-sa1100/include/mach/io.h     |    2 --
 arch/arm/mach-shark/include/mach/io.h      |    2 --
 arch/arm/mach-shmobile/include/mach/io.h   |    2 --
 arch/arm/mach-u300/include/mach/io.h       |    2 --
 arch/arm/mach-ux500/include/mach/io.h      |    2 --
 arch/arm/mach-versatile/include/mach/io.h  |    2 --
 arch/arm/mach-vexpress/include/mach/io.h   |    2 --
 arch/arm/mach-w90x900/include/mach/io.h    |    1 -
 arch/arm/plat-mxc/include/mach/io.h        |    2 --
 arch/arm/plat-omap/include/plat/io.h       |    2 --
 arch/arm/plat-spear/include/plat/io.h      |    2 --
 arch/arm/plat-stmp3xxx/include/mach/io.h   |    1 -
 55 files changed, 4 insertions(+), 102 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 01eec09..c5b8803 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -101,6 +101,10 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 
 #define IO_SPACE_LIMIT	0xffffffff
 
+#ifndef __mem_pci
+#define __mem_pci(a)	(a)
+#endif
+
 /*
  *  IO port access primitives
  *  -------------------------
diff --git a/arch/arm/mach-aaec2000/include/mach/io.h b/arch/arm/mach-aaec2000/include/mach/io.h
index ce19850..8b9193d 100644
--- a/arch/arm/mach-aaec2000/include/mach/io.h
+++ b/arch/arm/mach-aaec2000/include/mach/io.h
@@ -11,6 +11,4 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
index 34740b5..ab014c0 100644
--- a/arch/arm/mach-at91/include/mach/io.h
+++ b/arch/arm/mach-at91/include/mach/io.h
@@ -22,8 +22,6 @@
 #define __ASM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-bcmring/include/mach/io.h b/arch/arm/mach-bcmring/include/mach/io.h
index 1dba26d..3357d80 100644
--- a/arch/arm/mach-bcmring/include/mach/io.h
+++ b/arch/arm/mach-bcmring/include/mach/io.h
@@ -26,6 +26,4 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-clps711x/include/mach/io.h b/arch/arm/mach-clps711x/include/mach/io.h
index 2e90452..83980b6 100644
--- a/arch/arm/mach-clps711x/include/mach/io.h
+++ b/arch/arm/mach-clps711x/include/mach/io.h
@@ -21,8 +21,6 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 /*
  * We don't support ins[lb]/outs[lb].  Make them fault.
  */
diff --git a/arch/arm/mach-cns3xxx/include/mach/io.h b/arch/arm/mach-cns3xxx/include/mach/io.h
index 396b959..be5a0d2 100644
--- a/arch/arm/mach-cns3xxx/include/mach/io.h
+++ b/arch/arm/mach-cns3xxx/include/mach/io.h
@@ -10,6 +10,4 @@
 #define __MACH_IO_H
 
 #define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
index 29a866f..71d6a0d 100644
--- a/arch/arm/mach-davinci/include/mach/io.h
+++ b/arch/arm/mach-davinci/include/mach/io.h
@@ -16,7 +16,6 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
 #define __mem_isa(a)		(a)
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-dove/include/mach/io.h b/arch/arm/mach-dove/include/mach/io.h
index eaacc2a..db0cf90 100644
--- a/arch/arm/mach-dove/include/mach/io.h
+++ b/arch/arm/mach-dove/include/mach/io.h
@@ -13,6 +13,4 @@
 
 #define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
 				   DOVE_PCIE0_IO_VIRT_BASE))
-#define __mem_pci(a)		(a)
-
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
index 8931f94..b63e543 100644
--- a/arch/arm/mach-ep93xx/include/mach/io.h
+++ b/arch/arm/mach-ep93xx/include/mach/io.h
@@ -6,8 +6,6 @@
 #define __ASM_MACH_IO_H
 
 #define __io(p)			__typesafe_io(p)
-#define __mem_pci(p)		(p)
-
 /*
  * A typesafe __io() variation for variable initialisers
  */
diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
index d3b14d2..6a030d5 100644
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ b/arch/arm/mach-footbridge/include/mach/io.h
@@ -21,6 +21,4 @@
  * Translation of various region addresses to virtual addresses
  */
 #define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
-#define __mem_pci(a)		(a)
-
 #endif
diff --git a/arch/arm/mach-gemini/include/mach/io.h b/arch/arm/mach-gemini/include/mach/io.h
index 37b2896..9925714 100644
--- a/arch/arm/mach-gemini/include/mach/io.h
+++ b/arch/arm/mach-gemini/include/mach/io.h
@@ -11,6 +11,4 @@
 #define __MACH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif /* __MACH_IO_H */
diff --git a/arch/arm/mach-h720x/include/mach/io.h b/arch/arm/mach-h720x/include/mach/io.h
index 1b2229f..8745f59 100644
--- a/arch/arm/mach-h720x/include/mach/io.h
+++ b/arch/arm/mach-h720x/include/mach/io.h
@@ -15,6 +15,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/io.h b/arch/arm/mach-integrator/include/mach/io.h
index 37beed3..de4ae05 100644
--- a/arch/arm/mach-integrator/include/mach/io.h
+++ b/arch/arm/mach-integrator/include/mach/io.h
@@ -29,6 +29,4 @@
 #define PCI_IO_VADDR            0xee000000
 
 #define __io(a)			((void __iomem *)(PCI_IO_VADDR + (a)))
-#define __mem_pci(a)		(a)
-
 #endif
diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index a9368e6..c1387df 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -20,7 +20,6 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a) __iop13xx_io(a)
-#define __mem_pci(a) (a)
 #define __mem_isa(a) (a)
 
 extern void __iomem * __iop13xx_io(unsigned long io_addr);
diff --git a/arch/arm/mach-iop32x/include/mach/io.h b/arch/arm/mach-iop32x/include/mach/io.h
index 9ddc4df..907516a 100644
--- a/arch/arm/mach-iop32x/include/mach/io.h
+++ b/arch/arm/mach-iop32x/include/mach/io.h
@@ -18,8 +18,6 @@ extern void __iomem *__iop3xx_ioremap(unsigned long cookie, size_t size,
 extern void __iop3xx_iounmap(void __iomem *addr);
 
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
-#define __mem_pci(a)		(a)
-
 #define __arch_ioremap(a, s, f) __iop3xx_ioremap(a, s, f)
 #define __arch_iounmap(a)	 __iop3xx_iounmap(a)
 
diff --git a/arch/arm/mach-iop33x/include/mach/io.h b/arch/arm/mach-iop33x/include/mach/io.h
index 9c1341d..0c0dad4 100644
--- a/arch/arm/mach-iop33x/include/mach/io.h
+++ b/arch/arm/mach-iop33x/include/mach/io.h
@@ -18,8 +18,6 @@ extern void __iomem *__iop3xx_ioremap(unsigned long cookie, size_t size,
 extern void __iop3xx_iounmap(void __iomem *addr);
 
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
-#define __mem_pci(a)		(a)
-
 #define __arch_ioremap(a, s, f) __iop3xx_ioremap(a, s, f)
 #define __arch_iounmap(a)	 __iop3xx_iounmap(a)
 
diff --git a/arch/arm/mach-ixp2000/include/mach/io.h b/arch/arm/mach-ixp2000/include/mach/io.h
index e441d97..7898788 100644
--- a/arch/arm/mach-ixp2000/include/mach/io.h
+++ b/arch/arm/mach-ixp2000/include/mach/io.h
@@ -17,8 +17,6 @@
 
 #include <mach/hardware.h>
 
-#define __mem_pci(a)		(a)
-
 /*
  * The A? revisions of the IXP2000s assert byte lanes for PCI I/O
  * transactions the other way round (MEM transactions don't have this
diff --git a/arch/arm/mach-ixp23xx/include/mach/io.h b/arch/arm/mach-ixp23xx/include/mach/io.h
index 1e3752d..5d0f0b4 100644
--- a/arch/arm/mach-ixp23xx/include/mach/io.h
+++ b/arch/arm/mach-ixp23xx/include/mach/io.h
@@ -16,8 +16,6 @@
 #define __ASM_ARCH_IO_H
 
 #define __io(p)		((void __iomem*)((p) + IXP23XX_PCI_IO_VIRT))
-#define __mem_pci(a)	(a)
-
 static inline void __iomem *
 ixp23xx_ioremap(unsigned long addr, unsigned long size, unsigned int mtype)
 {
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 72af996..7489f8f 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -41,8 +41,6 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
  */
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 
-#define __mem_pci(a)		(a)
-
 #else
 
 /*
diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-kirkwood/include/mach/io.h
index 68560bf..be41fb2 100644
--- a/arch/arm/mach-kirkwood/include/mach/io.h
+++ b/arch/arm/mach-kirkwood/include/mach/io.h
@@ -43,7 +43,5 @@ __arch_iounmap(void __iomem *addr)
 #define __arch_ioremap(p, s, m)	__arch_ioremap(p, s, m)
 #define __arch_iounmap(a)	__arch_iounmap(a)
 #define __io(a)			__io(a)
-#define __mem_pci(a)		(a)
-
 
 #endif
diff --git a/arch/arm/mach-ks8695/include/mach/io.h b/arch/arm/mach-ks8695/include/mach/io.h
index 1b2e825..d2029d3 100644
--- a/arch/arm/mach-ks8695/include/mach/io.h
+++ b/arch/arm/mach-ks8695/include/mach/io.h
@@ -12,6 +12,4 @@
 #define __ASM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-l7200/include/mach/io.h b/arch/arm/mach-l7200/include/mach/io.h
index 814c0b3..13b6e5c 100644
--- a/arch/arm/mach-l7200/include/mach/io.h
+++ b/arch/arm/mach-l7200/include/mach/io.h
@@ -14,6 +14,4 @@
  * There are not real ISA nor PCI buses, so we fake it.
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-lh7a40x/include/mach/io.h b/arch/arm/mach-lh7a40x/include/mach/io.h
index f64cde6..4de858b 100644
--- a/arch/arm/mach-lh7a40x/include/mach/io.h
+++ b/arch/arm/mach-lh7a40x/include/mach/io.h
@@ -13,6 +13,4 @@
 
 /* No ISA or PCI bus on this machine. */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif /* __ASM_ARCH_IO_H */
diff --git a/arch/arm/mach-loki/include/mach/io.h b/arch/arm/mach-loki/include/mach/io.h
index ea63e33..b35cdf6 100644
--- a/arch/arm/mach-loki/include/mach/io.h
+++ b/arch/arm/mach-loki/include/mach/io.h
@@ -18,7 +18,5 @@ static inline void __iomem *__io(unsigned long addr)
 }
 
 #define __io(a)			__io(a)
-#define __mem_pci(a)		(a)
-
 
 #endif
diff --git a/arch/arm/mach-mmp/include/mach/io.h b/arch/arm/mach-mmp/include/mach/io.h
index dc24d77..e9581d5 100644
--- a/arch/arm/mach-mmp/include/mach/io.h
+++ b/arch/arm/mach-mmp/include/mach/io.h
@@ -14,6 +14,4 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index 40698df..5e0e93d 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -22,8 +22,6 @@
 void __iomem *__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype);
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)    (a)
-
 void msm_map_qsd8x50_io(void);
 void msm_map_msm7x30_io(void);
 
diff --git a/arch/arm/mach-mv78xx0/include/mach/io.h b/arch/arm/mach-mv78xx0/include/mach/io.h
index a92df8c..da6fa21 100644
--- a/arch/arm/mach-mv78xx0/include/mach/io.h
+++ b/arch/arm/mach-mv78xx0/include/mach/io.h
@@ -18,7 +18,5 @@ static inline void __iomem *__io(unsigned long addr)
 }
 
 #define __io(a)			__io(a)
-#define __mem_pci(a)		(a)
-
 
 #endif
diff --git a/arch/arm/mach-netx/include/mach/io.h b/arch/arm/mach-netx/include/mach/io.h
index a1b7e23..ac134a8 100644
--- a/arch/arm/mach-netx/include/mach/io.h
+++ b/arch/arm/mach-netx/include/mach/io.h
@@ -21,6 +21,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)            (a)
-
 #endif
diff --git a/arch/arm/mach-nomadik/include/mach/io.h b/arch/arm/mach-nomadik/include/mach/io.h
index d988297..a2b9e1a 100644
--- a/arch/arm/mach-nomadik/include/mach/io.h
+++ b/arch/arm/mach-nomadik/include/mach/io.h
@@ -15,6 +15,4 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)         __typesafe_io(a)
-#define __mem_pci(a)    (a)
-
 #endif
diff --git a/arch/arm/mach-ns9xxx/include/mach/io.h b/arch/arm/mach-ns9xxx/include/mach/io.h
index fb401c9..edb9cdd 100644
--- a/arch/arm/mach-ns9xxx/include/mach/io.h
+++ b/arch/arm/mach-ns9xxx/include/mach/io.h
@@ -12,7 +12,6 @@
 #define __ASM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)    (a)
 #define __mem_isa(a)    (IO_BASE + (a))
 
 #endif /* ifndef __ASM_ARCH_IO_H */
diff --git a/arch/arm/mach-nuc93x/include/mach/io.h b/arch/arm/mach-nuc93x/include/mach/io.h
index 2d0d853..99fe76d 100644
--- a/arch/arm/mach-nuc93x/include/mach/io.h
+++ b/arch/arm/mach-nuc93x/include/mach/io.h
@@ -20,7 +20,6 @@
  * 1:1 mapping for ioremapped regions.
  */
 
-#define __mem_pci(a)	(a)
 #define __io(a)		__typesafe_io(a)
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
index 839b888..34c2a5c 100644
--- a/arch/arm/mach-orion5x/include/mach/io.h
+++ b/arch/arm/mach-orion5x/include/mach/io.h
@@ -39,8 +39,6 @@ __arch_iounmap(void __iomem *addr)
 #define __arch_ioremap(p, s, m)	__arch_ioremap(p, s, m)
 #define __arch_iounmap(a)	__arch_iounmap(a)
 #define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-
 
 /*****************************************************************************
  * Helpers to access Orion registers
diff --git a/arch/arm/mach-pnx4008/include/mach/io.h b/arch/arm/mach-pnx4008/include/mach/io.h
index 76d5bca..bd655e5 100644
--- a/arch/arm/mach-pnx4008/include/mach/io.h
+++ b/arch/arm/mach-pnx4008/include/mach/io.h
@@ -14,6 +14,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/io.h b/arch/arm/mach-pxa/include/mach/io.h
index fedd427..5bfd427 100644
--- a/arch/arm/mach-pxa/include/mach/io.h
+++ b/arch/arm/mach-pxa/include/mach/io.h
@@ -11,6 +11,4 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
index 2bdf15d..cc45381 100644
--- a/arch/arm/mach-realview/include/mach/io.h
+++ b/arch/arm/mach-realview/include/mach/io.h
@@ -21,6 +21,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-rpc/include/mach/io.h b/arch/arm/mach-rpc/include/mach/io.h
index 3ccc17d..5881e43 100644
--- a/arch/arm/mach-rpc/include/mach/io.h
+++ b/arch/arm/mach-rpc/include/mach/io.h
@@ -206,6 +206,4 @@ DECLARE_IO(int,l,"")
 /*
  * 1:1 mapping for ioremapped regions.
  */
-#define __mem_pci(x)	(x)
-
 #endif
diff --git a/arch/arm/mach-s3c2410/include/mach/io.h b/arch/arm/mach-s3c2410/include/mach/io.h
index d9ba838..7ff5def 100644
--- a/arch/arm/mach-s3c2410/include/mach/io.h
+++ b/arch/arm/mach-s3c2410/include/mach/io.h
@@ -211,6 +211,4 @@ DECLARE_IO(int,l,"")
 /*
  * 1:1 mapping for ioremapped regions.
  */
-#define __mem_pci(x)	(x)
-
 #endif
diff --git a/arch/arm/mach-s3c24a0/include/mach/io.h b/arch/arm/mach-s3c24a0/include/mach/io.h
index 4ad89b9..e04664f 100644
--- a/arch/arm/mach-s3c24a0/include/mach/io.h
+++ b/arch/arm/mach-s3c24a0/include/mach/io.h
@@ -11,6 +11,4 @@
 
 /* No current ISA/PCI bus support. */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-s3c64xx/include/mach/io.h b/arch/arm/mach-s3c64xx/include/mach/io.h
index 1e9625c..eb4dae8 100644
--- a/arch/arm/mach-s3c64xx/include/mach/io.h
+++ b/arch/arm/mach-s3c64xx/include/mach/io.h
@@ -11,6 +11,4 @@
 
 /* No current ISA/PCI bus support. */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-s5p6440/include/mach/io.h b/arch/arm/mach-s5p6440/include/mach/io.h
index 72611ec..10e18d3 100644
--- a/arch/arm/mach-s5p6440/include/mach/io.h
+++ b/arch/arm/mach-s5p6440/include/mach/io.h
@@ -11,6 +11,4 @@
 
 /* No current ISA/PCI bus support. */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-s5p6442/include/mach/io.h b/arch/arm/mach-s5p6442/include/mach/io.h
index 7c1cb7c..02cacba 100644
--- a/arch/arm/mach-s5p6442/include/mach/io.h
+++ b/arch/arm/mach-s5p6442/include/mach/io.h
@@ -10,6 +10,4 @@
 
 /* No current ISA/PCI bus support. */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-s5pc100/include/mach/io.h b/arch/arm/mach-s5pc100/include/mach/io.h
index 25a0e92..d0970e4 100644
--- a/arch/arm/mach-s5pc100/include/mach/io.h
+++ b/arch/arm/mach-s5pc100/include/mach/io.h
@@ -11,6 +11,4 @@
 
 /* No current ISA/PCI bus support. */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-s5pv210/include/mach/io.h b/arch/arm/mach-s5pv210/include/mach/io.h
index 32ff10e..f80590e 100644
--- a/arch/arm/mach-s5pv210/include/mach/io.h
+++ b/arch/arm/mach-s5pv210/include/mach/io.h
@@ -19,6 +19,4 @@
 
 /* No current ISA/PCI bus support. */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-sa1100/include/mach/io.h b/arch/arm/mach-sa1100/include/mach/io.h
index bb1be3f..0817eb0 100644
--- a/arch/arm/mach-sa1100/include/mach/io.h
+++ b/arch/arm/mach-sa1100/include/mach/io.h
@@ -15,6 +15,4 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-shark/include/mach/io.h b/arch/arm/mach-shark/include/mach/io.h
index 9e09e10..0950cc1 100644
--- a/arch/arm/mach-shark/include/mach/io.h
+++ b/arch/arm/mach-shark/include/mach/io.h
@@ -13,6 +13,4 @@
 
 #define __io(a)                 ((void __iomem *)(0xe0000000 + (a)))
 
-#define __mem_pci(addr) (addr)
-
 #endif
diff --git a/arch/arm/mach-shmobile/include/mach/io.h b/arch/arm/mach-shmobile/include/mach/io.h
index 7b4d896..3e29649 100644
--- a/arch/arm/mach-shmobile/include/mach/io.h
+++ b/arch/arm/mach-shmobile/include/mach/io.h
@@ -2,6 +2,4 @@
 #define __ASM_MACH_IO_H
 
 #define __io(a)			((void __iomem *)(a))
-#define __mem_pci(a)		(a)
-
 #endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-u300/include/mach/io.h b/arch/arm/mach-u300/include/mach/io.h
index 49a1ceb..6770eea 100644
--- a/arch/arm/mach-u300/include/mach/io.h
+++ b/arch/arm/mach-u300/include/mach/io.h
@@ -13,6 +13,4 @@
 #define __MACH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/io.h b/arch/arm/mach-ux500/include/mach/io.h
index 03504ff..16acb3b 100644
--- a/arch/arm/mach-ux500/include/mach/io.h
+++ b/arch/arm/mach-ux500/include/mach/io.h
@@ -15,6 +15,4 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
index e87fb4a..25c902a 100644
--- a/arch/arm/mach-versatile/include/mach/io.h
+++ b/arch/arm/mach-versatile/include/mach/io.h
@@ -21,6 +21,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-vexpress/include/mach/io.h b/arch/arm/mach-vexpress/include/mach/io.h
index 13522d8..2b73325 100644
--- a/arch/arm/mach-vexpress/include/mach/io.h
+++ b/arch/arm/mach-vexpress/include/mach/io.h
@@ -21,6 +21,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/mach-w90x900/include/mach/io.h b/arch/arm/mach-w90x900/include/mach/io.h
index 062d401..272f76b 100644
--- a/arch/arm/mach-w90x900/include/mach/io.h
+++ b/arch/arm/mach-w90x900/include/mach/io.h
@@ -22,7 +22,6 @@
  * 1:1 mapping for ioremapped regions.
  */
 
-#define __mem_pci(a)	(a)
 #define __io(a)		__typesafe_io(a)
 
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/io.h b/arch/arm/plat-mxc/include/mach/io.h
index 18ab5ff..ed05017 100644
--- a/arch/arm/plat-mxc/include/mach/io.h
+++ b/arch/arm/plat-mxc/include/mach/io.h
@@ -35,6 +35,4 @@ __mx3_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 /* io address mapping macro */
 #define __io(a)		__typesafe_io(a)
 
-#define __mem_pci(a)	(a)
-
 #endif
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index bb3f68f..a9beb3c 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -44,8 +44,6 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
 /*
  * ----------------------------------------------------------------------------
  * I/O mapping
diff --git a/arch/arm/plat-spear/include/plat/io.h b/arch/arm/plat-spear/include/plat/io.h
index 4358221..faf8e7e 100644
--- a/arch/arm/plat-spear/include/plat/io.h
+++ b/arch/arm/plat-spear/include/plat/io.h
@@ -15,6 +15,4 @@
 #define __PLAT_IO_H
 
 #define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-
 #endif /* __PLAT_IO_H */
diff --git a/arch/arm/plat-stmp3xxx/include/mach/io.h b/arch/arm/plat-stmp3xxx/include/mach/io.h
index ccf0246..73817a1 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/io.h
+++ b/arch/arm/plat-stmp3xxx/include/mach/io.h
@@ -17,7 +17,6 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a) 	__typesafe_io(a)
-#define __mem_pci(a)	(a)
 #define __mem_isa(a)	(a)
 
 #endif
-- 
1.7.1
