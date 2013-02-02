From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sun,  3 Feb 2013 01:29:27 +0900
Subject: [PATCH 4/9] gpiolib: use gpio_chips list in sysfs ops
In-Reply-To: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1359822572-26009-6-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the code both simpler and faster compared to parsing the GPIO
number space.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpio/gpiolib.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 92f9ee4..e473ded 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1889,45 +1889,28 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 {
 	struct gpio_chip *chip = NULL;
-	unsigned int gpio;
-	void *ret = NULL;
-	loff_t index = 0;
+	loff_t index = *pos;
 
 	/* REVISIT this isn't locked against gpio_chip removal ... */
 
-	for (gpio = 0; gpio_is_valid(gpio); gpio++) {
-		if (gpio_desc[gpio].chip == chip)
-			continue;
-
-		chip = gpio_desc[gpio].chip;
-		if (!chip)
-			continue;
-
-		if (index++ >= *pos) {
-			ret = chip;
-			break;
-		}
-	}
-
 	s->private = "";
 
-	return ret;
+	list_for_each_entry(chip, &gpio_chips, list)
+		if (index-- == 0)
+			return chip;
+
+	return NULL;
 }
 
 static void *gpiolib_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
 	struct gpio_chip *chip = v;
-	unsigned int gpio;
 	void *ret = NULL;
 
-	/* skip GPIOs provided by the current chip */
-	for (gpio = chip->base + chip->ngpio; gpio_is_valid(gpio); gpio++) {
-		chip = gpio_desc[gpio].chip;
-		if (chip) {
-			ret = chip;
-			break;
-		}
-	}
+	if (list_is_last(&chip->list, &gpio_chips))
+		ret = NULL;
+	else
+		ret = list_entry(chip->list.next, struct gpio_chip, list);
 
 	s->private = "\n";
 	++*pos;
-- 
1.8.1.1
