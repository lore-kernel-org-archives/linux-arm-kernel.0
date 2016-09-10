From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sat, 10 Sep 2016 12:03:42 +0000
Subject: [PATCH -next] hwrng: st - Fix missing clk_disable_unprepare() on
 error in st_rng_probe()
Message-ID: <1473509022-3478-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the missing clk_disable_unprepare() before return
from st_rng_probe() in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/char/hw_random/st-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
index 7e8aa6b..938ec10 100644
--- a/drivers/char/hw_random/st-rng.c
+++ b/drivers/char/hw_random/st-rng.c
@@ -108,6 +108,7 @@ static int st_rng_probe(struct platform_device *pdev)
 	ret = hwrng_register(&ddata->ops);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register HW RNG\n");
+		clk_disable_unprepare(clk);
 		return ret;
 	}
 
