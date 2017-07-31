From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:26:10 +0100
Subject: [PATCH v3 32/59] irqchip/gic-v4: Add VLPI configuration interface
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-33-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required interfaces to map, unmap and update a VLPI.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v4.c       | 42 ++++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  4 ++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 86b46fb532ab..6fe2e09172ed 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -96,3 +96,45 @@ int its_invall_vpe(struct its_vpe *vpe)
 
 	return its_send_vpe_cmd(vpe, &info);
 }
+
+int its_map_vlpi(int irq, struct its_vlpi_map *map)
+{
+	struct its_cmd_info info = {
+		.cmd_type = MAP_VLPI,
+		.map      = map,
+	};
+
+	/*
+	 * The host will never see that interrupt firing again, so it
+	 * is vital that we don't do any lazy masking.
+	 */
+	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
+
+	return irq_set_vcpu_affinity(irq, &info);
+}
+
+int its_get_vlpi(int irq, struct its_vlpi_map *map)
+{
+	struct its_cmd_info info = {
+		.cmd_type = GET_VLPI,
+		.map      = map,
+	};
+
+	return irq_set_vcpu_affinity(irq, &info);
+}
+
+int its_unmap_vlpi(int irq)
+{
+	irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY);
+	return irq_set_vcpu_affinity(irq, NULL);
+}
+
+int its_prop_update_vlpi(int irq, u8 config, bool inv)
+{
+	struct its_cmd_info info = {
+		.cmd_type = inv ? PROP_UPDATE_AND_INV_VLPI : PROP_UPDATE_VLPI,
+		.config   = config,
+	};
+
+	return irq_set_vcpu_affinity(irq, &info);
+}
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index faaafd12d8c7..f495d4d1f7d7 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -93,5 +93,9 @@ int its_alloc_vcpu_irqs(struct its_vm *vm);
 void its_free_vcpu_irqs(struct its_vm *vm);
 int its_schedule_vpe(struct its_vpe *vpe, bool on);
 int its_invall_vpe(struct its_vpe *vpe);
+int its_map_vlpi(int irq, struct its_vlpi_map *map);
+int its_get_vlpi(int irq, struct its_vlpi_map *map);
+int its_unmap_vlpi(int irq);
+int its_prop_update_vlpi(int irq, u8 config, bool inv);
 
 #endif
-- 
2.11.0
