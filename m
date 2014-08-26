From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 26 Aug 2014 16:51:07 -0700
Subject: [PATCH v10 1/6] KVM: Add architecture-specific TLB flush
 implementations
In-Reply-To: <1409097072-1096-1-git-send-email-m.smarduch@samsung.com>
References: <1409097072-1096-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1409097072-1096-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to declare architecture specific TLB flush function, for now only
ARMv7.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 virt/kvm/Kconfig    | 3 +++
 virt/kvm/kvm_main.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 13f2d19..f1efaa5 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -34,3 +34,6 @@ config HAVE_KVM_CPU_RELAX_INTERCEPT
 
 config KVM_VFIO
        bool
+
+config HAVE_KVM_ARCH_TLB_FLUSH_ALL
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4b6c01b..d0a24f5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -186,12 +186,16 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
 
 void kvm_flush_remote_tlbs(struct kvm *kvm)
 {
+#ifdef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
+	kvm_arch_flush_remote_tlbs(kvm);
+#else
 	long dirty_count = kvm->tlbs_dirty;
 
 	smp_mb();
 	if (make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
 		++kvm->stat.remote_tlb_flush;
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
+#endif
 }
 EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
 
-- 
1.8.3.2
