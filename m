From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 19 May 2017 16:20:35 +0530
Subject: [PATCH v1] PM / devfreq: exynos-nocp : Handle return value of
 clk_prepare_enable
Message-ID: <1495191035-15882-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/devfreq/event/exynos-nocp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 5c3e7b1..f6e7956 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -267,7 +267,11 @@ static int exynos_nocp_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, nocp);
 
-	clk_prepare_enable(nocp->clk);
+	ret = clk_prepare_enable(nocp->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");
+		return ret;
+	}
 
 	pr_info("exynos-nocp: new NoC Probe device registered: %s\n",
 			dev_name(dev));
-- 
1.9.1
