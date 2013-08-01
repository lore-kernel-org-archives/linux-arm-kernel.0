From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 22:53:07 +0100
Subject: [PATCH RFC 19/51] DMA-API: media: dt3155v4l: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50nz-0006rJ-UO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/media/dt3155v4l/dt3155v4l.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/dt3155v4l/dt3155v4l.c b/drivers/staging/media/dt3155v4l/dt3155v4l.c
index 90d6ac4..081407b 100644
--- a/drivers/staging/media/dt3155v4l/dt3155v4l.c
+++ b/drivers/staging/media/dt3155v4l/dt3155v4l.c
@@ -901,10 +901,7 @@ dt3155_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int err;
 	struct dt3155_priv *pd;
 
-	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (err)
-		return -ENODEV;
-	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err)
 		return -ENODEV;
 	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
-- 
1.7.4.4
