From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu,  8 Sep 2016 15:00:59 +0100
Subject: [RFC PATCH 4/8] arm64: compat: Add a 32-bit vDSO
In-Reply-To: <20160908140103.7468-1-kevin.brodsky@arm.com>
References: <20160908140103.7468-1-kevin.brodsky@arm.com>
Message-ID: <20160908140103.7468-5-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the files necessary for building a compat (AArch32) vDSO in
kernel/vdso32.

This is mostly an adaptation of the arm vDSO. The most significant
change in vgettimeofday.c is the use of the arm64 vdso_data struct,
allowing the vDSO data page to be shared between the 32 and 64-bit
vDSOs.

In addition to the time functions, sigreturn trampolines are also
provided, aiming at replacing those in the vector page. To improve
debugging, CFI and unwinding directives are used, based on glibc's
implementation. Symbol offsets are made available to the kernel using
the same method as the 64-bit vDSO.

There is unfortunately an important caveat to all this: we cannot get
away with hand-coding 32-bit instructions like in kernel/kuser32.S,
this time we really need a 32-bit compiler. The compat vDSO Makefile
relies on CROSS_COMPILE_ARM32 to provide a 32-bit compiler,
appropriate logic will be added to the arm64 Makefile later on to
ensure that an attempt to build the compat vDSO is made only if this
variable has been set properly.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/kernel/vdso32/Makefile        | 121 +++++++++++++
 arch/arm64/kernel/vdso32/sigreturn.S     |  86 +++++++++
 arch/arm64/kernel/vdso32/vdso.S          |  32 ++++
 arch/arm64/kernel/vdso32/vdso.lds.S      |  98 +++++++++++
 arch/arm64/kernel/vdso32/vgettimeofday.c | 294 +++++++++++++++++++++++++++++++
 5 files changed, 631 insertions(+)
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
new file mode 100644
index 000000000000..38facc870f6e
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -0,0 +1,121 @@
+#
+# Building a vDSO image for AArch32.
+#
+# Author: Kevin Brodsky <kevin.brodsky@arm.com>
+# A mix between the arm64 and arm vDSO Makefiles.
+
+CC_ARM32 := $(CROSS_COMPILE_ARM32)gcc
+
+# Same as cc-ldoption, but using CC_ARM32 instead of CC
+cc32-ldoption = $(call try-run,\
+        $(CC_ARM32) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
+
+# Borrow vdsomunge.c from the arm vDSO
+munge := arch/arm/vdso/vdsomunge
+hostprogs-y := $(srctree)/$(munge)
+
+c-obj-vdso := vgettimeofday.o
+asm-obj-vdso := sigreturn.o
+
+# Build rules
+targets := $(c-obj-vdso) $(asm-obj-vdso) vdso.so vdso.so.dbg vdso.so.raw
+c-obj-vdso := $(addprefix $(obj)/, $(c-obj-vdso))
+asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
+obj-vdso := $(c-obj-vdso) $(asm-obj-vdso)
+
+ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
+
+# Force -O2 to avoid libgcc dependencies
+VDSO_CFLAGS := -march=armv8-a -O2
+# Import some useful flags from arch/arm/Makefile
+VDSO_CFLAGS += -mabi=aapcs-linux -mfloat-abi=soft -funwind-tables
+# The 32-bit compiler does not provide 128-bit integers, which are used in
+# some headers that are indirectly included from the vDSO code.
+# This hack makes the compiler happy and should trigger a warning/error if
+# variables of such type are referenced.
+VDSO_CFLAGS += -D__uint128_t='void*'
+# Silence some warnings coming from headers that operate on long's
+VDSO_CFLAGS += -Wno-shift-count-overflow -Wno-int-to-pointer-cast
+
+# We need to use the global flags to compile the vDSO files. However some flags
+# inherited from either the top-level or the arm64 Makefile are not appropriate
+# for the 32-bit compiler, this function takes care of changing them as
+# appropriate.
+sanitize_flags = \
+        $(subst $(shell $(CC) -print-file-name=include), \
+                $(shell $(CC_ARM32) -print-file-name=include), \
+        $(filter-out -pg -mgeneral-regs-only -mpc-relative-literal-loads \
+                     -fno-asynchronous-unwind-tables, \
+        $(1)))
+
+VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
+VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS += -nostdlib -shared -mfloat-abi=soft
+VDSO_LDFLAGS += $(call cc32-ldoption, -Wl$(comma)--hash-style=sysv)
+VDSO_LDFLAGS += $(call cc32-ldoption, -Wl$(comma)--build-id)
+VDSO_LDFLAGS += $(call cc32-ldoption, -fuse-ld=bfd)
+
+obj-y += vdso.o
+extra-y += vdso.lds
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+CFLAGS_REMOVE_vdso.o = -pg
+
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+
+# Force dependency (incbin is bad)
+$(obj)/vdso.o: $(obj)/vdso.so
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso.so.raw: $(src)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,vdsold)
+
+$(obj)/vdso.so.dbg: $(obj)/vdso.so.raw $(objtree)/$(munge) FORCE
+	$(call if_changed,vdsomunge)
+
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Generate vDSO offsets using helper script (borrowed from the 64-bit vDSO)
+gen-vdsosym := $(srctree)/$(src)/../vdso/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+# The AArch64 nm should be able to read an AArch32 binary
+define cmd_vdsosym
+	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+endef
+
+include/generated/vdso32-offsets.h: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+# Compilation rules for the vDSO sources
+$(c-obj-vdso): %.o: %.c FORCE
+	$(call if_changed_dep,vdsocc)
+$(asm-obj-vdso): %.o: %.S FORCE
+	$(call if_changed_dep,vdsoas)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL   $@
+      cmd_vdsold = $(CC_ARM32) $(call sanitize_flags,$(c_flags)) \
+                   $(VDSO_LDFLAGS) -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
+quiet_cmd_vdsocc = VDSOC   $@
+      cmd_vdsocc = $(CC_ARM32) $(call sanitize_flags,$(c_flags)) \
+                   $(VDSO_CFLAGS) -c -o $@ $<
+quiet_cmd_vdsoas = VDSOA   $@
+      cmd_vdsoas = $(CC_ARM32) $(call sanitize_flags, $(a_flags)) -c -o $@ $<
+
+quiet_cmd_vdsomunge = MUNGE   $@
+      cmd_vdsomunge = $(objtree)/$(munge) $< $@
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/arm64/kernel/vdso32/sigreturn.S b/arch/arm64/kernel/vdso32/sigreturn.S
new file mode 100644
index 000000000000..a203140ec491
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/sigreturn.S
@@ -0,0 +1,86 @@
+/*
+ * Sigreturn trampolines for returning from a signal when the SA_RESTORER
+ * flag is not set.
+ *
+ * Copyright (C) 2016 ARM Limited
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
+ * Based on glibc's arm sa_restorer. While this is not strictly necessary, we
+ * provide both A32 and T32 versions, in accordance with the arm sigreturn
+ * code.
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+.macro cfi_regs offset
+	.cfi_def_cfa sp, 0
+	.cfi_offset r0, \offset + 0 * 4
+	.cfi_offset r1, \offset + 1 * 4
+	.cfi_offset r2, \offset + 2 * 4
+	.cfi_offset r3, \offset + 3 * 4
+	.cfi_offset r4, \offset + 4 * 4
+	.cfi_offset r5, \offset + 5 * 4
+	.cfi_offset r6, \offset + 6 * 4
+	.cfi_offset r7, \offset + 7 * 4
+	.cfi_offset r8, \offset + 8 * 4
+	.cfi_offset r9, \offset + 9 * 4
+	.cfi_offset r10, \offset + 10 * 4
+	.cfi_offset r11, \offset + 11 * 4
+	.cfi_offset r12, \offset + 12 * 4
+	.cfi_offset r13, \offset + 13 * 4
+	.cfi_offset r14, \offset + 14 * 4
+	.cfi_offset r15, \offset + 15 * 4
+.endm
+
+.macro sigreturn_trampoline name, syscall, regs_offset
+	.fnstart
+	.save {r0-r15}
+	.pad #\regs_offset
+ENTRY(\name)
+	.cfi_startproc
+	.cfi_signal_frame
+	cfi_regs \regs_offset
+	mov	r7, #\syscall
+	svc	#0
+	.fnend
+	.cfi_endproc
+/*
+ * We would like to use ENDPROC, but the macro uses @ which is a comment symbol
+ * for arm assemblers, so directly use .type with % instead.
+ */
+	.type \name, %function
+END(\name)
+.endm
+
+	.text
+
+	.arm
+	sigreturn_trampoline __kernel_sigreturn_arm, \
+			     __NR_compat_sigreturn, \
+			     COMPAT_SIGFRAME_REGS_OFFSET
+
+	sigreturn_trampoline __kernel_rt_sigreturn_arm, \
+			     __NR_compat_rt_sigreturn, \
+			     COMPAT_RT_SIGFRAME_REGS_OFFSET
+
+	.thumb
+	sigreturn_trampoline __kernel_sigreturn_thumb, \
+			     __NR_compat_sigreturn, \
+			     COMPAT_SIGFRAME_REGS_OFFSET
+
+	sigreturn_trampoline __kernel_rt_sigreturn_thumb, \
+			     __NR_compat_rt_sigreturn, \
+			     COMPAT_RT_SIGFRAME_REGS_OFFSET
diff --git a/arch/arm64/kernel/vdso32/vdso.S b/arch/arm64/kernel/vdso32/vdso.S
new file mode 100644
index 000000000000..fe19ff70eb76
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vdso.S
@@ -0,0 +1,32 @@
+/*
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
+	.globl vdso32_start, vdso32_end
+	.section .rodata
+	.balign PAGE_SIZE
+vdso32_start:
+	.incbin "arch/arm64/kernel/vdso32/vdso.so"
+	.balign PAGE_SIZE
+vdso32_end:
+
+	.previous
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
new file mode 100644
index 000000000000..95abcc0dd37e
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -0,0 +1,98 @@
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
+	HIDDEN(_vdso_data = . - PAGE_SIZE);
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
+	LINUX_2.6 {
+	global:
+		__vdso_clock_gettime;
+		__vdso_gettimeofday;
+		__kernel_sigreturn_arm;
+		__kernel_sigreturn_thumb;
+		__kernel_rt_sigreturn_arm;
+		__kernel_rt_sigreturn_thumb;
+	local: *;
+	};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_compat_sigreturn_arm	= __kernel_sigreturn_arm;
+VDSO_compat_sigreturn_thumb	= __kernel_sigreturn_thumb;
+VDSO_compat_rt_sigreturn_arm	= __kernel_rt_sigreturn_arm;
+VDSO_compat_rt_sigreturn_thumb	= __kernel_rt_sigreturn_thumb;
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
new file mode 100644
index 000000000000..3591fd56f8a6
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -0,0 +1,294 @@
+/*
+ * Copyright 2015 Mentor Graphics Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clocksource.h>
+#include <linux/compiler.h>
+#include <linux/time.h>
+#include <asm/barrier.h>
+#include <asm/unistd.h>
+#include <asm/vdso_datapage.h>
+
+/*
+ * We use the hidden visibility to prevent the compiler from generating a GOT
+ * relocation. Not only is going through a GOT useless (the entry couldn't and
+ * musn't be overridden by another library), it does not even work: the linker
+ * cannot generate an absolute address to the data page.
+ *
+ * With the hidden visibility, the compiler simply generates a PC-relative
+ * relocation (R_ARM_REL32), and this is what we need.
+ */
+extern const struct vdso_data _vdso_data __attribute__((visibility("hidden")));
+
+static inline const struct vdso_data *get_vdso_data(void)
+{
+	const struct vdso_data *ret;
+	/*
+	 * This simply puts &_vdso_data into ret. The reason why we don't use
+	 * "ret = &_vdso_data" is that the compiler tends to optimise this in a
+	 * very suboptimal way: instead of keeping &_vdso_data in a register,
+	 * it goes through a relocation almost every time _vdso_data must be
+	 * accessed (even in subfunctions). This is both time and space
+	 * consuming: each relocation uses a word in the code section, and it
+	 * has to be loaded at runtime.
+	 *
+	 * This trick hides the assignment from the compiler. Since it cannot
+	 * track where the pointer comes from, it will only use one relocation
+	 * where get_vdso_data() is called, and then keep the result in a
+	 * register.
+	 */
+	asm("mov %0, %1" : "=r"(ret) : "r"(&_vdso_data));
+	return ret;
+}
+
+static notrace u32 __vdso_read_begin(const struct vdso_data *vdata)
+{
+	u32 seq;
+repeat:
+	seq = ACCESS_ONCE(vdata->tb_seq_count);
+	if (seq & 1) {
+		cpu_relax();
+		goto repeat;
+	}
+	return seq;
+}
+
+static notrace u32 vdso_read_begin(const struct vdso_data *vdata)
+{
+	u32 seq;
+
+	seq = __vdso_read_begin(vdata);
+
+	smp_rmb(); /* Pairs with smp_wmb in vdso_write_end */
+	return seq;
+}
+
+static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
+{
+	smp_rmb(); /* Pairs with smp_wmb in vdso_write_begin */
+	return vdata->tb_seq_count != start;
+}
+
+/*
+ * Note: only AEABI is supported by the compat layer, we can assume AEABI
+ * syscall conventions are used.
+ */
+static notrace long clock_gettime_fallback(clockid_t _clkid,
+					   struct timespec *_ts)
+{
+	register struct timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_clock_gettime;
+
+	asm volatile(
+	"	svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static notrace int do_realtime_coarse(struct timespec *ts,
+				      const struct vdso_data *vdata)
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
+static notrace int do_monotonic_coarse(struct timespec *ts,
+				       const struct vdso_data *vdata)
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
+static notrace u64 get_ns(const struct vdso_data *vdata)
+{
+	u64 cycle_delta;
+	u64 cycle_now;
+	u64 nsec;
+
+	/* AArch32 implementation of arch_counter_get_cntvct() */
+	isb();
+	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (cycle_now));
+
+	/* The virtual counter provides 56 significant bits. */
+	cycle_delta = (cycle_now - vdata->cs_cycle_last) & CLOCKSOURCE_MASK(56);
+
+	nsec = (cycle_delta * vdata->cs_mono_mult) + vdata->xtime_clock_nsec;
+	nsec >>= vdata->cs_shift;
+
+	return nsec;
+}
+
+static notrace int do_realtime(struct timespec *ts,
+			       const struct vdso_data *vdata)
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
+static notrace int do_monotonic(struct timespec *ts,
+				const struct vdso_data *vdata)
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
+notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
+{
+	const struct vdso_data *vdata = get_vdso_data();
+	int ret = -1;
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
+static notrace long gettimeofday_fallback(struct timeval *_tv,
+					  struct timezone *_tz)
+{
+	register struct timezone *tz asm("r1") = _tz;
+	register struct timeval *tv asm("r0") = _tv;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_gettimeofday;
+
+	asm volatile(
+	"	svc #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	struct timespec ts;
+	const struct vdso_data *vdata = get_vdso_data();
+	int ret;
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
+/* Avoid unresolved references emitted by GCC */
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
-- 
2.9.3
