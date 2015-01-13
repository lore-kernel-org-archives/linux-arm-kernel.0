From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 13 Jan 2015 18:33:38 +0100
Subject: [PATCH v6 2/4] KVM: introduce kvm_arch_intc_initialized
In-Reply-To: <1421170420-30617-1-git-send-email-eric.auger@linaro.org>
References: <1421170420-30617-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1421170420-30617-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce __KVM_HAVE_ARCH_INTC_INITIALIZED define and
associated kvm_arch_intc_initialized function. This latter
allows to test whether the virtual interrupt controller is initialized
and ready to accept virtual IRQ injection. On some architectures,
the virtual interrupt controller is dynamically instantiated, justifying
that kind of check.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v5 -> v6:
- rename function name and macro
- add kvm_arch_intc_initialized declaration in case the archi defines
  the macro
---
 include/linux/kvm_host.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 26f1060..702036a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -706,6 +706,20 @@ static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 #endif
 }
 
+#ifdef __KVM_HAVE_ARCH_INTC_INITIALIZED
+/*
+ * returns trues if the virtual interrupt controller is initialized and
+ * ready to accept virtual IRQ. On some architectures the virtual interrupt
+ * controller is dynamically instantiated and this is not always true.
+ */
+bool kvm_arch_intc_initialized(struct kvm *kvm);
+#else
+static inline bool kvm_arch_intc_initialized(struct kvm *kvm)
+{
+	return true;
+}
+#endif
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type);
 void kvm_arch_destroy_vm(struct kvm *kvm);
 void kvm_arch_sync_events(struct kvm *kvm);
-- 
1.9.1
