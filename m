From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Jan 2017 10:20:52 +0000
Subject: [RFC PATCH 31/33] irqchip/gic-v4: Add VLPI configuration interface
In-Reply-To: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1484648454-21216-32-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required interfaces to map, unmap and update a VLPI.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v4.c       | 29 +++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 7d74089..36ccaac 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -140,3 +140,32 @@ int its_invall_vpe(struct its_vpe *vpe)
 
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
+	return irq_set_vcpu_affinity(irq, &info);
+}
+
+int its_unmap_vlpi(int irq)
+{
+	struct its_cmd_info info = {
+		.cmd_type = UNMAP_VLPI,
+	};
+
+	return irq_set_vcpu_affinity(irq, &info);
+}
+
+int its_prop_update_vlpi(int irq, u8 config)
+{
+	struct its_cmd_info info = {
+		.cmd_type = PROP_UPDATE_VLPI,
+		.config   = config,
+	};
+
+	return irq_set_vcpu_affinity(irq, &info);
+}
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 1c58add..f85a929 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -93,5 +93,8 @@ int its_alloc_vcpu_irqs(struct its_vm *vm, struct its_vpe **vpes, int nr_vpes);
 void its_free_vcpu_irqs(struct its_vm *vm, int nr_vpes);
 int its_schedule_vpe(struct its_vpe *vpe, bool on);
 int its_invall_vpe(struct its_vpe *vpe);
+int its_map_vlpi(int irq, struct its_vlpi_map *map);
+int its_unmap_vlpi(int irq);
+int its_prop_update_vlpi(int irq, u8 config);
 
 #endif
-- 
2.1.4
