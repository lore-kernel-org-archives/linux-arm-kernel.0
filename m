From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Mon, 16 Aug 2010 15:54:06 +0200
Subject: [PATCH|RESEND 3/4] clock-imx35: correct arm and ahb clock calculation
In-Reply-To: <1281966847-553-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1281966847-553-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1281966847-553-4-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

According to the Datasheet:
"i.MX35 (MCIMX35) Multimedia Applications Processor Reference Manual,
Rev. 2" "Figure 14-24. Clock Control And Gating"
change the result of get_rate_ahb based on the frequency returned
by get_rate_arm to calculate the proper rate.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index f54a82c..009156d 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -155,7 +155,7 @@ static unsigned long get_rate_arm(void)
 
 	aad = &clk_consumer[(pdr0 >> 16) & 0xf];
 	if (aad->sel)
-		fref = fref * 2 / 3;
+		fref = fref * 3 / 4;
 
 	return fref / aad->arm;
 }
@@ -164,7 +164,7 @@ static unsigned long get_rate_ahb(struct clk *clk)
 {
 	unsigned long pdr0 = __raw_readl(CCM_BASE + CCM_PDR0);
 	struct arm_ahb_div *aad;
-	unsigned long fref = get_rate_mpll();
+	unsigned long fref = get_rate_arm();
 
 	aad = &clk_consumer[(pdr0 >> 16) & 0xf];
 
-- 
1.7.1
