From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 5 Jan 2012 15:59:22 +0800
Subject: [PATCH v3 2/2] dma/imx-sdma: use writel to write register when enable
 a channel
In-Reply-To: <1325750362-22598-1-git-send-email-richard.zhao@linaro.org>
References: <1325750362-22598-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325750362-22598-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_alloc_coherent memory may be bufferable when set
CONFIG_ARM_DMA_MEM_BUFFERABLE. We need to add nececcary
memory barrier. writel implicitly call wmb in such case.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c2bc4f1..e987468 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -396,7 +396,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
-	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
+	writel(1 << channel, sdma->regs + SDMA_H_START);
 }
 
 /*
-- 
1.7.5.4
