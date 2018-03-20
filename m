From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Tue, 20 Mar 2018 13:19:59 +0000
Subject: [PATCH -next] phy: phy-mtk-tphy: fix missing clk_disable_unprepare()
 on error in mtk_phy_init()
Message-ID: <1521551999-154546-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the missing clk_disable_unprepare() before return
from mtk_phy_init() in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 38c281b..3ff9020 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -841,7 +841,7 @@ static int mtk_phy_init(struct phy *phy)
 	ret = clk_prepare_enable(instance->ref_clk);
 	if (ret) {
 		dev_err(tphy->dev, "failed to enable ref_clk\n");
-		return ret;
+		goto disable_u3phya_ref;
 	}
 
 	switch (instance->type) {
@@ -859,10 +859,17 @@ static int mtk_phy_init(struct phy *phy)
 		break;
 	default:
 		dev_err(tphy->dev, "incompatible PHY type\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto disable_ref_clk;
 	}
 
 	return 0;
+
+disable_ref_clk:
+	clk_disable_unprepare(instance->ref_clk);
+disable_u3phya_ref:
+	clk_disable_unprepare(tphy->u3phya_ref);
+	return ret;
 }
 
 static int mtk_phy_power_on(struct phy *phy)
