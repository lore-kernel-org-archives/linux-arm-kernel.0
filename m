From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed, 30 Jun 2010 13:09:12 +0300
Subject: [PATCH 4/4] crash: add ARM crashdump support
In-Reply-To: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <fb49a2f47cad6fa573119ab5b173b257dbaf6dd9.1277891104.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds minimal support for reading ARM crashdumps (currently only
diskdump format is supported). It contains necessary virtual to physical
translations and stack unwinding support.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 Makefile     |   12 +-
 arm.c        | 1188 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 defs.h       |  131 +++++++
 unwind_arm.c |  702 ++++++++++++++++++++++++++++++++++
 4 files changed, 2031 insertions(+), 2 deletions(-)
 create mode 100644 arm.c
 create mode 100644 unwind_arm.c

diff --git a/Makefile b/Makefile
index 3ea6539..61d88c0 100644
--- a/Makefile
+++ b/Makefile
@@ -74,11 +74,12 @@ UNWIND_HFILES=unwind.h unwind_i.h rse.h unwind_x86.h unwind_x86_64.h
 CFILES=main.c tools.c global_data.c memory.c filesys.c help.c task.c \
 	kernel.c test.c gdb_interface.c configure.c net.c dev.c \
 	alpha.c x86.c ppc.c ia64.c s390.c s390x.c s390dbf.c ppc64.c x86_64.c \
+	arm.c \
 	extensions.c remote.c va_server.c va_server_v1.c symbols.c cmdline.c \
 	lkcd_common.c lkcd_v1.c lkcd_v2_v3.c lkcd_v5.c lkcd_v7.c lkcd_v8.c\
 	lkcd_fix_mem.c s390_dump.c lkcd_x86_trace.c \
 	netdump.c diskdump.c xendump.c unwind.c unwind_decoder.c \
-	unwind_x86_32_64.c \
+	unwind_x86_32_64.c unwind_arm.c \
  	xen_hyper.c xen_hyper_command.c xen_hyper_global_data.c \
 	xen_hyper_dump_tables.c kvmdump.c qemu.c qemu-load.c
 
@@ -90,11 +91,12 @@ SOURCE_FILES=${CFILES} ${GENERIC_HFILES} ${MCORE_HFILES} \
 OBJECT_FILES=main.o tools.o global_data.o memory.o filesys.o help.o task.o \
 	build_data.o kernel.o test.o gdb_interface.o net.o dev.o \
 	alpha.o x86.o ppc.o ia64.o s390.o s390x.o s390dbf.o ppc64.o x86_64.o \
+	arm.o \
 	extensions.o remote.o va_server.o va_server_v1.o symbols.o cmdline.o \
 	lkcd_common.o lkcd_v1.o lkcd_v2_v3.o lkcd_v5.o lkcd_v7.o lkcd_v8.o \
 	lkcd_fix_mem.o s390_dump.o netdump.o diskdump.o xendump.o \
 	lkcd_x86_trace.o unwind_v1.o unwind_v2.o unwind_v3.o \
-	unwind_x86_32_64.o \
+	unwind_x86_32_64.o unwind_arm.o \
  	xen_hyper.o xen_hyper_command.o xen_hyper_global_data.o \
 	xen_hyper_dump_tables.o kvmdump.o qemu.o qemu-load.o
 
@@ -407,6 +409,9 @@ ppc64.o: ${GENERIC_HFILES} ppc64.c
 x86_64.o: ${GENERIC_HFILES} ${REDHAT_HFILES} x86_64.c
 	cc -c ${CRASH_CFLAGS} x86_64.c ${WARNING_OPTIONS} ${WARNING_ERROR}
 
+arm.o: ${GENERIC_HFILES} ${REDHAT_HFILES} arm.c
+	cc -c ${CRASH_CFLAGS} arm.c ${WARNING_OPTIONS} ${WARNING_ERROR}
+
 s390.o: ${GENERIC_HFILES} ${IBM_HFILES} s390.c
 	cc -c ${CRASH_CFLAGS} s390.c ${WARNING_OPTIONS} ${WARNING_ERROR}
 
@@ -448,6 +453,9 @@ lkcd_x86_trace.o: ${GENERIC_HFILES} ${LKCD_TRACE_HFILES} lkcd_x86_trace.c
 unwind_x86_32_64.o: ${GENERIC_HFILES} ${UNWIND_HFILES} unwind_x86_32_64.c
 	cc -c ${CRASH_CFLAGS} unwind_x86_32_64.c -o unwind_x86_32_64.o ${WARNING_OPTIONS} ${WARNING_ERROR}
 
+unwind_arm.o: ${GENERIC_HFILES} ${UNWIND_HFILES} unwind_arm.c
+	cc -c ${CRASH_CFLAGS} unwind_arm.c -o unwind_arm.o ${WARNING_OPTIONS} ${WARNING_ERROR}
+
 unwind_v1.o: ${GENERIC_HFILES} ${UNWIND_HFILES} unwind.c unwind_decoder.c
 	cc -c ${CRASH_CFLAGS} unwind.c -DREDHAT -DUNWIND_V1 -o unwind_v1.o ${WARNING_OPTIONS} ${WARNING_ERROR}
 
