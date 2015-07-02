From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  2 Jul 2015 15:17:23 +0200
Subject: [RFC 13/17] KVM: introduce kvm_arch functions for IRQ bypass
In-Reply-To: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1435843047-6327-14-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces
- kvm_arch_add_producer
- kvm_arch_del_producer
- kvm_arch_stop_consumer
- kvm_arch_resume_consumer

They make possible to specialize the KVM IRQ bypass consumer.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 include/linux/kvm_host.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9564fd7..8e981e9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/irqflags.h>
 #include <linux/context_tracking.h>
+#include <linux/irqbypass.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -1133,5 +1134,31 @@ static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
 {
 }
 #endif /* CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
+
+#ifdef CONFIG_IRQ_BYPASS_MANAGER
+
+void kvm_arch_add_producer(struct irq_bypass_consumer *,
+			   struct irq_bypass_producer *);
+void kvm_arch_del_producer(struct irq_bypass_consumer *,
+			   struct irq_bypass_producer *);
+void kvm_arch_stop_consumer(struct irq_bypass_consumer *);
+void kvm_arch_resume_consumer(struct irq_bypass_consumer *);
+
+#else
+void kvm_arch_add_producer(struct irq_bypass_consumer *,
+			   struct irq_bypass_producer *)
+{
+}
+void kvm_arch_del_producer(struct irq_bypass_consumer *,
+			   struct irq_bypass_producer *)
+{
+}
+void kvm_arch_stop_consumer(struct irq_bypass_consumer *)
+{
+}
+void kvm_arch_resume_consumer(struct irq_bypass_consumer *)
+{
+}
+#endif /* CONFIG_IRQ_BYPASS_MANAGER */
 #endif
 
-- 
1.9.1
