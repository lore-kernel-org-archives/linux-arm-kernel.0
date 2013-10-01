From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue,  1 Oct 2013 12:31:04 +0200
Subject: [PATCH 1/1] dma: imx-sdma: setup dma mask
In-Reply-To: <1380623464-24652-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1380623464-24652-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1380623464-24652-2-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma mask is not configured in the current code.
This was triggered by soc-dmaengine-pcm which allocate the dma
buffers with the imx-sdma as device.
This commit fix audio on imx31.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 drivers/dma/imx-sdma.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fc43603..c1fd504 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1432,6 +1432,10 @@ static int __init sdma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	sdma = kzalloc(sizeof(*sdma), GFP_KERNEL);
 	if (!sdma)
 		return -ENOMEM;
-- 
1.7.9.5
