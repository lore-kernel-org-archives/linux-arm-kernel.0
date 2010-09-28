From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Tue, 28 Sep 2010 13:44:59 +0300
Subject: [PATCH 3/4] calibrate: retry with wider bounds when converge seems to
	fail
In-Reply-To: <1285670700-11099-3-git-send-email-ext-phil.2.carmody@nokia.com>
References: <1285670700-11099-1-git-send-email-ext-phil.2.carmody@nokia.com>
	<1285670700-11099-2-git-send-email-ext-phil.2.carmody@nokia.com>
	<1285670700-11099-3-git-send-email-ext-phil.2.carmody@nokia.com>
Message-ID: <1285670700-11099-4-git-send-email-ext-phil.2.carmody@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Systems with unmaskable interrupts such as SMIs may massively underestimate
loops_per_jiffy, and fail to converge anywhere near the real value. A case
seen on x86_64 was an initial estimate of 256<<12, which converged to 511<<12
where the real value should have been over 630<<12. This admitedly requires
bypassing the TSC calibration (lpj_fine), and a failure to settle in the
direct calibration too, but is physically possible. This failure does not
depend on my previous calibration optimisation, but by luck is easy to fix
with the optimisation in place with a trivial retry loop.

In the context of the optimised converging method, as we can no longer trust
the starting estimate, enlarge the search bounds exponentially so that the
number of retries is logarithmically bounded.
---
 init/calibrate.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/init/calibrate.c b/init/calibrate.c
index 7315c9a..5a734de 100644
--- a/init/calibrate.c
+++ b/init/calibrate.c
@@ -122,7 +122,7 @@ static unsigned long __cpuinit calibrate_delay_direct(void) {return 0;}
 static unsigned long __cpuinit calibrate_delay_converge(void)
 {
 	/* First stage - slowly accelerate to find initial bounds */
-	unsigned long lpj, ticks, loopadd, chop_limit;
+	unsigned long lpj, lpj_base, ticks, loopadd, loopadd_base, chop_limit;
 	int trials = 0, band = 0, trial_in_band = 0;
 
 	lpj = (1<<12);
@@ -146,14 +146,18 @@ static unsigned long __cpuinit calibrate_delay_converge(void)
 	 * the largest likely undershoot. This defines our chop bounds.
 	 */
 	trials -= band;
-	loopadd = lpj * band;
-	lpj *= trials;
-	chop_limit = lpj >> (LPS_PREC + 1);
+	loopadd_base = lpj * band;
+	lpj_base = lpj * trials;
+
+recalibrate:
+	lpj = lpj_base;
+	loopadd = loopadd_base;
 
 	/*
 	 * Do a binary approximation to get lpj set to
 	 * equal one clock (up to LPS_PREC bits)
 	 */
+	chop_limit = lpj >> LPS_PREC;
 	while (loopadd > chop_limit) {
 		lpj += loopadd;
 		ticks = jiffies;
@@ -165,6 +169,16 @@ static unsigned long __cpuinit calibrate_delay_converge(void)
 			lpj -= loopadd;
 		loopadd >>= 1;
 	}
+	/*
+	 * If we incremented every single time possible, presume we've
+	 * massively underestimated initially, and retry with a higher 
+	 * start, and larger range. (Only seen on x86_64.)
+	 */
+	if (lpj + loopadd * 2 == lpj_base + loopadd_base * 2) {
+		lpj_base = lpj;
+		loopadd_base <<= 2;
+		goto recalibrate;
+	}
 
 	return lpj;
 }
-- 
1.7.2.rc1.37.gf8c40
