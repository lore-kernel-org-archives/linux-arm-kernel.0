From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Aug 2017 13:49:47 +0900
Subject: [PATCH] pinctrl: nomadik: fix incorrect type in return expression
Message-ID: <1501822187-25303-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparse reports "warning: incorrect type in return expression (different
address spaces)" because nmk_gpio_populate_chip() is supposed to return
(struct nmk_gpio_chip *) whereas devm_ioremap_resource() returns
(void __iomem *).  ERR_CAST() is needed to fix the warning.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index d318ca055489..a53f1a9b1ed2 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1078,7 +1078,7 @@ static struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	res = platform_get_resource(gpio_pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
-		return base;
+		return ERR_CAST(base);
 	nmk_chip->addr = base;
 
 	clk = clk_get(&gpio_pdev->dev, NULL);
-- 
2.7.4
