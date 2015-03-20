From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 20 Mar 2015 16:13:22 -0500
Subject: [PATCH v11 3/4] ARM: VDSO initialization, mapping, and synchronization
In-Reply-To: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
References: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1426886003-30123-4-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the VDSO page list at boot, install the VDSO mapping at
exec time, and update the data page during timer ticks.  This code is
not built if CONFIG_VDSO is not enabled.

Account for the VDSO length when randomizing the offset from the
stack.  The [vdso] and [vvar] pages are placed immediately following
the sigpage with separate _install_special_mapping calls.

We want to "penalize" systems lacking the arch timer as little
as possible.  Previous versions of this code installed the VDSO
unconditionally and unmodified, making it a measurably slower way for
glibc to invoke the real syscalls on such systems.  E.g. calling
gettimeofday via glibc goes from ~560ns to ~630ns on i.MX6Q.

If we can indicate to glibc that the time-related APIs in the VDSO are
not accelerated, glibc can continue to invoke the syscalls directly
instead of dispatching through the VDSO only to fall back to the slow
path.

Thus, if the architected timer is unusable for whatever reason, patch
the VDSO at boot time so that symbol lookups for gettimeofday and
clock_gettime return NULL.  (This is similar to what powerpc does and
borrows code from there.)  This allows glibc to perform the syscall
directly instead of passing control to the VDSO, which minimizes the
penalty.  In my measurements the time taken for a gettimeofday call
via glibc goes from ~560ns to ~580ns (again on i.MX6Q), and this is
solely due to adding a test and branch to glibc's gettimeofday syscall
wrapper.

