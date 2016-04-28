From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Thu, 28 Apr 2016 15:01:34 +0800
Subject: [PATCH net-next 02/10] net: hns: set debug port irq index to 0
In-Reply-To: <1461826902-51368-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1461826902-51368-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1461826902-51368-3-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daode Huang <huangdaode@hisilicon.com>

As debug ports are removed from service dsaf to debug dsaf,
its interrupts offset should start from 0, So this patch
re-defines the offset index of debug ports.

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
Signed-off-by: Yuzeng Zhuang <yisen.zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 8 +-------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h | 5 +----
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 121ba4e..054f391 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -445,20 +445,14 @@ static int hns_rcb_get_port_in_comm(
 
 #define SERVICE_RING_IRQ_IDX(v1) \
 	((v1) ? HNS_SERVICE_RING_IRQ_IDX : HNSV2_SERVICE_RING_IRQ_IDX)
-#define DEBUG_RING_IRQ_IDX(v1) \
-	((v1) ? HNS_DEBUG_RING_IRQ_IDX : HNSV2_DEBUG_RING_IRQ_IDX)
-#define DEBUG_RING_IRQ_OFFSET(v1) \
-	((v1) ? HNS_DEBUG_RING_IRQ_OFFSET : HNSV2_DEBUG_RING_IRQ_OFFSET)
 static int hns_rcb_get_base_irq_idx(struct rcb_common_cb *rcb_common)
 {
-	int comm_index = rcb_common->comm_index;
 	bool is_ver1 = AE_IS_VER1(rcb_common->dsaf_dev->dsaf_ver);
 
 	if (!HNS_DSAF_IS_DEBUG(rcb_common->dsaf_dev))
 		return SERVICE_RING_IRQ_IDX(is_ver1);
 	else
-		return  DEBUG_RING_IRQ_IDX(is_ver1) +
-			(comm_index - 1) * DEBUG_RING_IRQ_OFFSET(is_ver1);
+		return  HNS_DEBUG_RING_IRQ_IDX;
 }
 
 #define RCB_COMM_BASE_TO_RING_BASE(base, ringid)\
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
index cffd244..8782608 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -10,12 +10,9 @@
 #ifndef _DSAF_REG_H_
 #define _DSAF_REG_H_
 
-#define HNS_DEBUG_RING_IRQ_IDX 55
+#define HNS_DEBUG_RING_IRQ_IDX 0
 #define HNS_SERVICE_RING_IRQ_IDX 59
-#define HNS_DEBUG_RING_IRQ_OFFSET 2
-#define HNSV2_DEBUG_RING_IRQ_IDX 409
 #define HNSV2_SERVICE_RING_IRQ_IDX 25
-#define HNSV2_DEBUG_RING_IRQ_OFFSET 9
 
 #define DSAF_MAX_PORT_NUM_PER_CHIP 8
 #define DSAF_SERVICE_PORT_NUM_PER_DSAF 6
-- 
1.9.1
