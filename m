From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 22 Oct 2014 15:34:06 -0700
Subject: [PATCH v12 1/6] KVM: Add architecture-defined TLB flush support
In-Reply-To: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1414017251-5772-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for architecture implemented VM TLB flush, currently
ARMv7 defines HAVE_KVM_ARCH_TLB_FLUSH_ALL. This leaves other architectures 
unaffected using the generic version. In subsequent patch ARMv7 defines
HAVE_KVM_ARCH_TLB_FLUSH_ALL and it's own TLB flush interface.

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
index 33712fb..887df87 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -184,6 +184,7 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
 	return called;
 }
 
+#ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
 void kvm_flush_remote_tlbs(struct kvm *kvm)
 {
 	long dirty_count = kvm->tlbs_dirty;
@@ -194,6 +195,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
 }
 EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
+#endif
 
 void kvm_reload_remote_mmus(struct kvm *kvm)
 {
-- 
1.7.9.5
