From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  8 Feb 2010 10:09:38 +0100
Subject: [PATCH 1/3] gpiolib: make names array and its values const
In-Reply-To: <20100203155558.GH11354@pengutronix.de>
References: <20100203155558.GH11354@pengutronix.de>
Message-ID: <1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpiolib doesn't need to modify the names and I assume most initializers
use sting constants that shouldn't be modified anyhow.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Kevin Wells <kevin.wells@nxp.com>
---
 drivers/gpio/gpiolib.c      |    2 +-
 drivers/gpio/pca953x.c      |    2 +-
 include/asm-generic/gpio.h  |    2 +-
 include/linux/i2c/pca953x.h |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a25ad28..8543685 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -716,7 +716,7 @@ int gpio_export(unsigned gpio, bool direction_may_change)
 	unsigned long		flags;
 	struct gpio_desc	*desc;
 	int			status = -EINVAL;
-	char			*ioname = NULL;
+	const char		*ioname = NULL;
 
 	/* can't export until sysfs is available ... */
 	if (!gpio_class.p) {
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 6a2fb3f..4faeca4 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -56,7 +56,7 @@ struct pca953x_chip {
 	struct i2c_client *client;
 	struct pca953x_platform_data *dyn_pdata;
 	struct gpio_chip gpio_chip;
-	char **names;
+	const char *const *names;
 };
 
 static int pca953x_write_reg(struct pca953x_chip *chip, int reg, uint16_t val)
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 485eeb6..37af893 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -98,7 +98,7 @@ struct gpio_chip {
 						struct gpio_chip *chip);
 	int			base;
 	u16			ngpio;
-	char			**names;
+	const char		*const *names;
 	unsigned		can_sleep:1;
 	unsigned		exported:1;
 };
diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
index 81736d6..4630fab 100644
--- a/include/linux/i2c/pca953x.h
+++ b/include/linux/i2c/pca953x.h
@@ -15,5 +15,5 @@ struct pca953x_platform_data {
 	int		(*teardown)(struct i2c_client *client,
 				unsigned gpio, unsigned ngpio,
 				void *context);
-	char		**names;
+	const char	*const *names;
 };
-- 
1.6.6
