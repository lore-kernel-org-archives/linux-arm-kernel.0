From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Jan 2011 11:57:52 +0100
Subject: [PATCH 1/3] ARM i.MX28: fix bit operation
In-Reply-To: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
References: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1295607474-6559-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reg | (1 << clk->enable_shift) always evaluates to true. Switch it
to & which makes much more sense

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 56312c0..4146b38 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -355,7 +355,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	} else {							\
 		reg &= ~BM_CLKCTRL_##dr##_DIV;				\
 		reg |= div << BP_CLKCTRL_##dr##_DIV;			\
-		if (reg | (1 << clk->enable_shift)) {			\
+		if (reg & (1 << clk->enable_shift)) {			\
 			pr_err("%s: clock is gated\n", __func__);	\
 			return -EINVAL;					\
 		}							\
-- 
1.7.2.3
