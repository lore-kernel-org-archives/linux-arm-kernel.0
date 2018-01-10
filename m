From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  9 Jan 2018 17:58:46 -0800
Subject: [PATCH 1/3] gpiolib: Export gpiochip_irqchip_irq_valid() to drivers
In-Reply-To: <20180110015848.11480-1-sboyd@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
Message-ID: <20180110015848.11480-2-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pinctrl drivers can use the gpiochip irq valid information
to figure out if certain gpios are exposed to the kernel for
usage or not. Expose this API so we can use it in the
pinmux_ops::request ops.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/gpio/gpiolib.c      | 5 +++--
 include/linux/gpio/driver.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b80936a25caa..c18b7b60ea1d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1503,14 +1503,15 @@ static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gpiochip)
 	gpiochip->irq.valid_mask = NULL;
 }
 
-static bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
-				       unsigned int offset)
+bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
+				unsigned int offset)
 {
 	/* No mask means all valid */
 	if (likely(!gpiochip->irq.valid_mask))
 		return true;
 	return test_bit(offset, gpiochip->irq.valid_mask);
 }
+EXPORT_SYMBOL_GPL(gpiochip_irqchip_irq_valid);
 
 /**
  * gpiochip_set_cascaded_irqchip() - connects a cascaded irqchip to a gpiochip
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 7258cd676df4..1ba9a331ec51 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -436,6 +436,9 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gpiochip,
 			     struct lock_class_key *lock_key,
 			     struct lock_class_key *request_key);
 
+bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
+				unsigned int offset);
+
 #ifdef CONFIG_LOCKDEP
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
