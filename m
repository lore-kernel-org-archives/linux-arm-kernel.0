From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Sep 2016 14:14:37 +0200
Subject: [PATCH 1/6] gpio: constify gpio_chip structures
In-Reply-To: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1473596082-32690-2-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These structures are only used to copy into other structures, so declare
them as const.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct gpio_chip i at p = { ... };

@ok@
identifier r.i;
expression e;
position p;
@@
e = i at p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct gpio_chip e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct gpio_chip i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpio/gpio-arizona.c  |    2 +-
 drivers/gpio/gpio-bcm-kona.c |    2 +-
 drivers/gpio/gpio-da9052.c   |    2 +-
 drivers/gpio/gpio-da9055.c   |    2 +-
 drivers/gpio/gpio-it87.c     |    2 +-
 drivers/gpio/gpio-lp873x.c   |    2 +-
 drivers/gpio/gpio-lpc18xx.c  |    2 +-
 drivers/gpio/gpio-pisosr.c   |    2 +-
 drivers/gpio/gpio-sch.c      |    2 +-
 drivers/gpio/gpio-stmpe.c    |    2 +-
 drivers/gpio/gpio-tc3589x.c  |    2 +-
 drivers/gpio/gpio-tpic2810.c |    2 +-
 drivers/gpio/gpio-tps65086.c |    2 +-
 drivers/gpio/gpio-tps65218.c |    2 +-
 drivers/gpio/gpio-tps65912.c |    2 +-
 drivers/gpio/gpio-ts4900.c   |    2 +-
 drivers/gpio/gpio-twl4030.c  |    2 +-
 drivers/gpio/gpio-wm831x.c   |    2 +-
 drivers/gpio/gpio-wm8350.c   |    2 +-
 drivers/gpio/gpio-wm8994.c   |    2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index 9913704..4824628 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -79,7 +79,7 @@ static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			   ARIZONA_GPN_LVL, value);
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "arizona",
 	.owner			= THIS_MODULE,
 	.direction_input	= arizona_gpio_direction_in,
diff --git a/drivers/gpio/gpio-wm831x.c b/drivers/gpio/gpio-wm831x.c
index 21f97bc..533707f 100644
--- a/drivers/gpio/gpio-wm831x.c
+++ b/drivers/gpio/gpio-wm831x.c
@@ -247,7 +247,7 @@ static void wm831x_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #define wm831x_gpio_dbg_show NULL
 #endif
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "wm831x",
 	.owner			= THIS_MODULE,
 	.direction_input	= wm831x_gpio_direction_in,
diff --git a/drivers/gpio/gpio-wm8350.c b/drivers/gpio/gpio-wm8350.c
index e976570..e46752e 100644
--- a/drivers/gpio/gpio-wm8350.c
+++ b/drivers/gpio/gpio-wm8350.c
@@ -93,7 +93,7 @@ static int wm8350_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return wm8350->irq_base + WM8350_IRQ_GPIO(offset);
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "wm8350",
 	.owner			= THIS_MODULE,
 	.direction_input	= wm8350_gpio_direction_in,
diff --git a/drivers/gpio/gpio-wm8994.c b/drivers/gpio/gpio-wm8994.c
index 2457aac..68410fd 100644
--- a/drivers/gpio/gpio-wm8994.c
+++ b/drivers/gpio/gpio-wm8994.c
@@ -249,7 +249,7 @@ static void wm8994_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #define wm8994_gpio_dbg_show NULL
 #endif
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "wm8994",
 	.owner			= THIS_MODULE,
 	.request		= wm8994_gpio_request,
diff --git a/drivers/gpio/gpio-it87.c b/drivers/gpio/gpio-it87.c
index 63a962d..45d29e4 100644
--- a/drivers/gpio/gpio-it87.c
+++ b/drivers/gpio/gpio-it87.c
@@ -273,7 +273,7 @@ exit:
 	return rc;
 }
 
