From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 16:00:25 +0900
Subject: [PATCH] ARM: Samsung: Add helper function for setup gpios
Message-ID: <20100930070025.GA11677@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

There are many places setup GPIOs for configuring the pin and pull state.
With this helper function we can make it simple codes.

Before:
        /* Set all the necessary GPK0[0:1] pins to special-function 2 */
        for (gpio = S5PV310_GPK0(0); gpio < S5PV310_GPK0(2); gpio++) {
                s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
                s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
        }

        switch (width) {
        case 8:
                /* GPK1[3:6] special-funtion 3 */
                for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
                        s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
                        s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
                }
        case 4:
                /* GPK0[3:6] special-funtion 2 */
                for (gpio = S5PV310_GPK0(3); gpio <= S5PV310_GPK0(6); gpio++) {
                        s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
                        s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
                }
        default:
                break;
        }
After:

        /* Set all the necessary GPK0[0:1] pins to special-function 2 */
        s3c_setup_gpios(S5PV310_GPK0(0), S5PV310_GPK0(1),
                                S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
        switch (width) {
        case 8:
                /* GPK1[3:6] special-funtion 3 */
                s3c_setup_gpios(S5PV310_GPK1(3), S5PV310_GPK1(6),
                                S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
        case 4:
                /* GPK0[3:6] special-funtion 2 */
                s3c_setup_gpios(S5PV310_GPK0(3), S5PV310_GPK0(6),
                                S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
        default:
                break;
        }

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index e3d41ea..66b838f 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -80,6 +80,20 @@ int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull)
 }
 EXPORT_SYMBOL(s3c_gpio_setpull);
 
+int s3c_setup_gpios(unsigned int start, unsigned int end,
+			unsigned int config, s3c_gpio_pull_t pull)
+{
+	unsigned int gpio;
+
+	for (gpio = start; gpio <= end; gpio++) {
+		s3c_gpio_cfgpin(gpio, config);
+		s3c_gpio_setpull(gpio, pull);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(s3c_setup_gpios);
+
 #ifdef CONFIG_S3C_GPIO_CFG_S3C24XX
 int s3c_gpio_setcfg_s3c24xx_a(struct s3c_gpio_chip *chip,
 			      unsigned int off, unsigned int cfg)
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index 1c6b929..6ac9091 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -133,6 +133,19 @@ extern unsigned s3c_gpio_getcfg(unsigned int pin);
 extern int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull);
 
 /**
+ * s3c_setup_gpios() - Change & set gpios pin from start to end
+ * @start: The start pin number to configure
+ * @end: The end pin number to configure
+ * @config: The configuration for the pin's function.
+ * @pull: The configuration for the pull resistor.
+ *
+ * Helper functions to do both s3c_gpio_cfgpin and s3c_gpio_setpull
+ * with range
+ */
+extern int s3c_setup_gpios(unsigned int start, unsigned int end,
+			unsigned int config, s3c_gpio_pull_t pull);
+
+/**
  * s3c_gpio_getpull() - get the pull resistor state of a gpio pin
  * @pin: The pin number to get the settings for
  *
