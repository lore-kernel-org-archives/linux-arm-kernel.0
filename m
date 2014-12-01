From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  1 Dec 2014 16:25:09 +0000
Subject: [PATCH] ARM: imx: irq: fix buggy usage of irq_data irq field
Message-ID: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-imx directly references to the irq field in
struct irq_data, and uses this to directly poke hardware register.

But irq is the *virtual* irq number, something that has nothing
to do with the actual HW irq (stored in the hwirq field). And once
we put the stacked domain code in action, the whole thing explodes,
as these two values are *very* different.

Just replacing all instances of irq with hwirq fixes the issue.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-imx/gpc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 82ea74e..1455829 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -56,14 +56,14 @@ void imx_gpc_post_resume(void)
 
 static int imx_gpc_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	unsigned int idx = d->irq / 32 - 1;
+	unsigned int idx = d->hwirq / 32 - 1;
 	u32 mask;
 
 	/* Sanity check for SPI irq */
-	if (d->irq < 32)
+	if (d->hwirq < 32)
 		return -EINVAL;
 
-	mask = 1 << d->irq % 32;
+	mask = 1 << d->hwirq % 32;
 	gpc_wake_irqs[idx] = on ? gpc_wake_irqs[idx] | mask :
 				  gpc_wake_irqs[idx] & ~mask;
 
@@ -97,12 +97,12 @@ void imx_gpc_irq_unmask(struct irq_data *d)
 	u32 val;
 
 	/* Sanity check for SPI irq */
-	if (d->irq < 32)
+	if (d->hwirq < 32)
 		return;
 
-	reg = gpc_base + GPC_IMR1 + (d->irq / 32 - 1) * 4;
+	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
 	val = readl_relaxed(reg);
-	val &= ~(1 << d->irq % 32);
+	val &= ~(1 << d->hwirq % 32);
 	writel_relaxed(val, reg);
 }
 
@@ -112,12 +112,12 @@ void imx_gpc_irq_mask(struct irq_data *d)
 	u32 val;
 
 	/* Sanity check for SPI irq */
-	if (d->irq < 32)
+	if (d->hwirq < 32)
 		return;
 
-	reg = gpc_base + GPC_IMR1 + (d->irq / 32 - 1) * 4;
+	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
 	val = readl_relaxed(reg);
-	val |= 1 << (d->irq % 32);
+	val |= 1 << (d->hwirq % 32);
 	writel_relaxed(val, reg);
 }
 
-- 
2.1.3
