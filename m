From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:23:54 +0900
Subject: [PATCH 1/9] ARM: shmobile: ag5evm: Use gpio_request_one()
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 032d108..5e7fe15 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -479,11 +479,10 @@ static void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
 	static int power_gpio = -EINVAL;
 
 	if (power_gpio < 0) {
-		int ret = gpio_request(GPIO_PORT114, "sdhi1_power");
-		if (!ret) {
+		int ret = gpio_request_one(GPIO_PORT114, GPIOF_OUT_INIT_LOW,
+					   "sdhi1_power");
+		if (!ret)
 			power_gpio = GPIO_PORT114;
-			gpio_direction_output(power_gpio, 0);
-		}
 	}
 
 	/*
@@ -604,14 +603,11 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_MMCD0_5_PU, NULL);
 	gpio_request(GPIO_FN_MMCD0_6_PU, NULL);
 	gpio_request(GPIO_FN_MMCD0_7_PU, NULL);
-	gpio_request(GPIO_PORT208, NULL); /* Reset */
-	gpio_direction_output(GPIO_PORT208, 1);
+	gpio_request_one(GPIO_PORT208, GPIOF_OUT_INIT_HIGH, NULL); /* Reset */
 
 	/* enable SMSC911X */
-	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
-	gpio_direction_input(GPIO_PORT144);
-	gpio_request(GPIO_PORT145, NULL); /* RESET */
-	gpio_direction_output(GPIO_PORT145, 1);
+	gpio_request_one(GPIO_PORT144, GPIOF_IN, NULL); /* PINTA2 */
+	gpio_request_one(GPIO_PORT145, GPIOF_OUT_INIT_HIGH, NULL); /* RESET */
 
 	/* FSI A */
 	gpio_request(GPIO_FN_FSIACK, NULL);
@@ -626,15 +622,13 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_PORT243_IRDA_FIRSEL, NULL);
 
 	/* LCD panel */
-	gpio_request(GPIO_PORT217, NULL); /* RESET */
-	gpio_direction_output(GPIO_PORT217, 0);
+	gpio_request_one(GPIO_PORT217, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
 	mdelay(1);
 	gpio_set_value(GPIO_PORT217, 1);
 	mdelay(100);
 
 	/* LCD backlight controller */
-	gpio_request(GPIO_PORT235, NULL); /* RESET */
-	gpio_direction_output(GPIO_PORT235, 0);
+	gpio_request_one(GPIO_PORT235, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
 	lcd_backlight_set_brightness(0);
 
 	/* enable SDHI0 on CN15 [SD I/F] */
-- 
1.7.10.4
