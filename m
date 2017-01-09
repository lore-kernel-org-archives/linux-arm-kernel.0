From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:22 -0500
Subject: [RFC 26/55] KVM: arm/arm64: Add VGIC data structures for the nesting
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-27-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

This adds a couple of extra data structures:

The nested_vgic_vX structures contain the data manipulated by the guest
hypervisor when it faults/traps on accesses to the GICH_ interface.

The shadow_vgic_vX arrays contain the shadow copies of the LRs.  That
is, it is a modified version of the nested_vgic_vX->vgic_lr.  The reason
why we need a modified version is that for interrupts with the HW bit
set (those for the timer) the interrupt number must be that of the host
hardware number, and not the virtual one programmed by the guest
hypervisor.

The hw_vX_cpu_if pointers point to the registers that the lowvisor (EL2)
code actually copied into hardware when switching to the guest, so at
init time we set:

vgic_cpu->hw_v2_cpu_if = &vcpu->arch.vgic_cpu.vgic_v2;

And we should change the vgic-sr function to read the LRs from the
hw_v2_lr pointer.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 include/kvm/arm_vgic.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 002f092..9a9cb27 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -246,6 +246,26 @@ struct vgic_cpu {
 	unsigned int used_lrs;
 	struct vgic_irq private_irqs[VGIC_NR_PRIVATE_IRQS];
 
+	/* CPU vif control registers for the virtual GICH interface */
+	union {
+		struct vgic_v2_cpu_if	nested_vgic_v2;
+		struct vgic_v3_cpu_if	nested_vgic_v3;
+	};
+
+	/*
+	 * The shadow vif control register loaded to the hardware when
+	 * running a sted L2 guest with the virtual IMO bit set.
+	 */
+	union {
+		struct vgic_v2_cpu_if	shadow_vgic_v2;
+		struct vgic_v3_cpu_if	shadow_vgic_v3;
+	};
+
+	union {
+		struct vgic_v2_cpu_if	*hw_v2_cpu_if;
+		struct vgic_v3_cpu_if	*hw_v3_cpu_if;
+	};
+
 	spinlock_t ap_list_lock;	/* Protects the ap_list */
 
 	/*
-- 
1.9.1
