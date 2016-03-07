From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  7 Mar 2016 09:33:33 +0000
Subject: [PATCH v3 11/12] arm64: KVM: vgic-v3: Reset LRs at boot time
In-Reply-To: <1457343214-19547-1-git-send-email-marc.zyngier@arm.com>
References: <1457343214-19547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1457343214-19547-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to let the GICv3 code be more lazy in the way it
accesses the LRs, it is necessary to start with a clean slate.

Let's reset the LRs on each CPU when the vgic is probed (which
includes a round trip to EL2...).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_asm.h | 1 +
 arch/arm64/kvm/hyp/vgic-v3-sr.c  | 9 +++++++++
 virt/kvm/arm/vgic-v3.c           | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 1037392..2d02ba6 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -42,6 +42,7 @@ extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
 extern u64 __vgic_v3_get_ich_vtr_el2(void);
+extern void __vgic_v3_init_lrs(void);
 
 extern u32 __kvm_get_mdcr_el2(void);
 
diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index 0db426e..8134947 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -321,6 +321,15 @@ void __hyp_text __vgic_v3_restore_state(struct kvm_vcpu *vcpu)
 	}
 }
 
+void __hyp_text __vgic_v3_init_lrs(void)
+{
+	int max_lr_idx = vtr_to_max_lr_idx(read_gicreg(ICH_VTR_EL2));
+	int i;
+
+	for (i = 0; i <= max_lr_idx; i++)
+		__gic_v3_set_lr(0, i);
+}
+
 static u64 __hyp_text __vgic_v3_read_ich_vtr_el2(void)
 {
 	return read_gicreg(ICH_VTR_EL2);
diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
index 11b5ff6..999bdc6 100644
--- a/virt/kvm/arm/vgic-v3.c
+++ b/virt/kvm/arm/vgic-v3.c
@@ -216,6 +216,11 @@ static const struct vgic_ops vgic_v3_ops = {
 
 static struct vgic_params vgic_v3_params;
 
+static void vgic_cpu_init_lrs(void *params)
+{
+	kvm_call_hyp(__vgic_v3_init_lrs);
+}
+
 /**
  * vgic_v3_probe - probe for a GICv3 compatible interrupt controller in DT
  * @node:	pointer to the DT node
@@ -284,6 +289,8 @@ int vgic_v3_probe(struct device_node *vgic_node,
 	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
 		 vcpu_res.start, vgic->maint_irq);
 
+	on_each_cpu(vgic_cpu_init_lrs, vgic, 1);
+
 	*ops = &vgic_v3_ops;
 	*params = vgic;
 
-- 
2.1.4
