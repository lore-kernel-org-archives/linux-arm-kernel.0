From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 21 Sep 2016 15:08:31 +0000
Subject: [PATCH -next] soc: mediatek: PMIC wrap: fix missing
 clk_disable_unprepare() on error in pwrap_probe()
Message-ID: <1474470511-2458-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the missing clk_disable_unprepare() before return
from pwrap_probe() in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index a5f1093..4da3bb2 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1200,7 +1200,8 @@ static int pwrap_probe(struct platform_device *pdev)
 
 	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
 		dev_dbg(wrp->dev, "initialization isn't finished\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_out2;
 	}
 
 	/* Initialize watchdog, may not be done by the bootloader */
