From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Apr 2010 09:40:25 +0200
Subject: [PATCH 1/2] i.MX35: Fix arm/ahb clock calculation
In-Reply-To: <1272008426-14435-1-git-send-email-s.hauer@pengutronix.de>
References: <1272008426-14435-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1272008426-14435-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct divider for the reference clock if arm_sel is 1 is
3/4 and not 2/3. Also, the ahb clock is also affected by this divider.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 9f3e943..5c87338 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -155,7 +155,7 @@ static unsigned long get_rate_arm(void)
 
 	aad = &clk_consumer[(pdr0 >> 16) & 0xf];
 	if (aad->sel)
-		fref = fref * 2 / 3;
+		fref = fref * 3 / 4;
 
 	return fref / aad->arm;
 }
@@ -167,6 +167,8 @@ static unsigned long get_rate_ahb(struct clk *clk)
 	unsigned long fref = get_rate_mpll();
 
 	aad = &clk_consumer[(pdr0 >> 16) & 0xf];
+	if (aad->sel)
+		fref = fref * 3 / 4;
 
 	return fref / aad->ahb;
 }
-- 
1.7.0
