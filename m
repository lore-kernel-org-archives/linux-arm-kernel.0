From: eric@anholt.net (Eric Anholt)
Date: Wed, 13 Apr 2016 13:28:41 -0700
Subject: [PATCH v2 2/4] irqchip: bcm2836: Drop smp_set_ops on arm64 builds
In-Reply-To: <1460579323-8099-1-git-send-email-eric@anholt.net>
References: <1460579323-8099-1-git-send-email-eric@anholt.net>
Message-ID: <1460579323-8099-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For arm64, the bootloader will instead be implementing the spin-table
enable method.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---

v2: add ack, fix #ifdef

 drivers/irqchip/irq-bcm2836.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 233ccddbdb41..6b61c68b87ae 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -223,6 +223,7 @@ static struct notifier_block bcm2836_arm_irqchip_cpu_notifier = {
 	.priority = 100,
 };
 
+#ifdef CONFIG_ARM
 int __init bcm2836_smp_boot_secondary(unsigned int cpu,
 				      struct task_struct *idle)
 {
@@ -238,7 +239,7 @@ int __init bcm2836_smp_boot_secondary(unsigned int cpu,
 static const struct smp_operations bcm2836_smp_ops __initconst = {
 	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
 };
-
+#endif
 #endif
 
 static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
@@ -256,8 +257,11 @@ bcm2836_arm_irqchip_smp_init(void)
 	register_cpu_notifier(&bcm2836_arm_irqchip_cpu_notifier);
 
 	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
+
+#ifdef CONFIG_ARM
 	smp_set_ops(&bcm2836_smp_ops);
 #endif
+#endif
 }
 
 /*
-- 
2.8.0.rc3
