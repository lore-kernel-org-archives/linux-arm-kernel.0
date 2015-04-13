From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 13 Apr 2015 14:29:28 +0200
Subject: [RFC v6 13/16] kvm: introduce kvm_arch_halt_guest and
 kvm_arch_resume_guest
In-Reply-To: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
References: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1428928171-18884-14-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This API allows to
- exit the guest and avoid re-entering it
- resume the guest execution

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 include/linux/kvm_host.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ae9c720..f4e1829 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1053,6 +1053,18 @@ extern struct kvm_device_ops kvm_xics_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
 
+#ifdef __KVM_HAVE_ARCH_HALT_GUEST
+
+void kvm_arch_halt_guest(struct kvm *kvm);
+void kvm_arch_resume_guest(struct kvm *kvm);
+
+#else
+
+inline void kvm_arch_halt_guest(struct kvm *kvm) {}
+inline void kvm_arch_resume_guest(struct kvm *kvm) {}
+
+#endif
+
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
 static inline void kvm_vcpu_set_in_spin_loop(struct kvm_vcpu *vcpu, bool val)
-- 
1.9.1
