From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:49 +0100
Subject: [PATCH v2 30/52] irqchip/gic-v4: Add VPE command interface
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-31-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required interfaces to schedule a VPE and perform a
VINVALL command.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v4.c       | 25 +++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 2ea12baf2e53..3c5ad70193ed 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -56,3 +56,28 @@ void its_free_vcpu_irqs(struct its_vm *vm)
 	irq_domain_free_irqs(vm->vpes[0]->irq, vm->nr_vpes);
 	irq_domain_remove(vm->domain);
 }
+
+static int its_send_vpe_cmd(struct its_vpe *vpe, struct its_cmd_info *info)
+{
+	return irq_set_vcpu_affinity(vpe->irq, info);
+}
+
+int its_schedule_vpe(struct its_vpe *vpe, bool on)
+{
+	struct its_cmd_info info;
+
+	WARN_ON(preemptible());
+
+	info.cmd_type = on ? SCHEDULE_VPE : DESCHEDULE_VPE;
+
+	return its_send_vpe_cmd(vpe, &info);
+}
+
+int its_invall_vpe(struct its_vpe *vpe)
+{
+	struct its_cmd_info info = {
+		.cmd_type = INVALL_VPE,
+	};
+
+	return its_send_vpe_cmd(vpe, &info);
+}
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 7474a981ed6d..97bb97a11fef 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -90,5 +90,7 @@ struct its_cmd_info {
 
 int its_alloc_vcpu_irqs(struct its_vm *vm);
 void its_free_vcpu_irqs(struct its_vm *vm);
+int its_schedule_vpe(struct its_vpe *vpe, bool on);
+int its_invall_vpe(struct its_vpe *vpe);
 
 #endif
-- 
2.11.0
