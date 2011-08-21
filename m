From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 22 Aug 2011 01:05:14 +0800
Subject: [PATCH 3/3] arm: mxs: disable clock-gates when setting saif-clocks
Message-ID: <1313946314-3891-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng-B29396 <B29396@freescale.com>

New divides should only be written when gates are off.

Reported-by: Dong Aisheng <b29396@freescale.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

---
BTW, i did a minus change based on wolfram's patch or the saif will
not work.

Change
+       __raw_writel(clkgate, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs##_SET); \
to
+       __raw_writel(reg & ~clkgate,
			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs##_SET); \

It seemed HW_CLKCTRL_##rs##_SET did not work well.
(i did not find HW_CLKCTRL_SAIFx_SET in spec).
---
 arch/arm/mach-mxs/clock-mx28.c        |    7 +++++--
 arch/arm/mach-mxs/regs-clkctrl-mx28.h |    2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 2a2db65..d1d119a 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -438,7 +438,7 @@ _CLK_SET_RATE1(xbus_clk, XBUS)
 static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 {									\
 	u16 div;							\
-	u32 reg;							\
+	u32 reg, clkgate;						\
 	u64 lrate;							\
 	unsigned long parent_rate;					\
 	int i;								\
@@ -455,7 +455,8 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 		return -EINVAL;						\
 									\
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
-	reg &= ~BM_CLKCTRL_##rs##_DIV;					\
+	clkgate = reg & BM_CLKCTRL_##rs##_CLKGATE;			\
+	reg &= ~(BM_CLKCTRL_##rs##_DIV | BM_CLKCTRL_##rs##_CLKGATE);	\
 	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
 									\
@@ -468,6 +469,8 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 		return -ETIMEDOUT;					\
 	}								\
 									\
+	__raw_writel(reg & ~clkgate,					\
+			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
 	return 0;							\
 }
 
diff --git a/arch/arm/mach-mxs/regs-clkctrl-mx28.h b/arch/arm/mach-mxs/regs-clkctrl-mx28.h
index 7d1b061..08749b3 100644
--- a/arch/arm/mach-mxs/regs-clkctrl-mx28.h
+++ b/arch/arm/mach-mxs/regs-clkctrl-mx28.h
@@ -285,6 +285,7 @@
 		(((v) << 0) & BM_CLKCTRL_EMI_DIV_EMI)
 
 #define HW_CLKCTRL_SAIF0	(0x00000100)
+#define HW_CLKCTRL_SAIF0_SET	(0x00000104)
 
 #define BP_CLKCTRL_SAIF0_CLKGATE	31
 #define BM_CLKCTRL_SAIF0_CLKGATE	0x80000000
@@ -296,6 +297,7 @@
 		(((v) << 0) & BM_CLKCTRL_SAIF0_DIV)
 
 #define HW_CLKCTRL_SAIF1	(0x00000110)
+#define HW_CLKCTRL_SAIF1_SET	(0x00000114)
 
 #define BP_CLKCTRL_SAIF1_CLKGATE	31
 #define BM_CLKCTRL_SAIF1_CLKGATE	0x80000000
-- 
1.7.0.4
