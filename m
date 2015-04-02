From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  2 Apr 2015 11:05:09 +0100
Subject: [PATCH 05/27] KVM: introduce kvm_arch_intc_initialized and use it in
 irqfd
In-Reply-To: <1427969131-8445-1-git-send-email-marc.zyngier@arm.com>
References: <1427969131-8445-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1427969131-8445-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

Introduce __KVM_HAVE_ARCH_INTC_INITIALIZED define and
associated kvm_arch_intc_initialized function. This latter
allows to test whether the virtual interrupt controller is initialized
and ready to accept virtual IRQ injection. On some architectures,
the virtual interrupt controller is dynamically instantiated, justifying
that kind of check.

The new function can now be used by irqfd to check whether the
virtual interrupt controller is ready on KVM_IRQFD request. If not,
KVM_IRQFD returns -EAGAIN.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/linux/kvm_host.h | 14 ++++++++++++++
 virt/kvm/eventfd.c       |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d12b210..ae9c720 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -700,6 +700,20 @@ static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 #endif
 }
 
+#ifdef __KVM_HAVE_ARCH_INTC_INITIALIZED
+/*
+ * returns true if the virtual interrupt controller is initialized and
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
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 148b239..fc5f43e 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -311,6 +311,9 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	unsigned int events;
 	int idx;
 
+	if (!kvm_arch_intc_initialized(kvm))
+		return -EAGAIN;
+
 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
 	if (!irqfd)
 		return -ENOMEM;
-- 
2.1.4
