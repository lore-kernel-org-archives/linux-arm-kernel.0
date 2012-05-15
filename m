From: marex@denx.de (Marek Vasut)
Date: Tue, 15 May 2012 10:23:32 +0200
Subject: [PATCH 1/8] MXS: Make clk_disable return integer
In-Reply-To: <1337070219-3630-1-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
Message-ID: <1337070219-3630-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows subsequent USB clock patch to interchange enable() and disable()
calls without adding unnecessary switching cruft.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/mach-mxs/clock-mx28.c         |    7 +++++--
 arch/arm/mach-mxs/include/mach/clock.h |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index cea29c9..43116ba 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -86,7 +86,7 @@ static int _raw_clk_enable(struct clk *clk)
 	return 0;
 }
 
-static void _raw_clk_disable(struct clk *clk)
+static int _raw_clk_disable(struct clk *clk)
 {
 	u32 reg;
 
@@ -95,6 +95,8 @@ static void _raw_clk_disable(struct clk *clk)
 		reg |= 1 << clk->enable_shift;
 		__raw_writel(reg, clk->enable_reg);
 	}
+
+	return 0;
 }
 
 /*
@@ -149,7 +151,7 @@ _CLK_ENABLE_PLL(pll1_clk, PLL1, EN_USB_CLKS)
 _CLK_ENABLE_PLL(pll2_clk, PLL2, CLKGATE)
 
 #define _CLK_DISABLE_PLL(name, r, g)					\
-static void name##_disable(struct clk *clk)				\
+static int name##_disable(struct clk *clk)				\
 {									\
 	__raw_writel(BM_CLKCTRL_##r##CTRL0_POWER,			\
 		     CLKCTRL_BASE_ADDR + HW_CLKCTRL_##r##CTRL0_CLR);	\
@@ -161,6 +163,7 @@ static void name##_disable(struct clk *clk)				\
 		__raw_writel(BM_CLKCTRL_##r##CTRL0_##g,			\
 			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##r##CTRL0_CLR);	\
 									\
+	return 0;							\
 }
 
 _CLK_DISABLE_PLL(pll0_clk, PLL0, EN_USB_CLKS)
diff --git a/arch/arm/mach-mxs/include/mach/clock.h b/arch/arm/mach-mxs/include/mach/clock.h
index 592c9ab..21d1fad 100644
--- a/arch/arm/mach-mxs/include/mach/clock.h
+++ b/arch/arm/mach-mxs/include/mach/clock.h
@@ -50,7 +50,7 @@ struct clk {
 	int (*enable) (struct clk *);
 	/* Function ptr to disable the clock. Leave blank if clock can not
 	   be gated. */
-	void (*disable) (struct clk *);
+	int (*disable) (struct clk *);
 	/* Function ptr to set the parent clock of the clock. */
 	int (*set_parent) (struct clk *, struct clk *);
 };
-- 
1.7.10
