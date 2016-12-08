From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Thu, 8 Dec 2016 11:02:20 -0600
Subject: [RFC PATCH v3 07/11] arm64: compat: Add a 32-bit vDSO
In-Reply-To: <0707aecb-6638-2447-cf4a-9c30fc08dae5@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
 <20161206160353.14581-8-kevin.brodsky@arm.com>
 <87r35jmv3e.fsf@wedge.i-did-not-set--mail-host-address--so-tickle-me>
 <0707aecb-6638-2447-cf4a-9c30fc08dae5@arm.com>
Message-ID: <87vauus6ar.fsf@wedge.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Brodsky <kevin.brodsky@arm.com> writes:
> On 07/12/16 18:51, Nathan Lynch wrote:
>> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>>> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
>>> new file mode 100644
>>> index 000000000000..53c3d1f82b26
>>> --- /dev/null
>>> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
>> As I said at LPC last month, I'm not excited to have arch/arm's
>> vgettimeofday.c copied into arch/arm64 and tweaked; I'd rather see this
>> part of the implementation shared between arch/arm and arch/arm64
>> somehow, even if there's not an elegant way to do so.
>>
>> The situation which must be avoided is one where the arch/arm64 compat
>> VDSO incompatibly diverges from the arch/arm VDSO.  That becomes much
>> less likely if there's only one copy of the userspace-exposed code to
>> maintain.
>
> I still agree this is very suboptimal. However, I also think this is by far the most 
> straightforward solution, and I would like to stick to it *as a first step*. If you 
> diff this "tweaked" vgettimeofday.c with the original one, you'll see that it is 
> really not obvious to share even parts of vgettimeofday.c in the current state of arm 
> and arm64.

After adapting your get_vdso_data() to arch/arm/vdso, I come up with the
differences below, which seems surmountable mostly with the addition of
appropriate accessor functions for the data page, or changing the field
names to match.  So I can't say I'm persuaded.

I'm happy to review and facilitate changes to code in arch/arm/vdso to
make it possible to share it with arm64 for its compat VDSO.

 vgettimeofday.c |   84 ++++++++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 47 deletions(-)

--- arch/arm/vdso/vgettimeofday.c	2016-12-07 11:24:35.043856904 -0600
+++ kb-vgettimeofday.c	2016-12-08 10:02:14.031896779 -0600
@@ -15,20 +15,23 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/clocksource.h>
 #include <linux/compiler.h>
-#include <linux/hrtimer.h>
 #include <linux/time.h>
-#include <asm/arch_timer.h>
-#include <asm/barrier.h>
-#include <asm/bug.h>
-#include <asm/page.h>
 #include <asm/unistd.h>
 #include <asm/vdso_datapage.h>
 
-#ifndef CONFIG_AEABI
-#error This code depends on AEABI system call conventions
-#endif
+#include "aarch32-barrier.h"
 
+/*
+ * We use the hidden visibility to prevent the compiler from generating a GOT
+ * relocation. Not only is going through a GOT useless (the entry couldn't and
+ * musn't be overridden by another library), it does not even work: the linker
+ * cannot generate an absolute address to the data page.
+ *
+ * With the hidden visibility, the compiler simply generates a PC-relative
+ * relocation (R_ARM_REL32), and this is what we need.
+ */
 extern const struct vdso_data _vdso_data __attribute__((visibility("hidden")));
 
 static inline const struct vdso_data *get_vdso_data(void)
@@ -52,13 +55,11 @@
 	return ret;
 }
 
