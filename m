From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 4 Mar 2016 11:23:49 +0000
Subject: [RFC PATCH 3/8] staging: board: Remove calls to
 of_genpd_get_from_provider()
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1457090634-14785-4-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the staging/board PM domain code to use the
of_genpd_add_subdomain() and remove any calls to
of_genpd_get_from_provider().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/staging/board/board.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index 45807d8287d1..86dc41101610 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -140,7 +140,6 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
 					const char *domain)
 {
 	struct of_phandle_args pd_args;
-	struct generic_pm_domain *pd;
 	struct device_node *np;
 
 	np = of_find_node_by_path(domain);
@@ -151,14 +150,8 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
 
 	pd_args.np = np;
 	pd_args.args_count = 0;
-	pd = of_genpd_get_from_provider(&pd_args);
-	if (IS_ERR(pd)) {
-		pr_err("Cannot find genpd %s (%ld)\n", domain, PTR_ERR(pd));
-		return PTR_ERR(pd);
-	}
-	pr_debug("Found genpd %s for device %s\n", pd->name, pdev->name);
 
-	return pm_genpd_add_device(pd, &pdev->dev);
+	return of_genpd_add_device(&pd_args, &pdev->dev);
 }
 #else
 static inline int board_staging_add_dev_domain(struct platform_device *pdev,
-- 
2.1.4
