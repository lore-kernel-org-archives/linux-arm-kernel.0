From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun,  3 Apr 2016 09:23:53 +0200
Subject: [PATCH 1/2] ARM: PIE infrastructure
In-Reply-To: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1459668234-16033-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for embedding position independent executables (PIE) in the
kernel. Those PIEs can then be loaded into memory allocated using genalloc.
For example, this allows running code from SRAM which is usually needed for
suspend/resume or to change the DDR timings. That code is usually written
in assembly and can now be developed in C.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/Kconfig          |   2 +
 arch/arm/Makefile         |   1 +
 arch/arm/pie/Kconfig      |   8 +++
 arch/arm/pie/Makefile     |   1 +
 arch/arm/pie/Makefile.pie |  70 ++++++++++++++++++++
 arch/arm/pie/lib/empty.c  |  15 +++++
 arch/arm/pie/pie.c        |  97 ++++++++++++++++++++++++++++
 arch/arm/pie/pie.lds.S    |  40 ++++++++++++
 include/linux/pie.h       | 159 ++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 393 insertions(+)
 create mode 100644 arch/arm/pie/Kconfig
 create mode 100644 arch/arm/pie/Makefile
 create mode 100644 arch/arm/pie/Makefile.pie
 create mode 100644 arch/arm/pie/lib/empty.c
 create mode 100644 arch/arm/pie/pie.c
 create mode 100644 arch/arm/pie/pie.lds.S
 create mode 100644 include/linux/pie.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2b7626..e671ade2d86a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2148,3 +2148,5 @@ endif
 source "lib/Kconfig"
 
 source "arch/arm/kvm/Kconfig"
+
+source "arch/arm/pie/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8c3ce2ac44c4..c39e6aef6ff7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -281,6 +281,7 @@ core-$(CONFIG_VFP)		+= arch/arm/vfp/
 core-$(CONFIG_XEN)		+= arch/arm/xen/
 core-$(CONFIG_KVM_ARM_HOST) 	+= arch/arm/kvm/
 core-$(CONFIG_VDSO)		+= arch/arm/vdso/
+core-$(CONFIG_PIE)		+= arch/arm/pie/
 
 # If we have a machine-specific directory, then include it in the build.
 core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
