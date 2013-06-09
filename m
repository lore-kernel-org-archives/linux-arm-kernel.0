From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sun,  9 Jun 2013 11:08:32 +0800
Subject: [PATCH] gpiolib: remove warnning of allocations with IRQs disabled
Message-ID: <1370747312-25957-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move of_gpiochip_add outof spin_lock, since kzalloc inside
of_gpiochip_add -> of_gpiochip_add_pin_range -> gpiochip_add_pin_range -> kzalloc

WARNING: at kernel/lockdep.c:2740 lockdep_trace_alloc+0xf8/0xfc()
DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/gpio/gpiolib.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c2534d6..ff0fd65 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1214,15 +1214,14 @@ int gpiochip_add(struct gpio_chip *chip)
 		}
 	}
 
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&chip->pin_ranges);
 #endif
 
 	of_gpiochip_add(chip);
 
-unlock:
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
 	if (status)
 		goto fail;
 
@@ -1235,6 +1234,9 @@ unlock:
 		chip->label ? : "generic");
 
 	return 0;
+
+unlock:
+	spin_unlock_irqrestore(&gpio_lock, flags);
 fail:
 	/* failures here can mean systems won't boot... */
 	pr_err("gpiochip_add: gpios %d..%d (%s) failed to register\n",
-- 
1.7.9.5
