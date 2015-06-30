From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 30 Jun 2015 09:45:26 +0200
Subject: [PATCH 6/7] pinctrl: sh-pfc: Move sh_pfc_add_gpiochip() up
In-Reply-To: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1435650327-2542-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move sh_pfc_add_gpiochip() to the generic helper section at the top of
the file, so it can be called from the "Function GPIOs" section later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/gpio.c | 58 +++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index b8929b5e2fa26c53..30654e800580524d 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -131,6 +131,35 @@ static int gpio_setup_data_regs(struct sh_pfc_chip *chip)
 	return 0;
 }
 
+static struct sh_pfc_chip *
+sh_pfc_add_gpiochip(struct sh_pfc *pfc, int(*setup)(struct sh_pfc_chip *),
+		    struct sh_pfc_window *mem)
+{
+	struct sh_pfc_chip *chip;
+	int ret;
+
+	chip = devm_kzalloc(pfc->dev, sizeof(*chip), GFP_KERNEL);
+	if (unlikely(!chip))
+		return ERR_PTR(-ENOMEM);
+
+	chip->mem = mem;
+	chip->pfc = pfc;
+
+	ret = setup(chip);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ret = gpiochip_add(&chip->gpio_chip);
+	if (unlikely(ret < 0))
+		return ERR_PTR(ret);
+
+	dev_info(pfc->dev, "%s handling gpio %u -> %u\n",
+		 chip->gpio_chip.label, chip->gpio_chip.base,
+		 chip->gpio_chip.base + chip->gpio_chip.ngpio - 1);
+
+	return chip;
+}
+
 /* -----------------------------------------------------------------------------
  * Pin GPIOs
  */
@@ -305,35 +334,6 @@ static int gpio_function_setup(struct sh_pfc_chip *chip)
  * Register/unregister
  */
 
-static struct sh_pfc_chip *
-sh_pfc_add_gpiochip(struct sh_pfc *pfc, int(*setup)(struct sh_pfc_chip *),
-		    struct sh_pfc_window *mem)
-{
-	struct sh_pfc_chip *chip;
-	int ret;
-
-	chip = devm_kzalloc(pfc->dev, sizeof(*chip), GFP_KERNEL);
-	if (unlikely(!chip))
-		return ERR_PTR(-ENOMEM);
-
-	chip->mem = mem;
-	chip->pfc = pfc;
-
-	ret = setup(chip);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	ret = gpiochip_add(&chip->gpio_chip);
-	if (unlikely(ret < 0))
-		return ERR_PTR(ret);
-
-	dev_info(pfc->dev, "%s handling gpio %u -> %u\n",
-		 chip->gpio_chip.label, chip->gpio_chip.base,
-		 chip->gpio_chip.base + chip->gpio_chip.ngpio - 1);
-
-	return chip;
-}
-
 int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 {
 	struct sh_pfc_chip *chip;
-- 
1.9.1
