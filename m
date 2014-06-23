From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:56 -0500
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place vdso-related user-space code in arch/arm/kernel/vdso/.

It is almost completely written in C with some assembly helpers to
load the data page address, sample the counter, and fall back to
system calls when necessary.

If CONFIG_ARM_ARCH_TIMER is not enabled, the vdso cannot service
high-resolution clocks and falls back to syscalls.  Low-resolution
clocks e.g. CLOCK_REALTIME_COARSE can be serviced regardless.

Of particular note is that a post-processing step ("vdsomunge") is
necessary to produce a shared object which is architecturally allowed
to be used by both soft- and hard-float EABI programs.

The 2012 edition of the ARM ABI defines Tag_ABI_VFP_args = 3 "Code is
compatible with both the base and VFP variants; the user did not
permit non-variadic functions to pass FP parameters/results."
Unfortunately current toolchains do not support this tag, which is
ideally what we would use.

The best available option is to ensure that both EF_ARM_ABI_FLOAT_SOFT
and EF_ARM_ABI_FLOAT_HARD are unset in the ELF header's e_flags,
indicating that the shared object is "old" and should be accepted for
backward compatibility's sake.  While binutils < 2.24 appear to
produce a vdso.so with both flags clear, 2.24 always sets
EF_ARM_ABI_FLOAT_SOFT, with no way to inhibit this behavior.  So we
have to fix things up with a custom post-processing step.

