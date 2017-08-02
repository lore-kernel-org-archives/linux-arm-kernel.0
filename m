From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Aug 2017 12:51:29 -0700
Subject: [PATCH] soc: imx: gpcv2: fix regulator deferred probe
Message-ID: <20170802195129.20442-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a regulator requests a deferred probe, the power domain gets
initialized twice. This leads to a list double add (without
list debugging the kernel hangs due to the double add later):

  WARNING: CPU: 0 PID: 19 at lib/list_debug.c:31 __list_add_valid+0xbc/0xc4
  list_add double add: new=c1229754, prev=c12383b4, next=c1229754.

Initialize the power domain after we get the regulator. Also do
not print an error in case the regulator defers probing.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Shawn,

Since this leads to a Kernel hang in v4.13-rc3, can you get this
into v4.13 still?

--
Stefan

 drivers/soc/imx/gpcv2.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 3039072911a5..afc7ecc3c187 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -200,16 +200,11 @@ static int imx7_pgc_domain_probe(struct platform_device *pdev)
 
 	domain->dev = &pdev->dev;
 
-	ret = pm_genpd_init(&domain->genpd, NULL, true);
-	if (ret) {
-		dev_err(domain->dev, "Failed to init power domain\n");
-		return ret;
-	}
-
 	domain->regulator = devm_regulator_get_optional(domain->dev, "power");
 	if (IS_ERR(domain->regulator)) {
 		if (PTR_ERR(domain->regulator) != -ENODEV) {
-			dev_err(domain->dev, "Failed to get domain's regulator\n");
+			if (PTR_ERR(domain->regulator) != -EPROBE_DEFER)
+				dev_err(domain->dev, "Failed to get domain's regulator\n");
 			return PTR_ERR(domain->regulator);
 		}
 	} else {
@@ -217,6 +212,12 @@ static int imx7_pgc_domain_probe(struct platform_device *pdev)
 				      domain->voltage, domain->voltage);
 	}
 
+	ret = pm_genpd_init(&domain->genpd, NULL, true);
+	if (ret) {
+		dev_err(domain->dev, "Failed to init power domain\n");
+		return ret;
+	}
+
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
 					   &domain->genpd);
 	if (ret) {
-- 
2.13.3
