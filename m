From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 01:25:43 +0800
Subject: [PATCH v8 02/12] gpio: fix wrong checking condition for gpio range
In-Reply-To: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1359825953-15663-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If index++ calculates from 0, the checking condition of "while
(index++)" fails & it doesn't check any more. It doesn't follow
the loop that used at here.

Replace it by endless loop at here. Then it keeps parsing
"gpio-ranges" property until it ends.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpiolib-of.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 380f84e..dae24c0 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -228,7 +228,7 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 	if (!np)
 		return;
 
-	do {
+	for (;; index++) {
 		ret = of_parse_phandle_with_args(np, "gpio-ranges",
 				"#gpio-range-cells", index, &pinspec);
 		if (ret)
@@ -246,8 +246,7 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 
 		if (ret)
 			break;
-
-	} while (index++);
+	}
 }
 
 #else
-- 
1.7.10.4
