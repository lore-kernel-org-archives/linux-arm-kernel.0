From: eric@anholt.net (Eric Anholt)
Date: Mon, 27 Jul 2015 13:09:49 -0700
Subject: [PATCH] irqchip: bcm2836: Use a CPU notifier enable IPIs.
In-Reply-To: <55B67C81.1010900@gmail.com>
References: <55B67C81.1010900@gmail.com>
Message-ID: <1438027789-1637-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---

Florian: Thanks!  That looks like what we need to squash for Thomas's
feedback.  It feels a bit silly to me to avoid enabling IPIs on
not-yet-booted CPUs, despite the fact that Linux itself is what
generates IPIs.  However, I've tested it on the 2836 series and it
does work.

 drivers/irqchip/irq-bcm2836.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 87340b0..0bb0552 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/cpu.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
@@ -195,6 +196,25 @@ static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
 		writel(1 << ipi, mailbox0_base + 16 * cpu);
 	}
 }
+
+/* Unmasks the IPI on the CPU wen it's first brought online. */
+static int bcm2836_arm_irqchip_cpu_notify(struct notifier_block *nfb,
+					  unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	unsigned int int_reg = LOCAL_MAILBOX_INT_CONTROL0;
+	unsigned int mailbox = 0;
+
+	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
+		bcm2836_arm_irqchip_unmask_per_cpu_irq(int_reg, mailbox, cpu);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block bcm2836_arm_irqchip_cpu_notifier = {
+	.notifier_call = bcm2836_arm_irqchip_cpu_notify,
+	.priority = 100,
+};
 #endif
 
 static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
@@ -205,13 +225,12 @@ static void
 bcm2836_arm_irqchip_smp_init(void)
 {
 #ifdef CONFIG_SMP
-	int i;
+	/* Unmask IPIs to the boot CPU. */
+	bcm2836_arm_irqchip_cpu_notify(&bcm2836_arm_irqchip_cpu_notifier,
+				       CPU_STARTING,
+				       (void *)smp_processor_id());
+	register_cpu_notifier(&bcm2836_arm_irqchip_cpu_notifier);
 
-	/* unmask IPIs */
-	for_each_possible_cpu(i) {
-		bcm2836_arm_irqchip_unmask_per_cpu_irq(
-			LOCAL_MAILBOX_INT_CONTROL0, 0, i);
-	}
 	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
 #endif
 }
-- 
2.1.4
