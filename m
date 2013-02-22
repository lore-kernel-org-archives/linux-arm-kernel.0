From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Feb 2013 18:40:46 +0000
Subject: [PATCH 2/2] ARM: KVM: vgic: take distributor lock on sync_hwstate path
In-Reply-To: <1361558446-8375-1-git-send-email-marc.zyngier@arm.com>
References: <1361558446-8375-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1361558446-8375-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the maintenance interrupt handling is actually out of the
handler itself, the code becomes quite racy as we can get preempted
while we process the state.

Wrapping this code around the distributor lock ensures that we're not
preempted and relatively race-free.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/vgic.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 76ea1aa..0e4cfe1 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -1016,21 +1016,6 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 
 	kvm_debug("MISR = %08x\n", vgic_cpu->vgic_misr);
 
-	/*
-	 * We do not need to take the distributor lock here, since the only
-	 * action we perform is clearing the irq_active_bit for an EOIed
-	 * level interrupt.  There is a potential race with
-	 * the queuing of an interrupt in __kvm_vgic_flush_hwstate(), where we
-	 * check if the interrupt is already active. Two possibilities:
-	 *
-	 * - The queuing is occurring on the same vcpu: cannot happen,
-	 *   as we're already in the context of this vcpu, and
-	 *   executing the handler
-	 * - The interrupt has been migrated to another vcpu, and we
-	 *   ignore this interrupt for this run. Big deal. It is still
-	 *   pending though, and will get considered when this vcpu
-	 *   exits.
-	 */
 	if (vgic_cpu->vgic_misr & GICH_MISR_EOI) {
 		/*
 		 * Some level interrupts have been EOIed. Clear their
@@ -1069,9 +1054,8 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 }
 
 /*
- * Sync back the VGIC state after a guest run. We do not really touch
- * the distributor here (the irq_pending_on_cpu bit is safe to set),
- * so there is no need for taking its lock.
+ * Sync back the VGIC state after a guest run. The distributor lock is
+ * needed so we don't get preempted in the middle of the state processing.
  */
 static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 {
@@ -1117,10 +1101,14 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 {
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
 	if (!irqchip_in_kernel(vcpu->kvm))
 		return;
 
+	spin_lock(&dist->lock);
 	__kvm_vgic_sync_hwstate(vcpu);
+	spin_unlock(&dist->lock);
 }
 
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
-- 
1.7.12.4
