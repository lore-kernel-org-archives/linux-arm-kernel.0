From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 18 Dec 2009 18:04:06 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
Message-ID: <20091218180406.32211.72790.stgit@e101986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SWP instruction was deprecated in the ARMv6 architecture, superseded
by the LDREX/STREX family of instructions for
load-linked/store-conditional operations. The ARMv7 multiprocessing
extensions mandate that SWP/SWPB instructions are treated as undefined
from reset, with the ability to enable them through the System Control
Register SW bit.

This patch adds the alternative solution to emulate the SWP and SWPB
instructions using LDREX/STREX sequences, and log statistics to
/proc/cpu/swp_emulation. To correctly deal with copy-on-write, it also
modifies cpu_v7_set_pte_ext to change the mappings to priviliged RO when
user RO.

Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/Makefile      |    1 
 arch/arm/kernel/swp_emulate.c |  282 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig           |   20 +++
 arch/arm/mm/proc-v7.S         |    6 +
 4 files changed, 309 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/swp_emulate.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index dd00f74..d1befbc 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
new file mode 100644
index 0000000..51fdbfd
--- /dev/null
+++ b/arch/arm/kernel/swp_emulate.c
@@ -0,0 +1,282 @@
+/*
+ *  linux/arch/arm/kernel/swp_emulate.c
+ *
+ *  Copyright (C) 2009 ARM Limited
+ *  __user_* functions adapted from include/asm/uaccess.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Implements emulation of the SWP/SWPB instructions using load-exclusive and
+ *  store-exclusive for processors that have them disabled (or future ones that
+ *  might not implement them).
+ *
+ *  Syntax of SWP{B} instruction: SWP{B}<c> <Rt>, <Rt2>, [<Rn>]
+ *  Where: Rt  = destination
+ *	   Rt2 = source
+ *	   Rn  = address
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/syscalls.h>
+
+#include <asm/traps.h>
+#include <asm/uaccess.h>
+
+
+/*
+ * Error-checking SWP macros implemented using ldrex{b}/strex{b}
+ */
+#define __user_swp_asm(data, addr, res)				\
+	__asm__ __volatile__(					\
+	"	mov	r3, %1\n"				\
+	"0:	ldrex	%1, [%2]\n"				\
+	"1:	strex	%0, r3, [%2]\n"				\
+	"	cmp	%0, #0\n"				\
+	"	bne	0b\n"					\
+	"2:\n"							\
+	"	.section .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
+	"3:	mov	%0, %3\n"				\
+	"	b	2b\n"					\
+	"	.previous\n"					\
+	"	.section __ex_table,\"a\"\n"			\
+	"	.align	3\n"					\
+	"	.long	0b, 3b\n"				\
+	"	.long	1b, 3b\n"				\
+	"	.previous"					\
+	: "=&r" (res), "+r" (data)				\
+	: "r" (addr), "i" (-EFAULT)				\
+	: "cc", "r3")
+
+#define __user_swpb_asm(data, addr, res)			\
+	__asm__ __volatile__(					\
+	"	mov	r3, %1\n"				\
+	"0:	ldrexb	%1, [%2]\n"				\
+	"1:	strexb	%0, r3, [%2]\n"				\
+	"	cmp	%0, #0\n"				\
+	"	bne	0b\n"					\
+	"2:\n"							\
+	"	.section .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
+	"3:	mov	%0, %3\n"				\
+	"	b	2b\n"					\
+	"	.previous\n"					\
+	"	.section __ex_table,\"a\"\n"			\
+	"	.align	3\n"					\
+	"	.long	0b, 3b\n"				\
+	"	.long	1b, 3b\n"				\
+	"	.previous"					\
+	: "=&r" (res), "+r" (data)				\
+	: "r" (addr), "i" (-EFAULT)				\
+	: "cc", "r3")
+
+/*
+ * Macros/defines for extracting register numbers from instruction.
+ */
+#define EXTRACT_REG_NUM(instruction, offset) \
+  (((instruction) & (0xf << (offset))) >> (offset))
+#define RN_OFFSET  16
+#define RT_OFFSET  12
+#define RT2_OFFSET  0
+
+static unsigned int swpcounter;
+static unsigned int swpbcounter;
+static unsigned int abtcounter;
+static long	    previous_pid;
+
+#ifdef CONFIG_PROC_FS
+static int proc_read_status(char *page, char **start, off_t off, int count,
+			    int *eof, void *data)
+{
+	char *p = page;
+	int len;
+
+	p += sprintf(p, "Emulated SWP:\t\t%u\n", swpcounter);
+	p += sprintf(p, "Emulated SWPB:\t\t%u\n", swpbcounter);
+	p += sprintf(p, "Aborted SWP{B}:\t\t%u\n", abtcounter);
+	if (previous_pid != 0)
+		p += sprintf(p, "Last process:\t\t%ld\n", previous_pid);
+
+	len = (p - page) - off;
+	if (len < 0)
+		len = 0;
+
+	*eof = (len <= count) ? 1 : 0;
+	*start = page + off;
+
+	return len;
+}
+#endif
+
+/*
+ * Set up process info to signal segmentation fault - called on access error.
+ */
+static void set_segfault(struct pt_regs *regs, unsigned long addr)
+{
+	siginfo_t info;
+
+	if (find_vma(current->mm, addr) == NULL)
+		info.si_code  = SEGV_MAPERR;
+	else
+		info.si_code  = SEGV_ACCERR;
+
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	info.si_addr  = (void __user *)regs->ARM_pc;
+
+	pr_debug("SWP{B} emulation: access caused memory abort!\n");
+	arm_notify_die("Illegal memory access", regs, &info, 0, 0);
+
+	abtcounter++;
+}
+
+static int emulate_swp(struct pt_regs *regs, unsigned int address,
+		       unsigned int destreg, unsigned int data)
+{
+	unsigned int res = 0;
+
+	if (address & 0x3) {
+		/* SWP to unaligned address not permitted */
+		pr_debug("SWP instruction on unaligned pointer!\n");
+		return -EFAULT;
+	}
+
+	smp_mb();
+	__user_swp_asm(data, address, res);
+	smp_mb();
+
+	if (res == -EFAULT)
+		return -EFAULT;
+
+	regs->uregs[destreg] = data;
+	swpcounter++;
+
+	return 0;
+}
+
+static int emulate_swpb(struct pt_regs *regs, unsigned int address,
+			unsigned int destreg, unsigned int data)
+{
+	unsigned int res = 0;
+
+	smp_mb();
+	__user_swpb_asm(data, address, res);
+	smp_mb();
+
+	if (res == -EFAULT)
+		return -EFAULT;
+
+	regs->uregs[destreg] = data;
+	swpbcounter++;
+
+	return 0;
+}
+
+/*
+ * swp_handler emulates SWP/SWPB instructions using the __user* macros defined
+ * above. Logs warning message to console to inform users programs are using
+ * deprecated instructions.
+ */
+static int swp_handler(struct pt_regs *regs, unsigned int instr)
+{
+	unsigned int address, destreg, data;
+	unsigned int res = 0;
+	long current_pid = sys_getpid();
+
+	address = regs->uregs[EXTRACT_REG_NUM(instr, RN_OFFSET)];
+	data	= regs->uregs[EXTRACT_REG_NUM(instr, RT2_OFFSET)];
+	destreg = EXTRACT_REG_NUM(instr, RT_OFFSET);
+
+	if (current_pid != previous_pid) {
+		printk(KERN_WARNING \
+			"\"%s\" (%ld) uses deprecated SWP{B} instruction\n",
+			current->comm, current_pid);
+		previous_pid = current_pid;
+	}
+
+	pr_debug("addr in r%d->0x%08x, dest is r%d, source in r%d->0x%08x)\n",
+		EXTRACT_REG_NUM(instr, RN_OFFSET), address,
+		destreg, EXTRACT_REG_NUM(instr, RT2_OFFSET), data);
+
+	/* Check access in reasonable access range for both SWP and SWPB */
+	if (!access_ok(VERIFY_WRITE, (address & ~3), 4)) {
+		pr_debug("SWP{B} emulation: access to %p not allowed!\n",
+			(void *)address);
+		res = -EFAULT;
+	} else {
+		/*
+		 * Bit 22 of the instruction distinguishes between the SWP and
+		 * SWPB variants (bit set means SWPB).
+		 */
+		if ((instr & (1 << 22)) == 0)
+			res = emulate_swp(regs, address, destreg, data);
+		else
+			res = emulate_swpb(regs, address, destreg, data);
+	}
+
+	/*
+	 * Memory errors do not mean emulation failed.
+	 * Set up signal info to return SEGV, then return OK
+	 */
+	if (res != 0)
+		set_segfault(regs, address);
+
+	/*
+	 * On successful emulation, revert the adjustment to the PC made in
+	 * kernel/traps.c in order to resume@the next instruction instead of
+	 * reexecuting the SWP{B}.
+	 */
+	regs->ARM_pc += 4;
+
+	return 0;
+}
+
+/*
+ * Only emulate SWP/SWPB executed in ARM state/User mode.
+ * The kernel must be SWP free and SWP{B} does not exist in Thumb/ThumbEE.
+ */
+static struct undef_hook swp_hook = {
+	.instr_mask = 0x0fb00ff0,
+	.instr_val  = 0x01000090,
+	.cpsr_mask  = MODE_MASK | PSR_T_BIT | PSR_J_BIT,
+	.cpsr_val   = USR_MODE,
+	.fn	    = swp_handler
+};
+
+/*
+ * Register handler and create status file in /proc/cpu
+ * Invoked as late_initcall, since not needed before init spawned.
+ */
+static int __init swp_emulation_init(void)
+{
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *res;
+
+#ifndef CONFIG_ALIGNMENT_TRAP
+	res = proc_mkdir("cpu", NULL);
+	if (!res)
+		return -ENOMEM;
+
+	res = create_proc_entry("swp_emulation", S_IRUGO, res);
+#else
+	res = create_proc_entry("cpu/swp_emulation", S_IRUGO, NULL);
+#endif
+
+	if (!res)
+		return -ENOMEM;
+
+	res->read_proc = proc_read_status;
+#endif /* CONFIG_PROC_FS */
+
+	printk(KERN_NOTICE "Registering SWP/SWPB emulation handler\n");
+	register_undef_hook(&swp_hook);
+
+	return 0;
+}
+
+late_initcall(swp_emulation_init);
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index dd4698c..1d40bd9 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -630,6 +630,26 @@ config ARM_THUMBEE
 	  Say Y here if you have a CPU with the ThumbEE extension and code to
 	  make use of it. Say N for code that can run on CPUs without ThumbEE.
 
