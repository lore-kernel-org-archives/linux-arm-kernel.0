From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 21 Nov 2014 16:24:26 +0000
Subject: [PATCH v2 1/2] arm: perf: Prevent wraparound during overflow
In-Reply-To: <1416587067-3220-1-git-send-email-daniel.thompson@linaro.org>
References: <1416412346-8759-1-git-send-email-daniel.thompson@linaro.org>
 <1416587067-3220-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1416587067-3220-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the overflow threshold for a counter is set above or near the
0xffffffff boundary then the kernel may lose track of the overflow
causing only events that occur *after* the overflow to be recorded.
Specifically the problem occurs when the value of the performance counter
overtakes its original programmed value due to wrap around.

Typical solutions to this problem are either to avoid programming in
values likely to be overtaken or to treat the overflow bit as the 33rd
bit of the counter.

Its somewhat fiddly to refactor the code to correctly handle the 33rd bit
during irqsave sections (context switches for example) so instead we take
the simpler approach of avoiding values likely to be overtaken.

We set the limit to half of max_period because this matches the limit
imposed in __hw_perf_event_init(). This causes a doubling of the interrupt
rate for large threshold values, however even with a very fast counter
ticking at 4GHz the interrupt rate would only be ~1Hz.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/kernel/perf_event.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 266cba46db3e..ab68833c1e31 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -115,8 +115,14 @@ int armpmu_event_set_period(struct perf_event *event)
 		ret = 1;
 	}
 
-	if (left > (s64)armpmu->max_period)
-		left = armpmu->max_period;
+	/*
+	 * Limit the maximum period to prevent the counter value
+	 * from overtaking the one we are about to program. In
+	 * effect we are reducing max_period to account for
+	 * interrupt latency (and we are being very conservative).
+	 */
+	if (left > (armpmu->max_period >> 1))
+		left = armpmu->max_period >> 1;
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
-- 
1.9.3