An alternative to patching the VDSO at boot would be to not install
the VDSO at all when the arch timer isn't usable.  Another alternative
is to include a separate "dummy" vdso.so without gettimeofday and
clock_gettime, which would be selected at boot time.  Either of these
would get cumbersome if the VDSO were to gain support for an API such
as getcpu which is unrelated to arch timer support.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/process.c |  17 ++-
 arch/arm/kernel/vdso.c    | 337 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 351 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/kernel/vdso.c

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fdfa3a78ec8c..c50fe212fd89 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -41,6 +41,7 @@
 #include <asm/system_misc.h>
 #include <asm/mach/time.h>
 #include <asm/tls.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -475,7 +476,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 }
 
 /* If possible, provide a placement hint at a random offset from the
- * stack for the signal page.
+ * stack for the sigpage and vdso pages.
  */
 static unsigned long sigpage_addr(const struct mm_struct *mm,
 				  unsigned int npages)
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
index 000000000000..0d31d3ccab81
--- /dev/null
+++ b/arch/arm/kernel/vdso.c
@@ -0,0 +1,337 @@
+/*
+ * Adapted from arm64 version.
+ *
+ * Copyright (C) 2012 ARM Limited
+ * Copyright (C) 2015 Mentor Graphics Corporation.
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
+#include <linux/elf.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/timekeeper_internal.h>
+#include <linux/vmalloc.h>
+#include <asm/arch_timer.h>
+#include <asm/barrier.h>
+#include <asm/cacheflush.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+#include <clocksource/arm_arch_timer.h>
+
+#define MAX_SYMNAME	64
+
+static struct page **vdso_text_pagelist;
+
+/* Total number of pages needed for the data and text portions of the VDSO. */
+unsigned int vdso_total_pages __read_mostly;
+
+/*
+ * The VDSO data page.
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
+struct elfinfo {
+	Elf32_Ehdr	*hdr;		/* ptr to ELF */
+	Elf32_Sym	*dynsym;	/* ptr to .dynsym section */
+	unsigned long	dynsymsize;	/* size of .dynsym section */
+	char		*dynstr;	/* ptr to .dynstr section */
+};
+
+/* Cached result of boot-time check for whether the arch timer exists,
+ * and if so, whether the virtual counter is useable.
+ */
+static bool cntvct_ok __read_mostly;
+
+static bool __init cntvct_functional(void)
+{
+	struct device_node *np;
+	bool ret = false;
+
+	if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
+		goto out;
+
+	/* The arm_arch_timer core should export
+	 * arch_timer_use_virtual or similar so we don't have to do
+	 * this.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
+	if (!np)
+		goto out_put;
+
+	if (of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
+		goto out_put;
+
+	ret = true;
+
+out_put:
+	of_node_put(np);
+out:
+	return ret;
+}
+
+static void * __init find_section(Elf32_Ehdr *ehdr, const char *name,
+				  unsigned long *size)
+{
+	Elf32_Shdr *sechdrs;
+	unsigned int i;
+	char *secnames;
+
+	/* Grab section headers and strings so we can tell who is who */
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+	secnames = (void *)ehdr + sechdrs[ehdr->e_shstrndx].sh_offset;
+
+	/* Find the section they want */
+	for (i = 1; i < ehdr->e_shnum; i++) {
+		if (strcmp(secnames + sechdrs[i].sh_name, name) == 0) {
+			if (size)
+				*size = sechdrs[i].sh_size;
+			return (void *)ehdr + sechdrs[i].sh_offset;
+		}
+	}
+
+	if (size)
+		*size = 0;
+	return NULL;
+}
+
+static Elf32_Sym * __init find_symbol(struct elfinfo *lib, const char *symname)
+{
+	unsigned int i;
+
+	for (i = 0; i < (lib->dynsymsize / sizeof(Elf32_Sym)); i++) {
+		char name[MAX_SYMNAME], *c;
+
+		if (lib->dynsym[i].st_name == 0)
+			continue;
+		strlcpy(name, lib->dynstr + lib->dynsym[i].st_name,
+			MAX_SYMNAME);
+		c = strchr(name, '@');
+		if (c)
+			*c = 0;
+		if (strcmp(symname, name) == 0)
+			return &lib->dynsym[i];
+	}
+	return NULL;
+}
+
+static void __init vdso_nullpatch_one(struct elfinfo *lib, const char *symname)
+{
+	Elf32_Sym *sym;
+
+	sym = find_symbol(lib, symname);
+	if (!sym)
+		return;
+
+	sym->st_name = 0;
+}
+
+static void __init patch_vdso(void *ehdr)
+{
+	struct elfinfo einfo;
+
+	einfo = (struct elfinfo) {
+		.hdr = ehdr,
+	};
+
+	einfo.dynsym = find_section(einfo.hdr, ".dynsym", &einfo.dynsymsize);
+	einfo.dynstr = find_section(einfo.hdr, ".dynstr", NULL);
+
+	/* If the virtual counter is absent or non-functional we don't
+	 * want programs to incur the slight additional overhead of
+	 * dispatching through the VDSO only to fall back to syscalls.
+	 */
+	if (!cntvct_ok) {
+		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
+	}
+}
+
+static int __init vdso_init(void)
+{
+	unsigned int text_pages;
+	int i;
+
+	if (memcmp(&vdso_start, "\177ELF", 4)) {
+		pr_err("VDSO is not a valid ELF object!\n");
+		return -ENOEXEC;
+	}
+
+	text_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	pr_debug("vdso: %i text pages at base %p\n", text_pages, &vdso_start);
+
+	/* Allocate the VDSO text pagelist */
+	vdso_text_pagelist = kcalloc(text_pages, sizeof(struct page *),
+				     GFP_KERNEL);
+	if (vdso_text_pagelist == NULL)
+		return -ENOMEM;
+
+	/* Grab the VDSO data page. */
+	vdso_data_page = virt_to_page(vdso_data);
+
+	/* Grab the VDSO text pages. */
+	for (i = 0; i < text_pages; i++) {
+		struct page *page;
+
+		page = virt_to_page(&vdso_start + i * PAGE_SIZE);
+		vdso_text_pagelist[i] = page;
+	}
+
+	vdso_text_mapping.pages = vdso_text_pagelist;
+
+	vdso_total_pages = 1; /* for the data/vvar page */
+	vdso_total_pages += text_pages;
+
+	cntvct_ok = cntvct_functional();
+
+	patch_vdso(&vdso_start);
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
+	smp_wmb(); /* Pairs with smp_rmb in vdso_read_retry */
+}
+
+static void vdso_write_end(struct vdso_data *vdata)
+{
+	smp_wmb(); /* Pairs with smp_rmb in vdso_read_begin */
+	++vdso_data->seq_count;
+}
+
+static bool tk_is_cntvct(const struct timekeeper *tk)
+{
+	if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
+		return false;
+
+	if (strcmp(tk->tkr.clock->name, "arch_sys_counter") != 0)
+		return false;
+
+	return true;
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
+
+	if (!cntvct_ok) {
+		/* The entry points have been zeroed, so there is no
+		 * point in updating the data page.
+		 */
+		return;
+	}
+
+	vdso_write_begin(vdso_data);
+
+	xtime_coarse = __current_kernel_time();
+	vdso_data->tk_is_cntvct			= tk_is_cntvct(tk);
+	vdso_data->xtime_coarse_sec		= xtime_coarse.tv_sec;
+	vdso_data->xtime_coarse_nsec		= xtime_coarse.tv_nsec;
+	vdso_data->wtm_clock_sec		= wtm->tv_sec;
+	vdso_data->wtm_clock_nsec		= wtm->tv_nsec;
+
+	if (vdso_data->tk_is_cntvct) {
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
