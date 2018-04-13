From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 13 Apr 2018 15:52:12 +0200
Subject: [PATCH v3 1/2] dmaengine: stm32-mdma: align TLEN and buffer length on
 burst
In-Reply-To: <1523627533-7184-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523627533-7184-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1523627533-7184-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both buffer Transfer Length (TLEN if any) and transfer size have to be
aligned on burst size (burst beats*bus width).

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
    v2:
    v3:
       * Get rid of while loop in favor of computed values
---
---
 drivers/dma/stm32-mdma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index daa1602..4c7634c 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -410,13 +410,10 @@ static enum dma_slave_buswidth stm32_mdma_get_max_width(dma_addr_t addr,
 static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
 				     enum dma_slave_buswidth width)
 {
-	u32 best_burst = max_burst;
-	u32 burst_len = best_burst * width;
+	u32 best_burst;
 
-	while ((burst_len > 0) && (tlen % burst_len)) {
-		best_burst = best_burst >> 1;
-		burst_len = best_burst * width;
-	}
+	best_burst = min((u32)1 << __ffs(tlen | buf_len),
+			 max_burst * width) / width;
 
 	return (best_burst > 0) ? best_burst : 1;
 }
-- 
2.7.4