-static struct gpio_chip it87_template_chip = {
+static const struct gpio_chip it87_template_chip = {
 	.label			= KBUILD_MODNAME,
 	.owner			= THIS_MODULE,
 	.request		= it87_gpio_request,
diff --git a/drivers/gpio/gpio-lp873x.c b/drivers/gpio/gpio-lp873x.c
index f10d49d..134f6b3 100644
--- a/drivers/gpio/gpio-lp873x.c
+++ b/drivers/gpio/gpio-lp873x.c
@@ -124,7 +124,7 @@ static int lp873x_gpio_set_single_ended(struct gpio_chip *gc,
 	}
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "lp873x-gpio",
 	.owner			= THIS_MODULE,
 	.request		= lp873x_gpio_request,
diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index cb14b8d..f5545049 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -90,7 +90,7 @@ static int pisosr_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return (gpio->buffer[offset / 8] >> (offset % 8)) & 0x1;
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "pisosr-gpio",
 	.owner			= THIS_MODULE,
 	.get_direction		= pisosr_gpio_get_direction,
diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index eb43ae4..5450044 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -138,7 +138,7 @@ static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned gpio_num,
 	return 0;
 }
 
-static struct gpio_chip sch_gpio_chip = {
+static const struct gpio_chip sch_gpio_chip = {
 	.label			= "sch_gpio",
 	.owner			= THIS_MODULE,
 	.direction_input	= sch_gpio_direction_in,
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 5c0d818..b51c5be 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -121,7 +121,7 @@ static int stmpe_gpio_request(struct gpio_chip *chip, unsigned offset)
 	return stmpe_set_altfunc(stmpe, 1 << offset, STMPE_BLOCK_GPIO);
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "stmpe",
 	.owner			= THIS_MODULE,
 	.get_direction		= stmpe_gpio_get_direction,
diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 8b36593..5baa457 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -124,7 +124,7 @@ static int tc3589x_gpio_single_ended(struct gpio_chip *chip,
 	return -ENOTSUPP;
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "tc3589x",
 	.owner			= THIS_MODULE,
 	.direction_input	= tc3589x_gpio_direction_input,
diff --git a/drivers/gpio/gpio-tpic2810.c b/drivers/gpio/gpio-tpic2810.c
index cace79c..c8b34d7 100644
--- a/drivers/gpio/gpio-tpic2810.c
+++ b/drivers/gpio/gpio-tpic2810.c
@@ -87,7 +87,7 @@ static void tpic2810_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 	tpic2810_set_mask_bits(chip, *mask, *bits);
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "tpic2810",
 	.owner			= THIS_MODULE,
 	.get_direction		= tpic2810_get_direction,
diff --git a/drivers/gpio/gpio-tps65086.c b/drivers/gpio/gpio-tps65086.c
index 8e25f01..b23c4d2 100644
--- a/drivers/gpio/gpio-tps65086.c
+++ b/drivers/gpio/gpio-tps65086.c
@@ -72,7 +72,7 @@ static void tps65086_gpio_set(struct gpio_chip *chip, unsigned offset,
 			   BIT(4 + offset), value ? BIT(4 + offset) : 0);
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "tps65086-gpio",
 	.owner			= THIS_MODULE,
 	.get_direction		= tps65086_gpio_get_direction,
diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 1c09a19..03e0dfb 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -172,7 +172,7 @@ static int tps65218_gpio_set_single_ended(struct gpio_chip *gc,
 	return -ENOTSUPP;
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "gpio-tps65218",
 	.owner			= THIS_MODULE,
 	.request		= tps65218_gpio_request,
diff --git a/drivers/gpio/gpio-tps65912.c b/drivers/gpio/gpio-tps65912.c
index acfd30a..abc0798 100644
--- a/drivers/gpio/gpio-tps65912.c
+++ b/drivers/gpio/gpio-tps65912.c
@@ -90,7 +90,7 @@ static void tps65912_gpio_set(struct gpio_chip *gc, unsigned offset,
 			   GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "tps65912-gpio",
 	.owner			= THIS_MODULE,
 	.get_direction		= tps65912_gpio_get_direction,
diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index 9dd9aca..5bd2172 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -101,7 +101,7 @@ static const struct regmap_config ts4900_regmap_config = {
 	.val_bits = 8,
 };
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "ts4900-gpio",
 	.owner			= THIS_MODULE,
 	.get_direction		= ts4900_gpio_get_direction,
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 4b807b0..dfcfbba 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -381,7 +381,7 @@ static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
 		: -EINVAL;
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label			= "twl4030",
 	.owner			= THIS_MODULE,
 	.request		= twl_request,
diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index 98832c9..f12e02e 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -78,7 +78,7 @@ static int lpc18xx_gpio_direction_output(struct gpio_chip *chip,
 	return lpc18xx_gpio_direction(chip, offset, true);
 }
 
-static struct gpio_chip lpc18xx_chip = {
+static const struct gpio_chip lpc18xx_chip = {
 	.label			= "lpc18xx/43xx-gpio",
 	.request		= gpiochip_generic_request,
 	.free			= gpiochip_generic_free,
diff --git a/drivers/gpio/gpio-da9052.c b/drivers/gpio/gpio-da9052.c
index e29553b..dd8977c 100644
--- a/drivers/gpio/gpio-da9052.c
+++ b/drivers/gpio/gpio-da9052.c
@@ -184,7 +184,7 @@ static int da9052_gpio_to_irq(struct gpio_chip *gc, u32 offset)
 	return irq;
 }
 
-static struct gpio_chip reference_gp = {
+static const struct gpio_chip reference_gp = {
 	.label = "da9052-gpio",
 	.owner = THIS_MODULE,
 	.get = da9052_gpio_get,
diff --git a/drivers/gpio/gpio-da9055.c b/drivers/gpio/gpio-da9055.c
index 2c2c18d..82053b5 100644
--- a/drivers/gpio/gpio-da9055.c
+++ b/drivers/gpio/gpio-da9055.c
@@ -121,7 +121,7 @@ static int da9055_gpio_to_irq(struct gpio_chip *gc, u32 offset)
 				  DA9055_IRQ_GPI0 + offset);
 }
 
-static struct gpio_chip reference_gp = {
+static const struct gpio_chip reference_gp = {
 	.label = "da9055-gpio",
 	.owner = THIS_MODULE,
 	.get = da9055_gpio_get,
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 953e4b8..3d1cf01 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -308,7 +308,7 @@ static int bcm_kona_gpio_set_debounce(struct gpio_chip *chip, unsigned gpio,
 	return 0;
 }
 
-static struct gpio_chip template_chip = {
+static const struct gpio_chip template_chip = {
 	.label = "bcm-kona-gpio",
 	.owner = THIS_MODULE,
 	.request = bcm_kona_gpio_request,
