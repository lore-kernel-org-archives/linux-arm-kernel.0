From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 19:13:07 +0000
Subject: [PATCH] Fix rounding in clocks_calc_mult_shift()
Message-ID: <20101216191307.GV9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Stultz <john.stultz@linaro.org>

Russell King reports:
| On the ARM dev boards, we have a 32-bit counter running at 24MHz.  Calling
| clocks_calc_mult_shift(&mult, &shift, 24MHz, NSEC_PER_SEC, 60) gives
| us a multiplier of 2796202666 and a shift of 26.
|
| Over a large counter delta, this produces an error - lets take a count
| from 362976315 to 4280663372:
|
| (4280663372-362976315) * 2796202666 / 2^26 - (4280663372-362976315) * (1000/24)
|  => -38.91872422891230269990
|
| Can we do better?
|
| (4280663372-362976315) * 2796202667 / 2^26 - (4280663372-362976315) * (1000/24)
| 19.45936211449532822051
|
| which is about twice as good as the 2796202666 multiplier.
|
| Looking at the equivalent divisions obtained, 2796202666 / 2^26 gives
| 41.66666665673255920410ns per tick, whereas 2796202667 / 2^26 gives
| 41.66666667163372039794ns.  The actual value wanted is 1000/24 =
| 41.66666666666666666666ns.

Fix this by ensuring we round to nearest when calculating the
multiplier.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

This is the final piece for my sched_clock() patches, which is required
by the patches to operate correctly with the known-constants-at-compile-
time platforms to avoid the kernel complaining that the constants are
wrong.  The above changelog was written by me, patch was from John, and
I tweaked the spacing to match the kernel style.

 kernel/time/clocksource.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c18d7ef..df140cd 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -152,6 +152,7 @@ clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 minsec)
 	 */
 	for (sft = 32; sft > 0; sft--) {
 		tmp = (u64) to << sft;
+		tmp += from / 2;
 		do_div(tmp, from);
 		if ((tmp >> sftacc) == 0)
 			break;
-- 
1.6.2.5
