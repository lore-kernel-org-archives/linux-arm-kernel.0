From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 19 Aug 2015 12:18:31 +0200
Subject: [PATCH 2/3] gpiolib: gpiod_hog remove separate name argument
In-Reply-To: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
References: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439979512-3894-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@devmp.org>

The gpio name is now stored in the gpio descriptor, so we can simply use
that instead of an argument to the function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 drivers/gpio/gpiolib.c    | 8 ++++----
 drivers/gpio/gpiolib.h    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 48a7579dd62d..f1fe5123da28 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -232,7 +232,7 @@ static void of_gpiochip_scan_gpios(struct gpio_chip *chip)
 				continue;
 			}
 
-			if (gpiod_hog(desc, name, lflags, dflags))
+			if (gpiod_hog(desc, lflags, dflags))
 				continue;
 		}
 	}
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 872fdd3617c1..f1559fa72c36 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2181,15 +2181,15 @@ EXPORT_SYMBOL_GPL(__gpiod_get_index_optional);
 /**
  * gpiod_hog - Hog the specified GPIO desc given the provided flags
  * @desc:	gpio whose value will be assigned
- * @name:	gpio line name
  * @lflags:	gpio_lookup_flags - returned from of_find_gpio() or
  *		of_get_gpio_hog()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  */
-int gpiod_hog(struct gpio_desc *desc, const char *name,
-	      unsigned long lflags, enum gpiod_flags dflags)
+int gpiod_hog(struct gpio_desc *desc, unsigned long lflags,
+	      enum gpiod_flags dflags)
 {
 	int status;
+	const char *name = desc->name;
 
 	status = __gpiod_request(desc, name);
 	if (status) {
@@ -2211,7 +2211,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 	set_bit(FLAG_IS_HOGGED, &desc->flags);
 
 	pr_info("GPIO line %d (%s) hogged as %s%s\n",
-		desc_to_gpio(desc), name,
+		desc_to_gpio(desc), desc->name,
 		(dflags&GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
 		(dflags&GPIOD_FLAGS_BIT_DIR_OUT) ?
 		  (dflags&GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low":"");
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 78e634d1c719..6c2aeff59f86 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -97,8 +97,8 @@ struct gpio_desc {
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
-int gpiod_hog(struct gpio_desc *desc, const char *name,
-		unsigned long lflags, enum gpiod_flags dflags);
+int gpiod_hog(struct gpio_desc *desc, unsigned long lflags,
+	      enum gpiod_flags dflags);
 
 /*
  * Return the GPIO number of the passed descriptor relative to its chip
-- 
2.4.6
