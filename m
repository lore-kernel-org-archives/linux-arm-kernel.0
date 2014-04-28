From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 28 Apr 2014 23:12:08 +0200
Subject: [PATCH v2 3/3] irqchip: orion: reverse irq handling priority
In-Reply-To: <1398540855-27367-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398540855-27367-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398719528-23607-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-DT irq handlers were working through irq causes from most-significant
to least-significant bit, while DT irqchip driver does it the other way
round. This revealed some more HW issues on Kirkwood peripheral IP, where
spurious sdio irqs can happen although irqs are masked.

Also, the generated binaries show that original non-DT order compared
to DT order save two instructions for each bit count check:

irqchip DT order with ffs():
  60:   e3a06001        mov     r6, #1
  64:   e2643000        rsb     r3, r4, #0
  68:   e0033004        and     r3, r3, r4
  6c:   e16f3f13        clz     r3, r3
  70:   e263301f        rsb     r3, r3, #31
  74:   e1c44316        bic     r4, r4, r6, lsl r3
  78:   e5971004        ldr     r1, [r7, #4]

Original non-DT order with fls():
  60:   e3a07001        mov     r7, #1
  64:   e16f3f14        clz     r3, r4
  68:   e263301f        rsb     r3, r3, #31
  6c:   e1c44317        bic     r4, r4, r7, lsl r3
  70:   e5951004        ldr     r1, [r5, #4]

Therefore, reverse irq bit handling back to original order by replacing
ffs() with fls().

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
Changelog:
v1->v2:
- reword commit msg to state less number of instructions

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/irqchip/irq-orion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index e25f246cd2fb..34d18b48bb78 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -42,7 +42,7 @@ __exception_irq_entry orion_handle_irq(struct pt_regs *regs)
 		u32 stat = readl_relaxed(gc->reg_base + ORION_IRQ_CAUSE) &
 			gc->mask_cache;
 		while (stat) {
-			u32 hwirq = ffs(stat) - 1;
+			u32 hwirq = __fls(stat);
 			u32 irq = irq_find_mapping(orion_irq_domain,
 						   gc->irq_base + hwirq);
 			handle_IRQ(irq, regs);
@@ -117,7 +117,7 @@ static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc *desc)
 		   gc->mask_cache;
 
 	while (stat) {
-		u32 hwirq = ffs(stat) - 1;
+		u32 hwirq = __fls(stat);
 
 		generic_handle_irq(irq_find_mapping(d, gc->irq_base + hwirq));
 		stat &= ~(1 << hwirq);
-- 
1.9.1
