From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 13:18:03 +0800
Subject: [PATCH 2/7] [ARM] locomo: avoid the unnecessary cascade of keyboard
	IRQ
In-Reply-To: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1261977488-18271-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not necessary and over-complicated that IRQ_LOCOMO_KEY is a cascaded
IRQ of IRQ_LOCOMO_KEY_BASE. Removed and introduced locomokbd_{open,close}
for masking/unmasking of the keyboard IRQ.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/common/locomo.c           |    5 +++--
 drivers/input/keyboard/locomokbd.c |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index bd36c77..43cdb5a 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -82,7 +82,7 @@ static struct locomo_dev_info locomo_devices[] = {
 	{
 		.devid 		= LOCOMO_DEVID_KEYBOARD,
 		.irq = {
-			IRQ_LOCOMO_KEY,
+			IRQ_LOCOMO_KEY_BASE,
 		},
 		.name		= "locomo-keyboard",
 		.offset		= LOCOMO_KEYBOARD,
@@ -470,7 +470,8 @@ static void locomo_setup_irq(struct locomo *lchip)
 	/* Install handlers for IRQ_LOCOMO_*_BASE */
 	set_irq_chip(IRQ_LOCOMO_KEY_BASE, &locomo_chip);
 	set_irq_chip_data(IRQ_LOCOMO_KEY_BASE, irqbase);
-	set_irq_chained_handler(IRQ_LOCOMO_KEY_BASE, locomo_key_handler);
+	set_irq_handler(IRQ_LOCOMO_KEY_BASE, handle_level_irq);
+	set_irq_flags(IRQ_LOCOMO_KEY_BASE, IRQF_VALID | IRQF_PROBE);
 
 	set_irq_chip(IRQ_LOCOMO_GPIO_BASE, &locomo_chip);
 	set_irq_chip_data(IRQ_LOCOMO_GPIO_BASE, irqbase);
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index 9caed30..b1ab298 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -192,11 +192,18 @@ static void locomokbd_scankeyboard(struct locomokbd *locomokbd)
 static irqreturn_t locomokbd_interrupt(int irq, void *dev_id)
 {
 	struct locomokbd *locomokbd = dev_id;
+	u16 r;
+
+	r = locomo_readl(locomokbd->base + LOCOMO_KIC);
+	if ((r & 0x0001) == 0)
+		return IRQ_HANDLED;
+
+	locomo_writel(r & ~0x0100, locomokbd->base + LOCOMO_KIC); /* Ack */
+
 	/** wait chattering delay **/
 	udelay(100);
 
 	locomokbd_scankeyboard(locomokbd);
-
 	return IRQ_HANDLED;
 }
 
@@ -210,6 +217,25 @@ static void locomokbd_timer_callback(unsigned long data)
 	locomokbd_scankeyboard(locomokbd);
 }
 
+static int locomokbd_open(struct input_dev *dev)
+{
+	struct locomokbd *locomokbd = input_get_drvdata(dev);
+	u16 r;
+	
+	r = locomo_readl(locomokbd->base + LOCOMO_KIC) | 0x0010;
+	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
+	return 0;
+}
+
+static void locomokbd_close(struct input_dev *dev)
+{
+	struct locomokbd *locomokbd = input_get_drvdata(dev);
+	u16 r;
+	
+	r = locomo_readl(locomokbd->base + LOCOMO_KIC) & ~0x0010;
+	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
+}
+
 static int __devinit locomokbd_probe(struct locomo_dev *dev)
 {
 	struct locomokbd *locomokbd;
@@ -253,6 +279,8 @@ static int __devinit locomokbd_probe(struct locomo_dev *dev)
 	input_dev->id.vendor = 0x0001;
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0100;
+	input_dev->open = locomokbd_open;
+	input_dev->close = locomokbd_close;
 	input_dev->dev.parent = &dev->dev;
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
@@ -261,6 +289,8 @@ static int __devinit locomokbd_probe(struct locomo_dev *dev)
 	input_dev->keycodesize = sizeof(locomokbd_keycode[0]);
 	input_dev->keycodemax = ARRAY_SIZE(locomokbd_keycode);
 
+	input_set_drvdata(input_dev, locomokbd);
+
 	memcpy(locomokbd->keycode, locomokbd_keycode, sizeof(locomokbd->keycode));
 	for (i = 0; i < LOCOMOKBD_NUMKEYS; i++)
 		set_bit(locomokbd->keycode[i], input_dev->keybit);
-- 
1.6.3.3