diff --git a/arm.c b/arm.c
new file mode 100644
index 0000000..40c860a
--- /dev/null
+++ b/arm.c
@@ -0,0 +1,1188 @@
+/*
+ * arm.c - core analysis suite
+ *
+ * Created by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifdef ARM
+#include <elf.h>
+
+#include "defs.h"
+
+static int arm_get_crash_notes(void);
+static int arm_verify_symbol(const char *, ulong, char);
+static int arm_is_module_addr(ulong);
+static int arm_is_kvaddr(ulong);
+static int arm_in_exception_text(ulong);
+static void arm_back_trace_cmd(struct bt_info *);
+static ulong arm_processor_speed(void);
+static int arm_translate_pte(ulong, void *, ulonglong);
+static int arm_vtop(ulong, ulong *, physaddr_t *, int);
+static int arm_kvtop(struct task_context *, ulong, physaddr_t *, int);
+static int arm_uvtop(struct task_context *, ulong, physaddr_t *, int);
+static int arm_get_frame(struct bt_info *, ulong *, ulong *);
+static int arm_get_dumpfile_stack_frame(struct bt_info *, ulong *, ulong *);
+static void arm_get_stack_frame(struct bt_info *, ulong *, ulong *);
+static void arm_dump_exception_stack(ulong, ulong);
+static ulong arm_vmalloc_start(void);
+static int arm_is_task_addr(ulong);
+static int arm_dis_filter(ulong, char *);
+static int arm_eframe_search(struct bt_info *);
+static ulong arm_get_task_pgd(ulong);
+static void arm_cmd_mach(void);
+static void arm_display_machine_stats(void);
+static int arm_get_smp_cpus(void);
+static void arm_init_machspec(void);
+
+static struct line_number_hook arm_line_number_hooks[];
+static struct machine_specific arm_machine_specific;
+
+/**
+ * struct arm_cpu_context_save - idle task registers
+ *
+ * This structure holds idle task registers. Only FP, SP, and PC are needed for
+ * unwinding the stack.
+ */
+struct arm_cpu_context_save {
+	ulong	fp;
+	ulong	sp;
+	ulong	pc;
+};
+
+/*
+ * Holds registers during the crash.
+ */
+static struct arm_pt_regs panic_task_regs;
+
+#define PGDIR_SIZE() (4 * PAGESIZE())
+#define PGDIR_OFFSET(X) (((ulong)(X)) & (PGDIR_SIZE() - 1))
+
+#define _SECTION_PAGE_MASK	(~((MEGABYTES(1))-1))
+
+#define PMD_TYPE_MASK   3
+#define PMD_TYPE_SECT   2
+#define PMD_TYPE_TABLE  1
+
+static inline ulong *
+pmd_page_addr(ulong pmd)
+{
+	ulong ptr;
+
+	ptr = pmd & ~(PTRS_PER_PTE * sizeof(void *) - 1);
+	ptr += PTRS_PER_PTE * sizeof(void *);
+
+	return (ulong *)ptr;
+}
+
+/*
+ * "Linux" PTE definitions.
+ */
+#define L_PTE_PRESENT		(1 << 0)
+#define L_PTE_YOUNG		(1 << 1)
+#define L_PTE_FILE		(1 << 2)
+#define L_PTE_DIRTY		(1 << 6)
+#define L_PTE_WRITE		(1 << 7)
+#define L_PTE_USER		(1 << 8)
+#define L_PTE_EXEC		(1 << 9)
+#define L_PTE_SHARED		(1 << 10)
+
+#define pte_val(pte)		(pte)
+
+#define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
+#define pte_write(pte)		(pte_val(pte) & L_PTE_WRITE)
+#define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
+#define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
+
+/*
+ * Following stuff is taken directly from the kernel sources. These are used in
+ * dump_exception_stack() to format an exception stack entry.
+ */
+#define USR26_MODE	0x00000000
+#define FIQ26_MODE	0x00000001
+#define IRQ26_MODE	0x00000002
+#define SVC26_MODE	0x00000003
+#define USR_MODE	0x00000010
+#define FIQ_MODE	0x00000011
+#define IRQ_MODE	0x00000012
+#define SVC_MODE	0x00000013
+#define ABT_MODE	0x00000017
+#define UND_MODE	0x0000001b
+#define SYSTEM_MODE	0x0000001f
+#define MODE32_BIT	0x00000010
+#define MODE_MASK	0x0000001f
+#define PSR_T_BIT	0x00000020
+#define PSR_F_BIT	0x00000040
+#define PSR_I_BIT	0x00000080
+#define PSR_A_BIT	0x00000100
+#define PSR_E_BIT	0x00000200
+#define PSR_J_BIT	0x01000000
+#define PSR_Q_BIT	0x08000000
+#define PSR_V_BIT	0x10000000
+#define PSR_C_BIT	0x20000000
+#define PSR_Z_BIT	0x40000000
+#define PSR_N_BIT	0x80000000
+
+#define isa_mode(regs) \
+	((((regs)->ARM_cpsr & PSR_J_BIT) >> 23) | \
+	 (((regs)->ARM_cpsr & PSR_T_BIT) >> 5))
+
+#define processor_mode(regs) \
+	((regs)->ARM_cpsr & MODE_MASK)
+
+#define interrupts_enabled(regs) \
+	(!((regs)->ARM_cpsr & PSR_I_BIT))
+
+#define fast_interrupts_enabled(regs) \
+	(!((regs)->ARM_cpsr & PSR_F_BIT))
+
+static const char *processor_modes[] = {
+	"USER_26", "FIQ_26", "IRQ_26", "SVC_26", "UK4_26", "UK5_26",
+	"UK6_26", "UK7_26" , "UK8_26", "UK9_26", "UK10_26", "UK11_26",
+	"UK12_26", "UK13_26", "UK14_26", "UK15_26", "USER_32", "FIQ_32",
+	"IRQ_32", "SVC_32", "UK4_32", "UK5_32", "UK6_32", "ABT_32",
+	"UK8_32", "UK9_32", "UK10_32", "UND_32", "UK12_32", "UK13_32",
+	"UK14_32", "SYS_32",
+};
+
+static const char *isa_modes[] = {
+	"ARM" , "Thumb" , "Jazelle", "ThumbEE",
+};
+
+#define NOT_IMPLEMENTED() \
+	error(FATAL, "%s: N/A\n", __func__)
+
+/*
+ * Do all necessary machine-specific setup here. This is called several times
+ * during initialization.
+ */
+void
+arm_init(int when)
+{
+	switch (when) {
+	case PRE_SYMTAB:
+		machdep->verify_symbol = arm_verify_symbol;
+		machdep->machspec = &arm_machine_specific;
+		if (pc->flags & KERNEL_DEBUG_QUERY)
+			return;
+		machdep->pagesize = memory_page_size();
+		machdep->pageshift = ffs(machdep->pagesize) - 1;
+		machdep->pageoffset = machdep->pagesize - 1;
+		machdep->pagemask = ~((ulonglong)machdep->pageoffset);
+		machdep->stacksize = machdep->pagesize * 2;
+		machdep->last_pgd_read = 0;
+		machdep->last_pmd_read = 0;
+		machdep->last_ptbl_read = 0;
+		machdep->verify_paddr = generic_verify_paddr;
+		machdep->ptrs_per_pgd = PTRS_PER_PGD;
+		break;
+
+	case PRE_GDB:
+		if ((machdep->pgd = (char *)malloc(PGDIR_SIZE())) == NULL)
+			error(FATAL, "cannot malloc pgd space.");
+		if ((machdep->ptbl = (char *)malloc(PAGESIZE())) == NULL)
+			error(FATAL, "cannot malloc ptbl space.");
+
+		/*
+		 * Kernel text starts 16k after PAGE_OFFSET.
+		 */
+	        machdep->kvbase = symbol_value("_stext") & 0xffff0000UL;
+		machdep->identity_map_base = machdep->kvbase;
+		machdep->is_kvaddr = arm_is_kvaddr;
+		machdep->is_uvaddr = generic_is_uvaddr;
+		machdep->eframe_search = arm_eframe_search;
+		machdep->back_trace = arm_back_trace_cmd;
+		machdep->processor_speed = arm_processor_speed;
+		machdep->uvtop = arm_uvtop;
+		machdep->kvtop = arm_kvtop;
+		machdep->get_task_pgd = arm_get_task_pgd;
+		machdep->get_stack_frame = arm_get_stack_frame;
+		machdep->get_stackbase = generic_get_stackbase;
+		machdep->get_stacktop = generic_get_stacktop;
+		machdep->translate_pte = arm_translate_pte;
+		machdep->memory_size = generic_memory_size;
+		machdep->vmalloc_start = arm_vmalloc_start;
+		machdep->is_task_addr = arm_is_task_addr;
+		machdep->dis_filter = arm_dis_filter;
+		machdep->cmd_mach = arm_cmd_mach;
+		machdep->get_smp_cpus = arm_get_smp_cpus;
+		machdep->line_number_hooks = arm_line_number_hooks;
+		machdep->value_to_symbol = generic_machdep_value_to_symbol;
+		machdep->init_kernel_pgd = NULL;
+
+		if (symbol_exists("irq_desc"))
+			machdep->dump_irq = generic_dump_irq;
+
+		arm_init_machspec();
+		break;
+
+	case POST_GDB:
+		if (symbol_exists("irq_desc"))
+			ARRAY_LENGTH_INIT(machdep->nr_irqs, irq_desc,
+					  "irq_desc", NULL, 0);
+		/*
+		 * Registers for idle threads are saved in
+		 * thread_info.cpu_context.
+		 */
+		STRUCT_SIZE_INIT(cpu_context_save, "cpu_context_save");
+		MEMBER_OFFSET_INIT(cpu_context_save_fp,
+			"cpu_context_save", "fp");
+		MEMBER_OFFSET_INIT(cpu_context_save_sp,
+			"cpu_context_save", "sp");
+		MEMBER_OFFSET_INIT(cpu_context_save_pc,
+			"cpu_context_save", "pc");
+		MEMBER_OFFSET_INIT(thread_info_cpu_context,
+			"thread_info", "cpu_context");
+
+		/*
+		 * We need to have information about note_buf_t which is used to
+		 * hold ELF note containing registers and status of the thread
+		 * that panic'd.
+		 */
+		STRUCT_SIZE_INIT(note_buf, "note_buf_t");
+
+		STRUCT_SIZE_INIT(elf_prstatus, "elf_prstatus");
+		MEMBER_OFFSET_INIT(elf_prstatus_pr_pid, "elf_prstatus",
+				   "pr_pid");
+		MEMBER_OFFSET_INIT(elf_prstatus_pr_reg, "elf_prstatus",
+				   "pr_reg");
+
+		/*
+		 * crash_notes contains machine specific information about the
+		 * crash. In particular, it contains CPU registers at the time
+		 * of the crash. We need this information to extract correct
+		 * backtraces from the panic task.
+		 */
+		if (!arm_get_crash_notes())
+			error(WARNING, "Couldn't retrieve crash_notes\n");
+		break;
+
+	case POST_VM:
+		machdep->machspec->vmalloc_start_addr = vt->high_memory;
+		/*
+		 * Modules are placed in first vmalloc'd area. This is 16MB
+		 * below PAGE_OFFSET.
+		 */
+		machdep->machspec->modules_vaddr = first_vmalloc_address();
+		machdep->machspec->modules_end = machdep->kvbase - 1;
+
+		if (!init_unwind_tables()) {
+			error(WARNING, "Couldn't initialize unwind tables.\n"
+			      "This means that stack unwinding is not\n"
+			      "available for this core file.\n");
+		}
+		break;
+	}
+}
+
+void
+arm_dump_machdep_table(ulong arg)
+{
+	const struct machine_specific *ms;
+	int others, i;
+
+        others = 0;
+        fprintf(fp, "              flags: %lx (", machdep->flags);
+	if (machdep->flags & KSYMS_START)
+		fprintf(fp, "%sKSYMS_START", others++ ? "|" : "");
+        fprintf(fp, ")\n");
+
+	fprintf(fp, "             kvbase: %lx\n", machdep->kvbase);
+	fprintf(fp, "  identity_map_base: %lx\n", machdep->kvbase);
+	fprintf(fp, "           pagesize: %d\n", machdep->pagesize);
+	fprintf(fp, "          pageshift: %d\n", machdep->pageshift);
+	fprintf(fp, "           pagemask: %lx\n", (ulong)machdep->pagemask);
+	fprintf(fp, "         pageoffset: %lx\n", machdep->pageoffset);
+	fprintf(fp, "          stacksize: %ld\n", machdep->stacksize);
+	fprintf(fp, "                 hz: %d\n", machdep->hz);
+	fprintf(fp, "                mhz: %ld\n", machdep->mhz);
+	fprintf(fp, "            memsize: %lld (0x%llx)\n",
+		machdep->memsize, machdep->memsize);
+	fprintf(fp, "               bits: %d\n", machdep->bits);
+	fprintf(fp, "            nr_irqs: %d\n", machdep->nr_irqs);
+	fprintf(fp, "      eframe_search: arm_eframe_search()\n");
+	fprintf(fp, "         back_trace: arm_back_trace_cmd()\n");
+	fprintf(fp, "    processor_speed: arm_processor_speed()\n");
+	fprintf(fp, "              uvtop: arm_uvtop()\n");
+	fprintf(fp, "              kvtop: arm_kvtop()\n");
+	fprintf(fp, "       get_task_pgd: arm_get_task_pgd()\n");
+	fprintf(fp, "           dump_irq: generic_dump_irq()\n");
+	fprintf(fp, "    get_stack_frame: arm_get_stack_frame()\n");
+	fprintf(fp, "      get_stackbase: generic_get_stackbase()\n");
+	fprintf(fp, "       get_stacktop: generic_get_stacktop()\n");
+	fprintf(fp, "      translate_pte: arm_translate_pte()\n");
+	fprintf(fp, "        memory_size: generic_memory_size()\n");
+	fprintf(fp, "      vmalloc_start: arm_vmalloc_start()\n");
+	fprintf(fp, "       is_task_addr: arm_is_task_addr()\n");
+	fprintf(fp, "      verify_symbol: arm_verify_symbol()\n");
+	fprintf(fp, "         dis_filter: arm_dis_filter()\n");
+	fprintf(fp, "           cmd_mach: arm_cmd_mach()\n");
+	fprintf(fp, "       get_smp_cpus: arm_get_smp_cpus()\n");
+	fprintf(fp, "          is_kvaddr: generic_is_kvaddr()\n");
+	fprintf(fp, "          is_uvaddr: generic_is_uvaddr()\n");
+	fprintf(fp, "       verify_paddr: generic_verify_paddr()\n");
+	fprintf(fp, " xendump_p2m_create: NULL\n");
+	fprintf(fp, "xen_kdump_p2m_create: NULL\n");
+	fprintf(fp, "  line_number_hooks: arm_line_number_hooks\n");
+	fprintf(fp, "      last_pgd_read: %lx\n", machdep->last_pgd_read);
+	fprintf(fp, "      last_pmd_read: %lx\n", machdep->last_pmd_read);
+	fprintf(fp, "     last_ptbl_read: %lx\n", machdep->last_ptbl_read);
+	fprintf(fp, "clear_machdep_cache: NULL\n");
+	fprintf(fp, "                pgd: %lx\n", (ulong)machdep->pgd);
+	fprintf(fp, "                pmd: %lx\n", (ulong)machdep->pmd);
+	fprintf(fp, "               ptbl: %lx\n", (ulong)machdep->ptbl);
+	fprintf(fp, "       ptrs_per_pgd: %d\n", machdep->ptrs_per_pgd);
+	fprintf(fp, "  section_size_bits: %ld\n", machdep->section_size_bits);
+	fprintf(fp, "   max_physmem_bits: %ld\n", machdep->max_physmem_bits);
+	fprintf(fp, "  sections_per_root: %ld\n", machdep->sections_per_root);
+
+	for (i = 0; i < MAX_MACHDEP_ARGS; i++) {
+		fprintf(fp, "    cmdline_args[%d]: %s\n",
+			i, machdep->cmdline_args[i] ?
+			machdep->cmdline_args[i] : "(unused)");
+	}
+
+	ms = machdep->machspec;
+
+	fprintf(fp, "           machspec: %lx\n", (ulong)ms);
+	fprintf(fp, "          phys_base: %lx\n", ms->phys_base);
+	fprintf(fp, " vmalloc_start_addr: %lx\n", ms->vmalloc_start_addr);
+	fprintf(fp, "      modules_vaddr: %lx\n", ms->modules_vaddr);
+	fprintf(fp, "        modules_end: %lx\n", ms->modules_end);
+	fprintf(fp, "  kernel_text_start: %lx\n", ms->kernel_text_start);
+	fprintf(fp, "    kernel_text_end: %lx\n", ms->kernel_text_end);
+	fprintf(fp, "exception_text_start: %lx\n", ms->exception_text_start);
+	fprintf(fp, " exception_text_end: %lx\n", ms->exception_text_end);
+	fprintf(fp, "     crash_task_pid: %ld\n", ms->crash_task_pid);
+	fprintf(fp, "    crash_task_regs: %lx\n", (ulong)ms->crash_task_regs);
+}
+
+/*
+ * Retrieve task registers for the time of the crash.
+ */
+static int
+arm_get_crash_notes(void)
+{
+	struct machine_specific *ms = machdep->machspec;
+	ulong crash_notes;
+	Elf32_Nhdr *note;
+	ulong ptr, offset;
+	char *buf, *p;
+
+	if (!symbol_exists("crash_notes"))
+		return FALSE;
+
+	crash_notes = symbol_value("crash_notes");
+
+	if (kt->cpus > 1)
+		error(WARNING, "only one CPU is currently supported\n");
+
+	/*
+	 * Read crash_notes for the first CPU. crash_notes are in standard ELF
+	 * note format.
+	 */
+	if (!readmem(crash_notes, KVADDR, &ptr, sizeof(ptr), "crash_notes",
+		     RETURN_ON_ERROR)) {
+		error(WARNING, "cannot read crash_notes\n");
+		return FALSE;
+	}
+
+	buf = GETBUF(SIZE(note_buf));
+
+	if (!readmem(ptr, KVADDR, buf, SIZE(note_buf), "note_buf_t",
+		     RETURN_ON_ERROR)) {
+		error(WARNING, "failed to read note_buf_t\n");
+		goto fail;
+	}
+
+	/*
+	 * Do some sanity checks for this note before reading registers from it.
+	 */
+	note = (Elf32_Nhdr *)buf;
+	p = buf + sizeof(Elf32_Nhdr);
+
+	if (note->n_type != NT_PRSTATUS) {
+		error(WARNING, "invalid note (n_type != NT_PRSTATUS)\n");
+		goto fail;
+	}
+	if (p[0] != 'C' || p[1] != 'O' || p[2] != 'R' || p[3] != 'E') {
+		error(WARNING, "invalid note (name != \"CORE\"\n");
+		goto fail;
+	}
+
+	/*
+	 * Find correct location of note data. This contains elf_prstatus
+	 * structure which has registers etc. for the crashed task.
+	 */
+	offset = sizeof(Elf32_Nhdr);
+	offset = roundup(offset + note->n_namesz, 4);
+	p = buf + offset; /* start of elf_prstatus */
+
+	BCOPY(p + OFFSET(elf_prstatus_pr_reg), &panic_task_regs,
+	      sizeof(panic_task_regs));
+
+	/*
+	 * And finally we have pid and registers for the crashed task. This is
+	 * used later on when dumping backtrace.
+	 */
+	ms->crash_task_pid = *(ulong *)(p + OFFSET(elf_prstatus_pr_pid));
+	ms->crash_task_regs = &panic_task_regs;
+
+	FREEBUF(buf);
+	return TRUE;
+
+fail:
+	FREEBUF(buf);
+	return FALSE;
+}
+
+/*
+ * Accept or reject a symbol from the kernel namelist.
+ */
+static int
+arm_verify_symbol(const char *name, ulong value, char type)
+{
+	if (STREQ(name, "swapper_pg_dir"))
+		machdep->flags |= KSYMS_START;
+
+	if (!name || !strlen(name) || !(machdep->flags & KSYMS_START))
+		return FALSE;
+
+	if (STREQ(name, "$a") || STREQ(name, "$n") || STREQ(name, "$d"))
+		return FALSE;
+
+	if (CRASHDEBUG(8) && name && strlen(name))
+		fprintf(fp, "%08lx %s\n", value, name);
+
+	return TRUE;
+}
+
+static int
+arm_is_module_addr(ulong vaddr)
+{
+	ulong modules_start;
+	ulong modules_end = machdep->kvbase - 1;
+
+	if (!MODULES_VADDR) {
+		/*
+		 * In case we are still initializing, and vm_init() has not been
+		 * called, we use defaults here which is 16MB below kernel start
+		 * address.
+		 */
+		modules_start = machdep->kvbase - 16 * 1024 * 1024;
+	} else {
+		modules_start = MODULES_VADDR;
+	}
+
+	return (vaddr >= modules_start && vaddr <= modules_end);
+}
+
+int
+arm_is_vmalloc_addr(ulong vaddr)
+{
+	if (arm_is_module_addr(vaddr))
+		return TRUE;
+
+	if (!VMALLOC_START)
+		return FALSE;
+
+	return (vaddr >= VMALLOC_START);
+}
+
+/*
+ * Check whether given address falls inside kernel address space (including
+ * modules).
+ */
+static int
+arm_is_kvaddr(ulong vaddr)
+{
+	if (arm_is_module_addr(vaddr))
+		return TRUE;
+
+	return (vaddr >= machdep->kvbase);
+}
+
+/*
+ * Returns TRUE if given pc is in exception area.
+ */
+static int
+arm_in_exception_text(ulong pc)
+{
+	ulong exception_start = machdep->machspec->exception_text_start;
+	ulong exception_end = machdep->machspec->exception_text_end;
+
+	if (exception_start && exception_end)
+		return (pc >= exception_start && pc < exception_end);
+
+	return FALSE;
+}
+
+/*
+ * Unroll a kernel stack.
+ */
+static void
+arm_back_trace_cmd(struct bt_info *bt)
+{
+	if (!(kt->flags & DWARF_UNWIND)) {
+		error(WARNING, "unwinding without unwind tables is not "
+		      "supported yet!\n");
+		return;
+	}
+
+	if (!INSTACK(bt->stkptr, bt)) {
+		error(WARNING, "unwinding exception stack is not supported\n");
+		return;
+	}
+
+	unwind_backtrace(bt);
+}
+
+/*
+ * Calculate and return the speed of the processor.
+ */
+static ulong
+arm_processor_speed(void)
+{
+	/*
+	 * For now, we don't support reading CPU speed.
+	 */
+	return 0;
+}
+
+/*
+ * Translate a PTE, returning TRUE if the page is present. If a physaddr pointer
+ * is passed in, don't print anything.
+ */
+static int
+arm_translate_pte(ulong pte, void *physaddr, ulonglong pae_pte)
+{
+	char ptebuf[BUFSIZE];
+	char physbuf[BUFSIZE];
+	char buf[BUFSIZE];
+	int page_present;
+	ulong paddr;
+	int len1, len2, others;
+
+	page_present = pte_present(pte);
+	paddr = PAGEBASE(pte);
+
+	if (physaddr) {
+		*((ulong *)physaddr) = paddr;
+		return page_present;
+	}
+
+	sprintf(ptebuf, "%lx", pte);
+	len1 = MAX(strlen(ptebuf), strlen("PTE"));
+	fprintf(fp, "%s  ", mkstring(buf, len1, CENTER | LJUST, "PTE"));
+
+	if (!page_present && pte) {
+		/* swap page, not handled yet */
+		return page_present;
+	}
+
+	sprintf(physbuf, "%lx", paddr);
+	len2 = MAX(strlen(physbuf), strlen("PHYSICAL"));
+	fprintf(fp, "%s  ", mkstring(buf, len2, CENTER | LJUST, "PHYSICAL"));
+
+	fprintf(fp, "FLAGS\n");
+	fprintf(fp, "%s  %s  ",
+		mkstring(ptebuf, len1, CENTER | RJUST, NULL),
+		mkstring(physbuf, len2, CENTER | RJUST, NULL));
+
+	fprintf(fp, "(");
+	others = 0;
+
+	if (pte) {
+		if (pte_present(pte))
+			fprintf(fp, "%sPRESENT", others++ ? "|" : "");
+		if (pte_write(pte))
+			fprintf(fp, "%sWRITE", others++ ? "|" : "");
+		if (pte_dirty(pte))
+			fprintf(fp, "%sDIRTY", others++ ? "|" : "");
+		if (pte_young(pte))
+			fprintf(fp, "%sYOUNG", others++ ? "|" : "");
+	} else {
+		fprintf(fp, "no mapping");
+	}
+
+	fprintf(fp, ")\n");
+
+	return 0;
+}
+
+/*
+ * Virtual to physical memory translation. This function will be called by both
+ * arm_kvtop() and arm_uvtop().
+ */
+static int
+arm_vtop(ulong vaddr, ulong *pgd, physaddr_t *paddr, int verbose)
+{
+	char buf[BUFSIZE];
+	ulong *page_dir;
+	ulong *page_middle;
+	ulong *page_table;
+	ulong pgd_pte;
+	ulong pmd_pte;
+	ulong pte;
+
+	/*
+	 * Page tables in ARM Linux
+	 *
+	 * In hardware PGD is 16k (having 4096 pointers to PTE) and PTE is 1k
+	 * (containing 256 translations).
+	 *
+	 * Linux, however, wants to have PTEs as page sized entities. This means
+	 * that in ARM Linux we have following setup (see also
+	 * arch/arm/include/asm/pgtable.h)
+	 *
+	 *     PGD                   PTE
+	 * +---------+
+	 * |         | 0  ---->  +------------+
+	 * +- - - - -+           | h/w pt 0   |
+	 * |         | 4  ---->  +------------+ +1024
+	 * +- - - - -+           | h/w pt 1   |
+	 * .         .           +------------+ +2048
+	 * .         .           | Linux pt 0 |
+	 * .         .           +------------+ +3072
+	 * |         | 4095      | Linux pt 1 |
+	 * +---------+           +------------+ +4096
+	 *
+	 * So in Linux implementation we have two hardware pointers to second
+	 * level page tables. After these come "Linux" versions of the page
+	 * tables.
+	 *
+	 * Linux PT entries contain bits that are not supported on hardware, for
+	 * example "young" and "dirty" flags.
+	 *
+	 * Our translation scheme only uses Linux PTEs here. Hardware entries
+	 * are 1024 bytes below Linux versions.
+	 */
+
+	if (verbose)
+		fprintf(fp, "PAGE DIRECTORY: %lx\n", (ulong)pgd);
+
+	/*
+	 * pgd_offset(pgd, vaddr)
+	 */
+	page_dir = pgd + PGD_OFFSET(vaddr) * 2;
+
+	FILL_PGD(PAGEBASE(pgd), KVADDR, PGDIR_SIZE());
+	pgd_pte = ULONG(machdep->pgd + PGDIR_OFFSET(page_dir));
+
+	if (verbose)
+		fprintf(fp, "  PGD: %s => %lx\n",
+			mkstring(buf, VADDR_PRLEN, RJUST | LONG_HEX,
+			MKSTR((ulong)page_dir)), pgd_pte);
+
+	if (!pgd_pte)
+		return FALSE;
+
+	/*
+	 * pmd_offset(pgd, vaddr)
+	 *
+	 * Here PMD is folded into a PGD.
+	 */
+	pmd_pte = pgd_pte;
+	page_middle = page_dir;
+
+	if (verbose)
+		fprintf(fp, "  PMD: %s => %lx\n",
+			mkstring(buf, VADDR_PRLEN, RJUST | LONG_HEX,
+			MKSTR((ulong)page_middle)), pmd_pte);
+
+	if ((pmd_pte & PMD_TYPE_MASK) == PMD_TYPE_SECT) {
+		if (verbose) {
+			fprintf(fp, " PAGE: %s  (1MB)\n\n",
+				mkstring(buf, VADDR_PRLEN, RJUST | LONG_HEX,
+				MKSTR(PAGEBASE(pmd_pte))));
+		}
+		*paddr = PAGEBASE(pmd_pte) + (vaddr & ~_SECTION_PAGE_MASK);
+		return TRUE;
+	}
+
+	/*
+	 * pte_offset_map(pmd, vaddr)
+	 */
+	page_table = (ulong *)PTOV(pmd_page_addr(pmd_pte)) + PTE_OFFSET(vaddr);
+
+	FILL_PTBL(PAGEBASE(page_table), KVADDR, PAGESIZE());
+	pte = ULONG(machdep->ptbl + PAGEOFFSET(page_table));
+
+	if (verbose) {
+		fprintf(fp, "  PTE: %s => %lx\n\n",
+			mkstring(buf, VADDR_PRLEN, RJUST | LONG_HEX,
+			MKSTR((ulong)page_table)), pte);
+	}
+
+	if (!pte_present(pte)) {
+		if (pte && verbose) {
+			fprintf(fp, "\n");
+			arm_translate_pte(pte, 0, 0);
+		}
+		return FALSE;
+	}
+
+	*paddr = PAGEBASE(pte) + PAGEOFFSET(vaddr);
+
+	if (verbose) {
+		fprintf(fp, " PAGE: %s\n\n",
+			mkstring(buf, VADDR_PRLEN, RJUST | LONG_HEX,
+			MKSTR(PAGEBASE(pte))));
+		arm_translate_pte(pte, 0, 0);
+	}
+
+	return TRUE;
+}
+
+/*
+ * Translates a user virtual address to its physical address. cmd_vtop() sets
+ * the verbose flag so that the pte translation gets displayed; all other
+ * callers quietly accept the translation.
+ */
+static int
+arm_uvtop(struct task_context *tc, ulong uvaddr, physaddr_t *paddr, int verbose)
+{
+	ulong *pgd;
+	ulong mm;
+
+	if (!tc)
+		error(FATAL, "current context invalid\n");
+
+	*paddr = 0;
+
+	if (IS_KVADDR(uvaddr))
+		return arm_kvtop(tc, uvaddr, paddr, verbose);
+
+	mm = task_mm(tc->task, TRUE);
+	if (mm)
+		pgd = ULONG_PTR(tt->mm_struct + OFFSET(mm_struct_pgd));
+	else
+		readmem(tc->mm_struct + OFFSET(mm_struct_pgd), KVADDR, &pgd,
+			sizeof(long), "mm_struct pgd", FAULT_ON_ERROR);
+
+	return arm_vtop(uvaddr, pgd, paddr, verbose);
+}
+
+/*
+ * Translates a kernel virtual address to its physical address. cmd_vtop() sets
+ * the verbose flag so that the pte translation gets displayed; all other
+ * callers quietly accept the translation.
+ */
+static int
+arm_kvtop(struct task_context *tc, ulong kvaddr, physaddr_t *paddr, int verbose)
+{
+	if (!IS_KVADDR(kvaddr))
+		return FALSE;
+
+	if (!vt->vmalloc_start) {
+		*paddr = VTOP(kvaddr);
+		return TRUE;
+	}
+
+	if (!IS_VMALLOC_ADDR(kvaddr)) {
+		*paddr = VTOP(kvaddr);
+		if (!verbose)
+			return TRUE;
+	}
+
+	return arm_vtop(kvaddr, (ulong *)vt->kernel_pgd[0], paddr, verbose);
+}
+
+/*
+ * Get SP and PC values for idle tasks.
+ */
+static int
+arm_get_frame(struct bt_info *bt, ulong *pcp, ulong *spp)
+{
+	const char *cpu_context;
+
+	if (!bt->tc || !(tt->flags & THREAD_INFO))
+		return FALSE;
+
+	/*
+	 * Update thread_info in tt.
+	 */
+	if (!fill_thread_info(bt->tc->thread_info))
+		return FALSE;
+
+	cpu_context = tt->thread_info + OFFSET(thread_info_cpu_context);
+
+#define GET_REG(ptr, cp, off) ((*ptr) = (*((ulong *)((cp) + OFFSET(off)))))
+	/*
+	 * Unwinding code needs FP value also so we pass it with bt.
+	 */
+	GET_REG(&bt->frameptr, cpu_context, cpu_context_save_fp);
+	GET_REG(spp, cpu_context, cpu_context_save_sp);
+	GET_REG(pcp, cpu_context, cpu_context_save_pc);
+
+	return TRUE;
+}
+
+/*
+ * Get the starting point for the active cpu in a diskdump.
+ *
+ * Note that we currently support only UP machines. In future we might want to
+ * support SMP machines as well.
+ */
+static int
+arm_get_dumpfile_stack_frame(struct bt_info *bt, ulong *nip, ulong *ksp)
+{
+	const struct machine_specific *ms = machdep->machspec;
+
+	if (!ms->crash_task_regs)
+		return FALSE;
+
+	if (tt->panic_task != bt->task || bt->tc->pid != ms->crash_task_pid)
+		return FALSE;
+
+	/*
+	 * We got registers for panic task from crash_notes. Just return them.
+	 */
+	*nip = ms->crash_task_regs->ARM_pc;
+	*ksp = ms->crash_task_regs->ARM_sp;
+
+	/*
+	 * Also store pointer to all registers in case unwinding code needs
+	 * to access LR.
+	 */
+	bt->machdep = ms->crash_task_regs;
+
+	return TRUE;
+}
+
+/*
+ * Get a stack frame combination of PC and SP from the most relevant spot.
+ */
+static void
+arm_get_stack_frame(struct bt_info *bt, ulong *pcp, ulong *spp)
+{
+	ulong ip, sp;
+	int ret;
+
+	ip = sp = 0;
+	bt->machdep = NULL;
+
+	if (DUMPFILE() && is_task_active(bt->task))
+		ret = arm_get_dumpfile_stack_frame(bt, &ip, &sp);
+	else
+		ret = arm_get_frame(bt, &ip, &sp);
+
+	if (!ret) {
+		error(WARNING, "cannot get stackframe for task\n");
+		return;
+	}
+
+	if (pcp)
+		*pcp = ip;
+	if (spp)
+		*spp = sp;
+}
+
+/*
+ * Prints out exception stack starting from start.
+ */
+static void
+arm_dump_exception_stack(ulong start, ulong end)
+{
+	struct arm_pt_regs regs;
+	ulong flags;
+	char buf[64];
+
+	if (!readmem(start, KVADDR, &regs, sizeof(regs),
+		     "exception regs", RETURN_ON_ERROR)) {
+		error(WARNING, "failed to read exception registers\n");
+		return;
+	}
+
+	fprintf(fp, "    pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n"
+		"    sp : %08lx  ip : %08lx  fp : %08lx\n",
+		regs.ARM_pc, regs.ARM_lr, regs.ARM_cpsr,
+		regs.ARM_sp, regs.ARM_ip, regs.ARM_fp);
+	fprintf(fp, "    r10: %08lx  r9 : %08lx  r8 : %08lx\n",
+		regs.ARM_r10, regs.ARM_r9, regs.ARM_r8);
+	fprintf(fp, "    r7 : %08lx  r6 : %08lx  r5 : %08lx  r4 : %08lx\n",
+		regs.ARM_r7, regs.ARM_r6,
+		regs.ARM_r5, regs.ARM_r4);
+	fprintf(fp, "    r3 : %08lx  r2 : %08lx  r1 : %08lx  r0 : %08lx\n",
+		regs.ARM_r3, regs.ARM_r2,
+		regs.ARM_r1, regs.ARM_r0);
+
+	flags = regs.ARM_cpsr;
+	buf[0] = flags & PSR_N_BIT ? 'N' : 'n';
+	buf[1] = flags & PSR_Z_BIT ? 'Z' : 'z';
+	buf[2] = flags & PSR_C_BIT ? 'C' : 'c';
+	buf[3] = flags & PSR_V_BIT ? 'V' : 'v';
+	buf[4] = '\0';
+
+	fprintf(fp, "    Flags: %s  IRQs o%s  FIQs o%s  Mode %s  ISA %s\n",
+		buf, interrupts_enabled(&regs) ? "n" : "ff",
+		fast_interrupts_enabled(&regs) ? "n" : "ff",
+		processor_modes[processor_mode(&regs)],
+		isa_modes[isa_mode(&regs)]);
+}
+
+/*
+ * Pretty prints a single stack frame.
+ */
+void
+arm_dump_backtrace_entry(struct bt_info *bt, int level, ulong where,
+			 ulong from, ulong frame)
+{
+	struct load_module *lm;
+	const char *name;
+
+	name = closest_symbol(where);
+
+	if (module_symbol(where, NULL, &lm, NULL, 0)) {
+		fprintf(fp, "%s#%d [<%08lx>] (%s [%s]) from [<%08lx>]\n",
+			level < 10 ? " " : "",
+			level, where, name, lm->mod_name, from);
+	} else {
+		fprintf(fp, "%s#%d [<%08lx>] (%s) from [<%08lx>]\n",
+			level < 10 ? " " : "",
+			level, where, name, from);
+	}
+
+	if (bt->flags & BT_LINE_NUMBERS) {
+		char buf[BUFSIZE];
+
+		get_line_number(where, buf, FALSE);
+		if (strlen(buf))
+			fprintf(fp, "    %s\n", buf);
+	}
+
+	if (arm_in_exception_text(where)) {
+		ulong frame_start = frame + 4;
+		ulong frame_end = frame_start + sizeof(struct arm_pt_regs);
+
+		arm_dump_exception_stack(frame_start, frame_end);
+	}
+}
+
+/*
+ * Determine where vmalloc'd memory starts.
+ */
+static ulong
+arm_vmalloc_start(void)
+{
+	return vt->high_memory;
+}
+
+/*
+ * Checks whether given task is valid task address.
+ */
+static int
+arm_is_task_addr(ulong task)
+{
+	if (tt->flags & THREAD_INFO)
+		return IS_KVADDR(task);
+
+	return (IS_KVADDR(task) && ALIGNED_STACK_OFFSET(task) == 0);
+}
+
+/*
+ * Filter dissassembly output if the output radix is not gdb's default 10
+ */
+static int
+arm_dis_filter(ulong vaddr, char *inbuf)
+{
+	char buf1[BUFSIZE];
+	char buf2[BUFSIZE];
+	char *colon, *p1;
+	int argc;
+	char *argv[MAXARGS];
+	ulong value;
+
+	if (!inbuf)
+		return TRUE;
+/*
+ *  For some reason gdb can go off into the weeds translating text addresses,
+ *  (on alpha -- not necessarily seen on arm) so this routine both fixes the
+ *  references as well as imposing the current output radix on the translations.
+ */
+	console("IN: %s", inbuf);
+
+	colon = strstr(inbuf, ":");
+
+	if (colon) {
+		sprintf(buf1, "0x%lx <%s>", vaddr,
+			value_to_symstr(vaddr, buf2, pc->output_radix));
+		sprintf(buf2, "%s%s", buf1, colon);
+		strcpy(inbuf, buf2);
+	}
+
+	strcpy(buf1, inbuf);
+	argc = parse_line(buf1, argv);
+
+	if ((FIRSTCHAR(argv[argc-1]) == '<') &&
+	    (LASTCHAR(argv[argc-1]) == '>')) {
+		p1 = rindex(inbuf, '<');
+		while ((p1 > inbuf) && !STRNEQ(p1, " 0x"))
+			p1--;
+
+		if (!STRNEQ(p1, " 0x"))
+			return FALSE;
+		p1++;
+
+		if (!extract_hex(p1, &value, NULLCHAR, TRUE))
+			return FALSE;
+
+		sprintf(buf1, "0x%lx <%s>\n", value,
+			value_to_symstr(value, buf2, pc->output_radix));
+
+		sprintf(p1, buf1);
+	}
+
+	console("    %s", inbuf);
+
+	return TRUE;
+}
+
+/*
+ * Look for likely exception frames in a stack.
+ */
+static int
+arm_eframe_search(struct bt_info *bt)
+{
+	return (NOT_IMPLEMENTED());
+}
+
+/*
+ * Get the relevant page directory pointer from a task structure.
+ */
+static ulong
+arm_get_task_pgd(ulong task)
+{
+	return (NOT_IMPLEMENTED());
+}
+
+/*
+ * Machine dependent command.
+ */
+static void
+arm_cmd_mach(void)
+{
+	int c;
+
+	while ((c = getopt(argcnt, args, "cm")) != -1) {
+		switch (c) {
+		case 'c':
+		case 'm':
+			fprintf(fp, "ARM: '-%c' option is not supported\n", c);
+			break;
+
+		default:
+			argerrs++;
+			break;
+		}
+	}
+
+	if (argerrs)
+		cmd_usage(pc->curcmd, SYNOPSIS);
+
+	arm_display_machine_stats();
+}
+
+static void
+arm_display_machine_stats(void)
+{
+	struct new_utsname *uts;
+	char buf[BUFSIZE];
+	ulong mhz;
+
+	uts = &kt->utsname;
+
+	fprintf(fp, "       MACHINE TYPE: %s\n", uts->machine);
+	fprintf(fp, "        MEMORY SIZE: %s\n", get_memory_size(buf));
+	fprintf(fp, "               CPUS: %d\n", get_cpus_to_display());
+	fprintf(fp, "    PROCESSOR SPEED: ");
+	if ((mhz = machdep->processor_speed()))
+		fprintf(fp, "%ld Mhz\n", mhz);
+	else
+		fprintf(fp, "(unknown)\n");
+	fprintf(fp, "                 HZ: %d\n", machdep->hz);
+	fprintf(fp, "          PAGE SIZE: %d\n", PAGESIZE());
+	fprintf(fp, "KERNEL VIRTUAL BASE: %lx\n", machdep->kvbase);
+	fprintf(fp, "KERNEL VMALLOC BASE: %lx\n", vt->vmalloc_start);
+	fprintf(fp, "  KERNEL STACK SIZE: %ld\n", STACKSIZE());
+}
+
+static int
+arm_get_smp_cpus(void)
+{
+	return get_cpus_online();
+}
+
+/*
+ * Initialize ARM specific stuff.
+ */
+static void
+arm_init_machspec(void)
+{
+	struct machine_specific *ms = machdep->machspec;
+	ulong phys_base;
+
+	if (!DISKDUMP_DUMPFILE())
+		error(FATAL, "Only diskdump format is currently supported!\n");
+
+	/*
+	 * First determine actual phys_base. This was set in place by
+	 * makedumpfile so we can just read what diskdump gives us.
+	 */
+	if (!diskdump_phys_base(&phys_base))
+		error(FATAL, "Cannot determine phys_base\n");
+
+	ms->phys_base = phys_base;
+
+	if (symbol_exists("__exception_text_start") &&
+	    symbol_exists("__exception_text_end")) {
+		ms->exception_text_start = symbol_value("__exception_text_start");
+		ms->exception_text_end = symbol_value("__exception_text_end");
+	}
+
+	if (symbol_exists("_stext") && symbol_exists("_etext")) {
+		ms->kernel_text_start = symbol_value("_stext");
+		ms->kernel_text_end = symbol_value("_etext");
+	}
+
+	if (CRASHDEBUG(1)) {
+		fprintf(fp, "compressed kdump: phys_base: %lx\n",
+			phys_base);
+		fprintf(fp, "kernel text: [%lx - %lx]\n",
+			ms->kernel_text_start, ms->kernel_text_end);
+		fprintf(fp, "exception text: [%lx - %lx]\n",
+			ms->exception_text_start, ms->exception_text_end);
+	}
+}
+
+static const char *hook_files[] = {
+	"arch/arm/kernel/entry-armv.S",
+	"arch/arm/kernel/entry-common.S",
+};
+
+#define ENTRY_ARMV_S	((char **)&hook_files[0])
+#define ENTRY_COMMON_S	((char **)&hook_files[1])
+
+static struct line_number_hook arm_line_number_hooks[] = {
+	{ "__dabt_svc", ENTRY_ARMV_S },
+	{ "__irq_svc", ENTRY_ARMV_S },
+	{ "__und_svc", ENTRY_ARMV_S },
+	{ "__pabt_svc", ENTRY_ARMV_S },
+	{ "__switch_to", ENTRY_ARMV_S },
+
+	{ "ret_fast_syscall", ENTRY_COMMON_S },
+	{ "ret_slow_syscall", ENTRY_COMMON_S },
+	{ "ret_from_fork", ENTRY_COMMON_S },
+	{ NULL, NULL },
+};
+#endif /* ARM */
diff --git a/defs.h b/defs.h
index bd8d492..0f63539 100644
--- a/defs.h
+++ b/defs.h
@@ -84,6 +84,9 @@
 #ifdef S390X
 #define NR_CPUS  (64)
 #endif
