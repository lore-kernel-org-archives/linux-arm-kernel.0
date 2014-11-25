From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 25 Nov 2014 16:19:12 +0100
Subject: [PATCH] ARM: orion: convert the irq_reg_{readl,
 writel} calls to the new API
Message-ID: <1416928752-24529-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit "genirq: Generic chip: Change irq_reg_{readl,writel}
arguments" modified the API. In the same tome the
arch/arm/plat-orion/gpio.c file received a fix with the use of the old
API: "ARM: orion: Fix for certain sequence of request_irq can cause
irq storm". This commit fixes the use of the API.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi Jason,

This patch fix a build error in linux-next:

arch/arm/plat-orion/gpio.c:509:12: error: too few arguments to function 'irq_reg_readl'
arch/arm/plat-orion/gpio.c:511:2: error: too few arguments to function 'irq_reg_writel'
arch/arm/plat-orion/gpio.c:523:12: error: too few arguments to function 'irq_reg_readl'
arch/arm/plat-orion/gpio.c:525:2: error: too few arguments to function 'irq_reg_writel'

But if we want to apply it on the mvebu branch we need to add a
dependecy to "332fd7c4fef5 genirq: Generic chip: Change
irq_reg_{readl,writel} arguments"

Thanks,

Gregory

 arch/arm/plat-orion/gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index e53fc8df7e4e..5168a52a17f9 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -506,9 +506,9 @@ static void orion_gpio_unmask_irq(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
-	reg_val = irq_reg_readl(gc->reg_base + ct->regs.mask);
+	reg_val = irq_reg_readl(gc, ct->regs.mask);
 	reg_val |= mask;
-	irq_reg_writel(reg_val, gc->reg_base + ct->regs.mask);
+	irq_reg_writel(gc, reg_val, ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
@@ -520,9 +520,9 @@ static void orion_gpio_mask_irq(struct irq_data *d)
 	u32 reg_val;
 
 	irq_gc_lock(gc);
-	reg_val = irq_reg_readl(gc->reg_base + ct->regs.mask);
+	reg_val = irq_reg_readl(gc, ct->regs.mask);
 	reg_val &= ~mask;
-	irq_reg_writel(reg_val, gc->reg_base + ct->regs.mask);
+	irq_reg_writel(gc, reg_val, ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
-- 
1.9.1
