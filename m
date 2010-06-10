From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Thu, 10 Jun 2010 15:26:01 +0530
Subject: [PATCH 3/3] nomadik-gpio: fix "ignoring return value" warning
In-Reply-To: <1276163761-28342-1-git-send-email-rabin.vincent@stericsson.com>
References: <1276163761-28342-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1276163761-28342-3-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/plat-nomadik/gpio.c: In function 'nmk_gpio_remove':
arch/arm/plat-nomadik/gpio.c:630: warning: ignoring return value of 'gpiochip_remove', declared with attribute warn_unused_result

Because this function is marked __exit and this code can't be built as a
module, this function is never used.  So just remove it, fixing the
warning in the process.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index b4aa299..dc736d2 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -619,30 +619,12 @@ out:
 	return ret;
 }
 
-static int __exit nmk_gpio_remove(struct platform_device *dev)
-{
-	struct nmk_gpio_chip *nmk_chip;
-	struct resource *res;
-
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-
-	nmk_chip = platform_get_drvdata(dev);
-	gpiochip_remove(&nmk_chip->chip);
-	clk_disable(nmk_chip->clk);
-	clk_put(nmk_chip->clk);
-	kfree(nmk_chip);
-	release_mem_region(res->start, resource_size(res));
-	return 0;
-}
-
-
 static struct platform_driver nmk_gpio_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "gpio",
 		},
 	.probe = nmk_gpio_probe,
-	.remove = __exit_p(nmk_gpio_remove),
 	.suspend = NULL, /* to be done */
 	.resume = NULL,
 };
-- 
1.7.0
