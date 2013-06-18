From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 18 Jun 2013 12:29:49 +0200
Subject: [PATCH v2 2/2] gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific
 sections
In-Reply-To: <1371551389-5493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1371551389-5493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1371551389-5493-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All functions and data types used by OF-specific code paths are declared
in <linux/of.h> regardless of CONFIG_OF. Replace the #ifdef CONFIG_OF
guard with a if(IS_ENABLED(CONFIG_OF)) and let the compiler optimize
the unused code away.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpio/gpio-rcar.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 5a693dd..7fd09ef 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -279,16 +279,13 @@ static struct irq_domain_ops gpio_rcar_irq_domain_ops = {
 static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
 {
 	struct gpio_rcar_config *pdata = p->pdev->dev.platform_data;
-#ifdef CONFIG_OF
 	struct device_node *np = p->pdev->dev.of_node;
 	struct of_phandle_args args;
 	int ret;
-#endif
 
-	if (pdata)
+	if (pdata) {
 		p->config = *pdata;
-#ifdef CONFIG_OF
-	else if (np) {
+	} else if (IS_ENABLED(CONFIG_OF) && np) {
 		ret = of_parse_phandle_with_args(np, "gpio-ranges",
 				"#gpio-range-cells", 0, &args);
 		p->config.number_of_pins = ret == 0 && args.args_count == 3
@@ -296,7 +293,6 @@ static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
 					 : RCAR_MAX_GPIO_PER_BANK;
 		p->config.gpio_base = -1;
 	}
-#endif
 
 	if (p->config.number_of_pins == 0 ||
 	    p->config.number_of_pins > RCAR_MAX_GPIO_PER_BANK) {
-- 
1.8.1.5
