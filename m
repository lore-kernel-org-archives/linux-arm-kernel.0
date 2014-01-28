From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Tue, 28 Jan 2014 15:06:53 -0600
Subject: [RFC/PATCH] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
References: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1390943213-5698-1-git-send-email-nathan_lynch@mentor.com>
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

Tested on OMAP5 UEVM (Cortex A15) using a LD_PRELOAD shim to redirect
system calls to the vDSO.  I plan to undertake adding proper support
to glibc if the overall approach is acceptable.

Note that while the high-precision realtime and monotonic clock
support depends on the generic timers extension, support for
clock_getres and (I think) the coarse clocks is pretty much
independent of the timer implementation in use and could be provided
unconditionally.

I also hope to add getcpu to the vDSO, using something like
TPIDRURO/TPIDRURW (although I believe these registers are claimed for
other uses already -- suggestions welcome).

This is RFC-quality code at the moment -- I haven't tested this on a
system lacking generic timers, nor have I done much build testing.
I'm sure there is plenty of room for improvement.

Based on linux-next 20140124.
---
 arch/arm/Kconfig                     |   1 +
 arch/arm/include/asm/arch_timer.h    |   7 +-
 arch/arm/include/asm/auxvec.h        |   7 +
 arch/arm/include/asm/elf.h           |   6 +
 arch/arm/include/asm/mmu.h           |   1 +
 arch/arm/include/asm/vdso.h          |  26 +++
 arch/arm/include/asm/vdso_datapage.h |  45 ++++++
 arch/arm/kernel/Makefile             |   3 +-
 arch/arm/kernel/process.c            |  16 +-
 arch/arm/kernel/vdso.c               | 157 ++++++++++++++++++
 arch/arm/kernel/vdso/.gitignore      |   2 +
 arch/arm/kernel/vdso/Makefile        |  46 ++++++
 arch/arm/kernel/vdso/vdso.S          |  35 ++++
 arch/arm/kernel/vdso/vdso.lds.S      |  93 +++++++++++
 arch/arm/kernel/vdso/vgettimeofday.c | 303 +++++++++++++++++++++++++++++++++++
 15 files changed, 742 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/include/asm/auxvec.h
 create mode 100644 arch/arm/include/asm/vdso.h
 create mode 100644 arch/arm/include/asm/vdso_datapage.h
 create mode 100644 arch/arm/kernel/vdso.c
 create mode 100644 arch/arm/kernel/vdso/.gitignore
 create mode 100644 arch/arm/kernel/vdso/Makefile
 create mode 100644 arch/arm/kernel/vdso/vdso.S
 create mode 100644 arch/arm/kernel/vdso/vdso.lds.S
 create mode 100644 arch/arm/kernel/vdso/vgettimeofday.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dc6ef9a2c649..c9f69d059c76 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,6 +23,7 @@ config ARM
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select GENERIC_TIME_VSYSCALL
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 30cc2fb09416..80f24827af94 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -102,13 +102,16 @@ static inline void arch_counter_set_user_access(void)
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
index f4b46d39b9cf..b8d099264000 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -1,6 +1,7 @@
 #ifndef __ASMARM_ELF_H
 #define __ASMARM_ELF_H
 
