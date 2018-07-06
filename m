From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  6 Jul 2018 15:02:20 +0200
Subject: [PATCH] dma: stm32: replace "%p" with "%pK"
Message-ID: <20180706130220.21957-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/dma/stm32-dma.c  | 4 ++--
 drivers/dma/stm32-mdma.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 8c5807362a25..379e8d534e61 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -594,7 +594,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 
 	chan->busy = true;
 
-	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
 }
 
 static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
@@ -693,7 +693,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
-		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
+		dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
 		stm32_dma_start_transfer(chan);
 
 	}
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 9dc450b7ace6..06dd1725375e 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1170,7 +1170,7 @@ static void stm32_mdma_start_transfer(struct stm32_mdma_chan *chan)
 
 	chan->busy = true;
 
-	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
 }
 
 static void stm32_mdma_issue_pending(struct dma_chan *c)
@@ -1183,7 +1183,7 @@ static void stm32_mdma_issue_pending(struct dma_chan *c)
 	if (!vchan_issue_pending(&chan->vchan))
 		goto end;
 
-	dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
 
 	if (!chan->desc && !chan->busy)
 		stm32_mdma_start_transfer(chan);
@@ -1203,7 +1203,7 @@ static int stm32_mdma_pause(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
 	if (!ret)
-		dev_dbg(chan2dev(chan), "vchan %p: pause\n", &chan->vchan);
+		dev_dbg(chan2dev(chan), "vchan %pK: pause\n", &chan->vchan);
 
 	return ret;
 }
@@ -1240,7 +1240,7 @@ static int stm32_mdma_resume(struct dma_chan *c)
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
-	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: resume\n", &chan->vchan);
 
 	return 0;
 }
-- 
2.15.0
