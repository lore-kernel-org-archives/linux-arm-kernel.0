From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 14 Aug 2015 16:11:04 +0200
Subject: [PATCH v3 7/9] gpiolib-sysfs: Add gpio name parsing for sysfs export
In-Reply-To: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439561466-14350-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib-sysfs.c | 47 ++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 2022cfb00aeb..e401878d05ce 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -455,18 +455,28 @@ static ssize_t export_store(struct class *class,
 				const char *buf, size_t len)
 {
 	long			gpio;
-	struct gpio_desc	*desc;
+	struct gpio_desc	*desc = NULL;
 	int			status;
 
 	status = kstrtol(buf, 0, &gpio);
-	if (status < 0)
-		goto done;
+	if (!status)
+		desc = gpio_to_desc(gpio);
 
-	desc = gpio_to_desc(gpio);
-	/* reject invalid GPIOs */
+	/* Fall back on detection by name */
 	if (!desc) {
-		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
-		return -EINVAL;
+		char *gpio_name = kstrdup(buf, GFP_KERNEL);
+
+		if (!gpio_name)
+			return -ENOMEM;
+
+		desc = gpio_name_to_desc(strim(gpio_name));
+		kfree(gpio_name);
+
+		/* reject invalid GPIOs */
+		if (!desc) {
+			pr_warn("%s: invalid GPIO %s\n", __func__, buf);
+			return -EINVAL;
+		}
 	}
 
 	/* No extra locking here; FLAG_SYSFS just signifies that the
@@ -497,17 +507,28 @@ static ssize_t unexport_store(struct class *class,
 				const char *buf, size_t len)
 {
 	long			gpio;
-	struct gpio_desc	*desc;
+	struct gpio_desc	*desc = NULL;
 	int			status;
 
 	status = kstrtol(buf, 0, &gpio);
-	if (status < 0)
-		goto done;
+	if (!status)
+		desc = gpio_to_desc(gpio);
+
+	/* Fall back on detection by name */
+	if (!desc) {
+		char *gpio_name = kstrdup(buf, GFP_KERNEL);
+
+		if (!gpio_name)
+			return -ENOMEM;
+
+		desc = gpio_name_to_desc(strim(gpio_name));
+		kfree(gpio_name);
+	}
+
 
-	desc = gpio_to_desc(gpio);
 	/* reject bogus commands (gpio_unexport ignores them) */
 	if (!desc) {
-		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
+		pr_warn("%s: invalid GPIO %s\n", __func__, buf);
 		return -EINVAL;
 	}
 
@@ -521,7 +542,7 @@ static ssize_t unexport_store(struct class *class,
 		status = 0;
 		gpiod_free(desc);
 	}
-done:
+
 	if (status)
 		pr_debug("%s: status %d\n", __func__, status);
 	return status ? : len;
-- 
2.4.6
