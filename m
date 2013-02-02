From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 01:25:44 +0800
Subject: [PATCH v8 03/12] gpio: find gpio base by ascend order
In-Reply-To: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1359825953-15663-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpiochip_find_base() always tries to find valid gpio with descend order.
It's inconvient if gpio information is passing from DTS. Now try to find
valid gpio with ascend order.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpiolib.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 199fca1..8af57e7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -128,20 +128,21 @@ static int gpiochip_find_base(int ngpio)
 	int spare = 0;
 	int base = -ENOSPC;
 
-	for (i = ARCH_NR_GPIOS - 1; i >= 0 ; i--) {
+	for (i = 0, base = 0; i < ARCH_NR_GPIOS; i++) {
 		struct gpio_desc *desc = &gpio_desc[i];
 		struct gpio_chip *chip = desc->chip;
 
-		if (!chip && !test_bit(FLAG_RESERVED, &desc->flags)) {
+		if (chip) {
+			spare = 0;
+			i += chip->ngpio - 1;
+			base = i + 1;
+		} else if (test_bit(FLAG_RESERVED, &desc->flags)) {
+			spare = 0;
+			base = i + 1;
+		} else {
 			spare++;
-			if (spare == ngpio) {
-				base = i;
+			if (spare == ngpio)
 				break;
-			}
-		} else {
-			spare = 0;
-			if (chip)
-				i -= chip->ngpio - 1;
 		}
 	}
 
-- 
1.7.10.4
