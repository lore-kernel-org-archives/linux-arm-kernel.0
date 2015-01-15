From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 Jan 2015 15:58:52 -0800
Subject: [PATCH v16 01/10] KVM: Add architecture-defined TLB flush support
In-Reply-To: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
References: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1421366341-26012-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow architectures to override the generic kvm_flush_remote_tlbs()
function via HAVE_KVM_ARCH_TLB_FLUSH_ALL. ARMv7 will need this to
provide its own TLB flush interface.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 virt/kvm/Kconfig    |    3 +++
 virt/kvm/kvm_main.c |    2 ++
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
index 3cee7b1..51e9dfa 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -185,6 +185,7 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 	return called;
 }
 
+#ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
 void kvm_flush_remote_tlbs(struct kvm *kvm)
 {
 	long dirty_count = kvm->tlbs_dirty;
@@ -195,6 +196,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
 }
 EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
+#endif
 
 void kvm_reload_remote_mmus(struct kvm *kvm)
 {
-- 
1.7.9.5
