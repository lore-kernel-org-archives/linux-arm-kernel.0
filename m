From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 30 May 2017 17:34:19 -0700
Subject: [PATCHv2 1/2] arm64:vdso: Rewrite gettimeofday into C.
Message-ID: <1496190860-5116-1-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the compiler to optimize the divide by 1000.
And remove the other divide.

On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
gettimeofday improves by 18%.

Note I noticed a bug in the old implementation of __kernel_clock_getres;
it was checking only the lower 32bits of the pointer; this would work
for most cases but could fail in a few.

Changes from v1:
* Fixed bug in __kernel_clock_getres for checking the pointer argument.
* Fix comments to refer to functions in arm64.


Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/kernel/vdso/Makefile       |  13 +-
 arch/arm64/kernel/vdso/gettimeofday.S | 329 --------------------------------
 arch/arm64/kernel/vdso/gettimeofday.c | 345 ++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+), 336 deletions(-)
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/gettimeofday.c

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 62c84f7..55f352f 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -11,10 +11,15 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
+# Force -O2 to avoid libgcc dependencies
+CFLAGS_REMOVE_gettimeofday.o = -pg -Os
+CFLAGS_gettimeofday.o = -O2 -mcmodel=tiny
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
@@ -48,15 +53,9 @@ endef
 include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
-# Assembly rules for the .S files
-$(obj-vdso): %.o: %.S FORCE
-	$(call if_changed_dep,vdsoas)
-
 # Actual build commands
 quiet_cmd_vdsold = VDSOL   $@
       cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
-quiet_cmd_vdsoas = VDSOA   $@
-      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
 
 # Install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
