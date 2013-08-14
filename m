From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Aug 2013 11:11:14 +0200
Subject: [PATCH 10/29] drivers/watchdog/nuc900_wdt.c: simplify use of
 devm_ioremap_resource
In-Reply-To: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376471493-22215-11-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Remove unneeded error handling on the result of a call to
platform_get_resource when the value is passed to devm_ioremap_resource.

A simplified version of the semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l;
@@

- res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  e = devm_ioremap_resource(e1, res);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/watchdog/nuc900_wdt.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index e2b6d2c..b15b6ef 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -256,11 +256,6 @@ static int nuc900wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&nuc900_wdt->wdt_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource specified\n");
-		return -ENOENT;
-	}
-
 	nuc900_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(nuc900_wdt->wdt_base))
 		return PTR_ERR(nuc900_wdt->wdt_base);
