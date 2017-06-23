From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 23 Jun 2017 21:03:39 +0800
Subject: [RFC PATCH] pinctrl: rockchip: add irq_shutdown
Message-ID: <1498223019-9123-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the rockchip pinctrl driver would try to enable/disable the
gpio bank clk when enable/disable an irq.

So when the irq core trying to shutdown an already disabled irq, it
would result in unbalanced clk disable request:
[   35.911955] WARNING: at drivers/clk/clk.c:680
...
[   37.272271] Call trace:
[   37.274729] [<ffffffc0007ac270>] clk_core_disable+0x28/0x194
[   37.280395] [<ffffffc0007ac6a8>] clk_disable+0x34/0x48
[   37.285544] [<ffffffc0004f3bf0>] rockchip_irq_disable+0x30/0x3c
[   37.291472] [<ffffffc00027a7e0>] __irq_disable+0x40/0x64
[   37.296791] [<ffffffc00027a86c>] irq_shutdown+0x68/0x8c
[   37.302023] [<ffffffc0002777fc>] __free_irq+0x110/0x218
[   37.307254] [<ffffffc0002779a8>] free_irq+0x54/0x64
[   37.312138] [<ffffffc00027ba24>] devm_irq_release+0x24/0x30

Add an irq_shutdown callback, and do a sanity check for irq state to
prevent that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/pinctrl/pinctrl-rockchip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 607f52c..b0e3130 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2551,6 +2551,12 @@ static void rockchip_irq_disable(struct irq_data *d)
 	clk_disable(bank->clk);
 }
 
+static void rockchip_irq_shutdown(struct irq_data *d)
+{
+	if (!irqd_irq_disabled(d))
+		rockchip_irq_disable(d);
+}
+
 static void rockchip_irq_bus_lock(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -2641,6 +2647,7 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
 		gc->chip_types[0].chip.irq_enable = rockchip_irq_enable;
 		gc->chip_types[0].chip.irq_disable = rockchip_irq_disable;
+		gc->chip_types[0].chip.irq_shutdown = rockchip_irq_shutdown;
 		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
 		gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
 		gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
-- 
2.1.4
