From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 4 Mar 2011 14:58:32 +0530
Subject: [PATCH] dmaengine/dw_dmac fix: use readl & writel instead of
	__raw_readl & __raw_writel
Message-ID: <14694f4c5383ef35c3c91d4c867e1ec304a1a63e.1299229845.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARMv7 cores, device memory mapped as Normal Non-cacheable, may not guarantee
ordered access causing failures in device drivers that do not use the mandatory
memory barriers. readl & writel versions contain necessary memory barriers for
this.

commit 79f64dbf68c8a9779a7e9a25e0a9f0217a25b57a: "ARM: 6273/1: Add barriers to
the I/O accessors if ARM_DMA_MEM_BUFFERABLE" can be referred for more
information on this.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac_regs.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw_dmac_regs.h b/drivers/dma/dw_dmac_regs.h
index 9a32964..720f821 100644
--- a/drivers/dma/dw_dmac_regs.h
+++ b/drivers/dma/dw_dmac_regs.h
@@ -159,9 +159,9 @@ __dwc_regs(struct dw_dma_chan *dwc)
 }
 
 #define channel_readl(dwc, name) \
-	__raw_readl(&(__dwc_regs(dwc)->name))
+	readl(&(__dwc_regs(dwc)->name))
 #define channel_writel(dwc, name, val) \
-	__raw_writel((val), &(__dwc_regs(dwc)->name))
+	writel((val), &(__dwc_regs(dwc)->name))
 
 static inline struct dw_dma_chan *to_dw_dma_chan(struct dma_chan *chan)
 {
@@ -185,9 +185,9 @@ static inline struct dw_dma_regs __iomem *__dw_regs(struct dw_dma *dw)
 }
 
 #define dma_readl(dw, name) \
-	__raw_readl(&(__dw_regs(dw)->name))
+	readl(&(__dw_regs(dw)->name))
 #define dma_writel(dw, name, val) \
-	__raw_writel((val), &(__dw_regs(dw)->name))
+	writel((val), &(__dw_regs(dw)->name))
 
 #define channel_set_bit(dw, reg, mask) \
 	dma_writel(dw, reg, ((mask) << 8) | (mask))
-- 
1.7.2.2
