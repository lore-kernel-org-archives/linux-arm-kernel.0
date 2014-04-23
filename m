From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Tue, 22 Apr 2014 19:48:55 -0500
Subject: [PATCH v6 4/6] ARM: add vdso user-space code
In-Reply-To: <cover.1398213562.git.nathan_lynch@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
Message-ID: <7388de73d6762443a427247afb2475d847c9765d.1398213562.git.nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place vdso-related user-space code in arch/arm/kernel/vdso/.

It is almost completely written in C with some assembly helpers to
load the data page address, sample the counter, and fall back to
system calls when necessary.

If CONFIG_ARM_ARCH_TIMER is not enabled, the vdso cannot service
high-resolution clocks and falls back to syscalls.  Low-resolution
clocks e.g. CLOCK_REALTIME_COARSE can be serviced regardless.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/asm-offsets.c        |   5 +
 arch/arm/kernel/vdso/.gitignore      |   1 +
 arch/arm/kernel/vdso/Makefile        |  50 ++++++
 arch/arm/kernel/vdso/checkundef.sh   |   9 +
 arch/arm/kernel/vdso/datapage.S      |  15 ++
 arch/arm/kernel/vdso/vdso.S          |  35 ++++
 arch/arm/kernel/vdso/vdso.lds.S      |  88 +++++++++
 arch/arm/kernel/vdso/vgettimeofday.c | 338 +++++++++++++++++++++++++++++++++++
 8 files changed, 541 insertions(+)
 create mode 100644 arch/arm/kernel/vdso/.gitignore
 create mode 100644 arch/arm/kernel/vdso/Makefile
 create mode 100755 arch/arm/kernel/vdso/checkundef.sh
 create mode 100644 arch/arm/kernel/vdso/datapage.S
 create mode 100644 arch/arm/kernel/vdso/vdso.S
 create mode 100644 arch/arm/kernel/vdso/vdso.lds.S
 create mode 100644 arch/arm/kernel/vdso/vgettimeofday.c

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 85598b5d1efd..a582bb42dc87 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/procinfo.h>
 #include <asm/suspend.h>
+#include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
 
@@ -200,5 +201,9 @@ int main(void)
 #endif
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
 #endif
+  BLANK();
+#ifdef CONFIG_VDSO
+  DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
+#endif
   return 0; 
 }
diff --git a/arch/arm/kernel/vdso/.gitignore b/arch/arm/kernel/vdso/.gitignore
new file mode 100644
index 000000000000..f8b69d84238e
--- /dev/null
+++ b/arch/arm/kernel/vdso/.gitignore
@@ -0,0 +1 @@
+vdso.lds
diff --git a/arch/arm/kernel/vdso/Makefile b/arch/arm/kernel/vdso/Makefile
new file mode 100644
index 000000000000..d4ba13f6f66b
--- /dev/null
+++ b/arch/arm/kernel/vdso/Makefile
@@ -0,0 +1,50 @@
+obj-vdso := vgettimeofday.o datapage.o
+
+# Build rules
+targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
+obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+
+ccflags-y := -shared -fPIC -fno-common -fno-builtin -fno-stack-protector
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
+checkundef = sh $(srctree)/$(src)/checkundef.sh
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL   $@
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-T $^ -o $@ -lgcc && \
+		   $(checkundef) '$(NM)' $@
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
index 000000000000..fbf36d75da06
--- /dev/null
+++ b/arch/arm/kernel/vdso/datapage.S
@@ -0,0 +1,15 @@
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+
+	.align 2
+.L_vdso_data_ptr:
+	.long	_start - . - VDSO_DATA_SIZE
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
index 000000000000..ce645a8dc8fb
--- /dev/null
+++ b/arch/arm/kernel/vdso/vdso.lds.S
@@ -0,0 +1,88 @@
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
+	PROVIDE(_start = .);
+
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
+	LINUX_3.16 {
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
-- 
1.8.3.1
