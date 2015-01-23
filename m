From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:34 +0100
Subject: [GIT PULL 05/36] KVM: Add architecture-defined TLB flush support
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mario Smarduch <m.smarduch@samsung.com>

Allow architectures to override the generic kvm_flush_remote_tlbs()
function via HAVE_KVM_ARCH_TLB_FLUSH_ALL. ARMv7 will need this to
provide its own TLB flush interface.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 virt/kvm/Kconfig    | 3 +++
 virt/kvm/kvm_main.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index fc0c5e6..3796a21 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -37,3 +37,6 @@ config HAVE_KVM_CPU_RELAX_INTERCEPT
 
 config KVM_VFIO
        bool
+
+config HAVE_KVM_ARCH_TLB_FLUSH_ALL
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 167e8c1..d03bd22 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -176,6 +176,7 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 	return called;
 }
 
+#ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
 void kvm_flush_remote_tlbs(struct kvm *kvm)
 {
 	long dirty_count = kvm->tlbs_dirty;
@@ -186,6 +187,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
 }
 EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
+#endif
 
 void kvm_reload_remote_mmus(struct kvm *kvm)
 {
-- 
2.1.2.330.g565301e.dirty