+#ifdef ARM
+#define NR_CPUS  (1)
+#endif
 
 #define BUFSIZE  (1500)
 #define NULLCHAR ('\0')
@@ -976,6 +979,7 @@ struct offset_table {                    /* stash of commonly-used offsets */
 	long thread_info_cpu;
 	long thread_info_previous_esp;
 	long thread_info_flags;
+	long thread_info_cpu_context;
 	long nsproxy_mnt_ns;
 	long mnt_namespace_root;
 	long mnt_namespace_list;
@@ -1427,6 +1431,13 @@ struct offset_table {                    /* stash of commonly-used offsets */
         long unwind_table_size;
         long unwind_table_link;
         long unwind_table_name;
+	long unwind_table_list;
+	long unwind_table_start;
+	long unwind_table_stop;
+	long unwind_table_begin_addr;
+	long unwind_table_end_addr;
+	long unwind_idx_addr;
+	long unwind_idx_insn;
 	long rq_cfs;
 	long rq_rt;
 	long rq_nr_running;
@@ -1504,6 +1515,11 @@ struct offset_table {                    /* stash of commonly-used offsets */
 	long mm_rss_stat_count;
 	long module_module_init;
 	long module_init_text_size;
+	long cpu_context_save_fp;
+	long cpu_context_save_sp;
+	long cpu_context_save_pc;
+	long elf_prstatus_pr_pid;
+	long elf_prstatus_pr_reg;
 };
 
 struct size_table {         /* stash of commonly-used sizes */
@@ -1601,6 +1617,7 @@ struct size_table {         /* stash of commonly-used sizes */
 	long mem_section;
 	long pid_link;
 	long unwind_table;
+	long unwind_idx;
 	long rlimit;
 	long kmem_cache;
 	long kmem_cache_node;
@@ -1616,6 +1633,9 @@ struct size_table {         /* stash of commonly-used sizes */
 	long module_sect_attr;
 	long task_struct_utime;
 	long task_struct_stime;
+	long cpu_context_save;
+	long note_buf;
+	long elf_prstatus;
 };
 
 struct array_table {
@@ -2090,6 +2110,49 @@ struct load_module {
  *  Machine specific stuff
  */
 
+#ifdef ARM
+#define _32BIT_
+#define MACHINE_TYPE		"ARM"
+
+#define PAGEBASE(X)		(((ulong)(X)) & (ulong)machdep->pagemask)
+
+#define PTOV(X) \
+	((unsigned long)(X)-(machdep->machspec->phys_base)+(machdep->kvbase))
+#define VTOP(X) \
+	((unsigned long)(X)-(machdep->kvbase)+(machdep->machspec->phys_base))
+
+#define IS_VMALLOC_ADDR(X) 	arm_is_vmalloc_addr((ulong)(X))
+
+#define MODULES_VADDR   	(machdep->machspec->modules_vaddr)
+#define MODULES_END     	(machdep->machspec->modules_end)
+#define VMALLOC_START   	(machdep->machspec->vmalloc_start_addr)
+#define VMALLOC_END     	(machdep->machspec->vmalloc_end)
+
+#define PGDIR_SHIFT   		(21)
+#define PTRS_PER_PTE		(512)
+#define PTRS_PER_PGD		(2048)
+
+#define PGD_OFFSET(vaddr)       ((vaddr) >> PGDIR_SHIFT)
+#define PTE_OFFSET(vaddr)       (((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
+
+#define __SWP_TYPE_SHIFT	3
+#define __SWP_TYPE_BITS		6
+#define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
+#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
+
+#define SWP_TYPE(entry)		(((entry) >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
+#define SWP_OFFSET(entry)	((entry) >> __SWP_OFFSET_SHIFT)
+
+#define __swp_type(entry)	SWP_TYPE(entry)
+#define __swp_offset(entry)	SWP_OFFSET(entry)
+
+#define TIF_SIGPENDING		(2)
+
+#define _SECTION_SIZE_BITS	28
+#define _MAX_PHYSMEM_BITS	32
+
+#endif  /* ARM */
+
 #ifdef X86
 #define _32BIT_
 #define MACHINE_TYPE       "X86"
@@ -2786,6 +2849,10 @@ struct efi_memory_desc_t {
 #define SIZEOF_16BIT  (2)
 #define SIZEOF_8BIT   (1)
 
+#ifdef ARM
+#define MAX_HEXADDR_STRLEN (8)
+#define UVADDR_PRLEN       (8)
+#endif
 #ifdef X86
 #define MAX_HEXADDR_STRLEN (8)             
 #define UVADDR_PRLEN       (8)
@@ -2873,6 +2940,13 @@ struct efi_memory_desc_t {
 #define IRQ_LEVEL       64      /* IRQ level triggered */
 #define IRQ_MASKED      128     /* IRQ masked - shouldn't be seen again */
 
+#ifdef ARM
+#define SA_PROBE                SA_ONESHOT
+#define SA_SAMPLE_RANDOM        SA_RESTART
+#define SA_SHIRQ                0x04000000
+#define SA_RESTORER             0x04000000
+#endif
+
 #ifdef X86
 #define SA_PROBE                SA_ONESHOT
 #define SA_SAMPLE_RANDOM        SA_RESTART
@@ -3203,6 +3277,9 @@ void program_usage(int);
 #define SHORT_FORM (0)
 void dump_program_context(void);
 void dump_build_data(void);
+#ifdef ARM
+#define machdep_init(X) arm_init(X)
+#endif
 #ifdef X86
 #define machdep_init(X) x86_init(X)
 #endif
@@ -3561,6 +3638,9 @@ void help_init(void);
 void cmd_usage(char *, int);
 void display_version(void);
 void display_help_screen(char *);
+#ifdef ARM
+#define dump_machdep_table(X) arm_dump_machdep_table(X)
+#endif
 #ifdef X86
 #define dump_machdep_table(X) x86_dump_machdep_table(X)
 #endif
@@ -3839,6 +3919,57 @@ void read_in_kernel_config(int);
 void dev_init(void);
 void dump_dev_table(void);
 
+#ifdef ARM
+void arm_init(int);
+void arm_dump_machdep_table(ulong);
+void arm_display_idt_table(void);
+int arm_is_vmalloc_addr(ulong);
+void arm_dump_backtrace_entry(struct bt_info *, int, ulong, ulong, ulong);
+#define display_idt_table() \
+        error(FATAL, "-d option is not applicable to ARM architecture\n")
+
+struct arm_pt_regs {
+	ulong uregs[18];
+};
+
+#define ARM_cpsr	uregs[16]
+#define ARM_pc		uregs[15]
+#define ARM_lr		uregs[14]
+#define ARM_sp		uregs[13]
+#define ARM_ip		uregs[12]
+#define ARM_fp		uregs[11]
+#define ARM_r10		uregs[10]
+#define ARM_r9		uregs[9]
+#define ARM_r8		uregs[8]
+#define ARM_r7		uregs[7]
+#define ARM_r6		uregs[6]
+#define ARM_r5		uregs[5]
+#define ARM_r4		uregs[4]
+#define ARM_r3		uregs[3]
+#define ARM_r2		uregs[2]
+#define ARM_r1		uregs[1]
+#define ARM_r0		uregs[0]
+#define ARM_ORIG_r0	uregs[17]
+
+#define KSYMS_START	(0x1)
+
+struct machine_specific {
+	ulong phys_base;
+	ulong vmalloc_start_addr;
+	ulong modules_vaddr;
+	ulong modules_end;
+	ulong kernel_text_start;
+	ulong kernel_text_end;
+	ulong exception_text_start;
+	ulong exception_text_end;
+	ulong crash_task_pid;
+	struct arm_pt_regs *crash_task_regs;
+};
+
+int init_unwind_tables(void);
+void unwind_backtrace(struct bt_info *);
+#endif /* ARM */
+
 /*
  *  alpha.c
  */
diff --git a/unwind_arm.c b/unwind_arm.c
new file mode 100644
index 0000000..f3497a8
--- /dev/null
+++ b/unwind_arm.c
@@ -0,0 +1,702 @@
+/*
+ * Stack unwinding support for ARM
+ *
+ * This code is derived from the kernel source:
+ * arch/arm/kernel/unwind.c
+ * Copyright (C) 2008 ARM Limited
+ *
+ * Created by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * For more information about ARM unwind tables see "Exception handling ABI for
+ * the ARM architecture" document at:
+ *
+ * http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifdef ARM
+
+#include "defs.h"
+
+/**
+ * struct unwind_idx - index table entry
+ * @addr: prel31 offset to the start of the function
+ * @insn: index table entry.
+ *
+ * @insn can be encoded as follows:
+ *     1. if bit31 is clear this points to the start of the EHT entry
+ *        (prel31 offset)
+ *     2. if bit31 is set, this contains the EHT entry itself
+ *     3. if 0x1, cannot unwind.
+ *
+ * In case 1. @insn points to the EH table that comes directly after index
+ * table. This offset is relative to address of @insn which implies that we must
+ * allocate both index table and EH table in single chunk.
+ */
+struct unwind_idx {
+	ulong	addr;
+	ulong	insn;
+};
+
+/**
+ * struct unwind_table - per-module unwind table
+ * @idx: pointer to the star of the unwind table
+ * @start: pointer to the start of the index table
+ * @end: pointer to the last element +1 of the index table
+ * @begin_addr: start address which this table covers
+ * @end_addr: end address which this table covers
+ *
+ * Kernel stores per-module unwind tables in this format. There can be more than
+ * one table per module as we have different ELF sections in the module.
+ */
+struct unwind_table {
+	struct unwind_idx	*idx;
+	struct unwind_idx	*start;
+	struct unwind_idx	*end;
+	ulong			begin_addr;
+	ulong			end_addr;
+};
+
+/*
+ * Unwind table pointers to master kernel table and for modules.
+ */
+static struct unwind_table	*kernel_unwind_table;
+static struct unwind_table	*module_unwind_tables;
+
+struct unwind_ctrl_block {
+	ulong	vrs[16];
+	ulong	*insn;
+	int	entries;
+	int	byte;
+};
+
+enum regs {
+	FP = 11,
+	SP = 13,
+	LR = 14,
+	PC = 15,
+};
+
+struct stackframe {
+	ulong	fp;
+	ulong	sp;
+	ulong	lr;
+	ulong	pc;
+};
+
+static int init_kernel_unwind_table(void);
+static void free_kernel_unwind_table(void);
+static int read_module_unwind_table(struct unwind_table *, ulong);
+static int init_module_unwind_tables(void);
+static ulong unwind_get_byte(struct unwind_ctrl_block *);
+static ulong get_value_from_stack(ulong *);
+static int unwind_exec_insn(struct unwind_ctrl_block *);
+static int is_core_kernel_text(ulong);
+static struct unwind_idx *search_index(ulong);
+static ulong *prel31_to_addr(ulong *);
+static int unwind_frame(struct stackframe *, ulong);
+
+/*
+ * Function reads in-memory kernel and module unwind tables and makes
+ * local copy of them for unwinding. If unwinding tables cannot be found, this
+ * function returns FALSE, otherwise TRUE.
+ */
+int
+init_unwind_tables(void)
+{
+	if (!symbol_exists("__start_unwind_idx") ||
+	    !symbol_exists("__stop_unwind_idx") ||
+	    !symbol_exists("__start_unwind_tab") ||
+	    !symbol_exists("__stop_unwind_tab") ||
+	    !symbol_exists("unwind_tables")) {
+		return FALSE;
+	}
+
+	if (!init_kernel_unwind_table()) {
+		error(WARNING,
+		      "UNWIND: failed to initialize kernel unwind table\n");
+		return FALSE;
+	}
+
+	/*
+	 * Initialize symbols for per-module unwind tables. Actually there are
+	 * several tables per module (one per code section).
+	 */
+	STRUCT_SIZE_INIT(unwind_table, "unwind_table");
+	MEMBER_OFFSET_INIT(unwind_table_list, "unwind_table", "list");
+	MEMBER_OFFSET_INIT(unwind_table_start, "unwind_table", "start");
+	MEMBER_OFFSET_INIT(unwind_table_stop, "unwind_table", "stop");
+	MEMBER_OFFSET_INIT(unwind_table_begin_addr, "unwind_table",
+			   "begin_addr");
+	MEMBER_OFFSET_INIT(unwind_table_end_addr, "unwind_table", "end_addr");
+
+	STRUCT_SIZE_INIT(unwind_idx, "unwind_idx");
+	MEMBER_OFFSET_INIT(unwind_idx_addr, "unwind_idx", "addr");
+	MEMBER_OFFSET_INIT(unwind_idx_insn, "unwind_idx", "insn");
+
+	if (!init_module_unwind_tables()) {
+		error(WARNING,
+		      "UNWIND: failed to initialize module unwind tables\n");
+		free_kernel_unwind_table();
+		return FALSE;
+	}
+
+	/*
+	 * We abuse DWARF_UNWIND flag a little here as ARM unwinding tables are
+	 * not in DWARF format but we can use the flags to indicate that we have
+	 * unwind tables support ready.
+	 */
+	kt->flags |= DWARF_UNWIND_CAPABLE;
+	kt->flags |= DWARF_UNWIND;
+
+	return TRUE;
+}
+
+/*
+ * Allocate and fill master kernel unwind table.
+ */
+static int
+init_kernel_unwind_table(void)
+{
+	ulong idx_start, idx_end, idx_size;
+	ulong tab_end, tab_size;
+
+	kernel_unwind_table = calloc(sizeof(*kernel_unwind_table), 1);
+	if (!kernel_unwind_table)
+		return FALSE;
+
+	idx_start = symbol_value("__start_unwind_idx");
+	idx_end = symbol_value("__stop_unwind_idx");
+	tab_end = symbol_value("__stop_unwind_tab");
+
+	/*
+	 * Calculate sizes of the idx table and the EH table.
+	 */
+	idx_size = idx_end - idx_start;
+	tab_size = tab_end - idx_start;
+
+	kernel_unwind_table->idx = calloc(tab_size, 1);
+	if (!kernel_unwind_table->idx)
+		goto fail;
+
+	/*
+	 * Now read in both the index table and the EH table. We need to read in
+	 * both because prel31 offsets in the index table are relative to the
+	 * index address.
+	 */
+	if (!readmem(idx_start, KVADDR, kernel_unwind_table->idx, tab_size,
+		     "master kernel unwind table", RETURN_ON_ERROR))
+		goto fail;
+
+	kernel_unwind_table->start = kernel_unwind_table->idx;
+	kernel_unwind_table->end = (struct unwind_idx *)
+		((char *)kernel_unwind_table->idx + idx_size);
+	kernel_unwind_table->begin_addr = kernel_unwind_table->start->addr;
+	kernel_unwind_table->end_addr = (kernel_unwind_table->end - 1)->addr;
+
+	if (CRASHDEBUG(1)) {
+		fprintf(fp, "UNWIND: master kernel table start\n");
+		fprintf(fp, "UNWIND: size      : %ld\n", tab_size);
+		fprintf(fp, "UNWIND: start     : %p\n", kernel_unwind_table->start);
+		fprintf(fp, "UNWIND: end       : %p\n", kernel_unwind_table->end);
+		fprintf(fp, "UNWIND: begin_addr: 0x%lx\n",
+			kernel_unwind_table->begin_addr);
+		fprintf(fp, "UNWIND: begin_addr: 0x%lx\n",
+			kernel_unwind_table->end_addr);
+		fprintf(fp, "UNWIND: master kernel table end\n");
+	}
+
+	return TRUE;
+
+fail:
+	free(kernel_unwind_table->idx);
+	free(kernel_unwind_table);
+	return FALSE;
+}
+
+static void
+free_kernel_unwind_table(void)
+{
+	free(kernel_unwind_table->idx);
+	free(kernel_unwind_table);
+}
+
+/*
+ * Read single module unwind table from addr.
+ */
+static int
+read_module_unwind_table(struct unwind_table *tbl, ulong addr)
+{
+	ulong idx_start, idx_stop, idx_size;
+	char *buf;
+
+	buf = GETBUF(SIZE(unwind_table));
+
+	/*
+	 * First read in the unwind table for this module. It then contains
+	 * pointers to the index table which we will read later.
+	 */
+	if (!readmem(addr, KVADDR, buf, SIZE(unwind_table),
+		     "module unwind table", RETURN_ON_ERROR)) {
+		error(WARNING, "UNWIND: cannot read unwind table\n");
+		goto fail;
+	}
+
+#define TABLE_VALUE(b, offs) (*((ulong *)((b) + OFFSET(offs))))
+
+	idx_start = TABLE_VALUE(buf, unwind_table_start);
+	idx_stop = TABLE_VALUE(buf, unwind_table_stop);
+	idx_size = idx_stop - idx_start;
+
+	/*
+	 * We know the size of the index table. Allocate memory for the table
+	 * (including the EH table) and read the contents from the kernel
+	 * memory.
+	 */
+	tbl->idx = calloc(idx_size, 1);
+	if (!tbl->idx)
+		goto fail;
+
+	if (!readmem(idx_start, KVADDR, tbl->idx, idx_size,
+		     "module unwind index table", RETURN_ON_ERROR)) {
+		free(tbl->idx);
+		goto fail;
+	}
+
+	tbl->start = &tbl->idx[0];
+	tbl->end = (struct unwind_idx *)((char *)tbl->start + idx_size);
+	tbl->begin_addr = TABLE_VALUE(buf, unwind_table_begin_addr);
+	tbl->end_addr = TABLE_VALUE(buf, unwind_table_end_addr);
+
+	if (CRASHDEBUG(1)) {
+		fprintf(fp, "UNWIND: module table start\n");
+		fprintf(fp, "UNWIND: start     : %p\n", tbl->start);
+		fprintf(fp, "UNWIND: end       : %p\n", tbl->end);
+		fprintf(fp, "UNWIND: begin_addr: 0x%lx\n", tbl->begin_addr);
+		fprintf(fp, "UNWIND: begin_addr: 0x%lx\n", tbl->end_addr);
+		fprintf(fp, "UNWIND: module table end\n");
+	}
+
+	FREEBUF(buf);
+	return TRUE;
+
+fail:
+	FREEBUF(buf);
+	free(tbl->idx);
+	return FALSE;
+}
+
+/*
+ * Allocate and fill per-module unwind tables.
+ */
+static int
+init_module_unwind_tables(void)
+{
+	ulong head = symbol_value("unwind_tables");
+	struct unwind_table *tbl;
+	struct list_data ld;
+	ulong *table_list;
+	int cnt, i, n;
+
+	BZERO(&ld, sizeof(ld));
+	ld.start = head;
+	ld.member_offset = OFFSET(unwind_table_list);
+
+	if (CRASHDEBUG(1))
+		ld.flags |= VERBOSE;
+
+	/*
+	 * Iterate through unwind table list and store start address of each
+	 * table in table_list.
+	 */
+	hq_open();
+	cnt = do_list(&ld);
+	table_list = (ulong *)GETBUF(cnt * sizeof(ulong));
+	cnt = retrieve_list(table_list, cnt);
+	hq_close();
+
+	module_unwind_tables = calloc(sizeof(struct unwind_table), cnt);
+	if (!module_unwind_tables) {
+		error(WARNING,
+		      "UNWIND: failed to allocate memory for (%d tables)\n",
+		      cnt);
+		FREEBUF(table_list);
+		return FALSE;
+	}
+
+	/* we skip the first address as it is just head pointer */
+	for (i = 1, n = 0; i < cnt; i++, n++) {
+		tbl = &module_unwind_tables[n];
+		if (!read_module_unwind_table(tbl, table_list[i]))
+			goto fail;
+	}
+
+	/* just in case, zero the last entry (again) */
+	BZERO(&module_unwind_tables[n], sizeof(module_unwind_tables[n]));
+
+	FREEBUF(table_list);
+	return TRUE;
+
+fail:
+	FREEBUF(table_list);
+
+	while (--n >= 0) {
+		tbl = &module_unwind_tables[n];
+		free(tbl->idx);
+	}
+
+	free(module_unwind_tables);
+	return FALSE;
+}
+
+/*
+ * Return next insn byte from ctl or 0 in case of failure. As a side-effect,
+ * changes ctrl according the next byte.
+ */
+static ulong
+unwind_get_byte(struct unwind_ctrl_block *ctrl)
+{
+	ulong ret;
+
+	if (ctrl->entries <= 0) {
+		error(WARNING, "UNWIND: corrupt unwind entry\n");
+		return 0;
+	}
+
+	ret = (*ctrl->insn >> (ctrl->byte * 8)) & 0xff;
+
+	if (!ctrl->byte) {
+		ctrl->insn++;
+		ctrl->entries--;
+		ctrl->byte = 3;
+	} else {
+		ctrl->byte--;
+	}
+
+	return ret;
+}
+
+/*
+ * Gets one value from stack pointed by vsp.
+ */
+static ulong
+get_value_from_stack(ulong *vsp)
+{
+	ulong val;
+
+	/*
+	 * We just read the value from kernel memory instead of peeking it from
+	 * the bt->stack.
+	 */
+	if (!readmem((ulong)vsp, KVADDR, &val, sizeof(val),
+		"unwind stack value", RETURN_ON_ERROR)) {
+		error(FATAL, "unwind: failed to read value from stack\n");
+	}
+
+	return val;
+}
+
+/*
+ * Execute the next unwind instruction.
+ */
+static int
+unwind_exec_insn(struct unwind_ctrl_block *ctrl)
+{
+	ulong insn = unwind_get_byte(ctrl);
+
+	if ((insn & 0xc0) == 0) {
+		/*
+		 * 00xx xxxx: vsp = vsp + (xx xxx << 2) + 4
+		 *
+		 * Note that it seems that there is a typo in the spec and this
+		 * is corrected in kernel.
+		 */
+		ctrl->vrs[SP] += ((insn & 0x3f) << 2) + 4;
+	} else if ((insn & 0xc0) == 0x40) {
+		/* 00xx xxxx: vsp = vsp + (xx xxx << 2) + 4 */
+		ctrl->vrs[SP] -= ((insn & 0x3f) << 2) + 4;
+	} else if ((insn & 0xf0) == 0x80) {
+		/*
+		 * Pop up to 12 integer registers under masks
+		 * {r15-r12}, {r11-r4}.
+		 */
+		ulong mask;
+		ulong *vsp = (ulong *)ctrl->vrs[SP];
+		int load_sp, reg = 4;
+
+		insn = (insn << 8) | unwind_get_byte(ctrl);
+		mask = insn & 0x0fff;
+		if (mask == 0) {
+			error(WARNING, "UNWIND: refuse to unwind\n");
+			return FALSE;
+		}
+
+		/* pop {r4-r15} according to mask */
+		load_sp = mask & (1 << (13 - 4));
+		while (mask) {
+			if (mask & 1)
+				ctrl->vrs[reg] = get_value_from_stack(vsp++);
+			mask >>= 1;
+			reg++;
+		}
+		if (!load_sp)
+			ctrl->vrs[SP] = (ulong)vsp;
+	} else if ((insn & 0xf0) == 0x90 &&
+		   (insn & 0x0d) != 0x0d) {
+		/* 1001 nnnn: set vsp = r[nnnn] */
+		ctrl->vrs[SP] = ctrl->vrs[insn & 0x0f];
+	} else if ((insn & 0xf0) == 0xa0) {
+		/*
+		 * 1010 0nnn: pop r4-r[4+nnn]
+		 * 1010 1nnn: pop r4-r[4+nnn], r14
+		 */
+		ulong *vsp = (ulong *)ctrl->vrs[SP];
+		int reg;
+
+		for (reg = 4; reg <= 4 + (insn & 7); reg++)
+			ctrl->vrs[reg] = get_value_from_stack(vsp++);
+
+		if (insn & 0x80)
+			ctrl->vrs[14] = get_value_from_stack(vsp++);
+
+		ctrl->vrs[SP] = (ulong)vsp;
+	} else if (insn == 0xb0) {
+		/* 1011 0000: finish */
+		if (ctrl->vrs[PC] == 0)
+			ctrl->vrs[PC] = ctrl->vrs[LR];
+		/* no further processing */
+		ctrl->entries = 0;
+	} else if (insn == 0xb1) {
+		/* 1011 0001 xxxx yyyy: spare */
+		ulong mask = unwind_get_byte(ctrl);
+		ulong *vsp = (ulong *)ctrl->vrs[SP];
+		int reg = 0;
+
+		if (mask == 0 || mask & 0xf0) {
+			error(WARNING, "UNWIND: spare error\n");
+			return FALSE;
+		}
+
+		/* pop r0-r3 according to mask */
+		while (mask) {
+			if (mask & 1)
+				ctrl->vrs[reg] = get_value_from_stack(vsp++);
+			mask >>= 1;
+			reg++;
+		}
+		ctrl->vrs[SP] = (ulong)vsp;
+	} else if (insn == 0xb2) {
+		/* 1011 0010 uleb128: vsp = vsp + 0x204 (uleb128 << 2) */
+		ulong uleb128 = unwind_get_byte(ctrl);
+
+		ctrl->vrs[SP] += 0x204 + (uleb128 << 2);
+	} else {
+		error(WARNING, "UNWIND: unhandled instruction: %02lx\n", insn);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static int
+is_core_kernel_text(ulong pc)
+{
+	ulong text_start = machdep->machspec->kernel_text_start;
+	ulong text_end = machdep->machspec->kernel_text_end;
+
+	if (text_start && text_end)
+		return (pc >= text_start && pc <= text_end);
+
+	return FALSE;
+}
+
+static struct unwind_idx *
+search_index(ulong ip)
+{
+	struct unwind_idx *start = NULL;
+	struct unwind_idx *end = NULL;
+
+	/*
+	 * First check if this address is in the master kernel unwind table or
+	 * some of the module unwind tables.
+	 */
+	if (is_core_kernel_text(ip)) {
+		start = kernel_unwind_table->start;
+		end = kernel_unwind_table->end;
+	} else {
+		struct unwind_table *tbl;
+
+		for (tbl = &module_unwind_tables[0]; tbl->idx; tbl++) {
+			if (ip >= tbl->begin_addr && ip < tbl->end_addr) {
+				start = tbl->start;
+				end = tbl->end;
+				break;
+			}
+		}
+	}
+
+	if (start && end) {
+		/*
+		 * Do a binary search for the addresses in the index table.
+		 * Addresses are guaranteed to be sorted in ascending order.
+		 */
+		while (start < end - 1) {
+			struct unwind_idx *mid = start + ((end - start + 1) >> 1);
+
+			if (ip < mid->addr)
+				end = mid;
+			else
+				start = mid;
+		}
+
+		return start;
+	}
+
+	return NULL;
+}
+
+/*
+ * Convert a prel31 symbol to an absolute address.
+ */
+static ulong *
+prel31_to_addr(ulong *ptr)
+{
+	/* sign extend to 32 bits */
+	long offset = (((long)*ptr) << 1) >> 1;
+	return (ulong *)((ulong)ptr + offset);
+}
+
+static int
+unwind_frame(struct stackframe *frame, ulong stacktop)
+{
+	struct unwind_ctrl_block ctrl;
+	struct unwind_idx *idx;
+	ulong low, high;
+
+	low = frame->sp;
+	high = stacktop;
+
+	idx = search_index(frame->pc);
+	if (!idx) {
+		error(WARNING, "UNWIND: cannot find index for %lx\n",
+		      frame->pc);
+		return FALSE;
+	}
+
+	ctrl.vrs[FP] = frame->fp;
+	ctrl.vrs[SP] = frame->sp;
+	ctrl.vrs[LR] = frame->lr;
+	ctrl.vrs[PC] = 0;
+
+	if (CRASHDEBUG(5)) {
+		fprintf(fp, "UNWIND: >frame: FP=%lx\n", ctrl.vrs[FP]);
+		fprintf(fp, "UNWIND: >frame: SP=%lx\n", ctrl.vrs[SP]);
+		fprintf(fp, "UNWIND: >frame: LR=%lx\n", ctrl.vrs[LR]);
+		fprintf(fp, "UNWIND: >frame: PC=%lx\n", ctrl.vrs[PC]);
+	}
+
+	if (idx->insn == 1) {
+		/* can't unwind */
+		return FALSE;
+	} else if ((idx->insn & 0x80000000) == 0) {
+		/* insn contains offset to eht entry */
+		ctrl.insn = prel31_to_addr(&idx->insn);
+	} else if ((idx->insn & 0xff000000) == 0x80000000) {
+		/* eht entry is in insn itself */
+		ctrl.insn = &idx->insn;
+	} else {
+		error(WARNING, "UNWIND: unsupported instruction %lx\n",
+		      idx->insn);
+		return FALSE;
+	}
+
+	/* check the personality routine */
+	if ((*ctrl.insn & 0xff000000) == 0x80000000) {
+		ctrl.byte = 2;
+		ctrl.entries = 1;
+	} else if ((*ctrl.insn & 0xff000000) == 0x81000000) {
+		ctrl.byte = 1;
+		ctrl.entries = 1 + ((*ctrl.insn & 0x00ff0000) >> 16);
+	} else {
+		error(WARNING, "UNWIND: unsupported personality routine\n");
+		return FALSE;
+	}
+
+	/* now, execute the instructions */
+	while (ctrl.entries > 0) {
+		if (!unwind_exec_insn(&ctrl)) {
+			error(WARNING, "UNWIND: failed to exec instruction\n");
+			return FALSE;
+		}
+
+		if (ctrl.vrs[SP] < low || ctrl.vrs[SP] >= high)
+			return FALSE;
+	}
+
+	if (ctrl.vrs[PC] == 0)
+		ctrl.vrs[PC] = ctrl.vrs[LR];
+
+	if (frame->pc == ctrl.vrs[PC])
+		return FALSE;
+
+	frame->fp = ctrl.vrs[FP];
+	frame->sp = ctrl.vrs[SP];
+	frame->lr = ctrl.vrs[LR];
+	frame->pc = ctrl.vrs[PC];
+
+	if (CRASHDEBUG(5)) {
+		fprintf(fp, "UNWIND: <frame: FP=%lx\n", ctrl.vrs[FP]);
+		fprintf(fp, "UNWIND: <frame: SP=%lx\n", ctrl.vrs[SP]);
+		fprintf(fp, "UNWIND: <frame: LR=%lx\n", ctrl.vrs[LR]);
+		fprintf(fp, "UNWIND: <frame: PC=%lx\n", ctrl.vrs[PC]);
+	}
+
+	return TRUE;
+}
+
+void
+unwind_backtrace(struct bt_info *bt)
+{
+	struct stackframe frame;
+	int n = 0;
+
+	BZERO(&frame, sizeof(frame));
+	frame.fp = bt->frameptr;
+	frame.sp = bt->stkptr;
+	frame.pc = bt->instptr;
+
+	/*
+	 * In case bt->machdep contains pointer to a full register set, we take
+	 * LR from there.
+	 */
+	if (bt->machdep) {
+		const struct arm_pt_regs *regs = bt->machdep;
+
+		frame.lr = regs->ARM_lr;
+	}
+
+	while (1) {
+		ulong where = frame.pc;
+
+		if (!IS_KVADDR(where))
+			break;
+
+		if (!unwind_frame(&frame, bt->stacktop))
+			break;
+
+		/* call back to ARM code to actually print this frame */
+		arm_dump_backtrace_entry(bt, n++, where, frame.pc,
+					 frame.sp - 4);
+	}
+}
+#endif /* ARM */
-- 
1.5.6.5
