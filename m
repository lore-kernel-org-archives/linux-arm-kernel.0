From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Tue, 21 Jun 2016 11:56:22 +0800
Subject: [PATCH net-next 02/19] net: hns: fix hns dsaf v1 dont support
 tx_pause close
In-Reply-To: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1466481399-70080-3-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qianqian Xie <xieqiaqian@huawei.com>

For service port, hns dsaf v1 support to close tx_pause.
However, the port will be invalid when it run command
ethtool to close tx_pause. This patch will fix it.

Signed-off-by: Qianqian Xie <xieqiaqian@huawei.com>
Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index ac03c4a..422f97d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -1114,10 +1114,10 @@ int hns_dsaf_set_rx_mac_pause_en(struct dsaf_device *dsaf_dev, int mac_id,
 				 u32 en)
 {
 	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
-		if (!en)
+		if (!en) {
 			dev_err(dsaf_dev->dev, "dsafv1 can't close rx_pause!\n");
-
-		return -EINVAL;
+			return -EINVAL;
+		}
 	}
 
 	dsaf_set_dev_bit(dsaf_dev, DSAF_PAUSE_CFG_REG + mac_id * 4,
-- 
1.9.1
