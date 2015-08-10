From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 10 Aug 2015 15:31:07 +0200
Subject: [PATCH v5 5/5] KVM: eventfd: add irq bypass consumer management
In-Reply-To: <1439213467-13668-1-git-send-email-eric.auger@linaro.org>
References: <1439213467-13668-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1439213467-13668-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the registration/unregistration of an
irq_bypass_consumer on irqfd assignment/deassignment.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Feng Wu <feng.wu@intel.com>

---

v4 -> v5:
- due to removal of static inline stubs, add
  #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
  around consumer registration/unregistration
- add pr_info when registration fails

v2 -> v3 (Feng Wu):
- Use kvm_arch_irq_bypass_start
- Remove kvm_arch_irq_bypass_update
- Add member 'struct irq_bypass_producer *producer' in
  'struct kvm_kernel_irqfd', it is needed by posted interrupt.
- Remove 'irq_bypass_unregister_consumer' in kvm_irqfd_deassign()

v1 -> v2:
- populate of kvm and gsi removed
- unregister the consumer on irqfd_shutdown
---
 include/linux/kvm_irqfd.h |  2 ++
 virt/kvm/eventfd.c        | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index f926b39..0c1de05 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -64,6 +64,8 @@ struct kvm_kernel_irqfd {
 	struct list_head list;
 	poll_table pt;
 	struct work_struct shutdown;
+	struct irq_bypass_consumer consumer;
+	struct irq_bypass_producer *producer;
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 647ffb8..d7a230f 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -35,6 +35,7 @@
 #include <linux/srcu.h>
 #include <linux/slab.h>
 #include <linux/seqlock.h>
+#include <linux/irqbypass.h>
 #include <trace/events/kvm.h>
 
 #include <kvm/iodev.h>
@@ -140,6 +141,9 @@ irqfd_shutdown(struct work_struct *work)
 	/*
 	 * It is now safe to release the object's resources
 	 */
+#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+	irq_bypass_unregister_consumer(&irqfd->consumer);
+#endif
 	eventfd_ctx_put(irqfd->eventfd);
 	kfree(irqfd);
 }
@@ -379,6 +383,17 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	 * we might race against the POLLHUP
 	 */
 	fdput(f);
+#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+	irqfd->consumer.token = (void *)irqfd->eventfd;
+	irqfd->consumer.add_producer = kvm_arch_irq_bypass_add_producer;
+	irqfd->consumer.del_producer = kvm_arch_irq_bypass_del_producer;
+	irqfd->consumer.stop = kvm_arch_irq_bypass_stop;
+	irqfd->consumer.start = kvm_arch_irq_bypass_start;
+	ret = irq_bypass_register_consumer(&irqfd->consumer);
+	if (ret)
+		pr_info("irq bypass consumer (token %p) registration fails: %d\n",
+				irqfd->consumer.token, ret);
+#endif
 
 	return 0;
 
-- 
1.9.1