In fact, the VDSO code in glibc does much less validation (including
checking these flags) than the code for handling conventional
file-backed shared libraries, so this is a bit moot unless glibc's
VDSO code becomes more strict.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/asm-offsets.c        |   5 +
 arch/arm/kernel/vdso/.gitignore      |   1 +
 arch/arm/kernel/vdso/Makefile        |  59 +++++++
 arch/arm/kernel/vdso/checkundef.sh   |   9 +
 arch/arm/kernel/vdso/datapage.S      |  15 ++
 arch/arm/kernel/vdso/vdso.S          |  35 ++++
 arch/arm/kernel/vdso/vdso.lds.S      |  88 ++++++++++
 arch/arm/kernel/vdso/vdsomunge.c     | 193 +++++++++++++++++++++
 arch/arm/kernel/vdso/vgettimeofday.c | 320 +++++++++++++++++++++++++++++++++++
 9 files changed, 725 insertions(+)
 create mode 100644 arch/arm/kernel/vdso/.gitignore
 create mode 100644 arch/arm/kernel/vdso/Makefile
 create mode 100755 arch/arm/kernel/vdso/checkundef.sh
 create mode 100644 arch/arm/kernel/vdso/datapage.S
 create mode 100644 arch/arm/kernel/vdso/vdso.S
 create mode 100644 arch/arm/kernel/vdso/vdso.lds.S
 create mode 100644 arch/arm/kernel/vdso/vdsomunge.c
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
index 000000000000..ceb712a7626c
--- /dev/null
+++ b/arch/arm/kernel/vdso/Makefile
@@ -0,0 +1,59 @@
+hostprogs-y := vdsomunge
+
+obj-vdso := vgettimeofday.o datapage.o
+
+# Build rules
+targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
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
+
+# Force -O2 to avoid libgcc dependencies
+CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
+CFLAGS_vgettimeofday.o = -O2
+
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+
+# Force dependency
+$(obj)/vdso.o : $(obj)/vdso.so
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso.so.raw: $(src)/vdso.lds $(obj-vdso)
+	$(call if_changed,vdsold)
+
+$(obj)/vdso.so.dbg: $(obj)/vdso.so.raw $(obj)/vdsomunge FORCE
+	$(call if_changed,vdsomunge)
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
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-T $^ -o $@ && \
+		   $(checkundef) '$(NM)' $@
+
+quiet_cmd_vdsomunge = MUNGE   $@
+      cmd_vdsomunge = $(objtree)/$(obj)/vdsomunge $< $@
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
index 000000000000..b509cc12e0eb
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
+	LINUX_3.17 {
+	global:
+		__kernel_clock_getres;
+		__kernel_clock_gettime;
+		__kernel_gettimeofday;
+	local: *;
+	};
+}
diff --git a/arch/arm/kernel/vdso/vdsomunge.c b/arch/arm/kernel/vdso/vdsomunge.c
new file mode 100644
index 000000000000..823b84d142bc
--- /dev/null
+++ b/arch/arm/kernel/vdso/vdsomunge.c
@@ -0,0 +1,193 @@
+/*
+ * Copyright 2014 Mentor Graphics Corporation.
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
+ *
+ *
+ * vdsomunge - Host program which produces a shared object
+ * architecturally specified to be usable by both soft- and hard-float
+ * programs.
+ *
+ * The Procedure Call Standard for the ARM Architecture (ARM IHI
+ * 0042E) says:
+ *
+ *	6.4.1 VFP and Base Standard Compatibility
+ *
+ *	Code compiled for the VFP calling standard is compatible with
+ *	the base standard (and vice-versa) if no floating-point or
+ *	containerized vector arguments or results are used.
+ *
+ * And ELF for the ARM Architecture (ARM IHI 0044E) (Table 4-2) says:
+ *
+ *	If both EF_ARM_ABI_FLOAT_XXXX bits are clear, conformance to the
+ *	base procedure-call standard is implied.
+ *
+ * The VDSO is built with -msoft-float, as with the rest of the ARM
+ * kernel, and uses no floating point arguments or results.  The build
+ * process will produce a shared object that may or may not have the
+ * EF_ARM_ABI_FLOAT_SOFT flag set (it seems to depend on the binutils
+ * version; binutils starting with 2.24 appears to set it).  The
+ * EF_ARM_ABI_FLOAT_HARD flag should definitely not be set, and this
+ * program will error out if it is.
+ *
+ * If the soft-float flag is set, this program clears it.  That's all
+ * it does.
+ */
+
+#define _GNU_SOURCE
+
+#include <byteswap.h>
+#include <elf.h>
+#include <errno.h>
+#include <error.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define HOST_ORDER ELFDATA2LSB
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define HOST_ORDER ELFDATA2MSB
+#endif
+
+static const char *outfile;
+
+static void cleanup(void)
+{
+	if (error_message_count > 0 && outfile != NULL)
+		unlink(outfile);
+}
+
+static Elf32_Word read_elf_word(Elf32_Word word, bool swap)
+{
+	return swap ? bswap_32(word) : word;
+}
+
+static Elf32_Half read_elf_half(Elf32_Half half, bool swap)
+{
+	return swap ? bswap_16(half) : half;
+}
+
+static void write_elf_word(Elf32_Word val, Elf32_Word *dst, bool swap)
+{
+	*dst = swap ? bswap_32(val) : val;
+}
+
+int main(int argc, char **argv)
+{
+	const Elf32_Ehdr *inhdr;
+	bool clear_soft_float;
+	const char *infile;
+	Elf32_Word e_flags;
+	const void *inbuf;
+	struct stat stat;
+	void *outbuf;
+	bool swap;
+	int outfd;
+	int infd;
+
+	atexit(cleanup);
+
+	if (argc != 3)
+		error(EXIT_FAILURE, 0, "Usage: %s [infile] [outfile]", argv[0]);
+
+	infile = argv[1];
+	outfile = argv[2];
+
+	infd = open(infile, O_RDONLY);
+	if (infd < 0)
+		error(EXIT_FAILURE, errno, "Cannot open %s", infile);
+
+	if (fstat(infd, &stat) != 0)
+		error(EXIT_FAILURE, errno, "Failed stat for %s", infile);
+
+	inbuf = mmap(NULL, stat.st_size, PROT_READ, MAP_PRIVATE, infd, 0);
+	if (inbuf == MAP_FAILED)
+		error(EXIT_FAILURE, errno, "Failed to map %s", infile);
+
+	close(infd);
+
+	inhdr = inbuf;
+
+	if (memcmp(&inhdr->e_ident, ELFMAG, SELFMAG) != 0)
+		error(EXIT_FAILURE, 0, "Not an ELF file");
+
+	if (inhdr->e_ident[EI_CLASS] != ELFCLASS32)
+		error(EXIT_FAILURE, 0, "Unsupported ELF class");
+
+	swap = inhdr->e_ident[EI_DATA] != HOST_ORDER;
+
+	if (read_elf_half(inhdr->e_type, swap) != ET_DYN)
+		error(EXIT_FAILURE, 0, "Not a shared object");
+
+	if (read_elf_half(inhdr->e_machine, swap) != EM_ARM) {
+		error(EXIT_FAILURE, 0, "Unsupported architecture %#x",
+		      inhdr->e_machine);
+	}
+
+	e_flags = read_elf_word(inhdr->e_flags, swap);
+
+	if (EF_ARM_EABI_VERSION(e_flags) != EF_ARM_EABI_VER5) {
+		error(EXIT_FAILURE, 0, "Unsupported EABI version %#x",
+		      EF_ARM_EABI_VERSION(e_flags));
+	}
+
+	if (e_flags & EF_ARM_ABI_FLOAT_HARD)
+		error(EXIT_FAILURE, 0, "Unexpected hard-float flag set in "
+		      "e_flags");
+
+	clear_soft_float = !!(e_flags & EF_ARM_ABI_FLOAT_SOFT);
+
+	outfd = open(outfile, O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
+	if (outfd < 0)
+		error(EXIT_FAILURE, errno, "Cannot open %s", outfile);
+
+	if (ftruncate(outfd, stat.st_size) != 0)
+		error(EXIT_FAILURE, errno, "Cannot truncate %s", outfile);
+
+	outbuf = mmap(NULL, stat.st_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		      outfd, 0);
+	if (outbuf == MAP_FAILED)
+		error(EXIT_FAILURE, errno, "Failed to map %s", outfile);
+
+	close(outfd);
+
+	memcpy(outbuf, inbuf, stat.st_size);
+
+	if (clear_soft_float) {
+		Elf32_Ehdr *outhdr;
+
+		outhdr = outbuf;
+		e_flags &= ~EF_ARM_ABI_FLOAT_SOFT;
+		write_elf_word(e_flags, &outhdr->e_flags, swap);
+
+#ifdef DEBUG
+		printf("%s: cleared soft-float bit in ELF header for %s "
+		       "(%#x => %#x)\n", program_invocation_short_name,
+		       outfile, inhdr->e_flags, outhdr->e_flags);
+#endif
+
+	}
+
+	if (msync(outbuf, stat.st_size, MS_SYNC) != 0)
+		error(EXIT_FAILURE, errno, "Failed to sync %s", outfile);
+
+	return EXIT_SUCCESS;
+}
diff --git a/arch/arm/kernel/vdso/vgettimeofday.c b/arch/arm/kernel/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..7fb4c4954f8a
--- /dev/null
+++ b/arch/arm/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,320 @@
+/*
+ * Copyright 2014 Mentor Graphics Corporation.
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
1.9.3
