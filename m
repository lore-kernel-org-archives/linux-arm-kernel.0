From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Sat, 23 Apr 2016 17:05:09 +0800
Subject: [PATCH v2 net-next 05/13] net: hns: add syscon operation for dsaf
In-Reply-To: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1461402317-136499-6-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the read/write function for dsaf to
access the registers through syscon methods.

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
Signed-off-by: Yisen Zhuang <yisen.zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
index ed0043a..6a03c94 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -10,6 +10,7 @@
 #ifndef _DSAF_REG_H_
 #define _DSAF_REG_H_
 
+#include <linux/regmap.h>
 #define HNS_DEBUG_RING_IRQ_IDX 0
 #define HNS_SERVICE_RING_IRQ_IDX 59
 #define HNSV2_SERVICE_RING_IRQ_IDX 25
@@ -989,6 +990,19 @@ static inline u32 dsaf_read_reg(u8 __iomem *base, u32 reg)
 	return readl(reg_addr + reg);
 }
 
+static inline void dsaf_write_syscon(struct regmap *base, u32 reg, u32 value)
+{
+	regmap_write(base, reg, value);
+}
+
+static inline u32 dsaf_read_syscon(struct regmap *base, u32 reg)
+{
+	unsigned int val;
+
+	regmap_read(base, reg, &val);
+	return val;
+}
+
 #define dsaf_read_dev(a, reg) \
 	dsaf_read_reg((a)->io_base, (reg))
 
-- 
1.9.1
