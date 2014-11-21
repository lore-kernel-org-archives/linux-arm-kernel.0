From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 21 Nov 2014 15:52:46 +0300
Subject: [PATCH] ARM: warn if bad IRQ was scheduled
Message-ID: <1416574366-27182-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If somebody causes an unexpected bad IRQ, this even will be unnoticed in
both dmesg and system logs. If the "bad" IRQ is stuck, the device will
just hang silently w/o reporting anything. Compare this to the generic
behaviour (from include/asm-generic/hardirq.h) which prints a message
with critical level. So to help everybody, include the same message into
ARM-specific ack_bad_irq().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/include/asm/hw_irq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
index a71b417..b1fa129 100644
--- a/arch/arm/include/asm/hw_irq.h
+++ b/arch/arm/include/asm/hw_irq.h
@@ -8,6 +8,7 @@ static inline void ack_bad_irq(int irq)
 {
 	extern unsigned long irq_err_count;
 	irq_err_count++;
+	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
 }
 
 void set_irq_flags(unsigned int irq, unsigned int flags);
-- 
2.1.1
