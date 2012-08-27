From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Mon, 27 Aug 2012 22:12:09 +0200
Subject: [PATCH] ARM: S3C24XX: Add .get_rate callback for "camif-upll" clock
Message-ID: <1346098329-32059-1-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing get_rate callback for the "camif-upll" clock, so frequency
of this clock is properly reported with clk_get_rate().

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/clock-s3c2440.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/clock-s3c2440.c b/arch/arm/mach-s3c24xx/clock-s3c2440.c
index cb2883d..749220f 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2440.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2440.c
@@ -87,6 +87,19 @@ static int s3c2440_camif_upll_setrate(struct clk *clk, unsigned long rate)
 	return 0;
 }

+static unsigned long s3c2440_camif_upll_getrate(struct clk *clk)
+{
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+	unsigned long camdivn =  __raw_readl(S3C2440_CAMDIVN);
+
+	if (!(camdivn & S3C2440_CAMDIVN_CAMCLK_SEL))
+		return parent_rate;
+
+	camdivn &= S3C2440_CAMDIVN_CAMCLK_MASK;
+
+	return parent_rate / (camdivn + 1) / 2;
+}
+
 /* Extra S3C2440 clocks */

 static struct clk s3c2440_clk_cam = {
@@ -99,6 +112,7 @@ static struct clk s3c2440_clk_cam_upll = {
 	.name		= "camif-upll",
 	.ops		= &(struct clk_ops) {
 		.set_rate	= s3c2440_camif_upll_setrate,
+		.get_rate	= s3c2440_camif_upll_getrate,
 		.round_rate	= s3c2440_camif_upll_round,
 	},
 };
--
1.7.4.1
