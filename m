From: rkrcmar@redhat.com (=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=)
Date: Wed, 16 Aug 2017 21:40:36 +0200
Subject: [PATCH RFC 1/2] KVM: remove unused __KVM_HAVE_ARCH_VM_ALLOC
In-Reply-To: <20170816194037.9460-1-rkrcmar@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
Message-ID: <20170816194037.9460-2-rkrcmar@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving it to generic code will allow us to extend it with ease.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Radim Kr?m?? <rkrcmar@redhat.com>
---
 include/linux/kvm_host.h | 12 ------------
 virt/kvm/kvm_main.c      | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538eda32..c8df733eed41 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -803,18 +803,6 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
 
-#ifndef __KVM_HAVE_ARCH_VM_ALLOC
-static inline struct kvm *kvm_arch_alloc_vm(void)
-{
-	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
-}
-
-static inline void kvm_arch_free_vm(struct kvm *kvm)
-{
-	kfree(kvm);
-}
-#endif
-
 #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
 void kvm_arch_register_noncoherent_dma(struct kvm *kvm);
 void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e17c40d986f3..2eac2c62795f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -640,10 +640,20 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 	return 0;
 }
 
+static inline struct kvm *kvm_alloc_vm(void)
+{
+	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
+}
+
+static inline void kvm_free_vm(struct kvm *kvm)
+{
+	kfree(kvm);
+}
+
 static struct kvm *kvm_create_vm(unsigned long type)
 {
 	int r, i;
-	struct kvm *kvm = kvm_arch_alloc_vm();
+	struct kvm *kvm = kvm_alloc_vm();
 
 	if (!kvm)
 		return ERR_PTR(-ENOMEM);
@@ -720,7 +730,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 		kfree(kvm_get_bus(kvm, i));
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
 		kvm_free_memslots(kvm, __kvm_memslots(kvm, i));
-	kvm_arch_free_vm(kvm);
+	kvm_free_vm(kvm);
 	mmdrop(current->mm);
 	return ERR_PTR(r);
 }
@@ -771,7 +781,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm_free_memslots(kvm, __kvm_memslots(kvm, i));
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	cleanup_srcu_struct(&kvm->srcu);
-	kvm_arch_free_vm(kvm);
+	kvm_free_vm(kvm);
 	preempt_notifier_dec();
 	hardware_disable_all();
 	mmdrop(mm);
-- 
2.13.3
