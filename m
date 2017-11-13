From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:45 +0100
Subject: [PULL 20/27] KVM: arm/arm64: GICv4: Hook vPE scheduling into vgic
 flush/sync
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-21-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The redistributor needs to be told which vPE is about to be run,
and tells us whether there is any pending VLPI on exit.

Let's add the scheduling calls to the vgic flush/sync functions,
allowing the VLPIs to be delivered to the guest.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-v4.c | 39 +++++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.c    |  4 ++++
 virt/kvm/arm/vgic/vgic.h    |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 1375a53054b9..c9cec01008c2 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -131,6 +131,45 @@ void vgic_v4_teardown(struct kvm *kvm)
 	its_vm->vpes = NULL;
 }
 
+int vgic_v4_sync_hwstate(struct kvm_vcpu *vcpu)
+{
+	if (!vgic_supports_direct_msis(vcpu->kvm))
+		return 0;
+
+	return its_schedule_vpe(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe, false);
+}
+
+int vgic_v4_flush_hwstate(struct kvm_vcpu *vcpu)
+{
+	int irq = vcpu->arch.vgic_cpu.vgic_v3.its_vpe.irq;
+	int err;
+
+	if (!vgic_supports_direct_msis(vcpu->kvm))
+		return 0;
+
+	/*
+	 * Before making the VPE resident, make sure the redistributor
+	 * corresponding to our current CPU expects us here. See the
+	 * doc in drivers/irqchip/irq-gic-v4.c to understand how this
+	 * turns into a VMOVP command at the ITS level.
+	 */
+	err = irq_set_affinity(irq, cpumask_of(smp_processor_id()));
+	if (err)
+		return err;
+
+	err = its_schedule_vpe(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe, true);
+	if (err)
+		return err;
+
+	/*
+	 * Now that the VPE is resident, let's get rid of a potential
+	 * doorbell interrupt that would still be pending.
+	 */
+	err = irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, false);
+
+	return err;
+}
+
 static struct vgic_its *vgic_get_its(struct kvm *kvm,
 				     struct kvm_kernel_irq_routing_entry *irq_entry)
 {
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index d29e91215366..b168a328a9e0 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -718,6 +718,8 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
+	WARN_ON(vgic_v4_sync_hwstate(vcpu));
+
 	/* An empty ap_list_head implies used_lrs == 0 */
 	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head))
 		return;
@@ -730,6 +732,8 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 /* Flush our emulation state into the GIC hardware before entering the guest. */
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 {
+	WARN_ON(vgic_v4_flush_hwstate(vcpu));
+
 	/*
 	 * If there are no virtual interrupts active or pending for this
 	 * VCPU, then there is no work to do and we can bail out without
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index bf03a9648fbb..efbcf8f96f9c 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -244,5 +244,7 @@ struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
 bool vgic_supports_direct_msis(struct kvm *kvm);
 int vgic_v4_init(struct kvm *kvm);
 void vgic_v4_teardown(struct kvm *kvm);
+int vgic_v4_sync_hwstate(struct kvm_vcpu *vcpu);
+int vgic_v4_flush_hwstate(struct kvm_vcpu *vcpu);
 
 #endif
-- 
2.14.2
