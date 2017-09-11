From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 11 Sep 2017 09:17:43 -0700
Subject: [PATCH 0/3] arm+arm64: vdso: Unification
Message-ID: <20170911161801.112659-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. Make sure it will work for future Aarch32 vdso
on arm64.

Side effects include renaming some vdso_datapage.h variables, adding
a few more to enhance features and functionality to match.

Finally, add unified support for CLOCK_BOOTTIME in clock_gettime call.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 arch/arm/include/asm/vdso_datapage.h |  10 +-
 arch/arm/kernel/vdso.c               |  21 +-
 arch/arm/vdso/compiler.h             |  69 ++++++
 arch/arm/vdso/datapage.h             |  25 +++
 arch/arm/vdso/vdso.lds.S             |   1 +
 arch/arm/vdso/vgettimeofday.c        | 423 ++++++++++++++++++++---------------
 6 files changed, 364 insertions(+), 185 deletions(-)
 create mode 100644 arch/arm/vdso/compiler.h
 create mode 100644 arch/arm/vdso/datapage.h

diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index 9be259442fca..d57c296f7f52 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -29,8 +29,8 @@
  * 32 bytes.
  */
 struct vdso_data {
-	u32 seq_count;		/* sequence count - odd during updates */
-	u16 tk_is_cntvct;	/* fall back to syscall if false */
+	u32 tb_seq_count;	/* sequence count - odd during updates */
+	u16 use_syscall;	/* fall back to syscall if true */
 	u16 cs_shift;		/* clocksource shift */
 	u32 xtime_coarse_sec;	/* coarse time */
 	u32 xtime_coarse_nsec;
@@ -38,7 +38,7 @@ struct vdso_data {
 	u32 wtm_clock_sec;	/* wall to monotonic offset */
 	u32 wtm_clock_nsec;
 	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
-	u32 cs_mult;		/* clocksource multiplier */
+	u32 cs_mono_mult;	/* clocksource multiplier */
 
 	u64 cs_cycle_last;	/* last cycle value */
 	u64 cs_mask;		/* clocksource mask */
@@ -46,6 +46,10 @@ struct vdso_data {
 	u64 xtime_clock_snsec;	/* CLOCK_REALTIME sub-ns base */
 	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
 	u32 tz_dsttime;
+
+	u32 cs_raw_mult;	/* Raw clocksource multipler */
+	u32 raw_time_sec;	/* Raw time */
+	u32 raw_time_nsec;
 };
 
 union vdso_data_store {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index a4d6dc0f2427..74bede343ffc 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -189,6 +189,7 @@ static void __init patch_vdso(void *ehdr)
 	if (!cntvct_ok) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
 	}
 }
 
@@ -274,14 +275,14 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 
 static void vdso_write_begin(struct vdso_data *vdata)
 {
-	++vdso_data->seq_count;
+	++vdso_data->tb_seq_count;
 	smp_wmb(); /* Pairs with smp_rmb in vdso_read_retry */
 }
 
 static void vdso_write_end(struct vdso_data *vdata)
 {
 	smp_wmb(); /* Pairs with smp_rmb in vdso_read_begin */
-	++vdso_data->seq_count;
+	++vdso_data->tb_seq_count;
 }
 
 static bool tk_is_cntvct(const struct timekeeper *tk)
@@ -305,10 +306,10 @@ static bool tk_is_cntvct(const struct timekeeper *tk)
  * counter again, making it even, indicating to userspace that the
  * update is finished.
  *
- * Userspace is expected to sample seq_count before reading any other
- * fields from the data page.  If seq_count is odd, userspace is
+ * Userspace is expected to sample tb_seq_count before reading any other
+ * fields from the data page.  If tb_seq_count is odd, userspace is
  * expected to wait until it becomes even.  After copying data from
- * the page, userspace must sample seq_count again; if it has changed
+ * the page, userspace must sample tb_seq_count again; if it has changed
  * from its previous value, userspace must retry the whole sequence.
  *
  * Calls to update_vsyscall are serialized by the timekeeping core.
@@ -326,7 +327,7 @@ void update_vsyscall(struct timekeeper *tk)
 
 	vdso_write_begin(vdso_data);
 
-	vdso_data->tk_is_cntvct			= tk_is_cntvct(tk);
+	vdso_data->use_syscall			= !tk_is_cntvct(tk);
 	vdso_data->xtime_coarse_sec		= tk->xtime_sec;
 	vdso_data->xtime_coarse_nsec		= (u32)(tk->tkr_mono.xtime_nsec >>
 							tk->tkr_mono.shift);
@@ -335,9 +336,15 @@ void update_vsyscall(struct timekeeper *tk)
 
 	if (vdso_data->tk_is_cntvct) {
 		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
+		vdso_data->raw_clock_sec	= tk->raw_time.tv_sec;
+		vdso_data->raw_clock_nsec	= (tk->raw_time.tv_nsec <<
+						   tk->raw_time.shift) +
+						  tk->tkr_raw.xtime_nsec;
 		vdso_data->xtime_clock_sec	= tk->xtime_sec;
 		vdso_data->xtime_clock_snsec	= tk->tkr_mono.xtime_nsec;
-		vdso_data->cs_mult		= tk->tkr_mono.mult;
+		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
+		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
+		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 		vdso_data->cs_mask		= tk->tkr_mono.mask;
 	}
diff --git a/arch/arm/vdso/compiler.h b/arch/arm/vdso/compiler.h
new file mode 100644
index 000000000000..ef1d664fb4fa
--- /dev/null
+++ b/arch/arm/vdso/compiler.h
@@ -0,0 +1,69 @@
+/*
+ * Userspace implementations of fallback calls
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
+#ifndef __VDSO_COMPILER_H
+#define __VDSO_COMPILER_H
+
+#include <asm/arch_timer.h>
+#include <asm/processor.h>
+#include <asm/unistd.h>
+#include <linux/compiler.h>
+
+#ifndef CONFIG_AEABI
+#error This code depends on AEABI system call conventions
+#endif
+
+#define DEFINE_FALLBACK(name, type_arg1, name_arg1, type_arg2, name_arg2) \
+static notrace long name##_fallback(type_arg1 _##name_arg1,		  \
+				    type_arg2 _##name_arg2)		  \
+{									  \
+	register type_arg1 name_arg1 asm("r0") = _##name_arg1;		  \
+	register type_arg2 name_arg2 asm("r1") = _##name_arg2;		  \
+	register long ret asm ("r0");					  \
+	register long nr asm("r7") = __NR_##name;			  \
+									  \
+	asm volatile(							  \
+	"	swi #0\n"						  \
+	: "=r" (ret)							  \
+	: "r" (name_arg1), "r" (name_arg2), "r" (nr)			  \
+	: "memory");							  \
+									  \
+	return ret;							  \
+}
+
+#define __arch_counter_get_cntvct() arch_counter_get_cntvct()
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
+
+#endif /* __VDSO_COMPILER_H */
diff --git a/arch/arm/vdso/datapage.h b/arch/arm/vdso/datapage.h
new file mode 100644
index 000000000000..e3088bdfb946
--- /dev/null
+++ b/arch/arm/vdso/datapage.h
@@ -0,0 +1,25 @@
+/*
+ * Userspace implementations of __get_datapage
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
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#include <linux/types.h>
+#include <asm/vdso_datapage.h>
+
+extern const struct vdso_data *__get_datapage(void);
+
+#endif /* __VDSO_DATAPAGE_H */
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 89ca89f12d23..1d81e8c3acf6 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -82,6 +82,7 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 79214d5ff097..786ff319aead 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -1,282 +1,355 @@
 /*
- * Copyright 2015 Mentor Graphics Corporation.
+ * Userspace implementations of gettimeofday() and friends.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2 of the
- * License.
+ * Copyright (C) 2017 Cavium, Inc.
+ * Copyright (C) 2015 Mentor Graphics Corporation
+ * Copyright (C) 2012 ARM Limited
  *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Rewriten from arch64 version into C by: Andrew Pinski <apinski@cavium.com>
+ * Reworked and rebased over arm version by: Mark Salyzyn <salyzyn@android.com>
  */
 
-#include <linux/compiler.h>
-#include <linux/hrtimer.h>
-#include <linux/time.h>
-#include <asm/arch_timer.h>
 #include <asm/barrier.h>
-#include <asm/bug.h>
-#include <asm/page.h>
-#include <asm/unistd.h>
-#include <asm/vdso_datapage.h>
+#include <linux/time.h>
+#include <linux/hrtimer.h>
 
-#ifndef CONFIG_AEABI
-#error This code depends on AEABI system call conventions
-#endif
+#include "compiler.h"
+#include "datapage.h"
 
-extern struct vdso_data *__get_datapage(void);
+DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
+DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
+DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
 
-static notrace u32 __vdso_read_begin(const struct vdso_data *vdata)
+static notrace u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
-repeat:
-	seq = ACCESS_ONCE(vdata->seq_count);
-	if (seq & 1) {
-		cpu_relax();
-		goto repeat;
-	}
-	return seq;
-}
 