+#include <asm/auxvec.h>
 #include <asm/hwcap.h>
 
 /*
@@ -129,6 +130,11 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define arch_randomize_brk arch_randomize_brk
 
 #ifdef CONFIG_MMU
+#define ARCH_DLINFO							\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (elf_addr_t)current->mm->context.vdso);		\
+} while (0)
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
 int arch_setup_additional_pages(struct linux_binprm *, int);
diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 64fd15159b7d..1ee0f42a3b26 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -11,6 +11,7 @@ typedef struct {
 #endif
 	unsigned int	vmalloc_seq;
 	unsigned long	sigpage;
+	unsigned long	vdso;
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
new file mode 100644
index 000000000000..ab080bbc4acf
--- /dev/null
+++ b/arch/arm/include/asm/vdso.h
@@ -0,0 +1,26 @@
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
+static inline bool vma_is_vdso(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.vdso)
+		return true;
+	return false;
+}
+
+void arm_install_vdso(void);
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
index 000000000000..e55358c1d565
--- /dev/null
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -0,0 +1,45 @@
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
+struct vdso_data {
+	__u64 cs_cycle_last;	/* Timebase at clocksource init */
+	__u32 xtime_clock_sec;	/* Kernel time */
+	__u32 xtime_clock_nsec;
+	__u32 xtime_coarse_sec;	/* Coarse time */
+	__u32 xtime_coarse_nsec;
+	__u32 wtm_clock_sec;	/* Wall to monotonic time */
+	__u32 wtm_clock_nsec;
+	__u32 tb_seq_count;	/* Timebase sequence counter */
+	__u32 cs_mult;		/* Clocksource multiplier */
+	__u32 cs_shift;		/* Clocksource shift */
+	__u32 tz_minuteswest;	/* Whacky timezone stuff */
+	__u32 tz_dsttime;
+	__u32 use_syscall;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a30fc9be9e9e..9e785550b307 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -18,7 +18,8 @@ CFLAGS_REMOVE_return_address.o = -pg
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o return_address.o \
 		   setup.o signal.o sigreturn_codes.o \
-		   stacktrace.o sys_arm.o time.o traps.o
+		   stacktrace.o sys_arm.o time.o traps.o \
+		   vdso.o vdso/
 
 obj-$(CONFIG_ATAGS)		+= atags_parse.o
 obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15dd221..9907227adf92 100644
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
 
