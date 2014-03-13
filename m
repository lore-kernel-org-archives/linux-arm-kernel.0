From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Thu, 13 Mar 2014 13:19:29 -0500
Subject: [PATCH v4] ARM: vDSO gettimeofday using generic timer architecture
Message-ID: <1394734769-32760-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide fast userspace implementations of gettimeofday and
clock_gettime on systems that implement the generic timers extension
defined in ARMv7.  This follows the example of arm64 in conception but
significantly differs in some aspects of the implementation (C vs
assembly, mainly).

Clocks supported:
- CLOCK_REALTIME
- CLOCK_MONOTONIC
- CLOCK_REALTIME_COARSE
- CLOCK_MONOTONIC_COARSE

This also provides clock_getres (as arm64 does).

Note that while the high-precision realtime and monotonic clock
support depends on the generic timers extension, support for
clock_getres and coarse clocks is independent of the timer
implementation and is provided unconditionally.

Run-time tested on OMAP5, Arndale, and i.MX6 using a patched glibc[1],
verifying that results from the vDSO are consistent with results from
the kernel.

[1] RFC glibc patch here:
https://www.sourceware.org/ml/libc-alpha/2014-02/msg00680.html

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
Tested-by: Steve Capper <steve.capper@linaro.org>
---

Steve, since I made some minor changes from v3, re-testing on your
Arndale would be very much appreciated and would keep the changelog
technically honest :-)

Changes since v3:
- Update to 3.14-rc6.
- Use a more seqcount-like API for critical sections.  Using seqcount
  API directly, however, would leak kernel pointers to userspace when
  lockdep is enabled.
- Trap instead of looping forever in division-by-zero stubs.
- Record vdso base in mm context before installing mapping (for the
  sake of perf_mmap_event).

Changes since v2:
- Update to 3.14-rc4.
- Make vDSO configurable, depending on AEABI and MMU.
- Defer shifting of nanosecond component of timespec: fixes observed
  1ns inconsistencies for CLOCK_REALTIME, CLOCK_MONOTONIC (see
  45a7905fc48f for arm64 equivalent).
