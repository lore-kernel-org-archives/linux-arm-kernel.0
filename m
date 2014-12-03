From: eric.auger@linaro.org (Eric Auger)
Date: Wed,  3 Dec 2014 17:07:09 +0100
Subject: [PATCH v5 2/5] KVM: introduce kvm_arch_is_virtual_intc_initialized
In-Reply-To: <1417622832-5460-1-git-send-email-eric.auger@linaro.org>
References: <1417622832-5460-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1417622832-5460-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce __KVM_HAVE_ARCH_VIRTUAL_INTC_INITIALIZED define and
associated kvm_arch_is_virtual_intc_initialized function. This latter
allows to test whether the virtual interrupt controller is initialized
and ready to accept virtual IRQ injection. On some architectures,
the virtual interrupt controller is dynamically instantiated, justifying
that kind of check.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 include/linux/kvm_host.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ea53b04..45fea3c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -696,6 +696,18 @@ static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 #endif
 }
 
+#ifndef __KVM_HAVE_ARCH_VIRTUAL_INTC_INITIALIZED
+/*
+ * returns trues if the virtual interrupt controller is initialized and
+ * ready to accept virtual IRQ. On some architectures the virtual interrupt
+ * controller is dynamically instantiated and this is not always true.
+ */
+static inline bool kvm_arch_is_virtual_intc_initialized(struct kvm *kvm)
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