diff --git a/arch/arm/pie/Kconfig b/arch/arm/pie/Kconfig
new file mode 100644
index 000000000000..d76122140561
--- /dev/null
+++ b/arch/arm/pie/Kconfig
@@ -0,0 +1,8 @@
+config PIE
+	bool
+	help
+	  This option adds support for embedding position indepentant (PIE)
+	  executables into the kernel. The PIEs can then be copied into
+	  genalloc regions such as SRAM and executed. Some platforms require
+	  this for suspend/resume support.
+
diff --git a/arch/arm/pie/Makefile b/arch/arm/pie/Makefile
new file mode 100644
index 000000000000..d1a6a823e431
--- /dev/null
+++ b/arch/arm/pie/Makefile
@@ -0,0 +1 @@
+obj-y += pie.o
diff --git a/arch/arm/pie/Makefile.pie b/arch/arm/pie/Makefile.pie
new file mode 100644
index 000000000000..709a51be1578
--- /dev/null
+++ b/arch/arm/pie/Makefile.pie
@@ -0,0 +1,70 @@
+obj-y		:= pie.bin.elf
+
+# Report unresolved symbol references
+ldflags-y	+= --no-undefined
+# Delete all temporary local symbols
+ldflags-y	+= -X
+
+# Reset objcopy flags
+OBJCOPYFLAGS	=
+
+$(obj)/empty.o: arch/arm/pie/lib/empty.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+# Reference gcc builtins for use in PIE with __pie_
+$(obj)/pie_rename.syms: $(obj)/empty.o
+	@$(NM) $^ | awk '{if ($$3) print $$3,"__pie_"$$3}' > $@
+
+# For embedding address of the symbols copied from the PIE into the kernel
+$(obj)/pie.syms: $(obj)/pie.elf
+	@$(NM) $^ | awk '{if ($$3 && $$2 == toupper($$2)) print $$3,"=","0x"$$1";"}' > $@
+
+# Collect together the libpie objects
+LDFLAGS_libpie_stage1.o += -r
+
+$(obj)/libpie_stage1.o: $(obj)/empty.o
+	$(call if_changed,ld)
+
+# Rename the libpie gcc builtins with a __pie_ prefix
+OBJCOPYFLAGS_libpie_stage2.o += --redefine-syms=$(obj)/pie_rename.syms
+
+$(obj)/libpie_stage2.o: $(obj)/libpie_stage1.o
+	$(call if_changed,objcopy)
+
+CFLAGS_$(PIE_NAME).o += -fPIE
+
+OBJCOPYFLAGS_pie_stage1.o += --redefine-syms=$(obj)/pie_rename.syms
+$(obj)/pie_stage1.o: $(obj)/$(PIE_NAME).o $(obj)/pie_rename.syms
+	$(call if_changed,objcopy)
+
+LDFLAGS_pie_stage2.o += -r
+
+$(obj)/pie_stage2.o: $(obj)/pie_stage1.o $(obj)/libpie_stage2.o
+	$(call if_changed,ld)
+
+SEDFLAGS_lds	= s/PIE_NAME/$(PIE_NAME)/
+$(obj)/pie.lds.S: arch/arm/pie/pie.lds.S
+	@sed "$(SEDFLAGS_lds)" < $< > $@
+
+# Create the position independent executable
+LDFLAGS_pie.elf += -Bstatic -T $(obj)/pie.lds
+
+$(obj)/pie.elf: $(obj)/pie_stage2.o $(obj)/pie.lds
+	$(call if_changed,ld)
+
+# Create binary data for the kernel
+OBJCOPYFLAGS_pie.bin += -O binary
+
+$(obj)/pie.bin: $(obj)/pie.elf $(obj)/pie.syms
+	$(call if_changed,objcopy)
+
+# Import the data into the kernel
+OBJCOPYFLAGS_pie.bin.o += -B $(ARCH) -I binary -O elf32-littlearm
+
+$(obj)/pie.bin.o: $(obj)/pie.bin
+	$(call if_changed,objcopy)
+
+LDFLAGS_pie.bin.elf += --just-symbols=$(obj)/pie.syms -r
+$(obj)/pie.bin.elf: $(obj)/pie.bin.o $(obj)/pie_stage2.o
+	$(call if_changed,ld)
+
diff --git a/arch/arm/pie/lib/empty.c b/arch/arm/pie/lib/empty.c
new file mode 100644
index 000000000000..9a6d54956379
--- /dev/null
+++ b/arch/arm/pie/lib/empty.c
@@ -0,0 +1,15 @@
+void __div0(void)
+{
+};
+
+void __aeabi_unwind_cpp_pr0(void)
+{
+};
+
+void __aeabi_unwind_cpp_pr1(void)
+{
+};
+
+void __aeabi_unwind_cpp_pr2(void)
+{
+};
diff --git a/arch/arm/pie/pie.c b/arch/arm/pie/pie.c
new file mode 100644
index 000000000000..62406a54459f
--- /dev/null
+++ b/arch/arm/pie/pie.c
@@ -0,0 +1,97 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/genalloc.h>
+#include <linux/pie.h>
+#include <asm/cacheflush.h>
+
+struct pie_chunk {
+	struct gen_pool *pool;
+	unsigned long addr;
+	size_t sz;
+};
+
+struct pie_chunk *__pie_load_data(struct gen_pool *pool, void *code_start,
+				  void *code_end, bool phys)
+{
+	struct pie_chunk *chunk;
+	unsigned long offset;
+	int ret;
+	size_t code_sz;
+	unsigned long base;
+	phys_addr_t pbase;
+
+	chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+	if (!chunk) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	code_sz = code_end - code_start;
+	chunk->pool = pool;
+	chunk->sz = code_sz;
+
+	base = gen_pool_alloc(pool, chunk->sz);
+	if (!base) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	pbase = gen_pool_virt_to_phys(pool, base);
+	chunk->addr = (unsigned long)__arm_ioremap_exec(pbase, code_sz, false);
+	if (!chunk->addr) {
+		ret = -ENOMEM;
+		goto err_remap;
+	}
+
+	/* Copy chunk specific code/data */
+	fncpy((char *)chunk->addr, code_start, code_sz);
+
+	/* Calculate initial offset */
+	if (phys)
+		offset = gen_pool_virt_to_phys(pool, chunk->addr);
+	else
+		offset = chunk->addr;
+
+	return chunk;
+
+err_remap:
+	gen_pool_free(chunk->pool, chunk->addr, chunk->sz);
+
+err_free:
+	kfree(chunk);
+err:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(__pie_load_data);
+
+phys_addr_t pie_to_phys(struct pie_chunk *chunk, unsigned long addr)
+{
+	return gen_pool_virt_to_phys(chunk->pool, addr);
+}
+EXPORT_SYMBOL_GPL(pie_to_phys);
+
+void __iomem *__kern_to_pie(struct pie_chunk *chunk, void *ptr)
+{
+	uintptr_t offset = (uintptr_t)ptr;
+
+	if (offset >= chunk->sz)
+		return NULL;
+	else
+		return (void *)(chunk->addr + offset);
+}
+EXPORT_SYMBOL_GPL(__kern_to_pie);
+
+void pie_free(struct pie_chunk *chunk)
+{
+	gen_pool_free(chunk->pool, chunk->addr, chunk->sz);
+	kfree(chunk);
+}
+EXPORT_SYMBOL_GPL(pie_free);
diff --git a/arch/arm/pie/pie.lds.S b/arch/arm/pie/pie.lds.S
new file mode 100644
index 000000000000..f84391260f64
--- /dev/null
+++ b/arch/arm/pie/pie.lds.S
@@ -0,0 +1,40 @@
+OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+
+#include <linux/export.h>
+
+SECTIONS
+{
+	/* Don't need unwind tables */
+	/DISCARD/ : {
+		*(.ARM.exidx*)
+		*(.ARM.extab*)
+		*(.comment)
+	}
+
+	. = 0x0;
+
+	____pie_PIE_NAME_start : {
+		VMLINUX_SYMBOL(__pie_PIE_NAME_start) = .;
+	}
+
+	.text : {
+		. = ALIGN(4);
+		KEEP(*(.text))
+	}
+
+	.rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) }
+	. = ALIGN(4);
+
+	.data : {
+		*(SORT_BY_ALIGNMENT(.data*))
+		. = ALIGN(4);
+
+		*(SORT_BY_ALIGNMENT(.bss*))
+		. = ALIGN(4);
+	}
+
+	____pie_PIE_NAME_end : {
+		VMLINUX_SYMBOL(__pie_PIE_NAME_end) = .;
+	}
+}
diff --git a/include/linux/pie.h b/include/linux/pie.h
new file mode 100644
index 000000000000..1e6f0fabd08f
--- /dev/null
+++ b/include/linux/pie.h
@@ -0,0 +1,159 @@
+/*
+ * Copyright 2013 Texas Instruments, Inc.
+ *      Russ Dill <russ.dill@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_PIE_H
+#define _LINUX_PIE_H
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+
+#include <asm/fncpy.h>
+#include <linux/bug.h>
+
+struct gen_pool;
+struct pie_chunk;
+
+#ifdef CONFIG_PIE
+
+/**
+ * __pie_load_data - load and fixup PIE code from kernel data
+ * @pool:	pool to allocate memory from and copy code into
+ * @start:	virtual start address in kernel of chunk specific code
+ * @end:	virtual end address in kernel of chunk specific code
+ * @phys:	%true to fixup to physical address of destination, %false to
+ *		fixup to virtual address of destination
+ *
+ * Returns 0 on success, -EERROR otherwise
+ */
+struct pie_chunk *__pie_load_data(struct gen_pool *pool,
+				  void *start, void *end, bool phys);
+
+/**
+ * pie_to_phys - translate a virtual PIE address into a physical one
+ * @chunk:	identifier returned by pie_load_sections
+ * @addr:	virtual address within pie chunk
+ *
+ * Returns physical address on success, -1 otherwise
+ */
+phys_addr_t pie_to_phys(struct pie_chunk *chunk, unsigned long addr);
+
+void __iomem *__kern_to_pie(struct pie_chunk *chunk, void *ptr);
+
+/**
+ * pie_free - free the pool space used by an pie chunk
+ * @chunk:	identifier returned by pie_load_sections
+ */
+void pie_free(struct pie_chunk *chunk);
+
+#define __pie_load_sections(pool, name, folder, phys) ({		\
+	extern char _binary_##folder##_pie_bin_start[];			\
+	extern char __pie_##name##_start[];				\
+	extern char __pie_##name##_end[];				\
+	char *start = _binary_##folder##_pie_bin_start + (unsigned long)__pie_##name##_start; \
+	char *end = _binary_##folder##_pie_bin_start + (unsigned long)__pie_##name##_end; \
+									\
+	__pie_load_data(pool, start, end, phys);			\
+})
+
+/*
+ * Required for any symbol within an PIE section that is referenced by the
+ * kernel
+ */
+#define EXPORT_PIE_SYMBOL(sym)		extern typeof(sym) sym __weak
+
+#else
+
+static inline struct pie_chunk *__pie_load_data(struct gen_pool *pool,
+						void *start, void *end,
+						bool phys)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline phys_addr_t pie_to_phys(struct pie_chunk *chunk,
+				      unsigned long addr)
+{
+	return -1;
+}
+
+static inline void __iomem *__kern_to_pie(struct pie_chunk *chunk, void *ptr)
+{
+	return NULL;
+}
+
+static inline void pie_free(struct pie_chunk *chunk)
+{
+}
+
+#define __pie_load_sections(pool, name, folder, phys) ({ ERR_PTR(-EINVAL); })
+
+#endif
+
+/**
+ * pie_load_sections - load and fixup sections associated with the given name
+ * @pool:	pool to allocate memory from and copy code into
+ *		fixup to virtual address of destination
+ * @name:	the name given to __pie() and __pie_data() when marking
+ *		data and code
+ *
+ * Returns 0 on success, -EERROR otherwise
+ */
+#define pie_load_sections(pool, name, folder) ({			\
+	__pie_load_sections(pool, name, folder, false);			\
+})
+
+/**
+ * pie_load_sections_phys - load and fixup sections associated with the given
+ * name for execution with the MMU off
+ *
+ * @pool:	pool to allocate memory from and copy code into
+ *		fixup to virtual address of destination
+ * @name:	the name given to __pie() and __pie_data() when marking
+ *		data and code
+ *
+ * Returns 0 on success, -EERROR otherwise
+ */
+#define pie_load_sections_phys(pool, name, folder) ({			\
+	__pie_load_sections(pool, name, folder, true);			\
+})
+
+/**
+ * kern_to_pie - convert a kernel symbol to the virtual address of where
+ * that symbol is loaded into the given PIE chunk.
+ *
+ * @chunk:	identifier returned by pie_load_sections
+ * @p:		symbol to convert
+ *
+ * Return type is the same as type passed
+ */
+#define kern_to_pie(chunk, p) ({					\
+	void *__ptr = (void *)(p);					\
+	typeof(p) __result = (typeof(p))__kern_to_pie(chunk, __ptr);	\
+	__result;							\
+})
+
+/**
+ * kern_to_fn - convert a kernel function symbol to the virtual address of where
+ * that symbol is loaded into the given PIE chunk
+ *
+ * @chunk:	identifier returned by pie_load_sections
+ * @funcp:	function to convert
+ *
+ * Return type is the same as type passed
+ */
+#define fn_to_pie(chunk, funcp) ({					\
+	uintptr_t __kern_addr, __pie_addr;				\
+									\
+	__kern_addr = (uintptr_t)funcp;					\
+	__pie_addr = kern_to_pie(chunk, __kern_addr);			\
+									\
+	(typeof(&funcp))(__pie_addr);					\
+})
+
+#endif
-- 
2.8.0.rc3
