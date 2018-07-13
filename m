From: micpof@gmail.com (Michael O'Farrell)
Date: Fri, 13 Jul 2018 12:24:51 -0700
Subject: [PATCH] Add cap_user_time aarch64
Message-ID: <20180713192451.49280-1-micpof@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useful to get the running time of a thread.  Doing so in an
efficient manner can be important for performance of user applications.
Avoiding system calls in `clock_gettime` when handling
CLOCK_THREAD_CPUTIME_ID is important.  Other clocks are handled in the
VDSO, but CLOCK_THREAD_CPUTIME_ID falls back on the system call.

CLOCK_THREAD_CPUTIME_ID is not handled in the VDSO since it would have
costs associated with maintaining updated user space accessible time
offsets.  These offsets have to be updated everytime the a thread is
scheduled/descheduled.  However, for programs regularly checking the
running time of a thread, this is a performance improvement.

This patch takes a middle ground, and adds support for cap_user_time an
optional feature of the perf_event API.  This way costs are only
incurred when the perf_event api is enabled.  This is done the same way
as it is in x86.  This patch also enables the cap_user_time facility of
perf_event since it comes free with the stable clock.

Ultimately this allows calculating the thread running time in userspace
on aarch64 as follows (adapted from perf_event_open manpage):

u32 seq, time_mult, time_shift;
u64 running, count, time_offset, quot, rem, delta;
struct perf_event_mmap_page *pc;
pc = buf;  // buf is the perf event mmaped page as documented in the API.

if (pc->cap_usr_time) {
    do {
        seq = pc->lock;
        barrier();
        running = pc->time_running;

        count = readCNTVCT_EL0();  // Read ARM hardware clock.
        time_offset = pc->time_offset;
        time_mult   = pc->time_mult;
        time_shift  = pc->time_shift;

        barrier();
    } while (pc->lock != seq);

    quot = (count >> time_shift);
    rem = count & (((u64)1 << time_shift) - 1);
    delta = time_offset + quot * time_mult +
            ((rem * time_mult) >> time_shift);

    running += delta;
    // running now has the current nanosecond level thread time.
}

Summary of changes in the patch:

For aarch64 systems with a stable scheduler clock, make
arch_perf_update_userpage update the timing information stored in the
perf_event page.  Requiring the following calculations:
  - Calculate the appropriate time_mult, and time_shift factors to convert
    ticks to nano seconds for the current clock frequency.
  - Adjust the mult and shift factors to avoid shift factors of 32 bits.
    (possibly unnecessary)
  - The time_offset userspace should apply when doing calculations:
    negative the current sched time (now), because time_running and
    time_enabled fields of the perf_event page have just been updated.
  - The time_zero field is zero since we have are using the stable
    sched_clock, and it started at zero.
Toggle bits to appropriate values:
  - Enable cap_user_time
  - Enable cap_user_time_zero.  Since the sched clock is stable, and
    it started at zero this is able to be true

Signed-off-by: Michael O'Farrell <micpof@gmail.com>
---
 arch/arm64/kernel/perf_event.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 33147aacdafd..c63f31caf7ac 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -25,6 +25,7 @@
 #include <asm/virt.h>
 
 #include <linux/acpi.h>
+#include <linux/clocksource.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
@@ -1127,3 +1128,41 @@ static int __init armv8_pmu_driver_init(void)
 		return arm_pmu_acpi_probe(armv8_pmuv3_init);
 }
 device_initcall(armv8_pmu_driver_init)
+
+#ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+void arch_perf_update_userpage(struct perf_event *event,
+			       struct perf_event_mmap_page *userpg, u64 now)
+{
+	u32 freq;
+	u32 shift;
+
+	/*
+	 * Internal timekeeping for enabled/running/stopped times
+	 * is always computed with the sched_clock.
+	 */
+	freq = arch_timer_get_rate();
+	userpg->cap_user_time = 1;
+
+	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
+			NSEC_PER_SEC, 0);
+	/*
+	 * time_shift is not expected to be greater than 31 due to
+	 * the original published conversion algorithm shifting a
+	 * 32-bit value (now specifies a 64-bit value) - refer
+	 * perf_event_mmap_page documentation in perf_event.h.
+	 */
+	if (shift == 32) {
+		shift = 31;
+		userpg->time_mult >>= 1;
+	}
+	userpg->time_shift = (u16)shift;
+	userpg->time_offset = -now;
+
+	/*
+	 * We are always using the sched_clock as the base, so
+	 * cap_user_time_zero makes sense.
+	 */
+	userpg->cap_user_time_zero = 1;
+	userpg->time_zero = 0;
+}
+#endif /* !CONFIG_HAVE_UNSTABLE_SCHED_CLOCK */
-- 
2.17.1
