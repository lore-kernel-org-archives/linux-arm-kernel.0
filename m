From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Mon, 3 Mar 2014 09:38:21 -0600
Subject: [PATCH v3] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <20140303110001.GB8554@mudshark.cambridge.arm.com>
References: <1393813295-27376-1-git-send-email-nathan_lynch@mentor.com>
 <20140303110001.GB8554@mudshark.cambridge.arm.com>
Message-ID: <5314A1ED.10005@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 03/03/2014 05:00 AM, Will Deacon wrote:
> On Mon, Mar 03, 2014 at 02:21:35AM +0000, Nathan Lynch wrote:
>> - Force reload of seq_count when spinning: without a memory clobber
>>   after the load of vdata->seq_count, GCC can generate code like this:
>>     2f8:   e59c9020        ldr     r9, [ip, #32]
>>     2fc:   e3190001        tst     r9, #1
>>     300:   1a000033        bne     3d4 <do_realtime+0x104>
>>     304:   f57ff05b        dmb     ish
>>     308:   e59c3034        ldr     r3, [ip, #52]   ; 0x34
>>     ...
>>     3d4:   eafffffe        b       3d4 <do_realtime+0x104>
> 
> Have you thought about using a seqlock instead? It looks like a drop-in
> replacement for your seqcnt_* stuff.

I have considered that, and x86_64 in fact uses the seqlock APIs for its
vDSO.  I've made the change locally and it passes my tests fine, but I
have one concern -- seqcount_t is defined as:

typedef struct seqcount {
	unsigned sequence;
#ifdef CONFIG_DEBUG_LOCK_ALLOC
	struct lockdep_map dep_map;
#endif
} seqcount_t;

If we use a seqcount_t in the vdso_data structure and
CONFIG_DEBUG_LOCK_ALLOC=y, not only does this bloat the structure to no
purpose (we can't use the lockdep-enabled read accessors in userspace),
it also leaks kernel pointer values and such through the lockdep_map
member.  So I think the seqcount would have to be a plain integer, and
we'd have to cast to seqcount_t to manipulate it, e.g.

seq = raw_read_seqcount_begin((seqcount_t *)&vdata->seq);

See the incremental patch (damaged by my mailer, sorry) below for how
this would look.


diff --git a/arch/arm/include/asm/vdso_datapage.h
b/arch/arm/include/asm/vdso_datapage.h
index 9011ec75a24b..83a752f969da 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -27,7 +27,7 @@
  * 32 bytes.
  */
 struct vdso_data {
-	u32 seq_count;		/* sequence count - odd during updates */
+	unsigned long seq;      /* sequence counter */
 	u16 use_syscall;	/* whether to fall back to syscalls */
 	u16 cs_shift;		/* clocksource shift */
 	u32 xtime_coarse_sec;	/* coarse time */
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 3db74240a766..6ff2893feb45 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/seqlock.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
@@ -109,18 +110,8 @@ void arm_install_vdso(struct mm_struct *mm)
 /**
  * update_vsyscall - update the vdso data page
  *
- * Increment the sequence counter, making it odd, indicating to
- * userspace that an update is in progress.  Update the fields used
- * for coarse clocks and, if the architected system timer is in use,
- * the fields used for high precision clocks.  Increment the sequence
- * counter again, making it even, indicating to userspace that the
- * update is finished.
- *
- * Userspace is expected to sample seq_count before reading any other
- * fields from the data page.  If seq_count is odd, userspace is
- * expected to wait until it becomes even.  After copying data from
- * the page, userspace must sample seq_count again; if it has changed
- * from its previous value, userspace must retry the whole sequence.
+ * Update the fields used for coarse clocks and, if the architected
+ * system timer is in use, the fields used for high precision clocks.
  *
  * Calls to update_vsyscall are serialized by the timekeeping core.
  */
@@ -130,8 +121,11 @@ void update_vsyscall(struct timekeeper *tk)
 	struct timespec *wtm = &tk->wall_to_monotonic;
 	bool use_syscall = strcmp(tk->clock->name, "arch_sys_counter");

-	++vdso_data->seq_count;
-	smp_wmb();
+	BUILD_BUG_ON(offsetof(struct seqcount, sequence) != 0);
+	BUILD_BUG_ON(FIELD_SIZEOF(struct vdso_data, seq) !=
+		     FIELD_SIZEOF(struct seqcount, sequence));
+
+	raw_write_seqcount_begin((seqcount_t *)&vdso_data->seq);

 	xtime_coarse = __current_kernel_time();
 	vdso_data->use_syscall			= use_syscall;
@@ -149,8 +143,7 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->cs_mask		= tk->clock->mask;
 	}

-	smp_wmb();
-	++vdso_data->seq_count;
+	raw_write_seqcount_end((seqcount_t *)&vdso_data->seq);
 	flush_dcache_page(virt_to_page(vdso_data));
 }

diff --git a/arch/arm/kernel/vdso/vgettimeofday.c
b/arch/arm/kernel/vdso/vgettimeofday.c
index d5d12528eed9..e434769817d3 100644
--- a/arch/arm/kernel/vdso/vgettimeofday.c
+++ b/arch/arm/kernel/vdso/vgettimeofday.c
@@ -10,6 +10,7 @@

 #include <linux/compiler.h>
 #include <linux/hrtimer.h>
+#include <linux/seqlock.h>
 #include <linux/time.h>
 #include <asm/arch_timer.h>
 #include <asm/barrier.h>
@@ -23,28 +24,6 @@

 extern struct vdso_data *__get_datapage(void);

-static u32 seqcnt_acquire(struct vdso_data *vdata)
-{
-	u32 seq;
-
-	do {
-		seq = vdata->seq_count;
-
-		/* Force gcc to reload from memory when spinning. */
-		asm volatile("" : : : "memory");
-	} while (seq & 1);
-
-	dmb(ish);
-	return seq;
-}
-
-static u32 seqcnt_read(struct vdso_data *vdata)
-{
-	dmb(ish);
-
-	return ACCESS_ONCE(vdata->seq_count);
-}
-
 static long clock_gettime_fallback(clockid_t _clkid, struct timespec *_ts)
 {
 	register struct timespec *ts asm("r1") = _ts;
@@ -63,15 +42,15 @@ static long clock_gettime_fallback(clockid_t _clkid,
struct timespec *_ts)

 static int do_realtime_coarse(struct timespec *ts, struct vdso_data *vdata)
 {
-	u32 seq;
+	unsigned long seq;

 	do {
-		seq = seqcnt_acquire(vdata);
+		seq = raw_read_seqcount_begin((seqcount_t *)&vdata->seq);

 		ts->tv_sec = vdata->xtime_coarse_sec;
 		ts->tv_nsec = vdata->xtime_coarse_nsec;

-	} while (seq != seqcnt_read(vdata));
+	} while (read_seqcount_retry((seqcount_t *)&vdata->seq, seq));

 	return 0;
 }
@@ -79,10 +58,10 @@ static int do_realtime_coarse(struct timespec *ts,
struct vdso_data *vdata)
 static int do_monotonic_coarse(struct timespec *ts, struct vdso_data
*vdata)
 {
 	struct timespec tomono;
-	u32 seq;
+	unsigned long seq;

 	do {
-		seq = seqcnt_acquire(vdata);
+		seq = raw_read_seqcount_begin((seqcount_t *)&vdata->seq);

 		ts->tv_sec = vdata->xtime_coarse_sec;
 		ts->tv_nsec = vdata->xtime_coarse_nsec;
@@ -90,7 +69,7 @@ static int do_monotonic_coarse(struct timespec *ts,
struct vdso_data *vdata)
 		tomono.tv_sec = vdata->wtm_clock_sec;
 		tomono.tv_nsec = vdata->wtm_clock_nsec;

-	} while (seq != seqcnt_read(vdata));
+	} while (read_seqcount_retry((seqcount_t *)&vdata->seq, seq));

 	ts->tv_sec += tomono.tv_sec;
 	timespec_add_ns(ts, tomono.tv_nsec);
@@ -119,10 +98,10 @@ static u64 get_ns(struct vdso_data *vdata)
 static int do_realtime(struct timespec *ts, struct vdso_data *vdata)
 {
 	u64 nsecs;
-	u32 seq;
+	unsigned long seq;

 	do {
-		seq = seqcnt_acquire(vdata);
+		seq = raw_read_seqcount_begin((seqcount_t *)&vdata->seq);

 		if (vdata->use_syscall)
 			return -1;
@@ -130,7 +109,7 @@ static int do_realtime(struct timespec *ts, struct
vdso_data *vdata)
 		ts->tv_sec = vdata->xtime_clock_sec;
 		nsecs = get_ns(vdata);

-	} while (seq != seqcnt_read(vdata));
+	} while (read_seqcount_retry((seqcount_t *)&vdata->seq, seq));

 	ts->tv_nsec = 0;
 	timespec_add_ns(ts, nsecs);
@@ -142,10 +121,10 @@ static int do_monotonic(struct timespec *ts,
struct vdso_data *vdata)
 {
 	struct timespec tomono;
 	u64 nsecs;
-	u32 seq;
+	unsigned long seq;

 	do {
-		seq = seqcnt_acquire(vdata);
+		seq = raw_read_seqcount_begin((seqcount_t *)&vdata->seq);

 		if (vdata->use_syscall)
 			return -1;
@@ -156,7 +135,7 @@ static int do_monotonic(struct timespec *ts, struct
vdso_data *vdata)
 		tomono.tv_sec = vdata->wtm_clock_sec;
 		tomono.tv_nsec = vdata->wtm_clock_nsec;

-	} while (seq != seqcnt_read(vdata));
+	} while (read_seqcount_retry((seqcount_t *)&vdata->seq, seq));

 	ts->tv_sec += tomono.tv_sec;
 	ts->tv_nsec = 0;
