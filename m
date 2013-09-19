From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 19 Sep 2013 23:00:03 +0100
Subject: [PATCH 35/51] DMA-API: parport: parport_pc.c: use
 dma_coerce_mask_and_coherent()
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMmGZ-0007jU-99@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code sequence:
	dev->coherent_dma_mask = DMA_BIT_MASK(24);
	dev->dma_mask = &dev->coherent_dma_mask;
bypasses the architectures check on the DMA mask.  It can be replaced
with dma_coerce_mask_and_coherent(), avoiding the direct initialization
of this mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/parport/parport_pc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 903e128..9637615 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2004,6 +2004,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 	struct resource	*ECR_res = NULL;
 	struct resource	*EPP_res = NULL;
 	struct platform_device *pdev = NULL;
+	int ret;
 
 	if (!dev) {
 		/* We need a physical device to attach to, but none was
@@ -2014,8 +2015,11 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 			return NULL;
 		dev = &pdev->dev;
 
-		dev->coherent_dma_mask = DMA_BIT_MASK(24);
-		dev->dma_mask = &dev->coherent_dma_mask;
+		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(24));
+		if (ret) {
+			dev_err(dev, "Unable to set coherent dma mask: disabling DMA\n");
+			dma = PARPORT_DMA_NONE;
+		}
 	}
 
 	ops = kmalloc(sizeof(struct parport_operations), GFP_KERNEL);
-- 
1.7.4.4
