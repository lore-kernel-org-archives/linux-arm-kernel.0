From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 19 Sep 2013 22:50:02 +0100
Subject: [PATCH 25/51] DMA-API: video: clcd: add dma_set_mask_and_coherent()
 call
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMm6s-0007iD-2R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA API requires drivers to call the appropriate dma_set_mask()
functions before doing any DMA mapping.  Add this required call to
the AMBA PL08x driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/amba-clcd.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 0a2cce7..afe4702 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -10,6 +10,7 @@
  *
  *  ARM PrimeCell PL110 Color LCD Controller
  */
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -551,6 +552,10 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!board)
 		return -EINVAL;
 
+	ret = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto out;
+
 	ret = amba_request_regions(dev, NULL);
 	if (ret) {
 		printk(KERN_ERR "CLCD: unable to reserve regs region\n");
-- 
1.7.4.4
