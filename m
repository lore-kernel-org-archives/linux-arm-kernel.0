From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:04:30 +0100
Subject: [PATCH 5/6] amba: Convert to clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
References: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386065071-9529-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To simplify code and error handling let's use clk_prepare_enable
and clk_disable_unprepare. No functional change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c |   30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index b90dc1e..0477131 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -151,36 +151,18 @@ postcore_initcall(amba_init);
 
 static int amba_get_enable_pclk(struct amba_device *pcdev)
 {
-	struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");
-	int ret;
-
-	pcdev->pclk = pclk;
-
-	if (IS_ERR(pclk))
-		return PTR_ERR(pclk);
+	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
 
-	ret = clk_prepare(pclk);
-	if (ret) {
-		clk_put(pclk);
-		return ret;
-	}
+	if (IS_ERR(pcdev->pclk))
+		return PTR_ERR(pcdev->pclk);
 
-	ret = clk_enable(pclk);
-	if (ret) {
-		clk_unprepare(pclk);
-		clk_put(pclk);
-	}
-
-	return ret;
+	return clk_prepare_enable(pcdev->pclk);
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