-#define __get_datapage() get_vdso_data()
-
 static notrace u32 __vdso_read_begin(const struct vdso_data *vdata)
 {
 	u32 seq;
 repeat:
-	seq = ACCESS_ONCE(vdata->seq_count);
+	seq = ACCESS_ONCE(vdata->tb_seq_count);
 	if (seq & 1) {
 		cpu_relax();
 		goto repeat;
@@ -72,26 +73,30 @@
 
 	seq = __vdso_read_begin(vdata);
 
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_end */
+	aarch32_smp_rmb();
 	return seq;
 }
 
 static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
 {
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_begin */
-	return vdata->seq_count != start;
+	aarch32_smp_rmb();
+	return vdata->tb_seq_count != start;
 }
 
+/*
+ * Note: only AEABI is supported by the compat layer, we can assume AEABI
+ * syscall conventions are used.
+ */
 static notrace long clock_gettime_fallback(clockid_t _clkid,
 					   struct timespec *_ts)
 {
 	register struct timespec *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_clock_gettime;
+	register long nr asm("r7") = __NR_compat_clock_gettime;
 
 	asm volatile(
-	"	swi #0\n"
+	"	svc #0\n"
 	: "=r" (ret)
 	: "r" (clkid), "r" (ts), "r" (nr)
 	: "memory");
@@ -138,25 +143,27 @@
 	return 0;
 }
 
-#ifdef CONFIG_ARM_ARCH_TIMER
-
 static notrace u64 get_ns(const struct vdso_data *vdata)
 {
 	u64 cycle_delta;
 	u64 cycle_now;
 	u64 nsec;
 
-	cycle_now = arch_counter_get_cntvct();
+	/* AArch32 implementation of arch_counter_get_cntvct() */
+	isb();
+	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (cycle_now));
 
-	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
+	/* The virtual counter provides 56 significant bits. */
+	cycle_delta = (cycle_now - vdata->cs_cycle_last) & CLOCKSOURCE_MASK(56);
 
-	nsec = (cycle_delta * vdata->cs_mult) + vdata->xtime_clock_snsec;
+	nsec = (cycle_delta * vdata->cs_mono_mult) + vdata->xtime_clock_nsec;
 	nsec >>= vdata->cs_shift;
 
 	return nsec;
 }
 
-static notrace int do_realtime(struct timespec *ts, const struct vdso_data *vdata)
+static notrace int do_realtime(struct timespec *ts,
+			       const struct vdso_data *vdata)
 {
 	u64 nsecs;
 	u32 seq;
@@ -164,7 +171,7 @@
 	do {
 		seq = vdso_read_begin(vdata);
 
-		if (!vdata->tk_is_cntvct)
+		if (vdata->use_syscall)
 			return -1;
 
 		ts->tv_sec = vdata->xtime_clock_sec;
@@ -178,7 +185,8 @@
 	return 0;
 }
 
-static notrace int do_monotonic(struct timespec *ts, const struct vdso_data *vdata)
+static notrace int do_monotonic(struct timespec *ts,
+				const struct vdso_data *vdata)
 {
 	struct timespec tomono;
 	u64 nsecs;
@@ -187,7 +195,7 @@
 	do {
 		seq = vdso_read_begin(vdata);
 
-		if (!vdata->tk_is_cntvct)
+		if (vdata->use_syscall)
 			return -1;
 
 		ts->tv_sec = vdata->xtime_clock_sec;
@@ -205,27 +213,11 @@
 	return 0;
 }
 
-#else /* CONFIG_ARM_ARCH_TIMER */
-
-static notrace int do_realtime(struct timespec *ts, const struct vdso_data *vdata)
-{
-	return -1;
-}
-
-static notrace int do_monotonic(struct timespec *ts, const struct vdso_data *vdata)
-{
-	return -1;
-}
-
-#endif /* CONFIG_ARM_ARCH_TIMER */
-
 notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
 {
-	const struct vdso_data *vdata;
+	const struct vdso_data *vdata = get_vdso_data();
 	int ret = -1;
 
-	vdata = __get_datapage();
-
 	switch (clkid) {
 	case CLOCK_REALTIME_COARSE:
 		ret = do_realtime_coarse(ts, vdata);
@@ -255,10 +247,10 @@
 	register struct timezone *tz asm("r1") = _tz;
 	register struct timeval *tv asm("r0") = _tv;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_gettimeofday;
+	register long nr asm("r7") = __NR_compat_gettimeofday;
 
 	asm volatile(
-	"	swi #0\n"
+	"	svc #0\n"
 	: "=r" (ret)
 	: "r" (tv), "r" (tz), "r" (nr)
 	: "memory");
@@ -269,11 +261,9 @@
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	struct timespec ts;
-	const struct vdso_data *vdata;
+	const struct vdso_data *vdata = get_vdso_data();
 	int ret;
 
-	vdata = __get_datapage();
-
 	ret = do_realtime(&ts, vdata);
 	if (ret)
 		return gettimeofday_fallback(tv, tz);