+	arm_install_vdso();
+
  up_fail:
 	up_write(&mm->mmap_sem);
 	return ret;
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
new file mode 100644
index 000000000000..82ffb77df861
--- /dev/null
+++ b/arch/arm/kernel/vdso.c
@@ -0,0 +1,157 @@
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
+#include <asm/page.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+
+extern char vdso_start, vdso_end;
+
+static unsigned long vdso_pages;
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
+	struct page *pg;
+	char *vbase;
+	int i, ret = 0;
+
+	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	pr_info("vdso: %ld pages (%ld code, %ld data) at base %p\n",
+		vdso_pages + 1, vdso_pages, 1L, &vdso_start);
+
+	/* Allocate the vDSO pagelist, plus a page for the data. */
+	vdso_pagelist = kzalloc(sizeof(struct page *) * (vdso_pages + 1),
+				GFP_KERNEL);
+	if (vdso_pagelist == NULL) {
+		pr_err("Failed to allocate vDSO pagelist!\n");
+		return -ENOMEM;
+	}
+
+	/* Grab the vDSO code pages. */
+	for (i = 0; i < vdso_pages; i++) {
+		pg = virt_to_page(&vdso_start + i*PAGE_SIZE);
+		ClearPageReserved(pg);
+		get_page(pg);
+		vdso_pagelist[i] = pg;
+	}
+
+	/* Sanity check the shared object header. */
+	vbase = vmap(vdso_pagelist, 1, 0, PAGE_KERNEL);
+	if (vbase == NULL) {
+		pr_err("Failed to map vDSO pagelist!\n");
+		return -ENOMEM;
+	} else if (memcmp(vbase, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		ret = -EINVAL;
+		goto unmap;
+	}
+
+	/* Grab the vDSO data page. */
+	pg = virt_to_page(vdso_data);
+	get_page(pg);
+	vdso_pagelist[i] = pg;
+
+unmap:
+	vunmap(vbase);
+	return ret;
+}
+arch_initcall(vdso_init);
+
+/* assumes mmap_sem is write-locked */
+void arm_install_vdso(void)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long vdso_base, vdso_mapping_len;
+	int ret;
+
+	/* Be sure to map the data page */
+	vdso_mapping_len = (vdso_pages + 1) << PAGE_SHIFT;
+
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		pr_notice_once("%s: get_unapped_area failed (%ld)\n",
+			       __func__, (long)vdso_base);
+		ret = vdso_base;
+		return;
+	}
+	mm->context.vdso = vdso_base;
+
+	ret = install_special_mapping(mm, vdso_base, vdso_mapping_len,
+				      VM_READ|VM_EXEC|
+				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				      vdso_pagelist);
+	if (ret) {
+		pr_notice_once("%s: install_special_mapping failed (%d)\n",
+			       __func__, ret);
+		mm->context.vdso = 0;
+		return;
+	}
+}
+
+void update_vsyscall(struct timekeeper *tk)
+{
+	struct timespec xtime_coarse;
+	struct timespec wall_time = tk_xtime(tk);
+	struct timespec *wtm = &tk->wall_to_monotonic;
+	u32 use_syscall = strcmp(tk->clock->name, "arch_sys_counter");
+
+	++vdso_data->tb_seq_count;
+	smp_wmb();
+
+	xtime_coarse = __current_kernel_time();
+	vdso_data->use_syscall			= use_syscall;
+	vdso_data->xtime_coarse_sec		= xtime_coarse.tv_sec;
+	vdso_data->xtime_coarse_nsec		= xtime_coarse.tv_nsec;
+
+	if (!use_syscall) {
+		vdso_data->cs_cycle_last	= tk->clock->cycle_last;
+		vdso_data->xtime_clock_sec	= wall_time.tv_sec;
+		vdso_data->xtime_clock_nsec	= wall_time.tv_nsec;
+		vdso_data->cs_mult		= tk->mult;
+		vdso_data->cs_shift		= tk->shift;
+		vdso_data->wtm_clock_sec	= wtm->tv_sec;
+		vdso_data->wtm_clock_nsec	= wtm->tv_nsec;
+	}
+
+	smp_wmb();
+	++vdso_data->tb_seq_count;
+}
+
+void update_vsyscall_tz(void)
+{
+	vdso_data->tz_minuteswest	= sys_tz.tz_minuteswest;
+	vdso_data->tz_dsttime		= sys_tz.tz_dsttime;
+}
diff --git a/arch/arm/kernel/vdso/.gitignore b/arch/arm/kernel/vdso/.gitignore
new file mode 100644
index 000000000000..a4093e0671be
--- /dev/null
+++ b/arch/arm/kernel/vdso/.gitignore
@@ -0,0 +1,2 @@
+vdso.lds
+
diff --git a/arch/arm/kernel/vdso/Makefile b/arch/arm/kernel/vdso/Makefile
new file mode 100644
index 000000000000..cc2b42db840e
--- /dev/null
+++ b/arch/arm/kernel/vdso/Makefile
@@ -0,0 +1,46 @@
+obj-vdso := vgettimeofday.o
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
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL $@
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-T $^ -o $@
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
index 000000000000..e16f8f6f08e1
--- /dev/null
+++ b/arch/arm/kernel/vdso/vdso.lds.S
@@ -0,0 +1,93 @@
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
+	. = ALIGN(16);
+
+	.text		: { *(.text*) }			:text	=0xd503201f
+	PROVIDE (__etext = .);
+	PROVIDE (_etext = .);
+	PROVIDE (etext = .);
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	_end = .;
+	PROVIDE(end = .);
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
index 000000000000..1519283dc2e5
--- /dev/null
+++ b/arch/arm/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,303 @@
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
+#include <asm/unistd.h>
+#include <asm/vdso_datapage.h>
+
+extern struct vdso_data _vdso_data;
+
+static struct vdso_data *get_datapage(void)
+{
+	struct vdso_data *ret;
+
+	/* Hack to perform pc-relative load of data page */
+	asm("b 1f\n"
+	    ".align 2\n"
+	    "2:\n"
+	    ".long _vdso_data - .\n"
+	    "1:\n"
+	    "adr r2, 2b\n"
+	    "ldr r3, [r2]\n"
+	    "add %0, r2, r3\n" :
+	    "=r" (ret) : : "r2", "r3");
+
+	return ret;
+}
+
+static u32 seqcnt_acquire(struct vdso_data *vdata)
+{
+	u32 seq;
+
+	do {
+		seq = ACCESS_ONCE(vdata->tb_seq_count);
+	} while (seq & 1);
+
+	dmb(ish);
+
+	return seq;
+}
+
+static u32 seqcnt_read(struct vdso_data *vdata)
+{
+	dmb(ish);
+
+	return ACCESS_ONCE(vdata->tb_seq_count);
+}
+
+static long clock_gettime_fallback(clockid_t _clkid, struct timespec *_ts)
+{
+	register struct timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_gettime;
+
+	asm("swi #0" : "=r" (ret) : "r" (clkid), "r" (ts), "r" (nr) : "memory");
+
+	return ret;
+}
+
+static int do_realtime_coarse(struct timespec *ts, struct vdso_data *vdata)
+{
+	struct timespec copy;
+	u32 seq;
+
+	do {
+		seq = seqcnt_acquire(vdata);
+
+		if (vdata->use_syscall)
+			return -1;
+
+		copy.tv_sec = vdata->xtime_coarse_sec;
+		copy.tv_nsec = vdata->xtime_coarse_nsec;
+	} while (seq != seqcnt_read(vdata));
+
+	*ts = copy;
+
+	return 0;
+}
+
+static int do_monotonic_coarse(struct timespec *ts, struct vdso_data *vdata)
+{
+	struct timespec copy;
+	struct timespec wtm;
+	u32 seq;
+
+	do {
+		seq = seqcnt_acquire(vdata);
+
+		if (vdata->use_syscall)
+			return -1;
+
+		copy.tv_sec = vdata->xtime_coarse_sec;
+		copy.tv_nsec = vdata->xtime_coarse_nsec;
+		wtm.tv_sec = vdata->wtm_clock_sec;
+		wtm.tv_nsec = vdata->wtm_clock_nsec;
+	} while (seq != seqcnt_read(vdata));
+
+	copy.tv_sec += wtm.tv_sec;
+	copy.tv_nsec += wtm.tv_nsec;
+	if (copy.tv_nsec >= NSEC_PER_SEC) {
+		copy.tv_nsec -= NSEC_PER_SEC;
+		copy.tv_sec += 1;
+	}
+
+	*ts = copy;
+
+	return 0;
+}
+
+static int do_realtime(struct timespec *ts, struct vdso_data *vdata)
+{
+	unsigned long sec;
+	u32 seq;
+	u64 ns;
+
+	do {
+		u64 cycles;
+
+		seq = seqcnt_acquire(vdata);
+
+		if (vdata->use_syscall)
+			return -1;
+
+		cycles = arch_counter_get_cntvct() - vdata->cs_cycle_last;
+
+		/* The generic timer architecture guarantees only 56 bits */
+		cycles &= ~(0xff00ULL << 48);
+		ns = (cycles * vdata->cs_mult) >> vdata->cs_shift;
+
+		sec = vdata->xtime_clock_sec;
+		ns += vdata->xtime_clock_nsec;
+
+		while (ns >= NSEC_PER_SEC) {
+			ns -= NSEC_PER_SEC;
+			sec += 1;
+		}
+	} while (seq != seqcnt_read(vdata));
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+static int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+{
+	unsigned long sec;
+	u32 seq;
+	u64 ns;
+
+	do {
+		u64 cycles;
+
+		seq = seqcnt_acquire(vdata);
+
+		if (vdata->use_syscall)
+			return -1;
+
+		cycles = arch_counter_get_cntvct() - vdata->cs_cycle_last;
+
+		/* The generic timer architecture guarantees only 56 bits */
+		cycles &= ~(0xff00ULL << 48);
+		ns = (cycles * vdata->cs_mult) >> vdata->cs_shift;
+
+		sec = vdata->xtime_clock_sec;
+		ns += vdata->xtime_clock_nsec;
+
+		sec += vdata->wtm_clock_sec;
+		ns += vdata->wtm_clock_nsec;
+
+		while (ns >= NSEC_PER_SEC) {
+			ns -= NSEC_PER_SEC;
+			sec += 1;
+		}
+	} while (seq != seqcnt_read(vdata));
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+int __kernel_clock_gettime(clockid_t clkid, struct timespec *ts)
+{
+	struct vdso_data *vdata;
+	int ret = -1;
+
+	vdata = get_datapage();
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
+		"swi #0" :
+		"=r" (ret) :
+		"r" (clkid), "r" (ts), "r" (nr) :
+		"memory");
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
+	asm("swi #0" : "=r" (ret) : "r" (tv), "r" (tz), "r" (nr) : "memory");
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
+	vdata = get_datapage();
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
-- 
1.8.3.1
