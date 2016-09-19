From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Sep 2016 10:22:10 +0200
Subject: [PATCH] pinctrl: nomadik: don't default-flag IRQs as falling
Message-ID: <1474273330-15789-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point in adding any default trigger for these
GPIO interrupts: the device tree should contain all trigger
information and the platforms using the driver boots
exclusively from device tree.

Also the boot log is nagging me to fix this:

[    0.771057] ------------[ cut here ]------------
[    0.775695] WARNING: CPU: 0 PID: 1 at
   ../drivers/gpio/gpiolib.c:1622 _gpiochip_irqchip_add+0x138/0x160
[    0.785034] /soc/gpio at 8012e000: Ignoring 2 default trigger
(...)
[    0.942962] gpio 8012e000.gpio: at address e08f8000
(etc ad nauseam)

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 205fb399268a..d318ca055489 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1177,7 +1177,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 				   irqchip,
 				   0,
 				   handle_edge_irq,
-				   IRQ_TYPE_EDGE_FALLING);
+				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_err(&dev->dev, "could not add irqchip\n");
 		gpiochip_remove(&nmk_chip->chip);
-- 
2.7.4
