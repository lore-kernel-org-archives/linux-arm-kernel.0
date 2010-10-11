From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 11 Oct 2010 15:02:06 +0200
Subject: [PATCHv2] mxc/gpio: make _set_value work with values != 0/1
Message-ID: <1286802126-11981-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/gpio.txt specifies that the value argument to
gpio_set_value() should be handled as a boolean (E.G. != 0 is high),
so use the same logic as in _set_direction().

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Use !! form, get rid of extra line

 arch/arm/plat-mxc/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 57ec4a8..9d38da0 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -235,7 +235,7 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
+	l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);
 	__raw_writel(l, reg);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-- 
1.7.1
