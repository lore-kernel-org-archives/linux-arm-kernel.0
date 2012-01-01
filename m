From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun,  1 Jan 2012 11:27:40 +0800
Subject: [PATCH] dma/imx-sdma: add wmb before enable/run a channel
Message-ID: <1325388460-20678-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_alloc_coherent memory may be bufferable. We need to add
nececcary memory barrier.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/dma/imx-sdma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 2ebb2bc..8cd9492 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -403,6 +403,7 @@ static int sdma_run_channel(struct sdma_channel *sdmac)
 
 	init_completion(&sdmac->done);
 
+	wmb();
 	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
 
 	ret = wait_for_completion_timeout(&sdmac->done, HZ);
@@ -809,6 +810,7 @@ out:
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
+	wmb();
 	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
 }
 
-- 
1.7.4.1