-static notrace u32 vdso_read_begin(const struct vdso_data *vdata)
-{
-	u32 seq;
+	do {
+		seq = READ_ONCE(vd->tb_seq_count);
+
+		if ((seq & 1) == 0)
+			break;
 
-	seq = __vdso_read_begin(vdata);
+		cpu_relax();
+	} while (true);
 
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_end */
+	smp_rmb(); /* Pairs with second smp_wmb in update_vsyscall */
 	return seq;
 }
 
-static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
+static notrace int vdso_read_retry(const struct vdso_data *vd, u32 start)
 {
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_begin */
-	return vdata->seq_count != start;
-}
+	u32 seq;
 
-static notrace long clock_gettime_fallback(clockid_t _clkid,
-					   struct timespec *_ts)
-{
-	register struct timespec *ts asm("r1") = _ts;
-	register clockid_t clkid asm("r0") = _clkid;
-	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_clock_gettime;
-
-	asm volatile(
-	"	swi #0\n"
-	: "=r" (ret)
-	: "r" (clkid), "r" (ts), "r" (nr)
-	: "memory");
-
-	return ret;
+	smp_rmb(); /* Pairs with first smp_wmb in update_vsyscall */
+	seq = READ_ONCE(vd->tb_seq_count);
+	return seq != start;
 }
 
