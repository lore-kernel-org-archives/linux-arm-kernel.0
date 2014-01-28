From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 28 Jan 2014 16:25:08 +0000
Subject: [RFC] arm: vdso: Convert sigpage to vdso implementation
Message-ID: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM has a special sigpage that is used for signal return trampolines.
Its implementation is very similar to a VDSO conceptually in that it
occupies a special mapping in user address space.

One could actually host the trampoline code in a VDSO instead with the
added advantage that one could also host specialised routines there.
One such routine could be gettimeofday where on ARM we have architected
(and some vendor supplied) timers that can be queried entirely in
userspace, obviating the need for an expensive syscall.

This patch converts the sigpage implementation to a VDSO. It is mostly
a direct port from Will Deacon's arm64 implementation with the ARM
signal trampoline plumbed in.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
As can be inferred from this RFC, I am interested ultimately in
implementing a syscall-less gettimeofday for ARM. Whilst researching
possible vectors page or VDSO implementations, I came across the
sigpage mechanism which is very similar to a VDSO.

The very simple function, __kernel_vdso_doubler, resolved in a test
program automatically on my Arndale board (running Fedora 20) without
any additional prodding.

IPC stress tests from LTP were executed to test the signal trampoline.

I would appreciate any comments on this approach of converting the
sigpage to a VDSO. If this looks sane to people, I will work on the
gettimeofday logic in a later patch.

Cheers,
-- 
Steve
---
 arch/arm/include/asm/elf.h               |  11 +++-
 arch/arm/include/asm/mmu.h               |   2 +-
 arch/arm/include/asm/vdso.h              |  44 +++++++++++++
 arch/arm/kernel/Makefile                 |   9 +++
 arch/arm/kernel/process.c                |  48 +++++---------
 arch/arm/kernel/signal.c                 |  38 ++---------
 arch/arm/kernel/vdso.c                   | 105 +++++++++++++++++++++++++++++++
 arch/arm/kernel/vdso/.gitignore          |   2 +
 arch/arm/kernel/vdso/Makefile            |  72 +++++++++++++++++++++
 arch/arm/kernel/vdso/gen_vdso_offsets.sh |  15 +++++
 arch/arm/kernel/vdso/simple.S            |  31 +++++++++
 arch/arm/kernel/vdso/vdso.S              |  35 +++++++++++
 arch/arm/kernel/vdso/vdso.lds.S          |  99 +++++++++++++++++++++++++++++
 13 files changed, 442 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso.h
 create mode 100644 arch/arm/kernel/vdso.c
 create mode 100644 arch/arm/kernel/vdso/.gitignore
 create mode 100644 arch/arm/kernel/vdso/Makefile
 create mode 100755 arch/arm/kernel/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/arm/kernel/vdso/simple.S
 create mode 100644 arch/arm/kernel/vdso/vdso.S
 create mode 100644 arch/arm/kernel/vdso/vdso.lds.S

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index f4b46d3..ee45b67 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -132,6 +132,15 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
 int arch_setup_additional_pages(struct linux_binprm *, int);
-#endif
+
+#define AT_SYSINFO_EHDR			33
+#define __HAVE_ARCH_GATE_AREA		1
+
+#define ARCH_DLINFO							\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (elf_addr_t)current->mm->context.vdso);		\
+} while (0)
+#endif /* CONFIG_MMU */
 
 #endif
diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 64fd151..11bcbf3 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -10,7 +10,7 @@ typedef struct {
 	int		switch_pending;
 #endif
 	unsigned int	vmalloc_seq;
-	unsigned long	sigpage;
+	unsigned long	vdso;
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
new file mode 100644
index 0000000..024b9726
--- /dev/null
+++ b/arch/arm/include/asm/vdso.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Based on Will Deacon's implementation in arch/arm64
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
+#ifndef __ASM_VDSO_H
+#define __ASM_VDSO_H
+
+#ifdef __KERNEL__
+
+/*
+ * Default link address for the vDSO.
+ * Since we randomise the VDSO mapping, there's little point in trying
+ * to prelink this.
+ */
+#define VDSO_LBASE	0x0
+
+#ifndef __ASSEMBLY__
+
+#include <generated/vdso-offsets.h>
+
+#define VDSO_SYMBOL(base, name)						   \
+({									   \
+	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
+})
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a30fc9b..87983ef 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -99,3 +99,12 @@ obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
 extra-y := $(head-y) vmlinux.lds
+
+ifdef CONFIG_MMU
+obj-y				+= vdso.o
+obj-y				+= vdso/
+
+# vDSO - this must be built first to generate the symbol offsets
+$(call objectify,$(obj-y)): $(obj)/vdso/vdso-offsets.h
+$(obj)/vdso/vdso-offsets.h: $(obj)/vdso
+endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15..1aa1cc2 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -467,46 +467,28 @@ int in_gate_area_no_mm(unsigned long addr)
 }
 #define is_gate_vma(vma)	((vma) == &gate_vma)
 #else
