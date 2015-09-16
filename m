From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 16 Sep 2015 16:05:40 +0800
Subject: [PATCH] ARM: zx: zx296702-pm-domain.c: Fix check return value of
 devm_ioremap_resource
Message-ID: <1442390740.28314.1.camel@ingics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource() returns ERR_PTR on failure.
devm_ioremap_resource() will also check res argument and show proper error
on error path, so remove the redundant checking for res and error messages.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/mach-zx/zx296702-pm-domain.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
index e08574d..17f778b 100644
--- a/arch/arm/mach-zx/zx296702-pm-domain.c
+++ b/arch/arm/mach-zx/zx296702-pm-domain.c
@@ -163,16 +163,9 @@ static int zx296702_pd_probe(struct platform_device *pdev)
 	genpd_data->num_domains = ARRAY_SIZE(zx296702_pm_domains);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
-		return -ENODEV;
-	}
-
 	pcubase = devm_ioremap_resource(&pdev->dev, res);
-	if (!pcubase) {
-		dev_err(&pdev->dev, "ioremap fail.\n");
-		return -EIO;
-	}
+	if (IS_ERR(pcubase))
+		return PTR_ERR(pcubase);
 
 	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
 		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
-- 
2.1.4
