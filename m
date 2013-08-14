From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Aug 2013 11:11:05 +0200
Subject: [PATCH 1/29] pinctrl: nomadik: simplify use of devm_ioremap_resource
In-Reply-To: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376471493-22215-2-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Remove unneeded error handling on the result of a call to
platform_get_resource when the value is passed to devm_ioremap_resource.

Move the call to platform_get_resource adjacent to the call to
devm_ioremap_resource to make the connection between them more clear.

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
 drivers/pinctrl/pinctrl-nomadik.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 89280bc..be126fc 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1055,10 +1055,6 @@ static int nmk_gpio_probe(struct platform_device *dev)
 		pdata->num_gpio   = NMK_GPIO_PER_CHIP;
 	}
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0)
 		return irq;
@@ -1067,6 +1063,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	if (secondary_irq >= 0 && !pdata->get_secondary_status)
 		return -EINVAL;
 
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&dev->dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
