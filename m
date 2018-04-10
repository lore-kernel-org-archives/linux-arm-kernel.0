From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Apr 2018 18:30:45 +0100
Subject: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility
 mode
In-Reply-To: <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
References: <20170320223614.1351-1-sboyd@codeaurora.org>
 <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
 <20180410170155.6e07113d@windsurf>
 <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
Message-ID: <41edab13-83db-4d57-583a-782144463857@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/18 16:23, Marc Zyngier wrote:

> I have a vague idea how to support this. Given that level-triggered MSIs
> have to be platform MSIs (because it is just madness otherwise), we can
> probably store an extra message in the struct platform_msi_desc for the
> "lower the line" write. On activation, you'd get two callbacks, probably
> with a flag of some sort to indicate whether this is for the rising or
> falling edge.

Actually, we can get away with a single call and no extra storage if we do
something like below, and check the trigger in the backends:

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2a8571f72b17..85408be6d752 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -89,13 +89,13 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 			    const struct cpumask *mask, bool force)
 {
 	struct irq_data *parent = irq_data->parent_data;
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-		irq_chip_write_msi_msg(irq_data, &msg);
+		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+		irq_chip_write_msi_msg(irq_data, msg);
 	}
 
 	return ret;
@@ -104,20 +104,20 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 static int msi_domain_activate(struct irq_domain *domain,
 			       struct irq_data *irq_data, bool early)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 
-	BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+	irq_chip_write_msi_msg(irq_data, msg);
 	return 0;
 }
 
 static void msi_domain_deactivate(struct irq_domain *domain,
 				  struct irq_data *irq_data)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 
-	memset(&msg, 0, sizeof(msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	memset(msg, 0, sizeof(msg));
+	irq_chip_write_msi_msg(irq_data, msg);
 }
 
 static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,

Is it disgusting? You bet. Does it work? Probably.

	M.
-- 
Jazz is not dead. It just smells funny...
