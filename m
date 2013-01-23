From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:25:45 +0800
Subject: [PATCH 01/10] gpio: pxa: set initcall level to module init
In-Reply-To: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358929554-32265-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio & pinctrl driver are used together. The pinctrl driver is already
launched before gpio driver in Makefile. So set gpio driver to module
init level. Otherwise, the sequence will be inverted.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 8325f58..9cc108d 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -642,12 +642,7 @@ static struct platform_driver pxa_gpio_driver = {
 		.of_match_table = of_match_ptr(pxa_gpio_dt_ids),
 	},
 };
-
-static int __init pxa_gpio_init(void)
-{
-	return platform_driver_register(&pxa_gpio_driver);
-}
-postcore_initcall(pxa_gpio_init);
+module_platform_driver(pxa_gpio_driver);
 
 #ifdef CONFIG_PM
 static int pxa_gpio_suspend(void)
-- 
1.7.10.4
