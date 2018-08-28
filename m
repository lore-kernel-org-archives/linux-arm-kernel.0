From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:29 +0100
Subject: [PATCH v5 19/27] irqchip/gic-v3: Remove acknowledge loop
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-20-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiple interrupts pending for a CPU is actually rare. Doing an
acknowledge loop does not give much better performance or even can
deteriorate them.

Do not loop when an interrupt has been acknowledged, just return
from interrupt and wait for another one to be raised.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 65 +++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 162c49c..a467fcf 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -348,48 +348,45 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 {
 	u32 irqnr;

-	do {
-		irqnr = gic_read_iar();
+	irqnr = gic_read_iar();

-		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
-			int err;
+	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+		int err;

-			if (static_branch_likely(&supports_deactivate_key))
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_eoir(irqnr);
+		else
+			isb();
+
+		err = handle_domain_irq(gic_data.domain, irqnr, regs);
+		if (err) {
+			WARN_ONCE(true, "Unexpected interrupt received!\n");
+			if (static_branch_likely(&supports_deactivate_key)) {
+				if (irqnr < 8192)
+					gic_write_dir(irqnr);
+			} else {
 				gic_write_eoir(irqnr);
-			else
-				isb();
-
-			err = handle_domain_irq(gic_data.domain, irqnr, regs);
-			if (err) {
-				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_branch_likely(&supports_deactivate_key)) {
-					if (irqnr < 8192)
-						gic_write_dir(irqnr);
-				} else {
-					gic_write_eoir(irqnr);
-				}
 			}
-			continue;
 		}
-		if (irqnr < 16) {
-			gic_write_eoir(irqnr);
-			if (static_branch_likely(&supports_deactivate_key))
-				gic_write_dir(irqnr);
+		return;
+	}
+	if (irqnr < 16) {
+		gic_write_eoir(irqnr);
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
-			/*
-			 * Unlike GICv2, we don't need an smp_rmb() here.
-			 * The control dependency from gic_read_iar to
-			 * the ISB in gic_write_eoir is enough to ensure
-			 * that any shared data read by handle_IPI will
-			 * be read after the ACK.
-			 */
-			handle_IPI(irqnr, regs);
+		/*
+		 * Unlike GICv2, we don't need an smp_rmb() here.
+		 * The control dependency from gic_read_iar to
+		 * the ISB in gic_write_eoir is enough to ensure
+		 * that any shared data read by handle_IPI will
+		 * be read after the ACK.
+		 */
+		handle_IPI(irqnr, regs);
 #else
-			WARN_ONCE(true, "Unexpected SGI received!\n");
+		WARN_ONCE(true, "Unexpected SGI received!\n");
 #endif
-			continue;
-		}
-	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
+	}
 }

 static u32 gic_get_pribits(void)
--
1.9.1
