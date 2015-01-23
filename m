From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:35 +0100
Subject: [GIT PULL 06/36] KVM: Add generic support for dirty page logging
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mario Smarduch <m.smarduch@samsung.com>

kvm_get_dirty_log() provides generic handling of dirty bitmap, currently reused
by several architectures. Building on that we intrdoduce
kvm_get_dirty_log_protect() adding write protection to mark these pages dirty
for future write access, before next KVM_GET_DIRTY_LOG ioctl call from user
space.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 include/linux/kvm_host.h |  9 ++++++
 virt/kvm/Kconfig         |  6 ++++
 virt/kvm/kvm_main.c      | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 26f1060..3b934cc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -611,6 +611,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext);
 
 int kvm_get_dirty_log(struct kvm *kvm,
 			struct kvm_dirty_log *log, int *is_dirty);
+
+int kvm_get_dirty_log_protect(struct kvm *kvm,
+			struct kvm_dirty_log *log, bool *is_dirty);
+
+void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
+					struct kvm_memory_slot *slot,
+					gfn_t gfn_offset,
+					unsigned long mask);
+
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 				struct kvm_dirty_log *log);
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 3796a21..314950c 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -40,3 +40,9 @@ config KVM_VFIO
 
 config HAVE_KVM_ARCH_TLB_FLUSH_ALL
        bool
+
+config HAVE_KVM_ARCH_DIRTY_LOG_PROTECT
+       bool
+
+config KVM_GENERIC_DIRTYLOG_READ_PROTECT
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d03bd22..246cf29 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -995,6 +995,86 @@ out:
 }
 EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
 
+#ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
+/**
+ * kvm_get_dirty_log_protect - get a snapshot of dirty pages, and if any pages
+ *	are dirty write protect them for next write.
+ * @kvm:	pointer to kvm instance
+ * @log:	slot id and address to which we copy the log
+ * @is_dirty:	flag set if any page is dirty
+ *
+ * We need to keep it in mind that VCPU threads can write to the bitmap
+ * concurrently. So, to avoid losing track of dirty pages we keep the
+ * following order:
+ *
+ *    1. Take a snapshot of the bit and clear it if needed.
+ *    2. Write protect the corresponding page.
+ *    3. Copy the snapshot to the userspace.
+ *    4. Upon return caller flushes TLB's if needed.
+ *
+ * Between 2 and 4, the guest may write to the page using the remaining TLB
+ * entry.  This is not a problem because the page is reported dirty using
+ * the snapshot taken before and step 4 ensures that writes done after
+ * exiting to userspace will be logged for the next call.
+ *
+ */
+int kvm_get_dirty_log_protect(struct kvm *kvm,
+			struct kvm_dirty_log *log, bool *is_dirty)
+{
+	struct kvm_memory_slot *memslot;
+	int r, i;
+	unsigned long n;
+	unsigned long *dirty_bitmap;
+	unsigned long *dirty_bitmap_buffer;
+
+	r = -EINVAL;
+	if (log->slot >= KVM_USER_MEM_SLOTS)
+		goto out;
+
+	memslot = id_to_memslot(kvm->memslots, log->slot);
+
+	dirty_bitmap = memslot->dirty_bitmap;
+	r = -ENOENT;
+	if (!dirty_bitmap)
+		goto out;
+
+	n = kvm_dirty_bitmap_bytes(memslot);
+
+	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
+	memset(dirty_bitmap_buffer, 0, n);
+
+	spin_lock(&kvm->mmu_lock);
+	*is_dirty = false;
+	for (i = 0; i < n / sizeof(long); i++) {
+		unsigned long mask;
+		gfn_t offset;
+
+		if (!dirty_bitmap[i])
+			continue;
+
+		*is_dirty = true;
+
+		mask = xchg(&dirty_bitmap[i], 0);
+		dirty_bitmap_buffer[i] = mask;
+
+		offset = i * BITS_PER_LONG;
+		kvm_arch_mmu_write_protect_pt_masked(kvm, memslot, offset,
+								mask);
+	}
+
+	spin_unlock(&kvm->mmu_lock);
+
+	r = -EFAULT;
+	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
+		goto out;
+
+	r = 0;
+out:
+	return r;
+}
+EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
+#endif
+
 bool kvm_largepages_enabled(void)
 {
 	return largepages_enabled;
-- 
2.1.2.330.g565301e.dirty
