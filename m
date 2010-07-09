From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 12:08:14 +0100
Subject: [PATCH v2 3/3] ARM: Add barriers to the I/O accessors if
	ARM_DMA_MEM_BUFFERABLE
In-Reply-To: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100709110814.11333.83771.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the coherent DMA buffers are mapped as Normal Non-cacheable
(ARM_DMA_MEM_BUFFERABLE enabled), buffer accesses are no longer ordered
with Device memory accesses causing failures in device drivers that do
not use the mandatory memory barriers before starting a DMA transfer.
LKML discussions led to the conclusion that such barriers have to be
added to the I/O accessors:

http://thread.gmane.org/gmane.linux.kernel/683509/focus=686153
http://thread.gmane.org/gmane.linux.ide/46414
http://thread.gmane.org/gmane.linux.kernel.cross-arch/5250

This patch introduces a wmb() barrier to the write*() I/O accessors to
handle the situations where Normal Non-cacheable writes are still in the
processor (or L2 cache controller) write buffer before a DMA transfer
command is issued. For the read*() accessors, a rmb() is introduced
after the I/O to avoid speculative loads where the driver polls for a
DMA transfer ready bit.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/io.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 97fb9aa..8f3edef 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -191,6 +191,15 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writel_relaxed(v,c)	__raw_writel((__force u32) \
 					cpu_to_le32(v),__mem_pci(c))
 
+#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
+#define readb(c)		({ u8  __v = readb_relaxed(c); rmb(); __v; })
+#define readw(c)		({ u16 __v = readw_relaxed(c); rmb(); __v; })
+#define readl(c)		({ u32 __v = readl_relaxed(c); rmb(); __v; })
+
+#define writeb(v,c)		do { wmb(); writeb_relaxed(v,c); } while (0)
+#define writew(v,c)		do { wmb(); writew_relaxed(v,c); } while (0)
+#define writel(v,c)		do { wmb(); writel_relaxed(v,c); } while (0)
+#else
 #define readb(c)		readb_relaxed(c)
 #define readw(c)		readw_relaxed(c)
 #define readl(c)		readl_relaxed(c)
@@ -198,6 +207,7 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writeb(v,c)		writeb_relaxed(v,c)
 #define writew(v,c)		writew_relaxed(v,c)
 #define writel(v,c)		writel_relaxed(v,c)
+#endif
 
 #define readsb(p,d,l)		__raw_readsb(__mem_pci(p),d,l)
 #define readsw(p,d,l)		__raw_readsw(__mem_pci(p),d,l)
