From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Sat, 11 Jun 2016 09:35:20 +0530
Subject: [PATCH] ARM: zx: Fix devm_ioremap_resource error detection code
Message-ID: <20160611040520.GA20393@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary error handling after the call to
platform_get_resource and fix error handling for devm_ioremap_resource

The Coccinelle semantic patch that was used to help find this is as
follows:
@@
expression e,e1;
statement S;
@@

*e = devm_ioremap_resource(...);
if (!e1) S

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
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
1.9.1
