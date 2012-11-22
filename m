From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2012 18:32:23 +0100
Subject: [PATCH 3/5] dma: mv_xor: use request_irq() instead of
 devm_request_irq()
In-Reply-To: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353605545-7091-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even through the usage of devm_*() functions is generally recommended
over their classic variants, in the case of devm_request_irq()
combined with irq_of_parse_and_map(), it doesn't work nicely.

We have the following scenario:

 irq_of_parse_and_map(...)
 devm_request_irq(...)

For some reason, the driver initialization fails at a later
point. Since irq_of_parse_and_map() is no device-managed, we do a:

 irq_dispose_mapping(...)

Unfortunately, this doesn't work, because the free_irq() must be done
prior to calling irq_dispose_mapping(). But with the devm mechanism,
the automatic free_irq() would happen only after we get out of the
->probe() function.

So basically, we revert to using request_irq() with traditional error
handling, so that in case of error, free_irq() gets called before
irq_dispose_mapping().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 2c69b89..0d4c24e 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1162,9 +1162,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/* clear errors before enabling interrupts */
 	mv_xor_device_clear_err_status(mv_chan);
 
-	ret = devm_request_irq(&pdev->dev, mv_chan->irq,
-			       mv_xor_interrupt_handler,
-			       0, dev_name(&pdev->dev), mv_chan);
+	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
+			  0, dev_name(&pdev->dev), mv_chan);
 	if (ret)
 		goto err_free_dma;
 
@@ -1185,14 +1184,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		ret = mv_xor_memcpy_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
 		if (ret)
-			goto err_free_dma;
+			goto err_free_irq;
 	}
 
 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
 		ret = mv_xor_xor_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
 		if (ret)
-			goto err_free_dma;
+			goto err_free_irq;
 	}
 
 	dev_info(&pdev->dev, "Marvell XOR: "
@@ -1205,6 +1204,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_async_device_register(dma_dev);
 	return mv_chan;
 
+err_free_irq:
+	free_irq(mv_chan->irq, mv_chan);
  err_free_dma:
 	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
-- 
1.7.9.5
