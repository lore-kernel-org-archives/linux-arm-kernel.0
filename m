From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Jul 2014 00:04:59 +0800
Subject: [PATCH] pinctrl: sunxi: Fix multi bank interrupt support in
 gpio_to_irq
Message-ID: <1404144299-740-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When mapping the interrupts, the gpio_to_irq function did not consider
the bank number of the gpio pin in question, only the offset or the
interrupt number in the bank. As a result, requests for interrupts in
the later banks get mapped to the first bank.

This issue was discovered while enabling mmc on the new sun8i platform.
The tablet I have uses a pin/interrupt from the second bank to do mmc
card detection. Tested on this very device with register inspection and
actual mmc card insertion/removal.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi,

This patch fixes gpios from the later banks used as external interrupts.
With this, mmc card detection works correctly on my A23 tablet. this
should also get MMC card detection working on the Mele M9.

This patch applies to pinctrl/for-next (4aba0a02ff8). It is a follow-up
fix for Maxime's multiple bank external interrupt support for sunxi pinctrl.
It is orthogonal to Hans' level/edge triggered gpio irqs series. It should
apply cleanly either way.


Cheers
ChenYu

---

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 66c3b42..33a5e87 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -521,6 +521,7 @@ static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct sunxi_pinctrl *pctl = dev_get_drvdata(chip->dev);
 	struct sunxi_desc_function *desc;
+	unsigned irqnum;
 
 	if (offset >= chip->ngpio)
 		return -ENXIO;
@@ -529,10 +530,12 @@ static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	if (!desc)
 		return -EINVAL;
 
+	irqnum = desc->irqbank * IRQ_PER_BANK + desc->irqnum;
+
 	dev_dbg(chip->dev, "%s: request IRQ for GPIO %d, return %d\n",
-		chip->label, offset + chip->base, desc->irqnum);
+		chip->label, offset + chip->base, irqnum);
 
-	return irq_find_mapping(pctl->domain, desc->irqnum);
+	return irq_find_mapping(pctl->domain, irqnum);
 }
 
 
-- 
2.0.0
