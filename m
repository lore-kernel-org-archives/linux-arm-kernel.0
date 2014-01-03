From: 21cnbao@gmail.com (Barry Song)
Date: Fri,  3 Jan 2014 11:34:46 +0800
Subject: [PATCH RESEND] irqchip: sirf: set IRQ_LEVEL status_flags
Message-ID: <1388720086-13135-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SiRF internal interrupts are using level trigger. we need to tell the irq
core this information. otherwise, we might get some problems as below
1. disable_irq(n)
here irq core will mark the disabled flag but still keep the irq enabled
due to involved lazy-disable
2. doing someting after disable_irq(n)
in step 2, if one interrupt n comes, irq core will mark it as pending and
mask the HW interrupt really. we name the coming interrupt as "X".
3. enable_irq(n)
this will unmask the interrupt, so the level-trigger HW interrupt will come
again, irq_handler will enter as "E1". after that, irq core will also check
whether irq n is pending, if yes, and pending interrupt is not level-trigger,
irq core will execute the pending irq_handler.
so if we don't set the IRQ_LEVEL flag here, irq core will execute pending
X again as "E2", but actually the pending interrupt has been handled by "E1".
that makes a level-trigger HW interrupt is executed twice.

here we fix the issue to avoid redundant interrupt overload.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Huayi Li <Huayi.Li@csr.com>
---
 drivers/irqchip/irq-sirfsoc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
index 4851afa..3a070c5 100644
--- a/drivers/irqchip/irq-sirfsoc.c
+++ b/drivers/irqchip/irq-sirfsoc.c
@@ -34,9 +34,10 @@ sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 	struct irq_chip_type *ct;
 	int ret;
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	unsigned int set = IRQ_LEVEL;
 
 	ret = irq_alloc_domain_generic_chips(sirfsoc_irqdomain, num, 1, "irq_sirfsoc",
-		handle_level_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
+		handle_level_irq, clr, set, IRQ_GC_INIT_MASK_CACHE);
 
 	gc = irq_get_domain_generic_chip(sirfsoc_irqdomain, irq_start);
 	gc->reg_base = base;
-- 
1.7.5.4