-#define is_gate_vma(vma)	0
-#endif
+#define is_gate_vma(vma)	(0)
 
-const char *arch_vma_name(struct vm_area_struct *vma)
+struct vm_area_struct * get_gate_vma(struct mm_struct *mm)
 {
-	return is_gate_vma(vma) ? "[vectors]" :
-		(vma->vm_mm && vma->vm_start == vma->vm_mm->context.sigpage) ?
-		 "[sigpage]" : NULL;
+	return NULL;
 }
 
-static struct page *signal_page;
-extern struct page *get_signal_page(void);
-
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int in_gate_area_no_mm(unsigned long addr)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret;
-
-	if (!signal_page)
-		signal_page = get_signal_page();
-	if (!signal_page)
-		return -ENOMEM;
-
-	down_write(&mm->mmap_sem);
-	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
-	if (IS_ERR_VALUE(addr)) {
-		ret = addr;
-		goto up_fail;
-	}
+	return 0;
+}
+#endif
 
-	ret = install_special_mapping(mm, addr, PAGE_SIZE,
-		VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
-		&signal_page);
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (is_gate_vma(vma))
+		return "[vectors]";
 
-	if (ret == 0)
-		mm->context.sigpage = addr;
+	if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.vdso)
+		return "[vdso]";
 
- up_fail:
-	up_write(&mm->mmap_sem);
-	return ret;
+	return NULL;
 }
+
 #endif
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 04d6388..b510077 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -20,11 +20,10 @@
 #include <asm/ucontext.h>
 #include <asm/unistd.h>
 #include <asm/vfp.h>
+#include <asm/vdso.h>
 
 extern const unsigned long sigreturn_codes[7];
 
-static unsigned long signal_return_offset;
-
 #ifdef CONFIG_CRUNCH
 static int preserve_crunch_context(struct crunch_sigframe __user *frame)
 {
@@ -395,8 +394,9 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 			 * except when the MPU has protected the vectors
 			 * page from PL0
 			 */
-			retcode = mm->context.sigpage + signal_return_offset +
-				  (idx << 2) + thumb;
+			retcode = (unsigned long) VDSO_SYMBOL(mm->context.vdso,
+								sigtramp);
+			retcode += (idx << 2) + thumb;
 		} else
 #endif
 		{
@@ -600,33 +600,3 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 	} while (thread_flags & _TIF_WORK_MASK);
 	return 0;
 }
