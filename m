From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:23:55 +0900
Subject: [PATCH 2/9] ARM: shmobile: ap4evb: Use gpio_request_one()
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 70d287c..0c59464 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1046,9 +1046,7 @@ static int ts_get_pendown_state(void)
 
 	gpio_free(GPIO_TSC_IRQ);
 
-	gpio_request(GPIO_TSC_PORT, NULL);
-
-	gpio_direction_input(GPIO_TSC_PORT);
+	gpio_request_one(GPIO_TSC_PORT, GPIOF_IN, NULL);
 
 	val = gpio_get_value(GPIO_TSC_PORT);
 
@@ -1129,18 +1127,10 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
 	/* enable Debug switch (S6) */
-	gpio_request(GPIO_PORT32, NULL);
-	gpio_request(GPIO_PORT33, NULL);
-	gpio_request(GPIO_PORT34, NULL);
-	gpio_request(GPIO_PORT35, NULL);
-	gpio_direction_input(GPIO_PORT32);
-	gpio_direction_input(GPIO_PORT33);
-	gpio_direction_input(GPIO_PORT34);
-	gpio_direction_input(GPIO_PORT35);
-	gpio_export(GPIO_PORT32, 0);
-	gpio_export(GPIO_PORT33, 0);
-	gpio_export(GPIO_PORT34, 0);
-	gpio_export(GPIO_PORT35, 0);
+	gpio_request_one(GPIO_PORT32, GPIOF_IN | GPIOF_EXPORT, NULL);
+	gpio_request_one(GPIO_PORT33, GPIOF_IN | GPIOF_EXPORT, NULL);
+	gpio_request_one(GPIO_PORT34, GPIOF_IN | GPIOF_EXPORT, NULL);
+	gpio_request_one(GPIO_PORT35, GPIOF_IN | GPIOF_EXPORT, NULL);
 
 	/* SDHI0 */
 	gpio_request(GPIO_FN_SDHICD0, NULL);
@@ -1188,8 +1178,7 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
 	gpio_request(GPIO_FN_FSIAISLD,	NULL);
 	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-	gpio_request(GPIO_PORT161,	NULL);
-	gpio_direction_output(GPIO_PORT161, 0); /* slave */
+	gpio_request_one(GPIO_PORT161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
 
 	gpio_request(GPIO_PORT9, NULL);
 	gpio_request(GPIO_PORT10, NULL);
@@ -1197,8 +1186,7 @@ static void __init ap4evb_init(void)
 	gpio_direction_none(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
 	/* card detect pin for MMC slot (CN7) */
-	gpio_request(GPIO_PORT41, NULL);
-	gpio_direction_input(GPIO_PORT41);
+	gpio_request_one(GPIO_PORT41, GPIOF_IN, NULL);
 
 	/* setup FSI2 port B (HDMI) */
 	gpio_request(GPIO_FN_FSIBCK, NULL);
@@ -1286,11 +1274,8 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_LCDDISP,  NULL);
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
-	gpio_request(GPIO_PORT189, NULL); /* backlight */
-	gpio_direction_output(GPIO_PORT189, 1);
-
-	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
-	gpio_direction_output(GPIO_PORT151, 1);
+	gpio_request_one(GPIO_PORT189, GPIOF_OUT_INIT_HIGH, NULL); /* backlight */
+	gpio_request_one(GPIO_PORT151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
 	lcdc_info.clock_source			= LCDC_CLK_BUS;
 	lcdc_info.ch[0].interface_type		= RGB18;
-- 
1.7.10.4
