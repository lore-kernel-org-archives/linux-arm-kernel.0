From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 19 May 2017 16:26:04 +0530
Subject: [PATCH v1] PM / devfreq: exynos-ppmu : Handle return value of
 clk_prepare_enable
Message-ID: <1495191364-16015-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 9b73509..8f6537a 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -648,7 +648,11 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 			dev_name(&pdev->dev), desc[i].name);
 	}
 
-	clk_prepare_enable(info->ppmu.clk);
+	ret = clk_prepare_enable(info->ppmu.clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
1.9.1
