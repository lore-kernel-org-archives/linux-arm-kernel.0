From: shihwei@cs.columbia.edu (Shih-Wei Li)
Date: Thu, 27 Oct 2016 15:08:13 +0000
Subject: [PATCH] KVM: arm/arm64: Kick VCPUs when queueing already pending IRQs
Message-ID: <1477580893-3479-1-git-send-email-shihwei@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In cases like IPI, we could be queueing an interrupt for a VCPU
that is already running and is not about to exit, because the
VCPU has entered the VM with the interrupt pending and would
not trap on EOI'ing that interrupt. This could result to delays
in interrupt deliveries or even loss of interrupts.
To guarantee prompt interrupt injection, here we have to try to
kick the VCPU.

Signed-off-by: Shih-Wei Li <shihwei@cs.columbia.edu>
---

I've tested the code with an IPI test built on kvm-unit-test, which
measures the cycles spent between one VCPU sending IPI to a target
VCPU that busy loops in the VM, until the target VCPU ACKs and EOIs
the IPI. The patch here can improve the performance in such case by
more than 5000 cycles.

 virt/kvm/arm/vgic/vgic.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index b419a11..07cf239 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -273,6 +273,17 @@ retry:
 		 * no more work for us to do.
 		 */
 		spin_unlock(&irq->irq_lock);
+
+		/*
+		 * If the VCPU is not NULL, we could be queueing an
+		 * edge-triggered interrupt for a VCPU which is already
+		 * running and is not about to exit, because the VCPU has
+		 * entered the VM with the interrupt pending and it wouldn't
+		 * trap on EOI. To ensure prompt delivery of that interrupt,
+		 * we have to try to kick the VCPU.
+		 */
+		if (vcpu)
+			kvm_vcpu_kick(vcpu);
 		return false;
 	}
 
-- 
1.9.1
