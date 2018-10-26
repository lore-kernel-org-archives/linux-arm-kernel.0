From: peng.ma@nxp.com (Peng Ma)
Date: Fri, 26 Oct 2018 17:52:35 +0800
Subject: [PATCH 2/7] dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement
 for ARM platform
In-Reply-To: <20181026095240.33668-1-peng.ma@nxp.com>
References: <20181026095240.33668-1-peng.ma@nxp.com>
Message-ID: <20181026095240.33668-2-peng.ma@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the macro FSL_DMA_IN/OUT implement for ARM platform.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
change in v10:
	- fixed compile warning on powerpc

 drivers/dma/fsldma.h |   61 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 982845b..88db939 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -196,39 +196,62 @@ struct fsldma_chan {
 #define to_fsl_desc(lh) container_of(lh, struct fsl_desc_sw, node)
 #define tx_to_fsl_desc(tx) container_of(tx, struct fsl_desc_sw, async_tx)
 
+#ifdef	CONFIG_PPC
+#define fsl_ioread32(p)		in_le32(p)
+#define fsl_ioread32be(p)	in_be32(p)
+#define fsl_iowrite32(v, p)	out_le32(p, v)
+#define fsl_iowrite32be(v, p)	out_be32(p, v)
+
 #ifndef __powerpc64__
-static u64 in_be64(const u64 __iomem *addr)
+static u64 fsl_ioread64(const u64 __iomem *addr)
 {
-	return ((u64)in_be32((u32 __iomem *)addr) << 32) |
-		(in_be32((u32 __iomem *)addr + 1));
+	u32 fsl_addr = lower_32_bits(addr);
+	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
+
+	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
 }
 
-static void out_be64(u64 __iomem *addr, u64 val)
+static void fsl_iowrite64(u64 val, u64 __iomem *addr)
 {
-	out_be32((u32 __iomem *)addr, val >> 32);
-	out_be32((u32 __iomem *)addr + 1, (u32)val);
+	out_le32((u32 __iomem *)addr + 1, val >> 32);
+	out_le32((u32 __iomem *)addr, (u32)val);
 }
 
-/* There is no asm instructions for 64 bits reverse loads and stores */
-static u64 in_le64(const u64 __iomem *addr)
+static u64 fsl_ioread64be(const u64 __iomem *addr)
 {
-	return ((u64)in_le32((u32 __iomem *)addr + 1) << 32) |
-		(in_le32((u32 __iomem *)addr));
+	u32 fsl_addr = lower_32_bits(addr);
+	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
+
+	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
 }
 
-static void out_le64(u64 __iomem *addr, u64 val)
+static void fsl_iowrite64be(u64 val, u64 __iomem *addr)
 {
-	out_le32((u32 __iomem *)addr + 1, val >> 32);
-	out_le32((u32 __iomem *)addr, (u32)val);
+	out_be32((u32 __iomem *)addr, val >> 32);
+	out_be32((u32 __iomem *)addr + 1, (u32)val);
 }
 #endif
+#endif
 
-#define FSL_DMA_IN(fsl_chan, addr, width)				\
-		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-			in_be##width(addr) : in_le##width(addr))
-#define FSL_DMA_OUT(fsl_chan, addr, val, width)			\
-		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-			out_be##width(addr, val) : out_le##width(addr, val))
+#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
+#define fsl_ioread32(p)		ioread32(p)
+#define fsl_ioread32be(p)	ioread32be(p)
+#define fsl_iowrite32(v, p)	iowrite32(v, p)
+#define fsl_iowrite32be(v, p)	iowrite32be(v, p)
+#define fsl_ioread64(p)		ioread64(p)
+#define fsl_ioread64be(p)	ioread64be(p)
+#define fsl_iowrite64(v, p)	iowrite64(v, p)
+#define fsl_iowrite64be(v, p)	iowrite64be(v, p)
+#endif
+
+#define FSL_DMA_IN(fsl_dma, addr, width)			\
+		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
+			fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
+
+#define FSL_DMA_OUT(fsl_dma, addr, val, width)			\
+		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
+			fsl_iowrite##width##be(val, addr) : fsl_iowrite	\
+		##width(val, addr))
 
 #define DMA_TO_CPU(fsl_chan, d, width)					\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-- 
1.7.1
