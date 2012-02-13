From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:28 -0600
Subject: [PATCH 15/15] ARM: kill off __mem_pci
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-16-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

__mem_pci is only used to enable readl/writel and friends. Just condition
this on readl being defined and remove all the __mem_pci defines.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/io.h                  |   46 ++++++++++-----------------
 arch/arm/mach-dove/include/mach/io.h       |    1 -
 arch/arm/mach-footbridge/include/mach/io.h |   13 --------
 arch/arm/mach-integrator/include/mach/io.h |    1 -
 arch/arm/mach-iop13xx/include/mach/io.h    |    2 -
 arch/arm/mach-iop32x/include/mach/io.h     |    1 -
 arch/arm/mach-iop33x/include/mach/io.h     |    1 -
 arch/arm/mach-ixp2000/include/mach/io.h    |    1 -
 arch/arm/mach-ixp23xx/include/mach/io.h    |    1 -
 arch/arm/mach-ixp4xx/include/mach/io.h     |    6 +---
 arch/arm/mach-kirkwood/include/mach/io.h   |    2 -
 arch/arm/mach-mv78xx0/include/mach/io.h    |    2 -
 arch/arm/mach-rpc/include/mach/io.h        |    5 ---
 arch/arm/mach-s3c2410/include/mach/io.h    |    5 ---
 arch/arm/mach-shark/include/mach/io.h      |    2 -
 arch/arm/mach-tegra/include/mach/io.h      |    1 -
 arch/arm/mach-vt8500/include/mach/io.h     |    1 -
 17 files changed, 18 insertions(+), 73 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 5e0ca53..0f506a8 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -113,7 +113,6 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #include <mach/io.h>
 #else
 #define __io(a)		({ (void)(a); __typesafe_io(0); })
-#define __mem_pci(a)	(a)
 #endif
 
 /*
@@ -216,18 +215,18 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * Again, this are defined to perform little endian accesses.  See the
  * IO port primitives for more information.
  */
-#ifdef __mem_pci
-#define readb_relaxed(c) ({ u8  __r = __raw_readb(__mem_pci(c)); __r; })
+#ifndef readl
+#define readb_relaxed(c) ({ u8  __r = __raw_readb(c); __r; })
 #define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
-					__raw_readw(__mem_pci(c))); __r; })
+					__raw_readw(c)); __r; })
 #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
-					__raw_readl(__mem_pci(c))); __r; })
+					__raw_readl(c)); __r; })
 
-#define writeb_relaxed(v,c)	((void)__raw_writeb(v,__mem_pci(c)))
+#define writeb_relaxed(v,c)	((void)__raw_writeb(v,c))
 #define writew_relaxed(v,c)	((void)__raw_writew((__force u16) \
-					cpu_to_le16(v),__mem_pci(c)))
+					cpu_to_le16(v),c))
 #define writel_relaxed(v,c)	((void)__raw_writel((__force u32) \
-					cpu_to_le32(v),__mem_pci(c)))
+					cpu_to_le32(v),c))
 
 #define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
 #define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
@@ -237,30 +236,19 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
 #define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
 
-#define readsb(p,d,l)		__raw_readsb(__mem_pci(p),d,l)
-#define readsw(p,d,l)		__raw_readsw(__mem_pci(p),d,l)
-#define readsl(p,d,l)		__raw_readsl(__mem_pci(p),d,l)
+#define readsb(p,d,l)		__raw_readsb(p,d,l)
+#define readsw(p,d,l)		__raw_readsw(p,d,l)
+#define readsl(p,d,l)		__raw_readsl(p,d,l)
 
-#define writesb(p,d,l)		__raw_writesb(__mem_pci(p),d,l)
-#define writesw(p,d,l)		__raw_writesw(__mem_pci(p),d,l)
-#define writesl(p,d,l)		__raw_writesl(__mem_pci(p),d,l)
+#define writesb(p,d,l)		__raw_writesb(p,d,l)
+#define writesw(p,d,l)		__raw_writesw(p,d,l)
+#define writesl(p,d,l)		__raw_writesl(p,d,l)
 
-#define memset_io(c,v,l)	_memset_io(__mem_pci(c),(v),(l))
-#define memcpy_fromio(a,c,l)	_memcpy_fromio((a),__mem_pci(c),(l))
-#define memcpy_toio(c,a,l)	_memcpy_toio(__mem_pci(c),(a),(l))
+#define memset_io(c,v,l)	_memset_io(c,(v),(l))
+#define memcpy_fromio(a,c,l)	_memcpy_fromio((a),c,(l))
+#define memcpy_toio(c,a,l)	_memcpy_toio(c,(a),(l))
 
