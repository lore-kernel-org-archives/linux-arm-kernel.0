From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 15 Jun 2016 20:22:34 +0200
Subject: [PATCH] Revert "gpio: bail out silently on NULL descriptors"
Message-ID: <1466014954-17956-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 54d77198fdfb("gpio: bail out silently on NULL
descriptors").

This commit causes the following code to fail:

gpio_desc = devm_gpiod_get_optional(dev, ...);
gpio_irq  = gpiod_to_irq(gpio_desc);
if (gpio_irq >= 0) {
	ret = devm_request_irq(dev, gpio_irq, ...);

And now ret is an error causing the probe function in question to bail.

The problem here is that gpiod_to_irq now returns 0 for a NULL
gpio_desc while 0 is a valid irq-nr. Also see:
commit 4c37ce8608a8("gpio: make gpiod_to_irq() return negative for NO_IRQ")
which specifically avoids returning 0.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 24f60d2..6c33a07 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1367,13 +1367,10 @@ done:
 /*
  * This descriptor validation needs to be inserted verbatim into each
  * function taking a descriptor, so we need to use a preprocessor
- * macro to avoid endless duplication. If the desc is NULL it is an
- * optional GPIO and calls should just bail out.
+ * macro to avoid endless duplication.
  */
 #define VALIDATE_DESC(desc) do { \
-	if (!desc) \
-		return 0; \
-	if (!desc->gdev) { \
+	if (!desc || !desc->gdev) { \
 		pr_warn("%s: invalid GPIO\n", __func__); \
 		return -EINVAL; \
 	} \
@@ -1384,9 +1381,7 @@ done:
 	} } while (0)
 
 #define VALIDATE_DESC_VOID(desc) do { \
-	if (!desc) \
-		return; \
-	if (!desc->gdev) { \
+	if (!desc || !desc->gdev) { \
 		pr_warn("%s: invalid GPIO\n", __func__); \
 		return; \
 	} \
-- 
2.7.4
