From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Mon, 13 Jun 2016 23:31:47 +0000
Subject: [PATCH] phy: rockchip-dp: fix return value check in
 rockchip_dp_phy_probe()
Message-ID: <1465860707-26005-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_kzalloc() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/phy/phy-rockchip-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-rockchip-dp.c b/drivers/phy/phy-rockchip-dp.c
index 793ecb6..8b267a7 100644
--- a/drivers/phy/phy-rockchip-dp.c
+++ b/drivers/phy/phy-rockchip-dp.c
@@ -90,7 +90,7 @@ static int rockchip_dp_phy_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
-	if (IS_ERR(dp))
+	if (!dp)
 		return -ENOMEM;
 
 	dp->dev = dev;
