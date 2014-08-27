From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 27 Aug 2014 15:18:08 +0530
Subject: [PATCH 05/14] pinctrl: exynos: Add driver data for Exynos7
In-Reply-To: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
References: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409132889-2080-5-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds driver data for Exynos7
to pinctrl-exynos driver. Exynos7 includes 229 multi-functional
input/output ports. There are 40 general port groups.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: linus.walleij at linaro.org
Cc: Thomas Abraham <thomas.ab@samsung.com>
---
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 drivers/pinctrl/samsung/Kconfig                    |    2 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  145 ++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    1 +
 5 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index e82aaf4..2da258f 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -18,6 +18,7 @@ Required Properties:
   - "samsung,exynos5250-pinctrl": for Exynos5250 compatible pin-controller.
   - "samsung,exynos5260-pinctrl": for Exynos5260 compatible pin-controller.
   - "samsung,exynos5420-pinctrl": for Exynos5420 compatible pin-controller.
+  - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
diff --git a/drivers/pinctrl/samsung/Kconfig b/drivers/pinctrl/samsung/Kconfig
index d0461cd..c660d31 100644
--- a/drivers/pinctrl/samsung/Kconfig
+++ b/drivers/pinctrl/samsung/Kconfig
@@ -8,7 +8,7 @@ config PINCTRL_SAMSUNG
 
 config PINCTRL_EXYNOS
 	bool "Pinctrl driver data for Samsung EXYNOS SoCs other than 5440"
-	depends on OF && GPIOLIB && (ARCH_EXYNOS || ARCH_S5PV210)
+	depends on OF && GPIOLIB && (ARCH_EXYNOS || ARCH_S5PV210 || ARCH_EXYNOS7)
 	select PINCTRL_SAMSUNG
 
 config PINCTRL_EXYNOS5440
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 003bfd8..8e9152b 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1121,3 +1121,148 @@ struct samsung_pin_ctrl exynos5420_pin_ctrl[] = {
 		.label		= "exynos5420-gpio-ctrl4",
 	},
 };
+
+/* pin banks of exynos7 pin-controller 0 */
+static struct samsung_pin_bank exynos7_pin_banks0[] = {
+	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
+};
+
+/* pin banks of exynos7 pin-controller 1 (AUD) */
+static struct samsung_pin_bank exynos7_pin_banks1[] = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+};
+
+/* pin banks of exynos7 pin-controller 2 (BUS0) */
+static struct samsung_pin_bank exynos7_pin_banks2[] = {
+	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpb0", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(2, 0x040, "gpc1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(6, 0x060, "gpc2", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpc3", 0x14),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x18),
+	EXYNOS_PIN_BANK_EINTG(6, 0x0c0, "gpd1", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpd2", 0x20),
+	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpd4", 0x24),
+	EXYNOS_PIN_BANK_EINTG(4, 0x120, "gpd5", 0x28),
+	EXYNOS_PIN_BANK_EINTG(6, 0x140, "gpd6", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(3, 0x160, "gpd7", 0x30),
+	EXYNOS_PIN_BANK_EINTG(2, 0x180, "gpd8", 0x34),
+	EXYNOS_PIN_BANK_EINTG(2, 0x1a0, "gpg0", 0x38),
+	EXYNOS_PIN_BANK_EINTG(4, 0x1c0, "gpg3", 0x3c),
+};
+
+/* pin banks of exynos7 pin-controller 3 (BUS1) */
+static struct samsung_pin_bank exynos7_pin_banks3[] = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpf0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpf1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpf2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpf3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpf4", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0c0, "gpf5", 0x14),
+	EXYNOS_PIN_BANK_EINTG(5, 0x0e0, "gpg1", 0x18),
+	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpg2", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(6, 0x120, "gph1", 0x20),
+	EXYNOS_PIN_BANK_EINTG(3, 0x140, "gpv6", 0x24),
+};
+
+/* pin banks of exynos7 pin-controller 4 (NFC) */
+static struct samsung_pin_bank exynos7_pin_banks4[] = {
+	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller 5 (TOUCH) */
+static struct samsung_pin_bank exynos7_pin_banks5[] = {
+	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller 6 (FF) */
+static struct samsung_pin_bank exynos7_pin_banks6[] = {
+	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpg4", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller 7 (ESE) */
+static struct samsung_pin_bank exynos7_pin_banks7[] = {
+	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpv7", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller 8 (FSYS0) */
+static struct samsung_pin_bank exynos7_pin_banks8[] = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpr4", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller 9 (FSYS1) */
+static struct samsung_pin_bank exynos7_pin_banks9[] = {
+	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpr0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpr1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr3", 0x0c),
+};
+
+struct samsung_pin_ctrl exynos7_pin_ctrl[] = {
+	{
+		/* pin-controller instance 0 Alive data */
+		.pin_banks	= exynos7_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.label		= "exynos7-gpio-ctrl0",
+	}, {
+		/* pin-controller instance 1 AUD data */
+		.pin_banks	= exynos7_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl1",
+	}, {
+		/* pin-controller instance 2 BUS0 data */
+		.pin_banks	= exynos7_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl2",
+	}, {
+		/* pin-controller instance 3 BUS1 data */
+		.pin_banks	= exynos7_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl3",
+	}, {
+		/* pin-controller instance 4 NFC data */
+		.pin_banks	= exynos7_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks4),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl4",
+	}, {
+		/* pin-controller instance 5 TOUCH data */
+		.pin_banks	= exynos7_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks5),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl5",
+	}, {
+		/* pin-controller instance 6 FF data */
+		.pin_banks	= exynos7_pin_banks6,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks6),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl6",
+	}, {
+		/* pin-controller instance 7 ESE data */
+		.pin_banks	= exynos7_pin_banks7,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks7),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl7",
+	}, {
+		/* pin-controller instance 8 FSYS0 data */
+		.pin_banks	= exynos7_pin_banks8,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks8),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl8",
+	}, {
+		/* pin-controller instance 9 FSYS1 data */
+		.pin_banks	= exynos7_pin_banks9,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks9),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos7-gpio-ctrl9",
+	},
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index b07406d..dd996b2f 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1232,6 +1232,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = (void *)exynos5420_pin_ctrl },
 	{ .compatible = "samsung,s5pv210-pinctrl",
 		.data = (void *)s5pv210_pin_ctrl },
+	{ .compatible = "samsung,exynos7-pinctrl",
+		.data = (void *)exynos7_pin_ctrl },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 2b88232..d070a6d 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -241,6 +241,7 @@ extern struct samsung_pin_ctrl exynos4x12_pin_ctrl[];
 extern struct samsung_pin_ctrl exynos5250_pin_ctrl[];
 extern struct samsung_pin_ctrl exynos5260_pin_ctrl[];
 extern struct samsung_pin_ctrl exynos5420_pin_ctrl[];
+extern struct samsung_pin_ctrl exynos7_pin_ctrl[];
 extern struct samsung_pin_ctrl s3c64xx_pin_ctrl[];
 extern struct samsung_pin_ctrl s3c2412_pin_ctrl[];
 extern struct samsung_pin_ctrl s3c2416_pin_ctrl[];
-- 
1.7.9.5