-
-struct page *get_signal_page(void)
-{
-	unsigned long ptr;
-	unsigned offset;
-	struct page *page;
-	void *addr;
-
-	page = alloc_pages(GFP_KERNEL, 0);
-
-	if (!page)
-		return NULL;
-
-	addr = page_address(page);
-
-	/* Give the signal return code some randomness */
-	offset = 0x200 + (get_random_int() & 0x7fc);
-	signal_return_offset = offset;
-
-	/*
-	 * Copy signal return handlers into the vector page, and
-	 * set sigreturn to be a pointer to these.
-	 */
-	memcpy(addr + offset, sigreturn_codes, sizeof(sigreturn_codes));
-
-	ptr = (unsigned long)addr + offset;
-	flush_icache_range(ptr, ptr + sizeof(sigreturn_codes));
-
-	return page;
-}
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
new file mode 100644
index 0000000..fd69184
--- /dev/null
+++ b/arch/arm/kernel/vdso.c
@@ -0,0 +1,105 @@
+/*
+ * VDSO implementation for ARM
+ *
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Code based on Will Deacon's arm64 VDSO implementation.
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
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/binfmts.h>
+#include <asm/vdso.h>
+
+extern char vdso_start, vdso_end;
+static unsigned long vdso_pages;
+static struct page **vdso_pagelist;
+
+static int __init vdso_init(void)
+{
+	struct page *pg;
+	char *vbase;
+	int i, ret = 0;
+
+	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	pr_info("vdso: %ld pages (%ld code, %ld data) at base %p\n",
+		vdso_pages, vdso_pages, 0L, &vdso_start);
+
+	vdso_pagelist = kzalloc(sizeof(struct page *) * vdso_pages,
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
+unmap:
+	vunmap(vbase);
+	return ret;
+}
+arch_initcall(vdso_init);
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long vdso_base, vdso_mapping_len;
+	int ret;
+
+	vdso_mapping_len = vdso_pages << PAGE_SHIFT;
+
+	down_write(&mm->mmap_sem);
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = vdso_base;
+		goto up_fail;
+	}
+	mm->context.vdso = vdso_base;
+
+	ret = install_special_mapping(mm, vdso_base, vdso_mapping_len,
+		VM_READ | VM_EXEC |
+		VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
+		vdso_pagelist);
+
+	if (ret) {
+		mm->context.vdso = 0;
+		goto up_fail;
+	}
+
+ up_fail:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
diff --git a/arch/arm/kernel/vdso/.gitignore b/arch/arm/kernel/vdso/.gitignore
new file mode 100644
index 0000000..b8cc94e
--- /dev/null
+++ b/arch/arm/kernel/vdso/.gitignore
@@ -0,0 +1,2 @@
+vdso.lds
+vdso-offsets.h
diff --git a/arch/arm/kernel/vdso/Makefile b/arch/arm/kernel/vdso/Makefile
new file mode 100644
index 0000000..13d3531
--- /dev/null
+++ b/arch/arm/kernel/vdso/Makefile
@@ -0,0 +1,72 @@
+#
+# Building a vDSO image for ARM.
+#
+# Based heavily on arm64 implementation by:
+# Author: Will Deacon <will.deacon@arm.com>
+# Heavily based on the vDSO Makefiles for other archs.
+#
+
+obj-vdso := simple.o
+obj-sig  := sigreturn_codes.o
+
+# Build rules
+targets := $(obj-vdso) $(obj-sig) vdso.so vdso.so.dbg
+obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+obj-sig := $(addprefix $(obj)/, $(obj-sig))
+
+ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
+		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+
+obj-y += vdso.o
+extra-y += vdso.lds vdso-offsets.h
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+# Force dependency (incbin is bad)
+$(obj)/vdso.o : $(obj)/vdso.so
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) $(obj-sig)
+	$(call if_changed,vdsold)
+
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Generate VDSO offsets using helper script
+gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+define cmd_vdsosym
+	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@ && \
+	cp $@ include/generated/
+endef
+
+$(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+# We can't move sigreturn_codes.S into our vdso as it contains code
+# which can also be used if we have no mmu. So we re-compile the
+# source from the parent directory, to prevent code duplication.
+$(obj)/sigreturn_codes.o:	$(obj)/../sigreturn_codes.S
+				$(call if_changed_dep,vdsoas)
+
+# Assembly rules for the .S files
+$(obj-vdso): %.o: %.S
+	$(call if_changed_dep,vdsoas)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL $@
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-T $^ -o $@
+quiet_cmd_vdsoas = VDSOA $@
+      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
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
diff --git a/arch/arm/kernel/vdso/gen_vdso_offsets.sh b/arch/arm/kernel/vdso/gen_vdso_offsets.sh
new file mode 100755
index 0000000..5b329ae
--- /dev/null
+++ b/arch/arm/kernel/vdso/gen_vdso_offsets.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+#
+# Match symbols in the DSO that look like VDSO_*; produce a header file
+# of constant offsets into the shared object.
+#
+# Doing this inside the Makefile will break the $(filter-out) function,
+# causing Kbuild to rebuild the vdso-offsets header file every time.
+#
+# Author: Will Deacon <will.deacon@arm.com>
+#
+
+LC_ALL=C
+sed -n -e 's/^00*/0/' -e \
+'s/^\([0-9a-fA-F]*\) . VDSO_\([a-zA-Z0-9_]*\)$/\#define vdso_offset_\2\t0x\1/p'
diff --git a/arch/arm/kernel/vdso/simple.S b/arch/arm/kernel/vdso/simple.S
new file mode 100644
index 0000000..6f21324
--- /dev/null
+++ b/arch/arm/kernel/vdso/simple.S
@@ -0,0 +1,31 @@
+/*
+ * Simple test function for VDSO implementation for ARM
+ *
+ * Copyright (C) 2014 Linaro Ltd.
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
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+/*
+ * An extremely simple test function:
+ * unsigned int __kernel_vdso_doubler(unsigned int arg);
+ */
+	.text
+ENTRY(__kernel_vdso_doubler)
+	lsl r0, r0, #1
+	mov pc, lr
+ENDPROC(__kernel_vdso_doubler)
diff --git a/arch/arm/kernel/vdso/vdso.S b/arch/arm/kernel/vdso/vdso.S
new file mode 100644
index 0000000..a459d42
--- /dev/null
+++ b/arch/arm/kernel/vdso/vdso.S
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Based on arm64 implementation by Will Deacon.
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
index 0000000..1bacbe8
--- /dev/null
+++ b/arch/arm/kernel/vdso/vdso.lds.S
@@ -0,0 +1,99 @@
+/*
+ * GNU linker script for the VDSO library.
+ *
+ * Copyright (C) 2014 Linaro ltd.
+ * Based heavily on work by:
+ * Will Deacon <will.deacon@arm.com>
+ * Copyright (C) 2012 ARM Limited
+ * Heavily based on the vDSO linker scripts for other archs.
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
+	.text		: { *(.text*) }			:text
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
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+	LINUX_2.6.39 {
+	global:
+		__kernel_vdso_doubler;
+	local: *;
+	};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_sigtramp		= sigreturn_codes;
-- 
1.8.1.4