- Force reload of seq_count when spinning: without a memory clobber
  after the load of vdata->seq_count, GCC can generate code like this:
    2f8:   e59c9020        ldr     r9, [ip, #32]
    2fc:   e3190001        tst     r9, #1
    300:   1a000033        bne     3d4 <do_realtime+0x104>
    304:   f57ff05b        dmb     ish
    308:   e59c3034        ldr     r3, [ip, #52]   ; 0x34
    ...
    3d4:   eafffffe        b       3d4 <do_realtime+0x104>
- Build vdso.so with -lgcc: calls to __lshrdi3, __divsi3 sometimes
  emitted (especially with -Os).  Override certain libgcc functions to
  prevent undefined symbols.
- Do not clear PG_reserved on vdso pages.
- Remove unnecessary get_page calls.
- Simplify ELF signature check during init.
- Use volatile for asm syscall fallbacks.
- Check whether vdso_pagelist is initialized in arm_install_vdso.
- Record clocksource mask in data page.
- Reduce code duplication in do_realtime, do_monotonic.
- Reduce calculations performed in critical sections.
- Simplify coarse clock handling.
- Move datapage load to its own assembly routine.
- Tune vdso_data layout and tweak field names.
- Check vdso shared object for undefined symbols during build.

Changes since v1:
- update to 3.14-rc1
- ensure cache coherency for data page
- Document the kernel-to-userspace protocol for vdso data page updates,
  and note that the timekeeping core prevents concurrent updates.
- update wall-to-monotonic fields unconditionally
- move vdso_start, vdso_end declarations to vdso.h
- correctly build and run when CONFIG_ARM_ARCH_TIMER=n
- rearrange linker script to avoid overlapping sections when CONFIG_DEBUGINFO=n
- remove use_syscall checks from coarse clock paths
- crib BUG_INSTR (0xe7f001f2) from asm/bug.h for text fill

 arch/arm/include/asm/arch_timer.h    |   7 +-
 arch/arm/include/asm/auxvec.h        |   7 +
 arch/arm/include/asm/elf.h           |   8 +
 arch/arm/include/asm/mmu.h           |   3 +
 arch/arm/include/asm/vdso.h          |  43 +++++
 arch/arm/include/asm/vdso_datapage.h |  53 ++++++
 arch/arm/kernel/Makefile             |   1 +
 arch/arm/kernel/process.c            |  16 +-
 arch/arm/kernel/vdso.c               | 180 +++++++++++++++++++
 arch/arm/kernel/vdso/.gitignore      |   1 +
 arch/arm/kernel/vdso/Makefile        |  52 ++++++
 arch/arm/kernel/vdso/checkundef.sh   |   9 +
 arch/arm/kernel/vdso/datapage.S      |  14 ++
 arch/arm/kernel/vdso/vdso.S          |  35 ++++
 arch/arm/kernel/vdso/vdso.lds.S      |  89 +++++++++
 arch/arm/kernel/vdso/vgettimeofday.c | 338 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                  |  15 ++
 17 files changed, 866 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/auxvec.h
 create mode 100644 arch/arm/include/asm/vdso.h
 create mode 100644 arch/arm/include/asm/vdso_datapage.h
 create mode 100644 arch/arm/kernel/vdso.c
 create mode 100644 arch/arm/kernel/vdso/.gitignore
 create mode 100644 arch/arm/kernel/vdso/Makefile
 create mode 100755 arch/arm/kernel/vdso/checkundef.sh
 create mode 100644 arch/arm/kernel/vdso/datapage.S
 create mode 100644 arch/arm/kernel/vdso/vdso.S
 create mode 100644 arch/arm/kernel/vdso/vdso.lds.S
 create mode 100644 arch/arm/kernel/vdso/vgettimeofday.c

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 0704e0cf5571..047c800b57f0 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -103,13 +103,16 @@ static inline void arch_counter_set_user_access(void)
 {
 	u32 cntkctl = arch_timer_get_cntkctl();
 
-	/* Disable user access to both physical/virtual counters/timers */
+	/* Disable user access to the timers and the physical counter */
 	/* Also disable virtual event stream */
 	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
 			| ARCH_TIMER_USR_VT_ACCESS_EN
 			| ARCH_TIMER_VIRT_EVT_EN
-			| ARCH_TIMER_USR_VCT_ACCESS_EN
 			| ARCH_TIMER_USR_PCT_ACCESS_EN);
+
+	/* Enable user access to the virtual counter */
+	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
+
 	arch_timer_set_cntkctl(cntkctl);
 }
 
diff --git a/arch/arm/include/asm/auxvec.h b/arch/arm/include/asm/auxvec.h
new file mode 100644
index 000000000000..f56936b97ec2
--- /dev/null
+++ b/arch/arm/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+/* vDSO location */
+#define AT_SYSINFO_EHDR	33
+
+#endif
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index f4b46d39b9cf..fc96b78a8102 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -1,6 +1,7 @@
 #ifndef __ASMARM_ELF_H
 #define __ASMARM_ELF_H
 
+#include <asm/auxvec.h>
 #include <asm/hwcap.h>
 
 /*
@@ -129,6 +130,13 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define arch_randomize_brk arch_randomize_brk
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_VDSO
+#define ARCH_DLINFO							\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (elf_addr_t)current->mm->context.vdso);		\
+} while (0)
+#endif
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
 int arch_setup_additional_pages(struct linux_binprm *, int);
diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 64fd15159b7d..a5b47421059d 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -11,6 +11,9 @@ typedef struct {
 #endif
 	unsigned int	vmalloc_seq;
 	unsigned long	sigpage;
+#ifdef CONFIG_VDSO
+	unsigned long	vdso;
+#endif
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
new file mode 100644
index 000000000000..ecffcba5e202
--- /dev/null
+++ b/arch/arm/include/asm/vdso.h
@@ -0,0 +1,43 @@
+#ifndef __ASM_VDSO_H
+#define __ASM_VDSO_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <linux/mm_types.h>
+#include <asm/mmu.h>
+
+#ifdef CONFIG_VDSO
+
+static inline bool vma_is_vdso(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.vdso)
+		return true;
+	return false;
+}
+
+void arm_install_vdso(struct mm_struct *mm);
+
+extern char vdso_start, vdso_end;
+
+#else /* CONFIG_VDSO */
+
+static inline bool vma_is_vdso(struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline void arm_install_vdso(struct mm_struct *mm)
+{
+}
+
+#endif /* CONFIG_VDSO */
+
+#endif /* __ASSEMBLY__ */
+
+#define VDSO_LBASE	0x0
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_H */
diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
new file mode 100644
index 000000000000..9011ec75a24b
--- /dev/null
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -0,0 +1,53 @@
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
+#ifndef __ASM_VDSO_DATAPAGE_H
+#define __ASM_VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+/* Try to be cache-friendly on systems that don't implement the
+ * generic timer: fit the unconditionally updated fields in the first
+ * 32 bytes.
+ */
+struct vdso_data {
+	u32 seq_count;		/* sequence count - odd during updates */
+	u16 use_syscall;	/* whether to fall back to syscalls */
+	u16 cs_shift;		/* clocksource shift */
+	u32 xtime_coarse_sec;	/* coarse time */
+	u32 xtime_coarse_nsec;
+
+	u32 wtm_clock_sec;	/* wall to monotonic offset */
+	u32 wtm_clock_nsec;
+	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
+	u32 cs_mult;		/* clocksource multiplier */
+
+	u64 cs_cycle_last;	/* last cycle value */
+	u64 cs_mask;		/* clocksource mask */
+
+	u64 xtime_clock_snsec;	/* CLOCK_REALTIME sub-ns base */
+	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
+	u32 tz_dsttime;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a30fc9be9e9e..a02d74c175f8 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
+obj-$(CONFIG_VDSO)		+= vdso.o vdso/
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15dd221..6ebd87d1c4cc 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -41,6 +41,7 @@
 #include <asm/stacktrace.h>
 #include <asm/mach/time.h>
 #include <asm/tls.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -472,9 +473,16 @@ int in_gate_area_no_mm(unsigned long addr)
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
-	return is_gate_vma(vma) ? "[vectors]" :
-		(vma->vm_mm && vma->vm_start == vma->vm_mm->context.sigpage) ?
-		 "[sigpage]" : NULL;
+	if (is_gate_vma(vma))
+		return "[vectors]";
+
+	if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.sigpage)
+		return "[sigpage]";
+
+	if (vma_is_vdso(vma))
+		return "[vdso]";
+
+	return NULL;
 }
 
 static struct page *signal_page;
@@ -505,6 +513,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret == 0)
 		mm->context.sigpage = addr;
 
