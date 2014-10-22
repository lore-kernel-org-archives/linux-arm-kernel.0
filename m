From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 22 Oct 2014 15:34:07 -0700
Subject: [PATCH v12 2/6] KVM: Add generic support for dirty page logging
In-Reply-To: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1414017251-5772-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines KVM_GENERIC_DIRTYLOG, and moves dirty log read function
to it's own file virt/kvm/dirtylog.c. x86 is updated to use the generic
dirty log interface, selecting KVM_GENERIC_DIRTYLOG in its Kconfig and 
makefile. No other architectures are affected, each uses it's own version.
This changed from previous patch revision where non-generic architectures 
were modified.

In subsequent patch armv7 does samething. All other architectures continue
use architecture defined version.


Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/x86/include/asm/kvm_host.h |    3 --
 arch/x86/kvm/Kconfig            |    1 +
 arch/x86/kvm/Makefile           |    1 +
 arch/x86/kvm/x86.c              |   86 ------------------------------
 include/linux/kvm_host.h        |    4 ++
 virt/kvm/Kconfig                |    3 ++
 virt/kvm/dirtylog.c             |  112 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 121 insertions(+), 89 deletions(-)
 create mode 100644 virt/kvm/dirtylog.c

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7c492ed..934dc24 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -805,9 +805,6 @@ void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
 
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
-void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
-				     struct kvm_memory_slot *slot,
-				     gfn_t gfn_offset, unsigned long mask);
 void kvm_mmu_zap_all(struct kvm *kvm);
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm);
 unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index f9d16ff..dca6fc7 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -40,6 +40,7 @@ config KVM
 	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_VFIO
+	select KVM_GENERIC_DIRTYLOG
 	---help---
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 25d22b2..2536195 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -12,6 +12,7 @@ kvm-y			+= $(KVM)/kvm_main.o $(KVM)/ioapic.o \
 				$(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o
 kvm-$(CONFIG_KVM_DEVICE_ASSIGNMENT)	+= $(KVM)/assigned-dev.o $(KVM)/iommu.o
 kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
+kvm-$(CONFIG_KVM_GENERIC_DIRTYLOG) 	+=$(KVM)/dirtylog.o
 
 kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o cpuid.o pmu.o
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8f1e22d..1467fa4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3595,92 +3595,6 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
 	return 0;
 }
 
-/**
- * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
- * @kvm: kvm instance
- * @log: slot id and address to which we copy the log
- *
- * We need to keep it in mind that VCPU threads can write to the bitmap
- * concurrently.  So, to avoid losing data, we keep the following order for
- * each bit:
- *
- *   1. Take a snapshot of the bit and clear it if needed.
- *   2. Write protect the corresponding page.
- *   3. Flush TLB's if needed.
- *   4. Copy the snapshot to the userspace.
- *
- * Between 2 and 3, the guest may write to the page using the remaining TLB
- * entry.  This is not a problem because the page will be reported dirty at
- * step 4 using the snapshot taken before and step 3 ensures that successive
- * writes will be logged for the next call.
- */
-int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
-{
-	int r;
-	struct kvm_memory_slot *memslot;
-	unsigned long n, i;
-	unsigned long *dirty_bitmap;
-	unsigned long *dirty_bitmap_buffer;
-	bool is_dirty = false;
-
-	mutex_lock(&kvm->slots_lock);
-
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
-
-	/*
-	 * All the TLBs can be flushed out of mmu lock, see the comments in
-	 * kvm_mmu_slot_remove_write_access().
-	 */
-	if (is_dirty)
-		kvm_flush_remote_tlbs(kvm);
-
-	r = -EFAULT;
-	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
-		goto out;
-
-	r = 0;
-out:
-	mutex_unlock(&kvm->slots_lock);
-	return r;
-}
-
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 			bool line_status)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a4c33b3..05ebcbe 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -592,6 +592,10 @@ int kvm_get_dirty_log(struct kvm *kvm,
 			struct kvm_dirty_log *log, int *is_dirty);
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 				struct kvm_dirty_log *log);
+void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+					struct kvm_memory_slot *slot,
+					gfn_t gfn_offset,
+					unsigned long mask);
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 			bool line_status);
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 3796a21..368fc4a 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -40,3 +40,6 @@ config KVM_VFIO
 
 config HAVE_KVM_ARCH_TLB_FLUSH_ALL
        bool
+
+config KVM_GENERIC_DIRTYLOG
+       bool
diff --git a/virt/kvm/dirtylog.c b/virt/kvm/dirtylog.c
new file mode 100644
index 0000000..67ffffa
--- /dev/null
+++ b/virt/kvm/dirtylog.c
@@ -0,0 +1,112 @@
+/*
+ * kvm generic dirty logging support, used by architectures that share
+ * comman dirty page logging implementation.
+ *
+ * Copyright (C) 2006 Qumranet, Inc.
+ * Copyright 2010 Red Hat, Inc. and/or its affiliates.
+ *
+ * Authors:
+ *   Avi Kivity   <avi@qumranet.com>
+ *   Yaniv Kamay  <yaniv@qumranet.com>
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kvm_host.h>
+
+#include <asm/processor.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+
+/**
+ * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
+ * @kvm: kvm instance
+ * @log: slot id and address to which we copy the log
+ *
+ * We need to keep it in mind that VCPU threads can write to the bitmap
+ * concurrently.  So, to avoid losing data, we keep the following order for
+ * each bit:
+ *
+ *   1. Take a snapshot of the bit and clear it if needed.
+ *   2. Write protect the corresponding page.
+ *   3. Flush TLB's if needed.
+ *   4. Copy the snapshot to the userspace.
+ *
+ * Between 2 and 3, the guest may write to the page using the remaining TLB
+ * entry.  This is not a problem because the page will be reported dirty at
+ * step 4 using the snapshot taken before and step 3 ensures that successive
+ * writes will be logged for the next call.
+ */
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
+{
+	int r;
+	struct kvm_memory_slot *memslot;
+	unsigned long n, i;
+	unsigned long *dirty_bitmap;
+	unsigned long *dirty_bitmap_buffer;
+	bool is_dirty = false;
+
+	mutex_lock(&kvm->slots_lock);
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
+
+	for (i = 0; i < n / sizeof(long); i++) {
+		unsigned long mask;
+		gfn_t offset;
+
+		if (!dirty_bitmap[i])
+			continue;
+
+		is_dirty = true;
+
+		mask = xchg(&dirty_bitmap[i], 0);
+		dirty_bitmap_buffer[i] = mask;
+
+		offset = i * BITS_PER_LONG;
+		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
+	}
+
+	spin_unlock(&kvm->mmu_lock);
+
+	/* See the comments in kvm_mmu_slot_remove_write_access(). */
+	lockdep_assert_held(&kvm->slots_lock);
+
+	/*
+	 * All the TLBs can be flushed out of mmu lock, see the comments in
+	 * kvm_mmu_slot_remove_write_access().
+	 */
+	if (is_dirty)
+		kvm_flush_remote_tlbs(kvm);
+
+	r = -EFAULT;
+	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
+		goto out;
+
+	r = 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
-- 
1.7.9.5
