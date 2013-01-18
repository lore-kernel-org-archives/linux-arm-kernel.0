From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 15:31:09 +0800
Subject: [PATCH v7 05/15] gpio: fix wrong checking condition for gpio range
In-Reply-To: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358494279-16503-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since index++ calculates from 0, the checking condition of "while
(index++)" is always fake. So replace it by unconditional loop.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpiolib-of.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index b1f0682..011e1e98 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -228,7 +228,7 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 	if (!np)
 		return;
 
-	do {
+	for (;;) {
 		ret = of_parse_phandle_with_args(np, "gpio-ranges",
 				"#gpio-range-cells", index, &pinspec);
 		if (ret)
@@ -254,8 +254,8 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 
 		if (ret)
 			break;
-
-	} while (index++);
+		index++;
+	}
 }
 
 #else
-- 
1.7.10.4
