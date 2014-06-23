From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:57 -0500
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and synchronization
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
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
 arch/arm/kernel/process.c |  13 +++-
 arch/arm/kernel/vdso.c    | 168 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/kernel/vdso.c

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 40445fb71ac9..39b0d68aa068 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -520,6 +520,7 @@ extern struct page *get_signal_page(void);
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long npages;
 	unsigned long addr;
 	unsigned long hint;
 	int ret;
@@ -529,9 +530,11 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (!signal_page)
 		return -ENOMEM;
 
+	npages = (vdso_mapping_len >> PAGE_SHIFT) + 1;
+
 	down_write(&mm->mmap_sem);
-	hint = vdso_addr(mm, 1);
-	addr = get_unmapped_area(NULL, hint, PAGE_SIZE, 0, 0);
+	hint = vdso_addr(mm, npages);
+	addr = get_unmapped_area(NULL, hint, npages, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret = addr;
 		goto up_fail;
@@ -544,6 +547,12 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret == 0)
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
index 000000000000..0cfd25f09adf
--- /dev/null
+++ b/arch/arm/kernel/vdso.c
@@ -0,0 +1,168 @@
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
+static struct page **vdso_pagelist;
+
+unsigned long vdso_mapping_len __read_mostly;
+
+/*
+ * The vDSO data page.
+ */
+static union vdso_data_store vdso_data_store __page_aligned_data;
+static struct vdso_data *vdso_data = &vdso_data_store.data;
+
+static int __init vdso_init(void)
+{
+	unsigned long vdso_pages;
+	int i;
+
+	if (memcmp(&vdso_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -ENOEXEC;
+	}
+
+	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	pr_debug("vdso: %ld code pages at base %p\n", vdso_pages, &vdso_start);
+
+	/* Allocate the vDSO pagelist, plus a page for the data. */
+	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
+				GFP_KERNEL);
+	if (vdso_pagelist == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO data page. */
+	vdso_pagelist[0] = virt_to_page(vdso_data);
+
+	/* Grab the vDSO code pages. */
+	for (i = 0; i < vdso_pages; i++)
+		vdso_pagelist[i + 1] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+
+	/* Precompute the mapping size */
+	vdso_mapping_len = (vdso_pages + 1) << PAGE_SHIFT;
+
+	return 0;
+}
+arch_initcall(vdso_init);
+
+/* assumes mmap_sem is write-locked */
+void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
+{
+	int ret;
+
+	mm->context.vdso = ~0UL;
+
+	if (vdso_pagelist == NULL)
+		return;
+
+	/*
+	 * Put vDSO base into mm struct before calling
+	 * install_special_mapping so the perf counter mmap tracking
+	 * code will recognise it as a vDSO.
+	 */
+	mm->context.vdso = addr;
+
+	ret = install_special_mapping(mm, addr, vdso_mapping_len,
+				      VM_READ|VM_EXEC|
+				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				      vdso_pagelist);
+	if (ret) {
+		pr_notice_once("%s: install_special_mapping failed (%d)\n",
+			       __func__, ret);
+		mm->context.vdso = ~0UL;
+		return;
+	}
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
+	struct timespec *wtm = &tk->wall_to_monotonic;
+	bool use_syscall = strcmp(tk->clock->name, "arch_sys_counter");
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
+		vdso_data->cs_cycle_last	= tk->cycle_last;
+		vdso_data->xtime_clock_sec	= tk->xtime_sec;
+		vdso_data->xtime_clock_snsec	= tk->xtime_nsec;
+		vdso_data->cs_mult		= tk->mult;
+		vdso_data->cs_shift		= tk->shift;
+		vdso_data->cs_mask		= tk->clock->mask;
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
