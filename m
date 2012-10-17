From: stigge@antcom.de (Roland Stigge)
Date: Wed, 17 Oct 2012 14:31:39 +0200
Subject: [PATCH RFC 07/15 v5] gpio-generic: Add block GPIO API
In-Reply-To: <1350477107-26512-1-git-send-email-stigge@antcom.de>
References: <1350477107-26512-1-git-send-email-stigge@antcom.de>
Message-ID: <1350477107-26512-8-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds block GPIO API support to the gpio-generic driver.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/gpio/gpio-generic.c |   56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

--- linux-2.6.orig/drivers/gpio/gpio-generic.c
+++ linux-2.6/drivers/gpio/gpio-generic.c
@@ -122,6 +122,13 @@ static int bgpio_get(struct gpio_chip *g
 	return bgc->read_reg(bgc->reg_dat) & bgc->pin2mask(bgc, gpio);
 }
 
+static unsigned long bgpio_get_block(struct gpio_chip *gc, unsigned long mask)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+
+	return bgc->read_reg(bgc->reg_dat) & mask;
+}
+
 static void bgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct bgpio_chip *bgc = to_bgpio_chip(gc);
@@ -170,6 +177,51 @@ static void bgpio_set_set(struct gpio_ch
 	spin_unlock_irqrestore(&bgc->lock, flags);
 }
 
+static void bgpio_set_block(struct gpio_chip *gc, unsigned long mask,
+			    unsigned long values)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bgc->lock, flags);
+
+	bgc->data &= ~mask;
+	bgc->data |= values & mask;
+
+	bgc->write_reg(bgc->reg_dat, bgc->data);
+
+	spin_unlock_irqrestore(&bgc->lock, flags);
+}
+
+static void bgpio_set_with_clear_block(struct gpio_chip *gc, unsigned long mask,
+				       unsigned long values)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+	unsigned long set_bits = values & mask;
+	unsigned long clr_bits = ~values & mask;
+
+	if (set_bits)
+		bgc->write_reg(bgc->reg_set, set_bits);
+	if (clr_bits)
+		bgc->write_reg(bgc->reg_set, clr_bits);
+}
+
+static void bgpio_set_set_block(struct gpio_chip *gc, unsigned long mask,
+				unsigned long values)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bgc->lock, flags);
+
+	bgc->data &= ~mask;
+	bgc->data |= values & mask;
+
+	bgc->write_reg(bgc->reg_set, bgc->data);
+
+	spin_unlock_irqrestore(&bgc->lock, flags);
+}
+
 static int bgpio_simple_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	return 0;
@@ -317,14 +369,18 @@ static int bgpio_setup_io(struct bgpio_c
 		bgc->reg_set = set;
 		bgc->reg_clr = clr;
 		bgc->gc.set = bgpio_set_with_clear;
+		bgc->gc.set_block = bgpio_set_with_clear_block;
 	} else if (set && !clr) {
 		bgc->reg_set = set;
 		bgc->gc.set = bgpio_set_set;
+		bgc->gc.set_block = bgpio_set_set_block;
 	} else {
 		bgc->gc.set = bgpio_set;
+		bgc->gc.set_block = bgpio_set_block;
 	}
 
 	bgc->gc.get = bgpio_get;
+	bgc->gc.get_block = bgpio_get_block;
 
 	return 0;
 }
