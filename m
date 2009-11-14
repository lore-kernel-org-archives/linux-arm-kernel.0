From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 00:05:05 +0100
Subject: [PATCH] ARM: Introduce HAVE_IOREAD_AND_IOWRITE macro.
Message-ID: <m3zl6owvvi.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define HAVE_IOREAD_AND_IOWRITE macro to indicate that the architecture has its
own set of ioread*() and iowrite*() routines and doesn't need the generic one
in arch/arm/include/asm/io.h.

Previously the ioread8 existence was tested, but it may be a function instead
of a macro (I want to get rid of IXP4xx ioread*/iowrite* macros).

Comments?

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -236,7 +236,7 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 /*
  * io{read,write}{8,16,32} macros
  */
-#ifndef ioread8
+#ifndef HAVE_IOREAD_AND_IOWRITE
 #define ioread8(p)	({ unsigned int __v = __raw_readb(p); __v; })
 #define ioread16(p)	({ unsigned int __v = le16_to_cpu((__force __le16)__raw_readw(p)); __v; })
 #define ioread32(p)	({ unsigned int __v = le32_to_cpu((__force __le32)__raw_readl(p)); __v; })
--- a/arch/arm/mach-ixp2000/include/mach/io.h
+++ b/arch/arm/mach-ixp2000/include/mach/io.h
@@ -123,6 +123,8 @@
 		}						\
 	})
 
+#define HAVE_IOREAD_AND_IOWRITE
+
 #define ioport_map(port, nr)	___io(port)
 
 #define ioport_unmap(addr)
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -553,6 +553,8 @@ __ixp4xx_iowrite32_rep(void __iomem *addr, const void *vaddr, u32 count)
 #define	iowrite16_rep(p, v, c)		__ixp4xx_iowrite16_rep(p, v, c)
 #define	iowrite32_rep(p, v, c)		__ixp4xx_iowrite32_rep(p, v, c)
 
+#define HAVE_IOREAD_AND_IOWRITE
+
 #define	ioport_map(port, nr)		((void __iomem*)(port + PIO_OFFSET))
 #define	ioport_unmap(addr)
 #endif	// !CONFIG_PCI
