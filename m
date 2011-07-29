From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 29 Jul 2011 16:19:16 +0530
Subject: [PATCH 06/18] dmaengine/amba-pl08x: Simplify pl08x_ensure_on()
In-Reply-To: <cover.1311936523.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
Message-ID: <88035b0bd1f3fd755b6a157193c39477e21ec60a.1311936524.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simply writing 1 on bit 0 is sufficient instead of reading and clearing bits.
Also as per manual, for bit 3-31 of DMACConfiguration register:
"read undefined, write as 0"

So, we must not rely on values read from this registers bit 3-31.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/amba-pl08x.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 56a9670..53d722e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1505,13 +1505,7 @@ bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
  */
 static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 {
-	u32 val;
-
-	val = readl(pl08x->base + PL080_CONFIG);
-	val &= ~(PL080_CONFIG_M2_BE | PL080_CONFIG_M1_BE | PL080_CONFIG_ENABLE);
-	/* We implicitly clear bit 1 and that means little-endian mode */
-	val |= PL080_CONFIG_ENABLE;
-	writel(val, pl08x->base + PL080_CONFIG);
+	writel(PL080_CONFIG_ENABLE, pl08x->base + PL080_CONFIG);
 }
 
 static void pl08x_unmap_buffers(struct pl08x_txd *txd)
-- 
1.7.2.2
