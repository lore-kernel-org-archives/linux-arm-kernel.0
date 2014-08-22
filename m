From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 22 Aug 2014 16:52:30 -0500
Subject: [PATCH v9 5/6] ARM: vdso initialization, mapping, and synchronization
In-Reply-To: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1408744351-7814-6-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the vdso page list at boot, install the vdso mapping at
exec time, and update the data page during timer ticks.  This code is
not built if CONFIG_VDSO is not enabled.

Account for the vdso length when randomizing the offset from the
stack.  The vdso is placed immediately following the sigpage with a
separate install_special_mapping call in arm_install_vdso.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/process.c |  17 +++-
 arch/arm/kernel/vdso.c    | 207 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 221 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/kernel/vdso.c

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 9e0d931dd475..7aa1025aff1f 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -41,6 +41,7 @@
 #include <asm/system_misc.h>
 #include <asm/mach/time.h>
 #include <asm/tls.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -476,7 +477,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 }
 
 /* If possible, provide a placement hint at a random offset from the
- * stack for the signal page.
+ * stack for the sigpage and vdso pages.
  */
 static unsigned long sigpage_addr(const struct mm_struct *mm, unsigned int npages)
 {
@@ -519,6 +520,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	unsigned long npages;
 	unsigned long addr;
 	unsigned long hint;
 	int ret = 0;
@@ -528,9 +530,12 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (!signal_page)
 		return -ENOMEM;
 
+	npages = 1; /* for sigpage */
+	npages += vdso_total_pages;
+
 	down_write(&mm->mmap_sem);
-	hint = sigpage_addr(mm, 1);
-	addr = get_unmapped_area(NULL, hint, PAGE_SIZE, 0, 0);
+	hint = sigpage_addr(mm, npages);
+	addr = get_unmapped_area(NULL, hint, npages << PAGE_SHIFT, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret = addr;
 		goto up_fail;
@@ -547,6 +552,12 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	mm->context.sigpage = addr;
 
+	/* Unlike the sigpage, failure to install the vdso is unlikely
+	 * to be fatal to the process, so no error check needed
+	 * here.
+	 */
+	arm_install_vdso(mm, addr + PAGE_SIZE);
+
  up_fail:
 	up_write(&mm->mmap_sem);
 	return ret;
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
new file mode 100644
index 000000000000..7bd393f588ea
--- /dev/null
+++ b/arch/arm/kernel/vdso.c
@@ -0,0 +1,207 @@
+/*
+ * Adapted from arm64 version.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/timekeeper_internal.h>
+#include <linux/vmalloc.h>
+
+#include <asm/barrier.h>
+#include <asm/cacheflush.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+
+#include <asm/arch_timer.h>
+
+static struct page **vdso_text_pagelist;
+
+/* Total number of pages needed for the data and text portions of the VDSO. */
+unsigned int vdso_total_pages __read_mostly;
+
+/*
+ * The vDSO data page.
+ */
+static union vdso_data_store vdso_data_store __page_aligned_data;
+static struct vdso_data *vdso_data = &vdso_data_store.data;
+
+static struct page *vdso_data_page;
+static struct vm_special_mapping vdso_data_mapping = {
+	.name = "[vvar]",
+	.pages = &vdso_data_page,
+};
+
+static struct vm_special_mapping vdso_text_mapping = {
+	.name = "[vdso]",
+};
+
+static int __init vdso_init(void)
+{
+	unsigned int text_pages;
+	int i;
+
+	if (memcmp(&vdso_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -ENOEXEC;
+	}
+
+	text_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	pr_debug("vdso: %i text pages at base %p\n", text_pages, &vdso_start);
+
+	/* Allocate the vDSO text pagelist */
+	vdso_text_pagelist = kcalloc(text_pages, sizeof(struct page *),
+				     GFP_KERNEL);
+	if (vdso_text_pagelist == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO data page. */
+	vdso_data_page = virt_to_page(vdso_data);
+
+	/* Grab the vDSO text pages. */
+	for (i = 0; i < text_pages; i++)
+		vdso_text_pagelist[i] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+
+	vdso_text_mapping.pages = vdso_text_pagelist;
+
+	vdso_total_pages = 1; /* for the data/vvar page */
+	vdso_total_pages += text_pages;
+
+	return 0;
+}
+arch_initcall(vdso_init);
+
+static int install_vvar(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	vma = _install_special_mapping(mm, addr, PAGE_SIZE,
+				       VM_READ | VM_MAYREAD,
+				       &vdso_data_mapping);
+
+	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
+}
+
+/* assumes mmap_sem is write-locked */
+void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long len;
+
+	mm->context.vdso = 0;
+
+	if (vdso_text_pagelist == NULL)
+		return;
+
+	if (install_vvar(mm, addr))
+		return;
+
+	/* Account for vvar page. */
+	addr += PAGE_SIZE;
+	len = (vdso_total_pages - 1) << PAGE_SHIFT;
+
+	vma = _install_special_mapping(mm, addr, len,
+		VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
+		&vdso_text_mapping);
+
+	if (!IS_ERR(vma))
+		mm->context.vdso = addr;
+}
+
+static void vdso_write_begin(struct vdso_data *vdata)
+{
+	++vdso_data->seq_count;
+	smp_wmb();
+}
+
+static void vdso_write_end(struct vdso_data *vdata)
+{
+	smp_wmb();
+	++vdso_data->seq_count;
+}
+
+static bool vdso_can_use_arch_timer(const struct timekeeper *tk)
+{
+#ifdef CONFIG_ARM_ARCH_TIMER
+	u32 cntkctl;
+
+	if (strcmp(tk->tkr.clock->name, "arch_sys_counter") != 0)
+		return false;
+
+	cntkctl = arch_timer_get_cntkctl();
+
+	return cntkctl & ARCH_TIMER_USR_VCT_ACCESS_EN;
+#else
+	return false;
+#endif
+}
+
+/**
+ * update_vsyscall - update the vdso data page
+ *
+ * Increment the sequence counter, making it odd, indicating to
+ * userspace that an update is in progress.  Update the fields used
+ * for coarse clocks and, if the architected system timer is in use,
+ * the fields used for high precision clocks.  Increment the sequence
+ * counter again, making it even, indicating to userspace that the
+ * update is finished.
+ *
+ * Userspace is expected to sample seq_count before reading any other
+ * fields from the data page.  If seq_count is odd, userspace is
+ * expected to wait until it becomes even.  After copying data from
+ * the page, userspace must sample seq_count again; if it has changed
+ * from its previous value, userspace must retry the whole sequence.
+ *
+ * Calls to update_vsyscall are serialized by the timekeeping core.
+ */
+void update_vsyscall(struct timekeeper *tk)
+{
+	struct timespec xtime_coarse;
+	struct timespec64 *wtm = &tk->wall_to_monotonic;
+	bool use_syscall = !vdso_can_use_arch_timer(tk);
+
+	vdso_write_begin(vdso_data);
+
+	xtime_coarse = __current_kernel_time();
+	vdso_data->use_syscall			= use_syscall;
+	vdso_data->xtime_coarse_sec		= xtime_coarse.tv_sec;
+	vdso_data->xtime_coarse_nsec		= xtime_coarse.tv_nsec;
+	vdso_data->wtm_clock_sec		= wtm->tv_sec;
+	vdso_data->wtm_clock_nsec		= wtm->tv_nsec;
+
+	if (!use_syscall) {
+		vdso_data->cs_cycle_last	= tk->tkr.cycle_last;
+		vdso_data->xtime_clock_sec	= tk->xtime_sec;
+		vdso_data->xtime_clock_snsec	= tk->tkr.xtime_nsec;
+		vdso_data->cs_mult		= tk->tkr.mult;
+		vdso_data->cs_shift		= tk->tkr.shift;
+		vdso_data->cs_mask		= tk->tkr.mask;
+	}
+
+	vdso_write_end(vdso_data);
+
+	flush_dcache_page(virt_to_page(vdso_data));
+}
+
+void update_vsyscall_tz(void)
+{
+	vdso_data->tz_minuteswest	= sys_tz.tz_minuteswest;
+	vdso_data->tz_dsttime		= sys_tz.tz_dsttime;
+	flush_dcache_page(virt_to_page(vdso_data));
+}
-- 
1.9.3
