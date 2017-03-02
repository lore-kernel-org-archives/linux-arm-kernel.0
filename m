From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  2 Mar 2017 13:56:52 +0800
Subject: [PATCH] pinctrl: rockchip: add irq_enable & irq_disable ops
Message-ID: <1488434212-6567-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are trying to enable/disable the clk of irq's gpio bank when
unmask/mask irq. But the kernel's "lazy disable approach" will skip masking
irq when the irq chip doesn't support irq_disable ops.

So we may hit this case:
	irq_enable-> enable clk
	irq_disable-> noop
	irq_enable-> enable clk again
	irq_disable-> noop

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

 drivers/pinctrl/pinctrl-rockchip.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 7813599..a9a7dfa 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2061,7 +2061,7 @@ static void rockchip_irq_resume(struct irq_data *d)
 	clk_disable(bank->clk);
 }
 
-static void rockchip_irq_gc_mask_clr_bit(struct irq_data *d)
+static void rockchip_irq_enable(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
@@ -2070,7 +2070,7 @@ static void rockchip_irq_gc_mask_clr_bit(struct irq_data *d)
 	irq_gc_mask_clr_bit(d);
 }
 
-static void rockchip_irq_gc_mask_set_bit(struct irq_data *d)
+static void rockchip_irq_disable(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
@@ -2137,9 +2137,10 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 		gc->chip_types[0].regs.mask = GPIO_INTMASK;
 		gc->chip_types[0].regs.ack = GPIO_PORTS_EOI;
 		gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
-		gc->chip_types[0].chip.irq_mask = rockchip_irq_gc_mask_set_bit;
-		gc->chip_types[0].chip.irq_unmask =
-						  rockchip_irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_enable = rockchip_irq_enable;
+		gc->chip_types[0].chip.irq_disable = rockchip_irq_disable;
 		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
 		gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
 		gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
-- 
2.1.4
