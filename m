From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 11 Feb 2015 09:32:20 +0100
Subject: [RFC v4 10/13] kvm: introduce kvm_arch_halt_guest and
 kvm_arch_resume_guest
In-Reply-To: <1423643543-24409-1-git-send-email-eric.auger@linaro.org>
References: <1423643543-24409-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1423643543-24409-11-git-send-email-eric.auger@linaro.org>
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
index 7f5858d..81c93de 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1057,6 +1057,18 @@ void kvm_unregister_device_ops(u32 type);
 extern struct kvm_device_ops kvm_mpic_ops;
 extern struct kvm_device_ops kvm_xics_ops;
 
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
