From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 18 Jan 2013 08:46:21 +0100
Subject: [PATCH 2/3] dma: mv_xor: fix DMA-API error handling sanity check
In-Reply-To: <1358495154.28503.5.camel@unicorn>
References: <1358495154.28503.5.camel@unicorn>
Message-ID: <1358495182-30964-2-git-send-email-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add error checking.
---
 drivers/dma/mv_xor.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 8b81a04..d00a834 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -939,9 +939,21 @@ static int mv_xor_memcpy_self_test(struct mv_xor_chan *mv_chan)
 
 	dest_dma = dma_map_single(dma_chan->device->dev, dest,
 				  MV_XOR_TEST_SIZE, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_chan->device->dev, dest_dma)) {
+		dev_err(dma_chan->device->dev,
+			"Could not map destination buffer, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
 
 	src_dma = dma_map_single(dma_chan->device->dev, src,
 				 MV_XOR_TEST_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_chan->device->dev, src_dma)) {
+		dev_err(dma_chan->device->dev,
+			"Could not map source buffer, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
 
 	tx = mv_xor_prep_dma_memcpy(dma_chan, dest_dma, src_dma,
 				    MV_XOR_TEST_SIZE,
@@ -1031,10 +1043,23 @@ mv_xor_xor_self_test(struct mv_xor_chan *mv_chan)
 	/* test xor */
 	dest_dma = dma_map_page(dma_chan->device->dev, dest, 0, PAGE_SIZE,
 				DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_chan->device->dev, dest_dma)) {
+		dev_err(dma_chan->device->dev,
+			"Could not map destination page, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
 
-	for (i = 0; i < MV_XOR_NUM_SRC_TEST; i++)
+	for (i = 0; i < MV_XOR_NUM_SRC_TEST; i++) {
 		dma_srcs[i] = dma_map_page(dma_chan->device->dev, xor_srcs[i],
 					   0, PAGE_SIZE, DMA_TO_DEVICE);
+		if (dma_mapping_error(dma_chan->device->dev, dma_srcs[i])) {
+			dev_err(dma_chan->device->dev,
+				"Could not map source page, disabling\n");
+			err = -ENODEV;
+			goto free_resources;
+		}
+	}
 
 	tx = mv_xor_prep_dma_xor(dma_chan, dest_dma, dma_srcs,
 				 MV_XOR_NUM_SRC_TEST, PAGE_SIZE, 0);
-- 
1.7.1
