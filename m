From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 15:12:26 +0100
Subject: [PATCH v3 2/5] dmaengine: sun6i: Add 4 as a possible burst value for
 the H3
In-Reply-To: <cover.1458311540.git.moinejf@free.fr>
References: <cover.1458311540.git.moinejf@free.fr>
Message-ID: <8485d9976f327cf23e051f64c3a3c5cbff4214a7.1458311540.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3 accepts 4 as a burst value.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ce1e4d6..9378fda 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -101,6 +101,7 @@ struct sun6i_dma_config {
 	u32 nr_max_channels;
 	u32 nr_max_requests;
 	u32 nr_max_vchans;
+	u32 burst_4;
 };
 
 /*
@@ -238,6 +239,8 @@ static inline s8 convert_burst(u32 maxburst)
 	switch (maxburst) {
 	case 1:
 		return 0;
+	case 4:
+		return 1;
 	case 8:
 		return 2;
 	default:
@@ -470,6 +473,10 @@ static int set_config(struct sun6i_dma_dev *sdev,
 {
 	s8 src_width, dst_width, src_burst, dst_burst;
 
+	if (!sdev->cfg->burst_4 &&
+	    (sconfig->src_maxburst == 4 || sconfig->dst_maxburst == 4))
+		return -EINVAL;
+
 	if (direction == DMA_MEM_TO_DEV) {
 		src_burst = convert_burst(sconfig->src_maxburst ?
 					sconfig->src_maxburst : 8);
@@ -900,12 +907,14 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 /*
  * The H3 has 12 physical channels, a maximum DRQ port id of 27,
  * and a total of 34 usable source and destination endpoints.
+ * Setting the maxburst to '4' is possible.
  */
 
 static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_channels = 12,
 	.nr_max_requests = 27,
 	.nr_max_vchans   = 34,
+	.burst_4	 = 1,
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
-- 
2.7.4
