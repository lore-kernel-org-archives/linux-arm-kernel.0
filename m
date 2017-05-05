From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:57:44 +0200
Subject: [PATCH 01/10] dma: mv_xor_v2: handle mv_xor_v2_prep_sw_desc() error
 properly
In-Reply-To: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493978274-12805-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv_xor_v2_prep_sw_desc() is called from a few different places in
the driver, but we never take into account the fact that it might
return NULL. This commit fixes that, ensuring that we don't panic if
there are no more descriptors available.

Fixes: 19a340b1a820 ("dmaengine: mv_xor_v2: new driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor_v2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index a28a01f..e928020 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -389,6 +389,8 @@ mv_xor_v2_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 		__func__, len, &src, &dest, flags);
 
 	sw_desc = mv_xor_v2_prep_sw_desc(xor_dev);
+	if (!sw_desc)
+		return NULL;
 
 	sw_desc->async_tx.flags = flags;
 
@@ -443,6 +445,8 @@ mv_xor_v2_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 		__func__, src_cnt, len, &dest, flags);
 
 	sw_desc = mv_xor_v2_prep_sw_desc(xor_dev);
+	if (!sw_desc)
+		return NULL;
 
 	sw_desc->async_tx.flags = flags;
 
@@ -491,6 +495,8 @@ mv_xor_v2_prep_dma_interrupt(struct dma_chan *chan, unsigned long flags)
 		container_of(chan, struct mv_xor_v2_device, dmachan);
 
 	sw_desc = mv_xor_v2_prep_sw_desc(xor_dev);
+	if (!sw_desc)
+		return NULL;
 
 	/* set the HW descriptor */
 	hw_descriptor = &sw_desc->hw_desc;
-- 
2.7.4
