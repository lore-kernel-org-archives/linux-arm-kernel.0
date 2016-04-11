From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Mon, 11 Apr 2016 11:38:42 +0300
Subject: [PATCH v3 5/6] dmaengine: qcom: bam_dma: use correct pipe FIFO size
In-Reply-To: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <1460363923-16296-6-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pipe fifo size register must instruct the bam hw
how many hw descriptors can be pushed to fifo. Currently
we instruct the hw with 32KBytes but wrap the tail in
bam_start_dma in BAM_P_EVNT_REG on 4095 i.e. 32760. This
leads to stalled transactions when the tail wraps.

Fix this by use the correct fifo size in BAM_P_FIFO_SIZES
register i.e. 32K - 8.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/dma/qcom/bam_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d0f878a78fae..7e5ad1c25e21 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -459,7 +459,7 @@ static void bam_chan_init_hw(struct bam_chan *bchan,
 	 */
 	writel_relaxed(ALIGN(bchan->fifo_phys, sizeof(struct bam_desc_hw)),
 			bam_addr(bdev, bchan->id, BAM_P_DESC_FIFO_ADDR));
-	writel_relaxed(BAM_DESC_FIFO_SIZE,
+	writel_relaxed(BAM_MAX_DATA_SIZE,
 			bam_addr(bdev, bchan->id, BAM_P_FIFO_SIZES));
 
 	/* enable the per pipe interrupts, enable EOT, ERR, and INT irqs */
-- 
1.7.9.5
