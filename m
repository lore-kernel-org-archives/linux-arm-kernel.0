From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 14:20:19 +0100
Subject: [RFC PATCH 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <20100705130010.5157.32032.stgit@e102109-lin.cambridge.arm.com>
References: <20100705130010.5157.32032.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100705132018.5157.21932.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces readl*_relaxed()/write*_relaxed() as the main I/O
accessors (when __mem_pci is defined). The standard read*()/write*()
macros are now based on the relaxed accessors.

This patch is in preparation for a subsequent patch which adds barriers
to the I/O accessors.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/io.h |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c980156..97fb9aa 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -179,25 +179,30 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * IO port primitives for more information.
  */
 #ifdef __mem_pci
-#define readb(c) ({ __u8  __v = __raw_readb(__mem_pci(c)); __v; })
-#define readw(c) ({ __u16 __v = le16_to_cpu((__force __le16) \
+#define readb_relaxed(c) ({ u8  __v = __raw_readb(__mem_pci(c)); __v; })
+#define readw_relaxed(c) ({ u16 __v = le16_to_cpu((__force __le16) \
 					__raw_readw(__mem_pci(c))); __v; })
-#define readl(c) ({ __u32 __v = le32_to_cpu((__force __le32) \
+#define readl_relaxed(c) ({ u32 __v = le32_to_cpu((__force __le32) \
 					__raw_readl(__mem_pci(c))); __v; })
-#define readb_relaxed(addr) readb(addr)
-#define readw_relaxed(addr) readw(addr)
-#define readl_relaxed(addr) readl(addr)
+
+#define writeb_relaxed(v,c)	__raw_writeb(v,__mem_pci(c))
+#define writew_relaxed(v,c)	__raw_writew((__force u16) \
+					cpu_to_le16(v),__mem_pci(c))
+#define writel_relaxed(v,c)	__raw_writel((__force u32) \
+					cpu_to_le32(v),__mem_pci(c))
+
+#define readb(c)		readb_relaxed(c)
+#define readw(c)		readw_relaxed(c)
+#define readl(c)		readl_relaxed(c)
+
+#define writeb(v,c)		writeb_relaxed(v,c)
+#define writew(v,c)		writew_relaxed(v,c)
+#define writel(v,c)		writel_relaxed(v,c)
 
 #define readsb(p,d,l)		__raw_readsb(__mem_pci(p),d,l)
 #define readsw(p,d,l)		__raw_readsw(__mem_pci(p),d,l)
 #define readsl(p,d,l)		__raw_readsl(__mem_pci(p),d,l)
 
-#define writeb(v,c)		__raw_writeb(v,__mem_pci(c))
-#define writew(v,c)		__raw_writew((__force __u16) \
-					cpu_to_le16(v),__mem_pci(c))
-#define writel(v,c)		__raw_writel((__force __u32) \
-					cpu_to_le32(v),__mem_pci(c))
-
 #define writesb(p,d,l)		__raw_writesb(__mem_pci(p),d,l)
 #define writesw(p,d,l)		__raw_writesw(__mem_pci(p),d,l)
 #define writesl(p,d,l)		__raw_writesl(__mem_pci(p),d,l)
