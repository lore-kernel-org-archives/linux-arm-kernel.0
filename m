From: thomas.ab@samsung.com (thomas.ab at samsung.com)
Date: Tue,  8 Sep 2009 14:26:00 +0900
Subject: [PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
Message-ID: <1252387560-11234-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

In s3c64xx_setrate_clksrc() we used sclk->shift,
but actually need to use sclk->divider_shift to
correctly calculate the value for the divider register.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index febac19..c972d2f 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -302,8 +302,8 @@ static int s3c64xx_setrate_clksrc(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	val = __raw_readl(reg);
-	val &= ~(0xf << sclk->shift);
-	val |= (div - 1) << sclk->shift;
+	val &= ~(0xf << sclk->divider_shift);
+	val |= (div - 1) << sclk->divider_shift;
 	__raw_writel(val, reg);
 
 	return 0;
-- 
1.5.3.4