deleted file mode 100644
index e00b467..0000000
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ /dev/null
@@ -1,329 +0,0 @@
-/*
- * Userspace implementations of gettimeofday() and friends.
- *
- * Copyright (C) 2012 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-
-#define NSEC_PER_SEC_LO16	0xca00
-#define NSEC_PER_SEC_HI16	0x3b9a
-
-vdso_data	.req	x6
-seqcnt		.req	w7
-w_tmp		.req	w8
-x_tmp		.req	x8
-
-/*
- * Conventions for macro arguments:
- * - An argument is write-only if its name starts with "res".
- * - All other arguments are read-only, unless otherwise specified.
- */
-
-	.macro	seqcnt_acquire
-9999:	ldr	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	tbnz	seqcnt, #0, 9999b
-	dmb	ishld
-	.endm
-
-	.macro	seqcnt_check fail
-	dmb	ishld
-	ldr	w_tmp, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	cmp	w_tmp, seqcnt
-	b.ne	\fail
-	.endm
-
-	.macro	syscall_check fail
-	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
-	cbnz	w_tmp, \fail
-	.endm
-
-	.macro get_nsec_per_sec res
-	mov	\res, #NSEC_PER_SEC_LO16
-	movk	\res, #NSEC_PER_SEC_HI16, lsl #16
-	.endm
-
-	/*
-	 * Returns the clock delta, in nanoseconds left-shifted by the clock
-	 * shift.
-	 */
-	.macro	get_clock_shifted_nsec res, cycle_last, mult
-	/* Read the virtual counter. */
-	isb
-	mrs	x_tmp, cntvct_el0
-	/* Calculate cycle delta and convert to ns. */
-	sub	\res, x_tmp, \cycle_last
-	/* We can only guarantee 56 bits of precision. */
-	movn	x_tmp, #0xff00, lsl #48
-	and	\res, x_tmp, \res
-	mul	\res, \res, \mult
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the REALTIME timespec, based on the
-	 * "wall time" (xtime) and the clock_mono delta.
-	 */
-	.macro	get_ts_realtime res_sec, res_nsec, \
-			clock_nsec, xtime_sec, xtime_nsec, nsec_to_sec
-	add	\res_nsec, \clock_nsec, \xtime_nsec
-	udiv	x_tmp, \res_nsec, \nsec_to_sec
-	add	\res_sec, \xtime_sec, x_tmp
-	msub	\res_nsec, x_tmp, \nsec_to_sec, \res_nsec
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the timespec based on the clock_raw delta,
-	 * used for CLOCK_MONOTONIC_RAW.
-	 */
-	.macro	get_ts_clock_raw res_sec, res_nsec, clock_nsec, nsec_to_sec
-	udiv	\res_sec, \clock_nsec, \nsec_to_sec
-	msub	\res_nsec, \res_sec, \nsec_to_sec, \clock_nsec
-	.endm
-
-	/* sec and nsec are modified in place. */
-	.macro add_ts sec, nsec, ts_sec, ts_nsec, nsec_to_sec
-	/* Add timespec. */
-	add	\sec, \sec, \ts_sec
-	add	\nsec, \nsec, \ts_nsec
-
-	/* Normalise the new timespec. */
-	cmp	\nsec, \nsec_to_sec
-	b.lt	9999f
-	sub	\nsec, \nsec, \nsec_to_sec
-	add	\sec, \sec, #1
-9999:
-	cmp	\nsec, #0
-	b.ge	9998f
-	add	\nsec, \nsec, \nsec_to_sec
-	sub	\sec, \sec, #1
-9998:
-	.endm
-
-	.macro clock_gettime_return, shift=0
-	.if \shift == 1
-	lsr	x11, x11, x12
-	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
-	mov	x0, xzr
-	ret
-	.endm
-
-	.macro jump_slot jumptable, index, label
-	.if (. - \jumptable) != 4 * (\index)
-	.error "Jump slot index mismatch"
-	.endif
-	b	\label
-	.endm
-
-	.text
-
-/* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
-ENTRY(__kernel_gettimeofday)
-	.cfi_startproc
-	adr	vdso_data, _vdso_data
-	/* If tv is NULL, skip to the timezone code. */
-	cbz	x0, 2f
-
-	/* Compute the time of day. */
-1:	seqcnt_acquire
-	syscall_check fail=4f
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=1b
-
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	/* Convert ns to us. */
-	mov	x13, #1000
-	lsl	x13, x13, x12
-	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
-2:
-	/* If tz is NULL, return 0. */
-	cbz	x1, 3f
-	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
-	stp	w4, w5, [x1, #TZ_MINWEST]
-3:
-	mov	x0, xzr
-	ret
-4:
-	/* Syscall fallback. */
-	mov	x8, #__NR_gettimeofday
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_gettimeofday)
-
-#define JUMPSLOT_MAX CLOCK_MONOTONIC_COARSE
-
-/* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
-ENTRY(__kernel_clock_gettime)
-	.cfi_startproc
-	cmp	w0, #JUMPSLOT_MAX
-	b.hi	syscall
-	adr	vdso_data, _vdso_data
-	adr	x_tmp, jumptable
-	add	x_tmp, x_tmp, w0, uxtw #2
-	br	x_tmp
-
-	ALIGN
-jumptable:
-	jump_slot jumptable, CLOCK_REALTIME, realtime
-	jump_slot jumptable, CLOCK_MONOTONIC, monotonic
-	b	syscall
-	b	syscall
-	jump_slot jumptable, CLOCK_MONOTONIC_RAW, monotonic_raw
-	jump_slot jumptable, CLOCK_REALTIME_COARSE, realtime_coarse
-	jump_slot jumptable, CLOCK_MONOTONIC_COARSE, monotonic_coarse
-
-	.if (. - jumptable) != 4 * (JUMPSLOT_MAX + 1)
-	.error	"Wrong jumptable size"
-	.endif
-
-	ALIGN
-realtime:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=realtime
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic
-
-	/* All computations are done with left-shifted nsecs. */
-	lsl	x4, x4, x12
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x3, ts_nsec=x4, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic_raw:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_raw_mult, w12 = cs_shift */
-	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
-	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-	seqcnt_check fail=monotonic_raw
-
-	/* All computations are done with left-shifted nsecs. */
-	lsl	x14, x14, x12
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-realtime_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	seqcnt_check fail=realtime_coarse
-	clock_gettime_return
-
-	ALIGN
-monotonic_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	ldp	x13, x14, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic_coarse
-
-	/* Computations are done in (non-shifted) nsecs. */
-	get_nsec_per_sec res=x9
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return
-
-	ALIGN
-syscall: /* Syscall fallback. */
-	mov	x8, #__NR_clock_gettime
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_clock_gettime)
-
-/* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
-ENTRY(__kernel_clock_getres)
-	.cfi_startproc
-	cmp	w0, #CLOCK_REALTIME
-	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
-	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
-	b.ne	1f
-
-	ldr	x2, 5f
-	b	2f
-1:
-	cmp	w0, #CLOCK_REALTIME_COARSE
-	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
-	ldr	x2, 6f
-2:
-	cbz	w1, 3f
-	stp	xzr, x2, [x1]
-
-3:	/* res == NULL. */
-	mov	w0, wzr
-	ret
-
-4:	/* Syscall fallback. */
-	mov	x8, #__NR_clock_getres
-	svc	#0
-	ret
-5:
-	.quad	CLOCK_REALTIME_RES
-6:
-	.quad	CLOCK_COARSE_RES
-	.cfi_endproc
-ENDPROC(__kernel_clock_getres)
diff --git a/arch/arm64/kernel/vdso/gettimeofday.c b/arch/arm64/kernel/vdso/gettimeofday.c
new file mode 100644
index 0000000..1293786
--- /dev/null
+++ b/arch/arm64/kernel/vdso/gettimeofday.c
@@ -0,0 +1,345 @@
+/*
+ * Userspace implementations of gettimeofday() and friends.
+ *
+ * Copyright (C) 2017 Cavium, Inc.
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
+ * Rewriten into C by: Andrew Pinski <apinski@cavium.com>
+ */
+
+#include <uapi/linux/time.h>
+#include <asm/unistd.h>
+#include <asm/vdso_datapage.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/hrtimer.h>
+
+extern struct vdso_data _vdso_data;
+
+static notrace int gettimeofday_fallback(struct timeval *_tv,
+					 struct timezone *_tz)
+{
+	register struct timezone *tz asm("x1") = _tz;
+	register struct timeval *tv asm("x0") = _tv;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_gettimeofday;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static notrace long clock_gettime_fallback(clockid_t _clkid,
+					   struct timespec *_ts)
+{
+	register struct timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_gettime;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static notrace int clock_getres_fallback(clockid_t _clkid,
+					 struct timespec *_ts)
+{
+	register struct timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_getres;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static notrace u32 vdso_read_begin(const struct vdso_data *vd)
+{
+	u32 seq;
+
+	do {
+		seq = READ_ONCE(vd->tb_seq_count);
+
+		if ((seq & 1) == 0)
+			break;
+
+		asm volatile ("" : : : "memory");
+	} while (true);
+
+	smp_rmb(); /* Pairs with second smp_wmb in update_vsyscall */
+	return seq;
+}
+
+static notrace u32 vdso_read_retry(const struct vdso_data *vd, u32 start)
+{
+	u32 seq;
+
+	smp_rmb(); /* Pairs with first smp_wmb in update_vsyscall */
+	seq = READ_ONCE(vd->tb_seq_count);
+	return seq != start;
+}
+
+
+/*
+ * Returns the clock delta, in nanoseconds left-shifted by the clock
+ * shift.
+ */
+static notrace u64 get_clock_shifted_nsec(u64 cycle_last, u64 mult)
+{
+	u64 res;
+
+	/* Read the virtual counter. */
+	isb();
+	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
+
+	res = res - cycle_last;
+	/* We can only guarantee 56 bits of precision. */
+	res &= ~(0xff00ull<<48);
+	return res * mult;
+}
+
+
+/* Code size doesn't matter (vdso is 4k/16k/64k anyway) and this is faster. */
+static __always_inline notrace int do_realtime(const struct vdso_data *vd,
+					       struct timespec *ts)
+{
+	u32 seq, cs_mono_mult, cs_shift;
+	u64 ns, sec, cycle_last;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		cs_mono_mult = vd->cs_mono_mult;
+		cs_shift = vd->cs_shift;
+
+		sec = vd->xtime_clock_sec;
+		ns = vd->xtime_clock_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult);
+	ns >>= cs_shift;
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+static notrace int do_monotonic(const struct vdso_data *vd,
+				struct timespec *ts)
+{
+	u32 seq, cs_mono_mult, cs_shift;
+	u64 ns, cycle_last, sec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return 1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		cs_mono_mult = vd->cs_mono_mult;
+		cs_shift = vd->cs_shift;
+
+		sec = vd->xtime_clock_sec;
+		ns = vd->xtime_clock_nsec;
+
+		sec += vd->wtm_clock_sec;
+		ns += vd->wtm_clock_nsec << cs_shift;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult);
+	ns >>= cs_shift;
+
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct timespec *ts)
+{
+	u32 seq, cs_raw_mult, cs_shift;
+	u64 ns, sec, cycle_last;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		cs_raw_mult = vd->cs_raw_mult;
+		cs_shift = vd->cs_shift;
+
+		sec = vd->raw_time_sec;
+		ns = vd->raw_time_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	ns += get_clock_shifted_nsec(cycle_last, cs_raw_mult);
+	ns >>= cs_shift;
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+
+static notrace void do_realtime_coarse(const struct vdso_data *vd,
+				       struct timespec *ts)
+{
+	u32 seq;
+	u64 ns, sec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		sec = vd->xtime_coarse_sec;
+		ns = vd->xtime_coarse_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = ns;
+}
+
+static notrace void do_monotonic_coarse(const struct vdso_data *vd,
+					struct timespec *ts)
+{
+	u32 seq;
+	u64 ns, sec, wtm_sec, wtm_ns;
+
+	do {
+
+		seq = vdso_read_begin(vd);
+
+		sec = vd->xtime_coarse_sec;
+		ns = vd->xtime_coarse_nsec;
+
+		wtm_sec = vd->wtm_clock_sec;
+		wtm_ns = vd->wtm_clock_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	sec += wtm_sec;
+	ns += wtm_ns;
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+}
+
+notrace int __kernel_clock_gettime(clockid_t clock, struct timespec *ts)
+{
+	const struct vdso_data *vd = &_vdso_data;
+
+	switch (clock) {
+	case CLOCK_REALTIME:
+		if (do_realtime(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_MONOTONIC:
+		if (do_monotonic(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_REALTIME_COARSE:
+		do_realtime_coarse(vd, ts);
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		do_monotonic_coarse(vd, ts);
+		break;
+	default:
+		goto fallback;
+	}
+
+	return 0;
+fallback:
+	return clock_gettime_fallback(clock, ts);
+}
+
+
+
+notrace int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	const struct vdso_data *vd = &_vdso_data;
+
+	if (likely(tv != NULL)) {
+		struct timespec ts;
+
+		if (do_realtime(vd, &ts))
+			return gettimeofday_fallback(tv, tz);
+
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+
+	if (unlikely(tz != NULL)) {
+		tz->tz_minuteswest = vd->tz_minuteswest;
+		tz->tz_dsttime = vd->tz_dsttime;
+	}
+
+	return 0;
+}
+
+
+int __kernel_clock_getres(clockid_t clock_id, struct timespec *res)
+{
+	u64 ns;
+
+	if (clock_id == CLOCK_REALTIME ||
+	    clock_id == CLOCK_MONOTONIC ||
+	    clock_id == CLOCK_MONOTONIC_RAW)
+		ns = MONOTONIC_RES_NSEC;
+	else if (clock_id == CLOCK_REALTIME_COARSE ||
+		 clock_id == CLOCK_MONOTONIC_COARSE)
+		ns = LOW_RES_NSEC;
+	else
+		return clock_getres_fallback(clock_id, res);
+
+	if (res) {
+		res->tv_sec = 0;
+		res->tv_nsec = ns;
+	}
+
+	return 0;
+}
-- 
2.7.4
