From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 10 Sep 2011 12:26:07 +0200
Subject: [PATCH] arm: mx28: fix bit operation in clock setting
Message-ID: <1315650367-3371-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reg | (1 << clk->enable_shift) always evaluates to true. Switch it
to & which makes much more sense. Same fix as 13be9f00 (ARM i.MX28: fix
bit operation) at a different location.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 633c395..63d6117 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -413,7 +413,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##dr);		\
 	reg &= ~BM_CLKCTRL_##dr##_DIV;					\
 	reg |= div << BP_CLKCTRL_##dr##_DIV;				\
-	if (reg | (1 << clk->enable_shift)) {				\
+	if (reg & (1 << clk->enable_shift)) {				\
 		pr_err("%s: clock is gated\n", __func__);		\
 		return -EINVAL;						\
 	}								\
-- 
1.7.5.4
