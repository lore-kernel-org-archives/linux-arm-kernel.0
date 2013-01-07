From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:45 +0100
Subject: [PATCH 03/16] dmaengine: ste_dma40: set dma max seg size
In-Reply-To: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1357557718-15676-4-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@stericsson.com>

Maximum DMA seg size is (0xffff x data_width).  If max seg
size is not set it deafults to 64k.  This results in failure
if transferring 64k in byte mode.
Large seg sizes may be supported by splitting large transfer.

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 23c5573..f5724d9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -344,6 +344,7 @@ struct d40_base {
 	int				  irq;
 	int				  num_phy_chans;
 	int				  num_log_chans;
+	struct device_dma_parameters	  dma_parms;
 	struct dma_device		  dma_both;
 	struct dma_device		  dma_slave;
 	struct dma_device		  dma_memcpy;
@@ -3362,6 +3363,13 @@ static int __init d40_probe(struct platform_device *pdev)
 	if (err)
 		goto failure;
 
+	base->dev->dma_parms = &base->dma_parms;
+	err = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
+	if (err) {
+		d40_err(&pdev->dev, "Failed to set dma max seg size\n");
+		goto failure;
+	}
+
 	d40_hw_init(base);
 
 	dev_info(base->dev, "initialized\n");
-- 
1.7.12.1
