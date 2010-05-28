From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:38 +0100
Subject: [PATCH 01/15] ARM: SAMSUNG: Add GPIO configuration for a range of pins
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add s3c_gpio_cfgpin_range() to configure a range of pins to the given
value. This is useful for a number of blocks where the pins are in order
and saves multiple calls to s3c_gpio_cfgpin().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/gpio-config.c           |   15 +++++++++++++++
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |   13 +++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index 57b68a5..a927dd2 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -41,6 +41,21 @@ int s3c_gpio_cfgpin(unsigned int pin, unsigned int config)
 }
 EXPORT_SYMBOL(s3c_gpio_cfgpin);
 
+int s3c_gpio_cfgpin_range(unsigned int start, unsigned int nr,
+			  unsigned int cfg)
+{
+	int ret;
+
+	for (; nr > 0; nr--, start++) {
+		ret = s3c_gpio_cfgpin(start, cfg);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s3c_gpio_cfgpin_range);
+
 unsigned s3c_gpio_getcfg(unsigned int pin)
 {
 	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index 34efdd2..8ec9936 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -89,6 +89,19 @@ extern int s3c_gpio_cfgpin(unsigned int pin, unsigned int to);
  */
 extern unsigned s3c_gpio_getcfg(unsigned int pin);
 
+/**
+ * s3c_gpio_cfgpin_range() - Change the GPIO function for configuring pin range
+ * @start: The pin number to start at
+ * @number: The number of pins to configure from @start.
+ * @cfg: The configuration for the pin's function
+ *
+ * Call s3c_gpio_cfgpin() for the @number pins starting at @start.
+ *
+ * @sa s3c_gpio_cfgpin.
+ */
+extern int s3c_gpio_cfgpin_range(unsigned int start, unsigned int nr,
+				 unsigned int cfg);
+
 /* Define values for the pull-{up,down} available for each gpio pin.
  *
  * These values control the state of the weak pull-{up,down} resistors
-- 
1.6.3.3
