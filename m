From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:22:58 +0200
Subject: [PATCH 7/8] S3C2443: Accommodate cpufreq frequency scheme in armdiv
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281222.58738.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cpufreq uses frequencies in kHz and not Hz, so set_rate and round_rate
would be called with a frequency of 266666000 instead of 266666666 but
the clock functions check for rates smaller or equal to the targetrate.

As the armdiv does not support steps this small we can accommodate
this by simply also setting the last 3 digits of the calculated rate
to zero.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/s3c2443-clock.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 31f97f1..40a8720 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -185,7 +185,8 @@ static unsigned long s3c2443_armclk_roundrate(struct clk *clk,
 	for (ptr = 0; ptr < nr_armdiv; ptr++) {
 		div = armdiv[ptr];
 		if (div) {
-			calc = parent / div;
+			/* cpufreq provides 266mhz as 266666000 not 266666666 */
+			calc = (parent / div / 1000) * 1000;
 			if (calc <= rate && div < best)
 				best = div;
 		}
@@ -225,7 +226,8 @@ static int s3c2443_armclk_setrate(struct clk *clk, unsigned long rate)
 	for (ptr = 0; ptr < nr_armdiv; ptr++) {
 		div = armdiv[ptr];
 		if (div) {
-			calc = parent / div;
+			/* cpufreq provides 266mhz as 266666000 not 266666666 */
+			calc = (parent / div / 1000) * 1000;
 			if (calc <= rate && div < best) {
 				best = div;
 				val = ptr;
-- 
1.7.5.4
