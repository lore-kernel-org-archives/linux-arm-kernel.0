From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:57:50 +0200
Subject: [PATCH 07/10] dma: mv_xor_v2: set DMA mask to 40 bits
In-Reply-To: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493978274-12805-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The XORv2 engine on Armada 7K/8K can only access the first 40 bits of
the physical address space, so the DMA mask must be set accordingly.

Fixes: 19a340b1a820 ("dmaengine: mv_xor_v2: new driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index b133fe2..f3e211f 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -693,6 +693,10 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, xor_dev);
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
+	if (ret)
+		return ret;
+
 	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(xor_dev->clk) && PTR_ERR(xor_dev->clk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
-- 
2.7.4
