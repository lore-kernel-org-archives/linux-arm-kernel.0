From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Aug 2013 11:11:16 +0200
Subject: [PATCH 12/29] sound/soc/samsung/ac97.c: simplify use of
 devm_ioremap_resource
In-Reply-To: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376471493-22215-13-git-send-email-Julia.Lawall@lip6.fr>
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
 sound/soc/samsung/ac97.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 2dd623f..c732df9 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -404,18 +404,13 @@ static int s3c_ac97_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		dev_err(&pdev->dev, "Unable to get register resource\n");
-		return -ENXIO;
-	}
-
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq_res) {
 		dev_err(&pdev->dev, "AC97 IRQ not provided!\n");
 		return -ENXIO;
 	}
 
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	s3c_ac97.regs = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(s3c_ac97.regs))
 		return PTR_ERR(s3c_ac97.regs);
