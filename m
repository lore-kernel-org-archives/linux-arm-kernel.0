From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 01 Feb 2012 18:32:32 +0530
Subject: [PATCH] gpio: samsung: adapt to changes in gpio specifier translator
 function declaration
Message-ID: <1328101352-22274-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 15c9a0acc3f7 (of: create of_phandle_args to simplify return of phandle
parsing data) modifies the parameter list of of_xlate function pointer declaration
in gpio_chip. Adapt the gpio specifier translate function for this change.

Reported-by: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/gpio/gpio-samsung.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index a766177..0a79a11 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2387,27 +2387,30 @@ static struct samsung_gpio_chip exynos4_gpios_3[] = {
 };
 
 #if defined(CONFIG_ARCH_EXYNOS4) && defined(CONFIG_OF)
-static int exynos4_gpio_xlate(struct gpio_chip *gc, struct device_node *np,
-			      const void *gpio_spec, u32 *flags)
+static int exynos4_gpio_xlate(struct gpio_chip *gc,
+			const struct of_phandle_args *gpiospec, u32 *flags)
 {
-	const __be32 *gpio = gpio_spec;
-	const u32 n = be32_to_cpup(gpio);
-	unsigned int pin = gc->base + be32_to_cpu(gpio[0]);
+	unsigned int pin;
 
 	if (WARN_ON(gc->of_gpio_n_cells < 4))
 		return -EINVAL;
 
-	if (n > gc->ngpio)
+	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
 		return -EINVAL;
 
-	if (s3c_gpio_cfgpin(pin, S3C_GPIO_SFN(be32_to_cpu(gpio[1]))))
+	if (gpiospec->args[0] > gc->ngpio)
+		return -EINVAL;
+
+	pin = gc->base + gpiospec->args[0];
+
+	if (s3c_gpio_cfgpin(pin, S3C_GPIO_SFN(gpiospec->args[1])))
 		pr_warn("gpio_xlate: failed to set pin function\n");
-	if (s3c_gpio_setpull(pin, be32_to_cpu(gpio[2])))
+	if (s3c_gpio_setpull(pin, gpiospec->args[2]))
 		pr_warn("gpio_xlate: failed to set pin pull up/down\n");
-	if (s5p_gpio_set_drvstr(pin, be32_to_cpu(gpio[3])))
+	if (s5p_gpio_set_drvstr(pin, gpiospec->args[3]))
 		pr_warn("gpio_xlate: failed to set pin drive strength\n");
 
-	return n;
+	return gpiospec->args[0];
 }
 
 static const struct of_device_id exynos4_gpio_dt_match[] __initdata = {
-- 
1.6.6.rc2
