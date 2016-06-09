From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu,  9 Jun 2016 11:30:12 +0100
Subject: [PATCH] irqchip/vic: make vic_syscore_ops and vic_of_init static
Message-ID: <1465468212-2937-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vic_syscore_ops and vic_of_init functions are not exported
outside the driver, so make them static to remove the following
warnings:

drivers/irqchip/irq-vic.c:170:20: warning: symbol 'vic_syscore_ops' was not declared. Should it be static?
drivers/irqchip/irq-vic.c:520:12: warning: symbol 'vic_of_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/irqchip/irq-vic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index b956dff..f811a7d 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -167,7 +167,7 @@ static int vic_suspend(void)
 	return 0;
 }
 
-struct syscore_ops vic_syscore_ops = {
+static struct syscore_ops vic_syscore_ops = {
 	.suspend	= vic_suspend,
 	.resume		= vic_resume,
 };
@@ -517,7 +517,8 @@ int __init vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
 EXPORT_SYMBOL_GPL(vic_init_cascaded);
 
 #ifdef CONFIG_OF
-int __init vic_of_init(struct device_node *node, struct device_node *parent)
+static int __init vic_of_init(struct device_node *node,
+			      struct device_node *parent)
 {
 	void __iomem *regs;
 	u32 interrupt_mask = ~0;
-- 
2.8.1
