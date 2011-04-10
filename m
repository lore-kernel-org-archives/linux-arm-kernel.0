From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 10 Apr 2011 17:33:16 +0200
Subject: [patch 2/2] Add GPIO DT support to s3c24xx
References: <20110410152735.338798127@gmail.com>
Message-ID: <20110410153316.GC27088@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

Assign proper OF node (= with matching physical base address) to each
s3c24xx GPIO chip.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---
 arch/arm/plat-s3c24xx/gpiolib.c |   45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

Index: b/arch/arm/plat-s3c24xx/gpiolib.c
===================================================================
--- a/arch/arm/plat-s3c24xx/gpiolib.c	2011-04-10 16:24:59.000000000 +0200
+++ b/arch/arm/plat-s3c24xx/gpiolib.c	2011-04-10 17:12:32.000000000 +0200
@@ -19,6 +19,8 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -97,6 +99,9 @@
 			.direction_input	= s3c24xx_gpiolib_banka_input,
 			.direction_output	= s3c24xx_gpiolib_banka_output,
 		},
+#ifdef CONFIG_OF_GPIO
+		.dt_compat = "samsung,s3c2410-gpio-a",
+#endif
 	},
 	[1] = {
 		.base	= S3C2410_GPBCON,
@@ -210,6 +215,45 @@
 	},
 };
 
+#ifdef CONFIG_OF_GPIO
+static int s3c24xx_of_base_match(struct s3c_gpio_chip *chip, struct device_node *dn)
+{
+	const u32 *addrp;
+	u64 addr;
+
+	addrp = of_get_address(dn, 0, 0, NULL);
+	if (!addrp)
+		return 0;
+
+	addr = of_translate_address(dn, addrp);
+	if (addr == OF_BAD_ADDR)
+		return 0;
+
+	return chip->base == (addr - S3C24XX_PA_GPIO + S3C24XX_VA_GPIO);
+}
+
+static void s3c24xx_attach_of_node(struct s3c_gpio_chip *chip)
+{
+	struct device_node *dn;
+
+	if (!chip->dt_compat)
+		chip->dt_compat = "samsung,s3c2410-gpio";
+
+	for_each_compatible_node(dn, NULL, chip->dt_compat) {
+		if (s3c24xx_of_base_match(chip, dn)) {
+			chip->chip.of_node = dn;
+			break;
+		}
+	}
+}
+
+#else
+
+static void s3c24xx_attach_of_node(struct s3c_gpio_chip *chip)
+{
+}
+
+#endif
 
 static __init int s3c24xx_gpiolib_init(void)
 {
@@ -220,6 +264,7 @@
 		if (!chip->config)
 			chip->config = &s3c24xx_gpiocfg_default;
 
+		s3c24xx_attach_of_node(chip);
 		s3c_gpiolib_add(chip);
 	}
 
