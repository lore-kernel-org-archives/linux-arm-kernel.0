From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Tue, 21 Jun 2016 11:56:21 +0800
Subject: [PATCH net-next 01/19] net: hns: bug fix of ge reset sequence
In-Reply-To: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1466481399-70080-2-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qianqian Xie <xieqianqian@huawei.com>

The bit fileds of PPE reset register are different between HNS v1 and
HNS v2, but the current procedure just only match HNS v1. Here is a
patch to fix it.

Signed-off-by: Kejian Yan <yankejian@huawei.com>
Signed-off-by: Qianqian Xie <xieqianqian@huawei.com>
Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index 96cb628..09e60d6 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -271,7 +271,11 @@ static void hns_dsaf_ge_srst_by_port(struct dsaf_device *dsaf_dev, u32 port,
 		}
 	} else {
 		reg_val_1 = 0x15540 << dsaf_dev->reset_offset;
-		reg_val_2 = 0x100 << dsaf_dev->reset_offset;
+
+		if (AE_IS_VER1(dsaf_dev->dsaf_ver))
+			reg_val_2 = 0x100 << dsaf_dev->reset_offset;
+		else
+			reg_val_2 = 0x40 << dsaf_dev->reset_offset;
 
 		if (!dereset) {
 			dsaf_write_sub(dsaf_dev, DSAF_SUB_SC_GE_RESET_REQ1_REG,
-- 
1.9.1
