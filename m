From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sun,  3 Feb 2013 01:29:26 +0900
Subject: [PATCH 3/9] gpiolib: use gpio_chips list in gpiochip_find
In-Reply-To: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1359822572-26009-5-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the GPIO chips list is much faster than parsing the entire GPIO
number space.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpio/gpiolib.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4ceb4a7..92f9ee4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1194,20 +1194,17 @@ struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *chip,
 					     void *data))
 {
-	struct gpio_chip *chip = NULL;
+	struct gpio_chip *chip;
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&gpio_lock, flags);
-	for (i = 0; i < ARCH_NR_GPIOS; i++) {
-		if (!gpio_desc[i].chip)
-			continue;
-
-		if (match(gpio_desc[i].chip, data)) {
-			chip = gpio_desc[i].chip;
+	list_for_each_entry(chip, &gpio_chips, list)
+		if (match(chip, data))
 			break;
-		}
-	}
+
+	/* No match? */
+	if (&chip->list == &gpio_chips)
+		chip = NULL;
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	return chip;
-- 
1.8.1.1
