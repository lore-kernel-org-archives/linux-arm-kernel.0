From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:47 -0500
Subject: [RFC 51/55] KVM: arm64: Expose physical address of vcpu interface
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-52-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose physical address of vgic virtual cpu interface.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 include/kvm/arm_vgic.h      | 1 +
 virt/kvm/arm/vgic/vgic-v2.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 5bda20c..05c7811 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -331,6 +331,7 @@ static inline void vgic_handle_nested_maint_irq(struct kvm_vcpu *vcpu) { }
 #define vgic_valid_spi(k, i)	(((i) >= VGIC_NR_PRIVATE_IRQS) && \
 			((i) < (k)->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS))
 
+phys_addr_t vgic_vcpu_base(void);
 bool kvm_vcpu_has_pending_irqs(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index b8b73fd..5d85041 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -386,3 +386,9 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
 
 	return ret;
 }
+
+/* Return physical address of vgic virtual cpu interface */
+phys_addr_t vgic_vcpu_base(void)
+{
+	return kvm_vgic_global_state.vcpu_base;
+}
-- 
1.9.1
