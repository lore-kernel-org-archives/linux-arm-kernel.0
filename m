From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  8 Sep 2017 07:52:19 -0700
Subject: [PATCH 2/2] KVM: arm/arm64: Fix vgic_mmio_change_active with
 PREEMPT_RT
In-Reply-To: <1504882339-42520-1-git-send-email-christoffer.dall@linaro.org>
References: <1504882339-42520-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1504882339-42520-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@linaro.org>

Getting a per-CPU variable requires a non-preemptible context and we
were relying on a normal spinlock to disable preemption as well.  This
asusmption breaks with PREEMPT_RT and was observed on v4.9 using
PREEMPT_RT.

This change moves the spinlock tighter around the critical section
accessing the IRQ structure protected by the lock and uses a separate
preemption disabled section for determining the requesting VCPU.  There
should be no change in functionality of performance degradation on
non-RT.

Fixes: 370a0ec18199 ("KVM: arm/arm64: Let vcpu thread modify its own active state")
Cc: stable at vger.kernel.org
Cc: Jintack Lim <jintack@cs.columbia.edu>
Reported-by: Hemanth Kumar <hemk976@gmail.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index c1e4bdd..7377f97 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -181,7 +181,6 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 				    bool new_active_state)
 {
 	struct kvm_vcpu *requester_vcpu;
-	spin_lock(&irq->irq_lock);
 
 	/*
 	 * The vcpu parameter here can mean multiple things depending on how
@@ -195,8 +194,19 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 	 * NULL, which is fine, because we guarantee that no VCPUs are running
 	 * when accessing VGIC state from user space so irq->vcpu->cpu is
 	 * always -1.
+	 *
+	 * We have to temporarily disable preemption to read the per-CPU
+	 * variable.  It doesn't matter if we actually get preempted
+	 * after enabling preemption because we only need to figure out if
+	 * this thread is a running VCPU thread, and in that case for which
+	 * VCPU.  If we're migrated the preempt notifiers will migrate the
+	 * running VCPU pointer with us.
 	 */
+	preempt_disable();
 	requester_vcpu = kvm_arm_get_running_vcpu();
+	preempt_enable();
+
+	spin_lock(&irq->irq_lock);
 
 	/*
 	 * If this virtual IRQ was written into a list register, we
-- 
2.7.4