-static notrace int do_realtime_coarse(struct timespec *ts,
-				      struct vdso_data *vdata)
-{
-	u32 seq;
+#ifdef CONFIG_ARM_ARCH_TIMER
 
-	do {
-		seq = vdso_read_begin(vdata);
+/*
+ * Returns the clock delta, in nanoseconds left-shifted by the clock
+ * shift.
+ */
+static __always_inline notrace u64 get_clock_shifted_nsec(const u64 cycle_last,
+							  const u32 mult,
+							  const u64 mask)
+{
+	u64 res;
 
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
+	/* Read the virtual counter. */
+	res = __arch_counter_get_cntvct();
 
-	} while (vdso_read_retry(vdata, seq));
+	res = res - cycle_last;
 
-	return 0;
+	res &= mask;
+	return res * mult;
 }
 
-static notrace int do_monotonic_coarse(struct timespec *ts,
-				       struct vdso_data *vdata)
+/* Code size doesn't matter (vdso is 4k/16k/64k anyway) and this is faster. */
+static __always_inline notrace int do_realtime(const struct vdso_data *vd,
+					       struct timespec *ts)
 {
-	struct timespec tomono;
-	u32 seq;
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+
+	typeof(((struct vdso_data *)vd)->xtime_clock_sec) sec;
 
 	do {
-		seq = vdso_read_begin(vdata);
+		seq = vdso_read_begin(vd);
 
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
 
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
 
-	} while (vdso_read_retry(vdata, seq));
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
 
-	ts->tv_sec += tomono.tv_sec;
-	timespec_add_ns(ts, tomono.tv_nsec);
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
 
-#ifdef CONFIG_ARM_ARCH_TIMER
-
-static notrace u64 get_ns(struct vdso_data *vdata)
+static __always_inline notrace int do_monotonic(const struct vdso_data *vd,
+						struct timespec *ts)
 {
-	u64 cycle_delta;
-	u64 cycle_now;
-	u64 nsec;
-
-	cycle_now = arch_counter_get_cntvct();
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
 
-	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
+	typeof(((struct vdso_data *)vd)->wtm_clock_nsec) wtm_nsec;
+	typeof(ts->tv_sec) sec;
 
-	nsec = (cycle_delta * vdata->cs_mult) + vdata->xtime_clock_snsec;
-	nsec >>= vdata->cs_shift;
+	do {
+		seq = vdso_read_begin(vd);
 
-	return nsec;
-}
+		if (vd->use_syscall)
+			return -1;
 
-static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
-{
-	u64 nsecs;
-	u32 seq;
+		cycle_last = vd->cs_cycle_last;
 
-	do {
-		seq = vdso_read_begin(vdata);
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
 
-		if (!vdata->tk_is_cntvct)
-			return -1;
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
 
-		ts->tv_sec = vdata->xtime_clock_sec;
-		nsecs = get_ns(vdata);
+		sec += vd->wtm_clock_sec;
+		wtm_nsec = vd->wtm_clock_nsec;
 
-	} while (vdso_read_retry(vdata, seq));
+	} while (unlikely(vdso_read_retry(vd, seq)));
 
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs);
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	nsec += wtm_nsec;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
 
-static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+static __always_inline notrace int do_monotonic_raw(const struct vdso_data *vd,
+						    struct timespec *ts)
 {
-	struct timespec tomono;
-	u64 nsecs;
-	u32 seq;
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+
+	typeof(((struct vdso_data *)vd)->raw_time_sec) sec;
 
 	do {
-		seq = vdso_read_begin(vdata);
+		seq = vdso_read_begin(vd);
 
-		if (!vdata->tk_is_cntvct)
+		if (vd->use_syscall)
 			return -1;
 
-		ts->tv_sec = vdata->xtime_clock_sec;
-		nsecs = get_ns(vdata);
+		cycle_last = vd->cs_cycle_last;
+
+		mult = vd->cs_raw_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
 
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
+		sec = vd->raw_time_sec;
+		nsec = vd->raw_time_nsec;
 
-	} while (vdso_read_retry(vdata, seq));
+	} while (unlikely(vdso_read_retry(vd, seq)));
 
-	ts->tv_sec += tomono.tv_sec;
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs + tomono.tv_nsec);
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
 
 #else /* CONFIG_ARM_ARCH_TIMER */
 
-static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
+static notrace int do_realtime(const struct vdso_data *vd,
+			       struct timespec *ts)
 {
 	return -1;
 }
 
-static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+static notrace int do_monotonic(const struct vdso_data *vd,
+				struct timespec *ts)
+{
+	return -1;
+}
+
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct timespec *ts)
 {
 	return -1;
 }
 
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
+static notrace void do_realtime_coarse(const struct vdso_data *vd,
+				       struct timespec *ts)
 {
-	struct vdso_data *vdata;
-	int ret = -1;
+	u32 seq;
 
-	vdata = __get_datapage();
+	typeof(((struct vdso_data *)vd)->xtime_coarse_sec) sec;
+	typeof(((struct vdso_data *)vd)->xtime_coarse_nsec) nsec;
 
-	switch (clkid) {
-	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(ts, vdata);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(ts, vdata);
-		break;
+	do {
+		seq = vdso_read_begin(vd);
+
+		sec = vd->xtime_coarse_sec;
+		nsec = vd->xtime_coarse_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = nsec;
+}
+
+static notrace void do_monotonic_coarse(const struct vdso_data *vd,
+					struct timespec *ts)
+{
+	u32 seq;
+	u64 nsec;
+
+	typeof(((struct vdso_data *)vd)->wtm_clock_nsec) wtm_nsec;
+	typeof(ts->tv_sec) sec;
+
+	do {
+
+		seq = vdso_read_begin(vd);
+
+		sec = vd->xtime_coarse_sec;
+		nsec = vd->xtime_coarse_nsec;
+
+		sec += vd->wtm_clock_sec;
+		wtm_nsec = vd->wtm_clock_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += wtm_nsec;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+}
+
+notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
+{
+	const struct vdso_data *vd = __get_datapage();
+
+	switch (clock) {
 	case CLOCK_REALTIME:
-		ret = do_realtime(ts, vdata);
+		if (do_realtime(vd, ts))
+			goto fallback;
 		break;
 	case CLOCK_MONOTONIC:
-		ret = do_monotonic(ts, vdata);
+		if (do_monotonic(vd, ts))
+			goto fallback;
 		break;
-	default:
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_REALTIME_COARSE:
+		do_realtime_coarse(vd, ts);
 		break;
+	case CLOCK_MONOTONIC_COARSE:
+		do_monotonic_coarse(vd, ts);
+		break;
+	default:
+		goto fallback;
 	}
 
-	if (ret)
-		ret = clock_gettime_fallback(clkid, ts);
-
-	return ret;
-}
-
-static notrace long gettimeofday_fallback(struct timeval *_tv,
-					  struct timezone *_tz)
-{
-	register struct timezone *tz asm("r1") = _tz;
-	register struct timeval *tv asm("r0") = _tv;
-	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_gettimeofday;
-
-	asm volatile(
-	"	swi #0\n"
-	: "=r" (ret)
-	: "r" (tv), "r" (tz), "r" (nr)
-	: "memory");
-
-	return ret;
+	return 0;
+fallback:
+	return clock_gettime_fallback(clock, ts);
 }
 
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-	struct timespec ts;
-	struct vdso_data *vdata;
-	int ret;
+	const struct vdso_data *vd = __get_datapage();
 
-	vdata = __get_datapage();
+	if (likely(tv != NULL)) {
+		struct timespec ts;
 
-	ret = do_realtime(&ts, vdata);
-	if (ret)
-		return gettimeofday_fallback(tv, tz);
+		if (do_realtime(vd, &ts))
+			return gettimeofday_fallback(tv, tz);
 
-	if (tv) {
 		tv->tv_sec = ts.tv_sec;
 		tv->tv_usec = ts.tv_nsec / 1000;
 	}
-	if (tz) {
-		tz->tz_minuteswest = vdata->tz_minuteswest;
-		tz->tz_dsttime = vdata->tz_dsttime;
-	}
 
-	return ret;
-}
-
-/* Avoid unresolved references emitted by GCC */
+	if (unlikely(tz != NULL)) {
+		tz->tz_minuteswest = vd->tz_minuteswest;
+		tz->tz_dsttime = vd->tz_dsttime;
+	}
 
-void __aeabi_unwind_cpp_pr0(void)
-{
+	return 0;
 }
 
-void __aeabi_unwind_cpp_pr1(void)
+int __vdso_clock_getres(clockid_t clock_id, struct timespec *res)
 {
-}
+	typeof(res->tv_nsec) nsec;
+
+	if (clock_id == CLOCK_REALTIME ||
+	    clock_id == CLOCK_MONOTONIC ||
+	    clock_id == CLOCK_MONOTONIC_RAW)
+		nsec = MONOTONIC_RES_NSEC;
+	else if (clock_id == CLOCK_REALTIME_COARSE ||
+		 clock_id == CLOCK_MONOTONIC_COARSE)
+		nsec = LOW_RES_NSEC;
+	else
+		return clock_getres_fallback(clock_id, res);
+
+	if (likely(res != NULL)) {
+		res->tv_sec = 0;
+		res->tv_nsec = nsec;
+	}
 
-void __aeabi_unwind_cpp_pr2(void)
-{
+	return 0;
 }
-- 
2.14.1.581.gf28d330327-goog
