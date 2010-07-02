From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 2 Jul 2010 14:05:03 -0400
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
In-Reply-To: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
References: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100702180503.GF2357@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 01:44:02PM +0100, Will Deacon wrote:
> Hardware performance counters on ARM are 32-bits wide but
> atomic64_t variables are used to represent counter data
> in the hw_perf_event structure.
> 
> The armpmu_event_update function right-shifts a signed
> 64-bit delta variable and adds the result to the event count.
> This can lead to shifting in sign-bits if the MSB of the
> 32-bit counter value is set. This results in perf output such as:
> 
>  Performance counter stats for 'sleep 20':
> 
>  18446744073460670464  cycles             <-- 0xFFFFFFFFF12A6000
>         7783773  instructions             #      0.000 IPC
>             465  context-switches
>             161  page-faults
>         1172393  branches
>    20.154242147  seconds time elapsed
> 
> This patch ensures that only the bottom 32 bits of the delta
> value are used.
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
Hi Will,

Well spotted! I think this may have actually been a typo when porting to ARM
from the sparc and x86 code, and this should address it so we do the same:

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 9e70f20..6c0f3ca 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -164,7 +164,7 @@ armpmu_event_update(struct perf_event *event,
 		    int idx)
 {
 	int shift = 64 - 32;
-	s64 prev_raw_count, new_raw_count;
+	u64 prev_raw_count, new_raw_count;
 	s64 delta;
 
 again:

This way we can cope with negative deltas if we ever need to.

Jamie
