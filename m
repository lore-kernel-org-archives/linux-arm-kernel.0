From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 Jan 2015 15:58:53 -0800
Subject: [PATCH v16 02/10] KVM: Add generic support for dirty page logging
In-Reply-To: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
References: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1421366341-26012-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_get_dirty_log() provides generic handling of dirty bitmap, currently reused
by several architectures. Building on that we intrdoduce
kvm_get_dirty_log_protect() adding write protection to mark these pages dirty
for future write access, before next KVM_GET_DIRTY_LOG ioctl call from user
space.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 include/linux/kvm_host.h |    9 ++++++
 virt/kvm/Kconfig         |    6 ++++
 virt/kvm/kvm_main.c      |   80 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e4d8f70..ed29e79 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -602,6 +602,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext);
 
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
index 51e9dfa..55a16b2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1001,6 +1001,86 @@ out:
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
1.7.9.5
