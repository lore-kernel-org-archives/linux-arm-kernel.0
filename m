From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 11 Oct 2010 13:59:05 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
Message-ID: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/gpio.txt specifies that the value argument to
gpio_set_value() should be handled as a boolean (E.G. != 0 is high),
so use the same logic as in _set_direction().

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/plat-mxc/gpio.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 57ec4a8..e226801 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -234,8 +234,13 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	u32 l;
 	unsigned long flags;
 
+
 	spin_lock_irqsave(&port->lock, flags);
-	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
+	l = __raw_readl(reg);
+	if (value)
+		l |= 1 << offset;
+	else
+		l &= ~(1 << offset);
 	__raw_writel(l, reg);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-- 
1.7.1
