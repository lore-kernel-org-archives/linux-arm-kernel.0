From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:22:16 +0200
Subject: [PATCH 6/8] S3C2443: handle unset armdiv values gracefully
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281222.17432.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armdiv array may contain unset divider values. Check the
relevant value to prevent division by zero errors.
Also check for set nr_armdiv and armdivmask before
meddling with clkdiv0.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/s3c2443-clock.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index fea3d5c..31f97f1 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -179,11 +179,16 @@ static unsigned long s3c2443_armclk_roundrate(struct clk *clk,
 	unsigned div;
 	int ptr;
 
+	if (!nr_armdiv)
+		return -EINVAL;
+
 	for (ptr = 0; ptr < nr_armdiv; ptr++) {
 		div = armdiv[ptr];
-		calc = parent / div;
-		if (calc <= rate && div < best)
-			best = div;
+		if (div) {
+			calc = parent / div;
+			if (calc <= rate && div < best)
+				best = div;
+		}
 	}
 
 	return parent / best;
@@ -195,6 +200,9 @@ static unsigned long s3c2443_armclk_getrate(struct clk *clk)
 	unsigned long clkcon0;
 	int val;
 
+	if (!nr_armdiv || !armdivmask)
+		return -EINVAL;
+
 	clkcon0 = __raw_readl(S3C2443_CLKDIV0);
 	clkcon0 &= armdivmask;
 	val = clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT;
@@ -211,12 +219,17 @@ static int s3c2443_armclk_setrate(struct clk *clk, unsigned long rate)
 	int ptr;
 	int val = -1;
 
+	if (!nr_armdiv || !armdivmask)
+		return -EINVAL;
+
 	for (ptr = 0; ptr < nr_armdiv; ptr++) {
 		div = armdiv[ptr];
-		calc = parent / div;
-		if (calc <= rate && div < best) {
-			best = div;
-			val = ptr;
+		if (div) {
+			calc = parent / div;
+			if (calc <= rate && div < best) {
+				best = div;
+				val = ptr;
+			}
 		}
 	}
 
-- 
1.7.5.4