+	arm_install_vdso(mm);
+
  up_fail:
 	up_write(&mm->mmap_sem);
 	return ret;
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
new file mode 100644
index 000000000000..91cbc5f14fb5
--- /dev/null
+++ b/arch/arm/kernel/vdso.c
@@ -0,0 +1,180 @@
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
+static unsigned long vdso_pages;
+static unsigned long vdso_mapping_len;
+static struct page **vdso_pagelist;
+
+static union {
+	struct vdso_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data = &vdso_data_store.data;
+
+/*
+ * The vDSO data page.
+ */
+
+static int __init vdso_init(void)
+{
+	int i;
+
+	if (memcmp(&vdso_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -ENOEXEC;
+	}
+
+	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	pr_info("vdso: %ld pages (%ld code, %ld data) at base %p\n",
+		vdso_pages + 1, vdso_pages, 1L, &vdso_start);
+
+	/* Allocate the vDSO pagelist, plus a page for the data. */
+	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
+				GFP_KERNEL);
+	if (vdso_pagelist == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO code pages. */
+	for (i = 0; i < vdso_pages; i++)
+		vdso_pagelist[i] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+
+	/* Grab the vDSO data page. */
+	vdso_pagelist[i] = virt_to_page(vdso_data);
+
+	/* Precompute the mapping size */
+	vdso_mapping_len = (vdso_pages + 1) << PAGE_SHIFT;
+
+	return 0;
+}
+arch_initcall(vdso_init);
+
+/* assumes mmap_sem is write-locked */
+void arm_install_vdso(struct mm_struct *mm)
+{
+	unsigned long vdso_base;
+	int ret;
+
+	mm->context.vdso = ~0UL;
+
+	if (vdso_pagelist == NULL)
+		return;
+
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		pr_notice_once("%s: get_unapped_area failed (%ld)\n",
+			       __func__, (long)vdso_base);
+		return;
+	}
+
+	/*
+	 * Put vDSO base into mm struct before calling
+	 * install_special_mapping so the perf counter mmap tracking
+	 * code will recognise it as a vDSO.
+	 */
+	mm->context.vdso = vdso_base;
+
+	ret = install_special_mapping(mm, vdso_base, vdso_mapping_len,
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
diff --git a/arch/arm/kernel/vdso/.gitignore b/arch/arm/kernel/vdso/.gitignore
new file mode 100644
index 000000000000..f8b69d84238e
--- /dev/null
+++ b/arch/arm/kernel/vdso/.gitignore
@@ -0,0 +1 @@
+vdso.lds
diff --git a/arch/arm/kernel/vdso/Makefile b/arch/arm/kernel/vdso/Makefile
new file mode 100644
index 000000000000..313c0e26bf20
--- /dev/null
+++ b/arch/arm/kernel/vdso/Makefile
@@ -0,0 +1,52 @@
+obj-vdso := vgettimeofday.o datapage.o
+
+# Build rules
+targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
+obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+
+ccflags-y := -shared -fPIC -fno-common -fno-builtin
+ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
+		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+
+obj-y += vdso.o
+extra-y += vdso.lds
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+CFLAGS_REMOVE_vdso.o = -pg
+CFLAGS_REMOVE_vgettimeofday.o = -pg
+
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+
+# Force dependency
+$(obj)/vdso.o : $(obj)/vdso.so
+
+# Link rule for the .so file, .lds has to be first
+SYSCFLAGS_vdso.so.dbg = $(c_flags)
+$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
+	$(call if_changed,vdsold)
+
+checkundef = sh $(srctree)/$(src)/checkundef.sh
+quiet_cmd_vdsocheck = CHECK $<
+      cmd_vdsocheck = $(checkundef) '$(NM)' $<
+
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,vdsocheck)
+	$(call if_changed,objcopy)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL $@
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-T $^ -o $@ -lgcc
+
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/arm/kernel/vdso/checkundef.sh b/arch/arm/kernel/vdso/checkundef.sh
new file mode 100755
index 000000000000..185c30da202b
--- /dev/null
+++ b/arch/arm/kernel/vdso/checkundef.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+nm="$1"
+file="$2"
+"$nm" -u "$file" | ( ret=0; while read discard symbol
+do
+    echo "$file: undefined symbol $symbol"
+    ret=1
+done ; exit $ret )
+exit $?
diff --git a/arch/arm/kernel/vdso/datapage.S b/arch/arm/kernel/vdso/datapage.S
new file mode 100644
index 000000000000..91b19b815888
--- /dev/null
+++ b/arch/arm/kernel/vdso/datapage.S
@@ -0,0 +1,14 @@
+#include <linux/linkage.h>
+
+	.align 2
+.L_vdso_data_ptr:
+	.long	_vdso_data - .
+
+ENTRY(__get_datapage)
+	.cfi_startproc
+	adr	r0, .L_vdso_data_ptr
+	ldr	r1, [r0]
+	add	r0, r0, r1
+	bx	lr
+	.cfi_endproc
+ENDPROC(__get_datapage)
diff --git a/arch/arm/kernel/vdso/vdso.S b/arch/arm/kernel/vdso/vdso.S
new file mode 100644
index 000000000000..aed16ff84c5f
--- /dev/null
+++ b/arch/arm/kernel/vdso/vdso.S
@@ -0,0 +1,35 @@
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
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/page.h>
+
+	__PAGE_ALIGNED_DATA
+
+	.globl vdso_start, vdso_end
+	.balign PAGE_SIZE
+vdso_start:
+	.incbin "arch/arm/kernel/vdso/vdso.so"
+	.balign PAGE_SIZE
+vdso_end:
+
+	.previous
diff --git a/arch/arm/kernel/vdso/vdso.lds.S b/arch/arm/kernel/vdso/vdso.lds.S
new file mode 100644
index 000000000000..24dd7b84e366
--- /dev/null
+++ b/arch/arm/kernel/vdso/vdso.lds.S
@@ -0,0 +1,89 @@
+/*
+ * Adapted from arm64 version.
+ *
+ * GNU linker script for the VDSO library.
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
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Heavily based on the vDSO linker scripts for other archs.
+ */
+
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+
+SECTIONS
+{
+	. = VDSO_LBASE + SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	.text		: { *(.text*) }			:text	=0xe7f001f2
+
+	.got		: { *(.got) }
+	.rel.plt	: { *(.rel.plt) }
+
+	. = ALIGN(PAGE_SIZE);
+	PROVIDE(_vdso_data = .);
+
+	/DISCARD/	: {
+		*(.note.GNU-stack)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+VERSION
+{
+	LINUX_3.15 {
+	global:
+		__kernel_clock_getres;
+		__kernel_clock_gettime;
+		__kernel_gettimeofday;
+	local: *;
+	};
+}
diff --git a/arch/arm/kernel/vdso/vgettimeofday.c b/arch/arm/kernel/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..8532b45cad62
--- /dev/null
+++ b/arch/arm/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,338 @@
+/*
+ * Copyright 2014 Mentor Graphics Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/compiler.h>
+#include <linux/hrtimer.h>
+#include <linux/time.h>
+#include <asm/arch_timer.h>
+#include <asm/barrier.h>
+#include <asm/bug.h>
+#include <asm/page.h>
+#include <asm/unistd.h>
+#include <asm/vdso_datapage.h>
+
+#ifndef CONFIG_AEABI
+#error This code depends on AEABI system call conventions
+#endif
+
+extern struct vdso_data *__get_datapage(void);
+
+static u32 __vdso_read_begin(const struct vdso_data *vdata)
+{
+	u32 seq;
+repeat:
+	seq = ACCESS_ONCE(vdata->seq_count);
+	if (seq & 1) {
+		cpu_relax();
+		goto repeat;
+	}
+	return seq;
+}
+
+static u32 vdso_read_begin(const struct vdso_data *vdata)
+{
+	u32 seq = __vdso_read_begin(vdata);
+	smp_rmb();
+	return seq;
+}
+
+static int vdso_read_retry(const struct vdso_data *vdata, u32 start)
+{
+	smp_rmb();
+	return vdata->seq_count != start;
+}
+
+static long clock_gettime_fallback(clockid_t _clkid, struct timespec *_ts)
+{
+	register struct timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_gettime;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static int do_realtime_coarse(struct timespec *ts, struct vdso_data *vdata)
+{
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vdata);
+
+		ts->tv_sec = vdata->xtime_coarse_sec;
+		ts->tv_nsec = vdata->xtime_coarse_nsec;
+
+	} while (vdso_read_retry(vdata, seq));
+
+	return 0;
+}
+
+static int do_monotonic_coarse(struct timespec *ts, struct vdso_data *vdata)
+{
+	struct timespec tomono;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vdata);
+
+		ts->tv_sec = vdata->xtime_coarse_sec;
+		ts->tv_nsec = vdata->xtime_coarse_nsec;
+
+		tomono.tv_sec = vdata->wtm_clock_sec;
+		tomono.tv_nsec = vdata->wtm_clock_nsec;
+
+	} while (vdso_read_retry(vdata, seq));
+
+	ts->tv_sec += tomono.tv_sec;
+	timespec_add_ns(ts, tomono.tv_nsec);
+
+	return 0;
+}
+
+#ifdef CONFIG_ARM_ARCH_TIMER
+
+static u64 get_ns(struct vdso_data *vdata)
+{
+	u64 cycle_delta;
+	u64 cycle_now;
+	u64 nsec;
+
+	cycle_now = arch_counter_get_cntvct();
+
+	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
+
+	nsec = (cycle_delta * vdata->cs_mult) + vdata->xtime_clock_snsec;
+	nsec >>= vdata->cs_shift;
+
+	return nsec;
+}
+
+static int do_realtime(struct timespec *ts, struct vdso_data *vdata)
+{
+	u64 nsecs;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vdata);
+
+		if (vdata->use_syscall)
+			return -1;
+
+		ts->tv_sec = vdata->xtime_clock_sec;
+		nsecs = get_ns(vdata);
+
+	} while (vdso_read_retry(vdata, seq));
+
+	ts->tv_nsec = 0;
+	timespec_add_ns(ts, nsecs);
+
+	return 0;
+}
+
+static int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+{
+	struct timespec tomono;
+	u64 nsecs;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vdata);
+
+		if (vdata->use_syscall)
+			return -1;
+
+		ts->tv_sec = vdata->xtime_clock_sec;
+		nsecs = get_ns(vdata);
+
+		tomono.tv_sec = vdata->wtm_clock_sec;
+		tomono.tv_nsec = vdata->wtm_clock_nsec;
+
+	} while (vdso_read_retry(vdata, seq));
+
+	ts->tv_sec += tomono.tv_sec;
+	ts->tv_nsec = 0;
+	timespec_add_ns(ts, nsecs + tomono.tv_nsec);
+
+	return 0;
+}
+
+#else /* CONFIG_ARM_ARCH_TIMER */
+
+static int do_realtime(struct timespec *ts, struct vdso_data *vdata)
+{
+	return -1;
+}
+
+static int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+{
+	return -1;
+}
+
+#endif /* CONFIG_ARM_ARCH_TIMER */
+
+int __kernel_clock_gettime(clockid_t clkid, struct timespec *ts)
+{
+	struct vdso_data *vdata;
+	int ret = -1;
+
+	vdata = __get_datapage();
+
+	switch (clkid) {
+	case CLOCK_REALTIME_COARSE:
+		ret = do_realtime_coarse(ts, vdata);
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		ret = do_monotonic_coarse(ts, vdata);
+		break;
+	case CLOCK_REALTIME:
+		ret = do_realtime(ts, vdata);
+		break;
+	case CLOCK_MONOTONIC:
+		ret = do_monotonic(ts, vdata);
+		break;
+	default:
+		break;
+	}
+
+	if (ret)
+		ret = clock_gettime_fallback(clkid, ts);
+
+	return ret;
+}
+
+static long clock_getres_fallback(clockid_t _clkid, struct timespec *_ts)
+{
+	register struct timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_getres;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+int __kernel_clock_getres(clockid_t clkid, struct timespec *ts)
+{
+	int ret;
+
+	switch (clkid) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+		if (ts) {
+			ts->tv_sec = 0;
+			ts->tv_nsec = MONOTONIC_RES_NSEC;
+		}
+		ret = 0;
+		break;
+	case CLOCK_REALTIME_COARSE:
+	case CLOCK_MONOTONIC_COARSE:
+		if (ts) {
+			ts->tv_sec = 0;
+			ts->tv_nsec = LOW_RES_NSEC;
+		}
+		ret = 0;
+		break;
+	default:
+		ret = clock_getres_fallback(clkid, ts);
+		break;
+	}
+
+	return ret;
+}
+
+static long gettimeofday_fallback(struct timeval *_tv, struct timezone *_tz)
+{
+	register struct timezone *tz asm("r1") = _tz;
+	register struct timeval *tv asm("r0") = _tv;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_gettimeofday;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	struct timespec ts;
+	struct vdso_data *vdata;
+	int ret;
+
+	vdata = __get_datapage();
+
+	ret = do_realtime(&ts, vdata);
+	if (ret)
+		return gettimeofday_fallback(tv, tz);
+
+	if (tv) {
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+	if (tz) {
+		tz->tz_minuteswest = vdata->tz_minuteswest;
+		tz->tz_dsttime = vdata->tz_dsttime;
+	}
+
+	return ret;
+}
+
+static inline void vdso_bug(void)
+{
+	/* Cribbed from asm/bug.h - force illegal instruction */
+	asm volatile(BUG_INSTR(BUG_INSTR_VALUE) "\n");
+	unreachable();
+}
+
+/* Avoid undefined symbols that can be referenced by routines brought
+ * in from libgcc.  libgcc's __div0, __aeabi_idiv0 and __aeabi_ldiv0
+ * can call raise(3); here they are defined to trap with an undefined
+ * instruction: divide by zero should not be possible in this code.
+ */
+void __div0(void)
+{
+	vdso_bug();
+}
+
+void __aeabi_idiv0(void)
+{
+	vdso_bug();
+}
+
+void __aeabi_ldiv0(void)
+{
+	vdso_bug();
+}
+
+void __aeabi_unwind_cpp_pr0(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr1(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr2(void)
+{
+}
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 1f8fed94c2a4..84898cf4b030 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -825,6 +825,21 @@ config KUSER_HELPERS
 	  Say N here only if you are absolutely certain that you do not
 	  need these helpers; otherwise, the safe option is to say Y.
 
+config VDSO
+	bool "Enable vDSO for acceleration of some system calls"
+	depends on AEABI && MMU
+	default y if ARM_ARCH_TIMER
+	select GENERIC_TIME_VSYSCALL
+	help
+	  Place in the process address space an ELF shared object
+	  providing fast implementations of several system calls,
+	  including gettimeofday and clock_gettime.  Systems that
+	  implement the ARM architected timer will receive maximum
+	  benefit.
+
+	  You must have glibc 2.20 or later for programs to seamlessly
+	  take advantage of this.
+
 config DMA_CACHE_RWFO
 	bool "Enable read/write for ownership DMA cache maintenance"
 	depends on CPU_V6K && SMP
-- 
1.8.3.1
