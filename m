From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 16 Oct 2015 10:18:04 +0300
Subject: [PATCH v2 06/14] dmaengine: edma: Get qDMA channel information from
 HW also
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1444979892-31626-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Query the number of qDMA channels from CCCFG register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index eaf1f9e4bde0..ea851ab05c8e 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -107,6 +107,7 @@
 
 /* CCCFG register */
 #define GET_NUM_DMACH(x)	(x & 0x7) /* bits 0-2 */
+#define GET_NUM_QDMACH(x)	(x & 0x70 >> 4) /* bits 4-6 */
 #define GET_NUM_PAENTRY(x)	((x & 0x7000) >> 12) /* bits 12-14 */
 #define GET_NUM_EVQUE(x)	((x & 0x70000) >> 16) /* bits 16-18 */
 #define GET_NUM_REGN(x)		((x & 0x300000) >> 20) /* bits 20-21 */
@@ -220,6 +221,7 @@ struct edma_cc {
 
 	/* eDMA3 resource information */
 	unsigned			num_channels;
+	unsigned			num_qchannels;
 	unsigned			num_region;
 	unsigned			num_slots;
 	unsigned			num_tc;
@@ -1819,6 +1821,9 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	value = GET_NUM_DMACH(cccfg);
 	ecc->num_channels = BIT(value + 1);
 
+	value = GET_NUM_QDMACH(cccfg);
+	ecc->num_qchannels = value * 2;
+
 	value = GET_NUM_PAENTRY(cccfg);
 	ecc->num_slots = BIT(value + 4);
 
@@ -1830,6 +1835,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	dev_dbg(dev, "eDMA3 CC HW configuration (cccfg: 0x%08x):\n", cccfg);
 	dev_dbg(dev, "num_region: %u\n", ecc->num_region);
 	dev_dbg(dev, "num_channels: %u\n", ecc->num_channels);
+	dev_dbg(dev, "num_qchannels: %u\n", ecc->num_qchannels);
 	dev_dbg(dev, "num_slots: %u\n", ecc->num_slots);
 	dev_dbg(dev, "num_tc: %u\n", ecc->num_tc);
 	dev_dbg(dev, "chmap_exist: %s\n", ecc->chmap_exist ? "yes" : "no");
-- 
2.6.1
