From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:55 -0500
Subject: [PATCH v7 6/9] ARM: miscellaneous vdso infrastructure, preparation
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-7-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the layout of the data structure shared between kernel and
userspace.

Track the vdso address in the mm_context; needed for reporting [vdso]
via /proc/pid/maps and communicating AT_SYSINFO_EHDR to the ELF
loader.

Add declarations for vma_is_vdso, arm_install_vdso, and !CONFIG_VDSO
implementations of same.  The CONFIG_VDSO=y implementations of these
come later.

Make arch_vma_name recognize a vdso VMA, using vma_is_vdso to return
"[vdso]" when appropriate.

Define AT_SYSINFO_EHDR, and, if CONFIG_VDSO=y, report the vdso shared
object address via the ELF auxiliary vector.

Note - this adds the AT_SYSINFO_EHDR in a new user-visible header
asm/auxvec.h; this is consistent with other architectures.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/include/asm/Kbuild          |  1 -
 arch/arm/include/asm/elf.h           | 11 +++++++
 arch/arm/include/asm/mmu.h           |  3 ++
 arch/arm/include/asm/vdso.h          | 47 ++++++++++++++++++++++++++++
 arch/arm/include/asm/vdso_datapage.h | 60 ++++++++++++++++++++++++++++++++++++
 arch/arm/include/uapi/asm/Kbuild     |  1 +
 arch/arm/include/uapi/asm/auxvec.h   |  7 +++++
 arch/arm/kernel/process.c            | 14 +++++++--
 8 files changed, 140 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso.h
 create mode 100644 arch/arm/include/asm/vdso_datapage.h
 create mode 100644 arch/arm/include/uapi/asm/auxvec.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index f5a357601983..0e70f40e04ef 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -1,6 +1,5 @@
 
 
-generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += cputime.h
 generic-y += current.h
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index f4b46d39b9cf..45d2ddff662a 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -1,7 +1,9 @@
 #ifndef __ASMARM_ELF_H
 #define __ASMARM_ELF_H
 
+#include <asm/auxvec.h>
 #include <asm/hwcap.h>
+#include <asm/vdso_datapage.h>
 
 /*
  * ELF register definitions..
@@ -129,6 +131,15 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define arch_randomize_brk arch_randomize_brk
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_VDSO
+#define ARCH_DLINFO								\
+do {										\
+	/* Account for the data page at the beginning of the [vdso] VMA. */	\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,						\
+		    (elf_addr_t)current->mm->context.vdso +			\
+		    sizeof(union vdso_data_store));				\
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
index 000000000000..0e2a6154eceb
--- /dev/null
+++ b/arch/arm/include/asm/vdso.h
@@ -0,0 +1,47 @@
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
+void arm_install_vdso(struct mm_struct *mm, unsigned long addr);
+
+extern char vdso_start, vdso_end;
+
+extern unsigned long vdso_mapping_len;
+
+#else /* CONFIG_VDSO */
+
+static inline bool vma_is_vdso(struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
+{
+}
+
+#define vdso_mapping_len 0
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
index 000000000000..f08bdb73d3f4
--- /dev/null
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -0,0 +1,60 @@
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
+#include <asm/page.h>
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
+union vdso_data_store {
+	struct vdso_data data;
+	u8 page[PAGE_SIZE];
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 70a1c9da30ca..a1c05f93d920 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -1,6 +1,7 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+header-y += auxvec.h
 header-y += byteorder.h
 header-y += fcntl.h
 header-y += hwcap.h
diff --git a/arch/arm/include/uapi/asm/auxvec.h b/arch/arm/include/uapi/asm/auxvec.h
new file mode 100644
index 000000000000..f56936b97ec2
--- /dev/null
+++ b/arch/arm/include/uapi/asm/auxvec.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+/* vDSO location */
+#define AT_SYSINFO_EHDR	33
+
+#endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 219a0d1d10fc..40445fb71ac9 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -41,6 +41,7 @@
 #include <asm/system_misc.h>
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
 
 static unsigned long vdso_addr(const struct mm_struct *mm, unsigned int npages)
-- 
1.9.3
