From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Sep 2013 15:43:26 +0200
Subject: [PATCH 1/2] gpio: rcar: Remove #gpio-range-cells DT property usage
In-Reply-To: <1378907007-19152-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1378907007-19152-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1378907007-19152-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a1bc260bb5f5d95da854be7898202d788e94448d ("gpio: clean up
gpio-ranges documentation") deprecated the #gpio-range-cells property.
Replace its usage with a hardcoded value in the gpio-rcar driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpio/gpio-rcar.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e3745eb..6038966 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -293,10 +293,9 @@ static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
 	if (pdata) {
 		p->config = *pdata;
 	} else if (IS_ENABLED(CONFIG_OF) && np) {
-		ret = of_parse_phandle_with_args(np, "gpio-ranges",
-				"#gpio-range-cells", 0, &args);
-		p->config.number_of_pins = ret == 0 && args.args_count == 3
-					 ? args.args[2]
+		ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
+						       &args);
+		p->config.number_of_pins = ret == 0 ? args.args[2]
 					 : RCAR_MAX_GPIO_PER_BANK;
 		p->config.gpio_base = -1;
 	}
-- 
1.8.1.5
