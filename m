From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:49:24 +0100
Subject: [PATCH V2 5/6] amba: Convert to clk_prepare_enable and
 clk_disable_unprepare
Message-ID: <1386067764-25138-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To simplify code and error handling let's use clk_prepare_enable
and clk_disable_unprepare. No functional change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c |   29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index b90dc1e..ea1d835 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -151,36 +151,23 @@ postcore_initcall(amba_init);
 
 static int amba_get_enable_pclk(struct amba_device *pcdev)
 {
-	struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");
 	int ret;
 
-	pcdev->pclk = pclk;
+	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
+	if (IS_ERR(pcdev->pclk))
+		return PTR_ERR(pcdev->pclk);
 
-	if (IS_ERR(pclk))
-		return PTR_ERR(pclk);
-
-	ret = clk_prepare(pclk);
-	if (ret) {
-		clk_put(pclk);
-		return ret;
-	}
-
-	ret = clk_enable(pclk);
-	if (ret) {
-		clk_unprepare(pclk);
-		clk_put(pclk);
-	}
+	ret = clk_prepare_enable(pcdev->pclk);
+	if (ret)
+		clk_put(pcdev->pclk);
 
 	return ret;
 }
 
 static void amba_put_disable_pclk(struct amba_device *pcdev)
 {
-	struct clk *pclk = pcdev->pclk;
-
-	clk_disable(pclk);
-	clk_unprepare(pclk);
-	clk_put(pclk);
+	clk_disable_unprepare(pcdev->pclk);
+	clk_put(pcdev->pclk);
 }
 
 /*
-- 
1.7.9.5
