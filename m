From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 17:04:46 +0900
Subject: [PATCH] ARM: SAMSUNG: Add the missed s3c_gpio_getpull() API
Message-ID: <1287648286-7202-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daein Moon <moon9124@samsung.com>

This patch adds the s3c_gpio_getpull() API that has been missed in the
plat-samsung/gpio-config.c and actullay there is its extern declaration
in plat/gpio-cfg.h.

Signed-off-by: Daein Moon <moon9124@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE:
- already issued about this

 arch/arm/plat-samsung/gpio-config.c                |   19 +++++++++++++++++++
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |    6 ++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index 8a37211..b732b77 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -111,6 +111,25 @@ int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull)
 }
 EXPORT_SYMBOL(s3c_gpio_setpull);
 
+s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin)
+{
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	unsigned long flags;
+	int offset;
+	u32 pup = 0;
+
+	if (chip) {
+		offset = pin - chip->chip.base;
+
+		s3c_gpio_lock(chip, flags);
+		pup = s3c_gpio_do_getpull(chip, offset);
+		s3c_gpio_unlock(chip, flags);
+	}
+
+	return (__force s3c_gpio_pull_t)pup;
+}
+EXPORT_SYMBOL(s3c_gpio_getpull);
+
 #ifdef CONFIG_S3C_GPIO_CFG_S3C24XX
 int s3c_gpio_setcfg_s3c24xx_a(struct s3c_gpio_chip *chip,
 			      unsigned int off, unsigned int cfg)
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
index 3e21c75..c417f85 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
@@ -42,6 +42,12 @@ static inline int s3c_gpio_do_setpull(struct s3c_gpio_chip *chip,
 	return (chip->config->set_pull)(chip, off, pull);
 }
 
+static inline unsigned s3c_gpio_do_getpull(struct s3c_gpio_chip *chip,
+					   unsigned int off)
+{
+	return (chip->config->get_pull)(chip, off);
+}
+
 /**
  * s3c_gpio_setcfg_s3c24xx - S3C24XX style GPIO configuration.
  * @chip: The gpio chip that is being configured.
-- 
1.6.3.3
