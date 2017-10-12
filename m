From: salyzyn@android.com (Mark Salyzyn)
Date: Thu, 12 Oct 2017 15:59:32 -0700
Subject: [PATCH v2 3/10] arm: vdso: inline assembler operations to compiler.h
Message-ID: <20171012225940.86652-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move compiler-specific code to a local compiler.h file. CONFIG_AEABI
dependency check. System call fallback functions standardized into
a DEFINE_FALLBACK macro. Accept that __arch_counter_get_cntvct()
is the API for aarch64. Deal with unresolved references emitted by
GCC. Optimize handling of fallback calls. Most notably add unlikely
nullptr checking to __vdso_gettimeofday, if tv null no need to
proceed to fallback, as vdso is capable of filling in the tv values.
For time functions that always return success, do not waste time
checking return value for switch to fallback.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2: split first CL into 3 of 7 pieces
---
 arch/arm/vdso/compiler.h      |  69 ++++++++++++++++++++++++++
 arch/arm/vdso/vgettimeofday.c | 109 +++++++++++-------------------------------
 2 files changed, 96 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/vdso/compiler.h

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
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 2474c17dc356..5f596911bd53 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -22,21 +22,16 @@
  * Reworked and rebased over arm version by: Mark Salyzyn <salyzyn@android.com>
  */
 
-#include <linux/compiler.h>
-#include <linux/hrtimer.h>
-#include <linux/time.h>
-#include <asm/arch_timer.h>
 #include <asm/barrier.h>
-#include <asm/bug.h>
-#include <asm/page.h>
-#include <asm/unistd.h>
-
-#ifndef CONFIG_AEABI
-#error This code depends on AEABI system call conventions
-#endif
+#include <linux/time.h>
+#include <linux/hrtimer.h>
 
+#include "compiler.h"
 #include "datapage.h"
 
+DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
+DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
+
 static notrace u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
@@ -63,23 +58,6 @@ static notrace int vdso_read_retry(const struct vdso_data *vd, u32 start)
 	return seq != start;
 }
 
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
-}
-
 static notrace int do_realtime_coarse(const struct vdso_data *vd,
 				      struct timespec *ts)
 {
@@ -127,7 +105,7 @@ static notrace u64 get_ns(const struct vdso_data *vd)
 	u64 cycle_now;
 	u64 nsec;
 
-	cycle_now = arch_counter_get_cntvct();
+	cycle_now = __arch_counter_get_cntvct();
 
 	cycle_delta = (cycle_now - vd->cs_cycle_last) & vd->cs_mask;
 
@@ -200,85 +178,52 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
+notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
-	int ret = -1;
-
 	const struct vdso_data *vd = __get_datapage();
 
-	switch (clkid) {
+	switch (clock) {
 	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(vd, ts);
+		do_realtime_coarse(vd, ts);
 		break;
 	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(vd, ts);
+		do_monotonic_coarse(vd, ts);
 		break;
 	case CLOCK_REALTIME:
-		ret = do_realtime(vd, ts);
+		if (do_realtime(vd, ts))
+			goto fallback;
 		break;
 	case CLOCK_MONOTONIC:
-		ret = do_monotonic(vd, ts);
+		if (do_monotonic(vd, ts))
+			goto fallback;
 		break;
 	default:
-		break;
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
-	int ret;
-
 	const struct vdso_data *vd = __get_datapage();
 
-	ret = do_realtime(vd, &ts);
-	if (ret)
-		return gettimeofday_fallback(tv, tz);
+	if (likely(tv != NULL)) {
+		struct timespec ts;
+
+		if (do_realtime(vd, &ts))
+			return gettimeofday_fallback(tv, tz);
 
-	if (tv) {
 		tv->tv_sec = ts.tv_sec;
 		tv->tv_usec = ts.tv_nsec / 1000;
 	}
-	if (tz) {
+
+	if (unlikely(tz != NULL)) {
 		tz->tz_minuteswest = vd->tz_minuteswest;
 		tz->tz_dsttime = vd->tz_dsttime;
 	}
 
-	return ret;
-}
-
-/* Avoid unresolved references emitted by GCC */
-
-void __aeabi_unwind_cpp_pr0(void)
-{
-}
-
-void __aeabi_unwind_cpp_pr1(void)
-{
-}
-
-void __aeabi_unwind_cpp_pr2(void)
-{
+	return 0;
 }
-- 
2.15.0.rc0.271.g36b669edcc-goog
