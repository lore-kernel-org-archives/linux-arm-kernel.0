From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sun,  3 Feb 2013 01:29:25 +0900
Subject: [PATCH 2/9] gpiolib: use gpio_chips list in gpiolib_sysfs_init
In-Reply-To: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1359822572-26009-4-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the small list of GPIO chips instead of parsing the whole GPIO
number space.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpio/gpiolib.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0050766..4ceb4a7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -973,7 +973,7 @@ static int __init gpiolib_sysfs_init(void)
 {
 	int		status;
 	unsigned long	flags;
-	unsigned	gpio;
+	struct gpio_chip *chip;
 
 	status = class_register(&gpio_class);
 	if (status < 0)
@@ -986,10 +986,7 @@ static int __init gpiolib_sysfs_init(void)
 	 * registered, and so arch_initcall() can always gpio_export().
 	 */
 	spin_lock_irqsave(&gpio_lock, flags);
-	for (gpio = 0; gpio < ARCH_NR_GPIOS; gpio++) {
-		struct gpio_chip	*chip;
-
-		chip = gpio_desc[gpio].chip;
+	list_for_each_entry(chip, &gpio_chips, list) {
 		if (!chip || chip->exported)
 			continue;
 
-- 
1.8.1.1