+config SWP_EMULATE
+	bool "Emulate SWP/SWPB instructions"
+	depends on CPU_V7
+	default y if SMP
+	help
+	  ARMv6 architecture deprecates use of the SWP/SWPB instructions.
+	  ARMv7 multiprocessing extensions introduce the ability to disable
+	  these instructions, triggering an undefined instruction exception
+	  when executed. Say Y here to enable software emulation of these
+	  instructions for userspace (not kernel) using LDREX/STREX.
+	  Also creates /proc/cpu/swp_emulation for statistics.
+
+	  NOTE: when accessing uncached shared regions, LDREX/STREX rely
+	  on an external transaction monitoring block called a global
+	  monitor to maintain update atomicity. If your system does not
+	  implement a global monitor, this option is not safe for programs
+	  that are permitted to map uncached memory (CAP_SYS_RAWIO).
+
+	  If unsure, say Y.
+
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on ARCH_SUPPORTS_BIG_ENDIAN
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3a28521..cb85aeb 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -147,8 +147,10 @@ ENTRY(cpu_v7_set_pte_ext)
 
 	tst	r1, #L_PTE_USER
 	orrne	r3, r3, #PTE_EXT_AP1
+#ifndef CONFIG_SWP_EMULATE
 	tstne	r3, #PTE_EXT_APX
 	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
+#endif
 
 	tst	r1, #L_PTE_EXEC
 	orreq	r3, r3, #PTE_EXT_XN
@@ -275,6 +277,10 @@ __v7_setup:
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	orr	r6, r6, #1 << 25		@ big-endian page tables
 #endif
+#ifdef CONFIG_SWP_EMULATE
+	orr     r5, r5, #(1 << 10)              @ set SW bit in "clear"
+	bic     r6, r6, #(1 << 10)              @ clear it in "mmuset"
+#endif
    	mrc	p15, 0, r0, c1, c0, 0		@ read control register
 	bic	r0, r0, r5			@ clear bits them
 	orr	r0, r0, r6			@ set them