-#elif !defined(readb)
-
-#define readb(c)			(__readwrite_bug("readb"),0)
-#define readw(c)			(__readwrite_bug("readw"),0)
-#define readl(c)			(__readwrite_bug("readl"),0)
-#define writeb(v,c)			__readwrite_bug("writeb")
-#define writew(v,c)			__readwrite_bug("writew")
-#define writel(v,c)			__readwrite_bug("writel")
-
-#define check_signature(io,sig,len)	(0)
-
-#endif	/* __mem_pci */
+#endif	/* readl */
 
 /*
  * ioremap and friends.
diff --git a/arch/arm/mach-dove/include/mach/io.h b/arch/arm/mach-dove/include/mach/io.h
index eb4936f..29c8b85 100644
--- a/arch/arm/mach-dove/include/mach/io.h
+++ b/arch/arm/mach-dove/include/mach/io.h
@@ -15,6 +15,5 @@
 
 #define __io(a)  	((void __iomem *)(((a) - DOVE_PCIE0_IO_BUS_BASE) + \
 						 DOVE_PCIE0_IO_VIRT_BASE))
-#define __mem_pci(a)	(a)
 
 #endif
diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
index 15a7039..aba531ee 100644
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ b/arch/arm/mach-footbridge/include/mach/io.h
@@ -27,18 +27,5 @@
  * Translation of various region addresses to virtual addresses
  */
 #define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
-#if 1
-#define __mem_pci(a)		(a)
-#else
-
-static inline void __iomem *___mem_pci(void __iomem *p)
-{
-	unsigned long a = (unsigned long)p;
-	BUG_ON(a <= 0xc0000000 || a >= 0xe0000000);
-	return p;
-}
-
-#define __mem_pci(a)		___mem_pci(a)
-#endif
 
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/io.h b/arch/arm/mach-integrator/include/mach/io.h
index 37beed3..8de70de 100644
--- a/arch/arm/mach-integrator/include/mach/io.h
+++ b/arch/arm/mach-integrator/include/mach/io.h
@@ -29,6 +29,5 @@
 #define PCI_IO_VADDR            0xee000000
 
 #define __io(a)			((void __iomem *)(PCI_IO_VADDR + (a)))
-#define __mem_pci(a)		(a)
 
 #endif
diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index dffb234..858ba98 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -22,8 +22,6 @@
 #define IO_SPACE_LIMIT 0xffffffff
 
 #define __io(a) __iop13xx_io(a)
