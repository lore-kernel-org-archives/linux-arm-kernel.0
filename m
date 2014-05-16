From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 16 May 2014 15:17:13 +0300
Subject: [PATCH v3 06/13] ARM: edma: Remove num_cc member from struct edma
In-Reply-To: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1400242640-9902-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The struct edma is allocated per CC bases so the member num_cc does not make
any sense. One CC is one CC, it does not have sub CCs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 0bc5ed6fc249..929a03e4749c 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -233,7 +233,6 @@ struct edma {
 	unsigned	num_region;
 	unsigned	num_slots;
 	unsigned	num_tc;
-	unsigned	num_cc;
 	enum dma_event_q 	default_queue;
 
 	/* list of channels with no even trigger; terminated by "-1" */
@@ -1481,7 +1480,6 @@ static int edma_of_parse_dt(struct device *dev,
 		return ret;
 	pdata->n_slot = value;
 
-	pdata->n_cc = 1;
 	pdata->n_tc = 3;
 
 	rsv_info = devm_kzalloc(dev, sizeof(struct edma_rsv_info), GFP_KERNEL);
@@ -1627,8 +1625,6 @@ static int edma_probe(struct platform_device *pdev)
 							EDMA_MAX_DMACH);
 		edma_cc[j]->num_slots = min_t(unsigned, info[j]->n_slot,
 							EDMA_MAX_PARAMENTRY);
-		edma_cc[j]->num_cc = min_t(unsigned, info[j]->n_cc,
-							EDMA_MAX_CC);
 		edma_cc[j]->num_tc = info[j]->n_tc;
 
 		edma_cc[j]->default_queue = info[j]->default_queue;
-- 
1.9.3
