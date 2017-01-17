From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Jan 2017 10:20:47 +0000
Subject: [RFC PATCH 26/33] irqchip/gic-v3-its: Add VPE affinity changes
In-Reply-To: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1484648454-21216-27-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we're about to run a vcpu, it is crucial that the redistributor
associated with the physical CPU is being told about the new residency.

This is abstracted by hijacking the irq_set_affinity method for the
doorbell interrupt associated with the VPE. It is expected that the
hypervisor will call this method before scheduling the VPE.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 51a1930..06e959f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -139,6 +139,9 @@ static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
 
 static unsigned long its_list_map;
+static u16 vmovp_seq_num;
+static DEFINE_RAW_SPINLOCK(vmovp_lock);
+
 static DEFINE_IDA(its_vpeid_ida);
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
@@ -229,6 +232,13 @@ struct its_cmd_desc {
 			u32 event_id;
 			bool db_enabled;
 		} its_vmovi_cmd;
+
+		struct {
+			struct its_vpe *vpe;
+			struct its_collection *col;
+			u16 seq_num;
+			u16 its_list;
+		} its_vmovp_cmd;
 	};
 };
 
@@ -320,6 +330,16 @@ static void its_encode_db_valid(struct its_cmd_block *cmd, bool db_valid)
 	its_mask_encode(&cmd->raw_cmd[2], db_valid, 0, 0);
 }
 
+static void its_encode_seq_num(struct its_cmd_block *cmd, u16 seq_num)
+{
+	its_mask_encode(&cmd->raw_cmd[0], seq_num, 47, 32);
+}
+
+static void its_encode_its_list(struct its_cmd_block *cmd, u16 its_list)
+{
+	its_mask_encode(&cmd->raw_cmd[1], its_list, 15, 0);
+}
+
 static void its_encode_vpt_addr(struct its_cmd_block *cmd, u64 vpt_pa)
 {
 	its_mask_encode(&cmd->raw_cmd[3], vpt_pa >> 16, 50, 16);
@@ -562,6 +582,20 @@ static struct its_vpe *its_build_vmovi_cmd(struct its_cmd_block *cmd,
 	return desc->its_vmovi_cmd.vpe;
 }
 
+static struct its_vpe *its_build_vmovp_cmd(struct its_cmd_block *cmd,
+					   struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_VMOVP);
+	its_encode_seq_num(cmd, desc->its_vmovp_cmd.seq_num);
+	its_encode_its_list(cmd, desc->its_vmovp_cmd.its_list);
+	its_encode_vpeid(cmd, desc->its_vmovp_cmd.vpe->vpe_id);
+	its_encode_target(cmd, desc->its_vmovp_cmd.col->target_address);
+
+	its_fixup_cmd(cmd);
+
+	return desc->its_vmovp_cmd.vpe;
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -852,6 +886,46 @@ static void its_send_vmapp(struct its_vpe *vpe, bool valid)
 	}
 }
 
+static void its_send_vmovp(struct its_vpe *vpe, unsigned int col_id)
+{
+	struct its_cmd_desc desc;
+	struct its_node *its;
+	unsigned long flags;
+
+	desc.its_vmovp_cmd.vpe = vpe;
+	desc.its_vmovp_cmd.its_list = (u16)its_list_map;
+
+	if (!its_list_map) {
+		its = list_first_entry(&its_nodes, struct its_node, entry);
+		desc.its_vmovp_cmd.seq_num = 0;
+		its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
+		return;
+	}
+
+	/*
+	 * Yet another marvel of the architecture. If using the
+	 * its_list "feature", we need to make sure that all ITSs
+	 * receive all VMOVP commands in the same order. The only way
+	 * to guarantee this is to make vmovp a serialization point.
+	 *
+	 * Wall <-- Head.
+	 */
+	raw_spin_lock_irqsave(&vmovp_lock, flags);
+
+	desc.its_vmovp_cmd.seq_num = vmovp_seq_num++;
+
+	/* Emit VMOVPs */
+	list_for_each_entry(its, &its_nodes, entry) {
+		if (!its->is_v4)
+			continue;
+
+		desc.its_vmovp_cmd.col = &its->collections[col_id];
+		its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
+	}
+
+	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
+}
+
 static void its_send_vinvall(struct its_vpe *vpe)
 {
 	struct its_cmd_desc desc;
@@ -2040,6 +2114,25 @@ static const struct irq_domain_ops its_domain_ops = {
 	.deactivate		= its_irq_domain_deactivate,
 };
 
+static int its_vpe_set_affinity(struct irq_data *d,
+				const struct cpumask *mask_val,
+				bool force)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	int cpu = cpumask_first(mask_val);
+
+	/*
+	 * Changing affinity is mega expensive, so let's be as lazy as
+	 * we can and only do it if we really have to.
+	 */
+	if (vpe->col_idx != cpu) {
+		its_send_vmovp(vpe, cpu);
+		vpe->col_idx = cpu;
+	}
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
 static int its_vpe_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
@@ -2103,6 +2196,7 @@ static int its_vpe_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 
 static struct irq_chip its_vpe_irq_chip = {
 	.name			= "GICv4-vpe",
+	.irq_set_affinity	= its_vpe_set_affinity,
 	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
 };
 
-- 
2.1.4
