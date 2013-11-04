From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  4 Nov 2013 09:04:56 +0100
Subject: [PATCH] ARM: footbridge: fix build warning
Message-ID: <1383552296-16275-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The raw spinlock in the netwinder GPIO implementation was using
non-raw accessors, fix this warning from the autobuilder:

arch/arm/mach-footbridge/netwinder-hw.c:695:2:
warning: passing argument 1 of 'spinlock_check' from
incompatible pointer type [enabled by default]
arch/arm/mach-footbridge/netwinder-hw.c:702:2:
warning: passing argument 1 of 'spin_unlock_irqrestore' from
incompatible pointer type [enabled by default]
arch/arm/mach-footbridge/netwinder-hw.c:712:2:
warning: passing argument 1 of 'spinlock_check' from
incompatible pointer type [enabled by default]
arch/arm/mach-footbridge/netwinder-hw.c:714:2:
warning: passing argument 1 of 'spin_unlock_irqrestore' from
incompatible pointer type [enabled by default]

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly to fixes.
---
 arch/arm/mach-footbridge/netwinder-hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index 1fd2cf097e30..eb1fa5c84723 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -692,14 +692,14 @@ static void netwinder_led_set(struct led_classdev *cdev,
 	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	reg = nw_gpio_read();
 	if (b != LED_OFF)
 		reg &= ~led->mask;
 	else
 		reg |= led->mask;
 	nw_gpio_modify_op(led->mask, reg);
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 }
 
 static enum led_brightness netwinder_led_get(struct led_classdev *cdev)
@@ -709,9 +709,9 @@ static enum led_brightness netwinder_led_get(struct led_classdev *cdev)
 	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&nw_gpio_lock, flags);
+	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
 	reg = nw_gpio_read();
-	spin_unlock_irqrestore(&nw_gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 
 	return (reg & led->mask) ? LED_OFF : LED_FULL;
 }
-- 
1.8.3.1