-#define __mem_pci(a) (a)
-#define __mem_isa(a) (a)
 
 extern void __iomem * __iop13xx_io(unsigned long io_addr);
 extern void __iomem *__iop13xx_ioremap(unsigned long cookie, size_t size,
diff --git a/arch/arm/mach-iop32x/include/mach/io.h b/arch/arm/mach-iop32x/include/mach/io.h
index 2d88264..e2ada26 100644
--- a/arch/arm/mach-iop32x/include/mach/io.h
+++ b/arch/arm/mach-iop32x/include/mach/io.h
@@ -15,6 +15,5 @@
 
 #define IO_SPACE_LIMIT		0xffffffff
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
-#define __mem_pci(a)		(a)
 
 #endif
diff --git a/arch/arm/mach-iop33x/include/mach/io.h b/arch/arm/mach-iop33x/include/mach/io.h
index a8a66fc..f7c1b65 100644
--- a/arch/arm/mach-iop33x/include/mach/io.h
+++ b/arch/arm/mach-iop33x/include/mach/io.h
@@ -15,6 +15,5 @@
 
 #define IO_SPACE_LIMIT		0xffffffff
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
-#define __mem_pci(a)		(a)
 
 #endif
diff --git a/arch/arm/mach-ixp2000/include/mach/io.h b/arch/arm/mach-ixp2000/include/mach/io.h
index 859e584..f6552d6 100644
--- a/arch/arm/mach-ixp2000/include/mach/io.h
+++ b/arch/arm/mach-ixp2000/include/mach/io.h
@@ -18,7 +18,6 @@
 #include <mach/hardware.h>
 
 #define IO_SPACE_LIMIT		0xffffffff
-#define __mem_pci(a)		(a)
 
 /*
  * The A? revisions of the IXP2000s assert byte lanes for PCI I/O
diff --git a/arch/arm/mach-ixp23xx/include/mach/io.h b/arch/arm/mach-ixp23xx/include/mach/io.h
index 4ce4353..a7aceb5 100644
--- a/arch/arm/mach-ixp23xx/include/mach/io.h
+++ b/arch/arm/mach-ixp23xx/include/mach/io.h
@@ -18,6 +18,5 @@
 #define IO_SPACE_LIMIT 0xffffffff
 
 #define __io(p)		((void __iomem*)((p) + IXP23XX_PCI_IO_VIRT))
-#define __mem_pci(a)	(a)
 
 #endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index ffb9d6a..d76a9bb 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -39,11 +39,7 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
  *    but in some cases the performance hit is acceptable. In addition, you
  *    cannot mmap() PCI devices in this case.
  */
-#ifndef	CONFIG_IXP4XX_INDIRECT_PCI
-
-#define __mem_pci(a)		(a)
-
-#else
+#ifdef	CONFIG_IXP4XX_INDIRECT_PCI
 
 /*
  * In the case of using indirect PCI, we simply return the actual PCI
diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-kirkwood/include/mach/io.h
index 49dd0cb..5d0ab61 100644
--- a/arch/arm/mach-kirkwood/include/mach/io.h
+++ b/arch/arm/mach-kirkwood/include/mach/io.h
@@ -20,7 +20,5 @@ static inline void __iomem *__io(unsigned long addr)
 }
 
 #define __io(a)			__io(a)
-#define __mem_pci(a)		(a)
-
 
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/io.h b/arch/arm/mach-mv78xx0/include/mach/io.h
index 450e0e1..c7d9d00 100644
--- a/arch/arm/mach-mv78xx0/include/mach/io.h
+++ b/arch/arm/mach-mv78xx0/include/mach/io.h
@@ -20,7 +20,5 @@ static inline void __iomem *__io(unsigned long addr)
 }
 
 #define __io(a)			__io(a)
-#define __mem_pci(a)		(a)
-
 
 #endif
diff --git a/arch/arm/mach-rpc/include/mach/io.h b/arch/arm/mach-rpc/include/mach/io.h
index 695f4ed..707071a 100644
--- a/arch/arm/mach-rpc/include/mach/io.h
+++ b/arch/arm/mach-rpc/include/mach/io.h
@@ -28,9 +28,4 @@
  */
 #define __io(a)		(PCIO_BASE + ((a) << 2))
 
-/*
- * 1:1 mapping for ioremapped regions.
- */
-#define __mem_pci(x)	(x)
-
 #endif
diff --git a/arch/arm/mach-s3c2410/include/mach/io.h b/arch/arm/mach-s3c2410/include/mach/io.h
index 118749f..5dd1db4 100644
--- a/arch/arm/mach-s3c2410/include/mach/io.h
+++ b/arch/arm/mach-s3c2410/include/mach/io.h
@@ -208,9 +208,4 @@ DECLARE_IO(int,l,"")
 #define outsw(p,d,l)	__raw_writesw(__ioaddr(p),d,l)
 #define outsl(p,d,l)	__raw_writesl(__ioaddr(p),d,l)
 
-/*
- * 1:1 mapping for ioremapped regions.
- */
-#define __mem_pci(x)	(x)
-
 #endif
diff --git a/arch/arm/mach-shark/include/mach/io.h b/arch/arm/mach-shark/include/mach/io.h
index 9ccbcec..1a45fc0 100644
--- a/arch/arm/mach-shark/include/mach/io.h
+++ b/arch/arm/mach-shark/include/mach/io.h
@@ -15,6 +15,4 @@
 
 #define __io(a)                 ((void __iomem *)(0xe0000000 + (a)))
 
-#define __mem_pci(addr) (addr)
-
 #endif
diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
index 47b4b61..fe700f9 100644
--- a/arch/arm/mach-tegra/include/mach/io.h
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -40,7 +40,6 @@ static inline void __iomem *__io(unsigned long addr)
 #endif
 
 #define __io(a)         __io(a)
-#define __mem_pci(a)    (a)
 
 #endif
 
diff --git a/arch/arm/mach-vt8500/include/mach/io.h b/arch/arm/mach-vt8500/include/mach/io.h
index 46181ee..fe30fa9 100644
--- a/arch/arm/mach-vt8500/include/mach/io.h
+++ b/arch/arm/mach-vt8500/include/mach/io.h
@@ -21,6 +21,5 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io((a) + 0xf0000000)
-#define __mem_pci(a)	(a)
 
 #endif
-- 
1.7.5.4
