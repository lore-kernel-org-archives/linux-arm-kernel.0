From: stefan@agner.ch (Stefan Agner)
Date: Sun, 12 Oct 2014 20:13:59 +0200
Subject: [RFC 5/7] irqchip: nvic: increase number of external interrupts to 112
In-Reply-To: <cover.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
Message-ID: <a6cf6073e13cfbb98674b0cc9e75330ee821883e.1413136383.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far only vectors for up to 48 external interrupts have been
registred in the vector table. Increase the amount of registred
external vectors to 112. Also add a warning in case NVIC reports
support for more interrupts than 128.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/kernel/entry-v7m.S | 4 ++--
 drivers/irqchip/irq-nvic.c  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 2260f18..1c5deac 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -136,6 +136,6 @@ ENTRY(vector_table)
 	.long	__invalid_entry		@ 13 - Reserved
 	.long	__pendsv_entry		@ 14 - PendSV
 	.long	__invalid_entry		@ 15 - SysTick
-	.rept	64 - 16
-	.long	__irq_entry		@ 16..64 - External Interrupts
+	.rept	128 - 16
+	.long	__irq_entry		@ 16..128 - External Interrupts
 	.endr
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 4ff0805..3ecb5fe 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -69,6 +69,8 @@ static int __init nvic_of_init(struct device_node *node,
 	if (irqs > NVIC_MAX_IRQ)
 		irqs = NVIC_MAX_IRQ;
 
+	WARN(irqs > 128, "vector table in entry-v7m.S configured for 128 irqs");
+
 	nvic_irq_domain =
 		irq_domain_add_linear(node, irqs, &irq_generic_chip_ops, NULL);
 	if (!nvic_irq_domain) {
-- 
2.1.2
