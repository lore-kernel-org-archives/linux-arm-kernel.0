From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 Jul 2010 13:44:02 +0100
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
Message-ID: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware performance counters on ARM are 32-bits wide but
atomic64_t variables are used to represent counter data
in the hw_perf_event structure.

The armpmu_event_update function right-shifts a signed
64-bit delta variable and adds the result to the event count.
This can lead to shifting in sign-bits if the MSB of the
32-bit counter value is set. This results in perf output such as:

 Performance counter stats for 'sleep 20':

 18446744073460670464  cycles             <-- 0xFFFFFFFFF12A6000
        7783773  instructions             #      0.000 IPC
            465  context-switches
            161  page-faults
        1172393  branches

   20.154242147  seconds time elapsed

This patch ensures that only the bottom 32 bits of the delta
value are used.

Cc: Jamie Iles <jamie.iles@picochip.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index c457686..c7f7a14 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -199,9 +199,7 @@ armpmu_event_update(struct perf_event *event,
 		    struct hw_perf_event *hwc,
 		    int idx)
 {
-	int shift = 64 - 32;
-	s64 prev_raw_count, new_raw_count;
-	s64 delta;
+	s64 prev_raw_count, new_raw_count, delta;
 
 again:
 	prev_raw_count = atomic64_read(&hwc->prev_count);
@@ -211,8 +209,7 @@ again:
 			     new_raw_count) != prev_raw_count)
 		goto again;
 
-	delta = (new_raw_count << shift) - (prev_raw_count << shift);
-	delta >>= shift;
+	delta = (new_raw_count - prev_raw_count) & 0xffffffff;
 
 	atomic64_add(delta, &event->count);
 	atomic64_sub(delta, &hwc->period_left);
-- 
1.6.3.3
