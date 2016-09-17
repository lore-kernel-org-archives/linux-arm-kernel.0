From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:23:15 +0200
Subject: [PATCH 14/24] ste_dma40: One check less in d40_prep_sg() after error
 detection
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <26e8b766-a614-ba4f-7f16-f3a89ed714e4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 15:34:07 +0200

* Adjust jump targets according to the Linux coding style convention.

* Delete a repeated check which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0788add..a7e7cd0 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2251,7 +2251,7 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 
 	desc = d40_prep_desc(chan, sg_src, sg_len, dma_flags);
 	if (desc == NULL)
-		goto err;
+		goto unlock;
 
 	if (sg_next(&sg_src[sg_len - 1]) == sg_src)
 		desc->cyclic = true;
@@ -2271,7 +2271,7 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	if (ret) {
 		chan_err(chan, "Failed to prepare %s sg job: %d\n",
 			 chan_is_logical(chan) ? "log" : "phy", ret);
-		goto err;
+		goto free_desc;
 	}
 
 	/*
@@ -2283,10 +2283,9 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return &desc->txd;
-
-err:
-	if (desc)
-		d40_desc_free(chan, desc);
+ free_desc:
+	d40_desc_free(chan, desc);
+ unlock:
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return NULL;
 }
-- 
2.10.0
