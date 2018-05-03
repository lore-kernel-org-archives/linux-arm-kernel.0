From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  3 May 2018 14:13:57 +0800
Subject: [PATCH] pinctrl: rockchip: Disable interrupt when changing it's
 capability
Message-ID: <20180503061357.5697-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We saw spurious irq when changing irq's trigger type, for example
setting gpio-keys's wakeup irq trigger type.

And according to the TRM:
"Programming the GPIO registers for interrupt capability, edge-sensitive
or level-sensitive interrupts, and interrupt polarity should be
completed prior to enabling the interrupts on Port A in order to prevent
spurious glitches on the interrupt lines to the interrupt controller."

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/pinctrl/pinctrl-rockchip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 3924779f55785..7ff45ec8330d1 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2727,9 +2727,19 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
+	/**
+	 * According to the TRM, we should keep irq disabled during programming
+	 * interrupt capability to prevent spurious glitches on the interrupt
+	 * lines to the interrupt controller.
+	 */
+	data = readl(bank->reg_base + GPIO_INTEN);
+	writel_relaxed(data & ~mask, gc->reg_base + GPIO_INTEN);
+
 	writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
 	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
 
+	writel_relaxed(data, gc->reg_base + GPIO_INTEN);
+
 	irq_gc_unlock(gc);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
-- 
2.11.0
