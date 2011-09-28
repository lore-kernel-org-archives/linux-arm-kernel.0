From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:21:37 +0200
Subject: [PATCH 5/8] S3C2443: Add get_rate operation for clk_armdiv
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281221.37568.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/s3c2443-clock.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index f9c5b03..fea3d5c 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -189,6 +189,19 @@ static unsigned long s3c2443_armclk_roundrate(struct clk *clk,
 	return parent / best;
 }
 
+static unsigned long s3c2443_armclk_getrate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned long clkcon0;
+	int val;
+
+	clkcon0 = __raw_readl(S3C2443_CLKDIV0);
+	clkcon0 &= armdivmask;
+	val = clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT;
+
+	return rate / armdiv[val];
+}
+
 static int s3c2443_armclk_setrate(struct clk *clk, unsigned long rate)
 {
 	unsigned long parent = clk_get_rate(clk->parent);
@@ -224,6 +237,7 @@ static struct clk clk_armdiv = {
 	.parent		= &clk_msysclk.clk,
 	.ops		= &(struct clk_ops) {
 		.round_rate = s3c2443_armclk_roundrate,
+		.get_rate = s3c2443_armclk_getrate,
 		.set_rate = s3c2443_armclk_setrate,
 	},
 };
-- 
1.7.5.4
