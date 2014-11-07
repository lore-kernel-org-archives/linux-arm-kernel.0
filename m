From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 06 Nov 2014 16:40:44 -0800
Subject: [PATCH v13 3/7] KVM: x86: flush TLBs last before returning from
 KVM_GET_DIRTY_LOG
In-Reply-To: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
References: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1415320848-13813-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the next patches, we will move parts of x86's kvm_vm_ioctl_get_dirty_log
implementation to generic code; leave the arch-specific code at the end,
similar to the existing generic function kvm_get_dirty_log.

Reviewed-by: Mario Smarduch <m.smarduch@samsung.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8f1e22d..dc8e66b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3606,13 +3606,13 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
  *
  *   1. Take a snapshot of the bit and clear it if needed.
  *   2. Write protect the corresponding page.
- *   3. Flush TLB's if needed.
- *   4. Copy the snapshot to the userspace.
+ *   3. Copy the snapshot to the userspace.
+ *   4. Flush TLB's if needed.
  *
- * Between 2 and 3, the guest may write to the page using the remaining TLB
- * entry.  This is not a problem because the page will be reported dirty at
- * step 4 using the snapshot taken before and step 3 ensures that successive
- * writes will be logged for the next call.
+ * Between 2 and 4, the guest may write to the page using the remaining TLB
+ * entry.  This is not a problem because the page is reported dirty using
+ * the snapshot taken before and step 4 ensures that writes done after
+ * exiting to userspace will be logged for the next call.
  */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
@@ -3661,6 +3661,10 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 
 	spin_unlock(&kvm->mmu_lock);
 
+	r = 0;
+	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
+		r = -EFAULT;
+
 	/* See the comments in kvm_mmu_slot_remove_write_access(). */
 	lockdep_assert_held(&kvm->slots_lock);
 
@@ -3670,12 +3674,6 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	 */
 	if (is_dirty)
 		kvm_flush_remote_tlbs(kvm);
-
-	r = -EFAULT;
-	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
-		goto out;
-
-	r = 0;
 out:
 	mutex_unlock(&kvm->slots_lock);
 	return r;
-- 
1.7.9.5
