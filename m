From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:36 +0100
Subject: [GIT PULL 07/36] KVM: x86: switch to kvm_get_dirty_log_protect
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paolo Bonzini <pbonzini@redhat.com>

We now have a generic function that does most of the work of
kvm_vm_ioctl_get_dirty_log, now use it.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/x86/include/asm/kvm_host.h |  3 --
 arch/x86/kvm/Kconfig            |  1 +
 arch/x86/kvm/mmu.c              |  4 +--
 arch/x86/kvm/x86.c              | 72 ++++++++---------------------------------
 4 files changed, 16 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cb19d05..3ceddf4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -821,9 +821,6 @@ void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
 
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
-void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
-				     struct kvm_memory_slot *slot,
-				     gfn_t gfn_offset, unsigned long mask);
 void kvm_mmu_zap_all(struct kvm *kvm);
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm);
 unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index f9d16ff..d073594 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -39,6 +39,7 @@ config KVM
 	select PERF_EVENTS
 	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
+	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_VFIO
 	---help---
 	  Support hosting fully virtualized guest machines using hardware
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index a0985eb..3aa46aa 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1203,7 +1203,7 @@ static bool __rmap_write_protect(struct kvm *kvm, unsigned long *rmapp,
 }
 
 /**
- * kvm_mmu_write_protect_pt_masked - write protect selected PT level pages
+ * kvm_arch_mmu_write_protect_pt_masked - write protect selected PT level pages
  * @kvm: kvm instance
  * @slot: slot to protect
  * @gfn_offset: start of the BITS_PER_LONG pages we care about
@@ -1212,7 +1212,7 @@ static bool __rmap_write_protect(struct kvm *kvm, unsigned long *rmapp,
  * Used when we do not need to care about huge page mappings: e.g. during dirty
  * logging we do not have any such mappings.
  */
-void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
 				     struct kvm_memory_slot *slot,
 				     gfn_t gfn_offset, unsigned long mask)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 49ecda7..556dfb4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3748,83 +3748,37 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
  * @kvm: kvm instance
  * @log: slot id and address to which we copy the log
  *
- * We need to keep it in mind that VCPU threads can write to the bitmap
- * concurrently.  So, to avoid losing data, we keep the following order for
- * each bit:
+ * Steps 1-4 below provide general overview of dirty page logging. See
+ * kvm_get_dirty_log_protect() function description for additional details.
+ *
+ * We call kvm_get_dirty_log_protect() to handle steps 1-3, upon return we
+ * always flush the TLB (step 4) even if previous step failed  and the dirty
+ * bitmap may be corrupt. Regardless of previous outcome the KVM logging API
+ * does not preclude user space subsequent dirty log read. Flushing TLB ensures
+ * writes will be marked dirty for next log read.
  *
  *   1. Take a snapshot of the bit and clear it if needed.
  *   2. Write protect the corresponding page.
- *   3. Flush TLB's if needed.
- *   4. Copy the snapshot to the userspace.
- *
- * Between 2 and 3, the guest may write to the page using the remaining TLB
- * entry.  This is not a problem because the page will be reported dirty at
- * step 4 using the snapshot taken before and step 3 ensures that successive
- * writes will be logged for the next call.
+ *   3. Copy the snapshot to the userspace.
+ *   4. Flush TLB's if needed.
  */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
-	int r;
-	struct kvm_memory_slot *memslot;
-	unsigned long n, i;
-	unsigned long *dirty_bitmap;
-	unsigned long *dirty_bitmap_buffer;
 	bool is_dirty = false;
+	int r;
 
 	mutex_lock(&kvm->slots_lock);
 
-	r = -EINVAL;
-	if (log->slot >= KVM_USER_MEM_SLOTS)
-		goto out;
-
-	memslot = id_to_memslot(kvm->memslots, log->slot);
-
-	dirty_bitmap = memslot->dirty_bitmap;
-	r = -ENOENT;
-	if (!dirty_bitmap)
-		goto out;
-
-	n = kvm_dirty_bitmap_bytes(memslot);
-
-	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
-	memset(dirty_bitmap_buffer, 0, n);
-
-	spin_lock(&kvm->mmu_lock);
-
-	for (i = 0; i < n / sizeof(long); i++) {
-		unsigned long mask;
-		gfn_t offset;
-
-		if (!dirty_bitmap[i])
-			continue;
-
-		is_dirty = true;
-
-		mask = xchg(&dirty_bitmap[i], 0);
-		dirty_bitmap_buffer[i] = mask;
-
-		offset = i * BITS_PER_LONG;
-		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
-	}
-
-	spin_unlock(&kvm->mmu_lock);
-
-	/* See the comments in kvm_mmu_slot_remove_write_access(). */
-	lockdep_assert_held(&kvm->slots_lock);
+	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
 
 	/*
 	 * All the TLBs can be flushed out of mmu lock, see the comments in
 	 * kvm_mmu_slot_remove_write_access().
 	 */
+	lockdep_assert_held(&kvm->slots_lock);
 	if (is_dirty)
 		kvm_flush_remote_tlbs(kvm);
 
-	r = -EFAULT;
-	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
-		goto out;
-
-	r = 0;
-out:
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
-- 
2.1.2.330.g565301e.dirty
