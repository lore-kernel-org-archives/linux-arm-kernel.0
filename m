From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 4 Apr 2013 15:16:12 -0500
Subject: [PATCH 1/5] gpio/omap: free irq domain in probe() failure paths
In-Reply-To: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1365106576-31816-2-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the IRQ domain is not freed once allocated, in the case where
omap_gpio_probe() fails. Therefore, ensure we free the domain if the
probe does fail. Furthermore, the local variable "ret" is not needed
and so remove this.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0d30c7a..1e666c8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1094,7 +1094,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	const struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
-	int ret = 0;
 
 	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
 
@@ -1143,18 +1142,21 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
 		dev_err(dev, "Invalid mem resource\n");
+		irq_domain_remove(bank->domain);
 		return -ENODEV;
 	}
 
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
 				     pdev->name)) {
 		dev_err(dev, "Region already claimed\n");
+		irq_domain_remove(bank->domain);
 		return -EBUSY;
 	}
 
 	bank->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!bank->base) {
 		dev_err(dev, "Could not ioremap\n");
+		irq_domain_remove(bank->domain);
 		return -ENOMEM;
 	}
 
@@ -1178,7 +1180,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	list_add_tail(&bank->node, &omap_gpio_list);
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
-- 
1.7.10.4
