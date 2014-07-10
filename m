From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 10 Jul 2014 07:42:31 -0700
Subject: [PATCH] arm/arm64: KVM: Support KVM_CAP_READONLY_MEM
Message-ID: <1405003351-12973-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When userspace loads code and data in a read-only memory regions, KVM
needs to be able to handle this on arm and arm64.  Specifically this is
used when running code directly from a read-only flash device; the
common scenario is a UEFI blob loaded with the -bios option in QEMU.

To avoid looking through the memslots twice and to reuse the hva error
checking of gfn_to_hva_prot(), add a new gfn_to_hva_memslot_prot()
function and refactor gfn_to_hva_prot() to use this function.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Note that if you want to test this with QEMU, you need to update the
uapi headers.  You can also grab the branch below from my qemu git tree
with the temporary update headers patch applied on top of Peter
Maydell's -bios in -M virt support patches:

git://git.linaro.org/people/christoffer.dall/qemu-arm.git virt-for-uefi

 arch/arm/include/uapi/asm/kvm.h   |  1 +
 arch/arm/kvm/arm.c                |  1 +
 arch/arm/kvm/mmu.c                | 15 ++++++++-------
 arch/arm64/include/uapi/asm/kvm.h |  1 +
 include/linux/kvm_host.h          |  2 ++
 virt/kvm/kvm_main.c               | 11 +++++++++--
 6 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index e6ebdd3..51257fd 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -25,6 +25,7 @@
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
+#define __KVM_HAVE_READONLY_MEM
 
 #define KVM_REG_SIZE(id)						\
 	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d7424ef..037adda 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -188,6 +188,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ARM_PSCI:
 	case KVM_CAP_ARM_PSCI_0_2:
+	case KVM_CAP_READONLY_MEM:
 		r = 1;
 		break;
 	case KVM_CAP_COALESCED_MMIO:
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 0f6f642..d606d86 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -745,14 +745,13 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
 }
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  struct kvm_memory_slot *memslot,
+			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
 {
 	int ret;
 	bool write_fault, writable, hugetlb = false, force_pte = false;
 	unsigned long mmu_seq;
 	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
-	unsigned long hva = gfn_to_hva(vcpu->kvm, gfn);
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
@@ -861,7 +860,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	unsigned long fault_status;
 	phys_addr_t fault_ipa;
 	struct kvm_memory_slot *memslot;
-	bool is_iabt;
+	unsigned long hva;
+	bool is_iabt, write_fault, writable;
 	gfn_t gfn;
 	int ret, idx;
 
@@ -882,7 +882,10 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	gfn = fault_ipa >> PAGE_SHIFT;
-	if (!kvm_is_visible_gfn(vcpu->kvm, gfn)) {
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
+	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
+	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
 		if (is_iabt) {
 			/* Prefetch Abort on I/O address */
 			kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
@@ -908,9 +911,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		goto out_unlock;
 	}
 
-	memslot = gfn_to_memslot(vcpu->kvm, gfn);
-
-	ret = user_mem_abort(vcpu, fault_ipa, memslot, fault_status);
+	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
 	if (ret == 0)
 		ret = 1;
 out_unlock:
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index e633ff8..f4ec5a6 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -37,6 +37,7 @@
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
+#define __KVM_HAVE_READONLY_MEM
 
 #define KVM_REG_SIZE(id)						\
 	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 970c681..8636b7f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -544,6 +544,8 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn);
 unsigned long gfn_to_hva(struct kvm *kvm, gfn_t gfn);
 unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable);
 unsigned long gfn_to_hva_memslot(struct kvm_memory_slot *slot, gfn_t gfn);
+unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot, gfn_t gfn,
+				      bool *writable);
 void kvm_release_page_clean(struct page *page);
 void kvm_release_page_dirty(struct page *page);
 void kvm_set_page_accessed(struct page *page);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c86be0f..a90f8d4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1073,9 +1073,9 @@ EXPORT_SYMBOL_GPL(gfn_to_hva);
  * If writable is set to false, the hva returned by this function is only
  * allowed to be read.
  */
-unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
+unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot,
+				      gfn_t gfn, bool *writable)
 {
-	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 	unsigned long hva = __gfn_to_hva_many(slot, gfn, NULL, false);
 
 	if (!kvm_is_error_hva(hva) && writable)
@@ -1084,6 +1084,13 @@ unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
 	return hva;
 }
 
+unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+
+	return gfn_to_hva_memslot_prot(slot, gfn, writable);
+}
+
 static int kvm_read_hva(void *data, void __user *hva, int len)
 {
 	return __copy_from_user(data, hva, len);
-- 
2.0.0
