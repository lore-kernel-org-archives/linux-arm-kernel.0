From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:01 +0900
Subject: [PATCH 01/18] ARM: S5PV210: Rearrange the system clock definitions
Message-ID: <1274056681-14217-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The system clock definitions are currently defined below the
peripheral clock definitions in the V210 clock code. For the V210
clock updates that follow this patch, it is required that the
system clock definitions such as the mout_apll and mout_mpll be
defined prior to the device clock definitions. This patch
re-arranges the system clock defintions for the clock updates that
follow this patch.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   54 ++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index ccccae2..a620cd8 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -31,6 +31,33 @@
 #include <plat/clock-clksrc.h>
 #include <plat/s5pv210.h>
 
+static struct clksrc_clk clk_mout_apll = {
+	.clk	= {
+		.name		= "mout_apll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_apll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_epll = {
+	.clk	= {
+		.name		= "mout_epll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_epll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_mpll = {
+	.clk = {
+		.name		= "mout_mpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_mpll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
+};
+
 static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
@@ -272,33 +299,6 @@ static struct clk init_clocks[] = {
 	},
 };
 
-static struct clksrc_clk clk_mout_apll = {
-	.clk	= {
-		.name		= "mout_apll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_apll,
-	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
-};
-
-static struct clksrc_clk clk_mout_epll = {
-	.clk	= {
-		.name		= "mout_epll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_epll,
-	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
-};
-
-static struct clksrc_clk clk_mout_mpll = {
-	.clk = {
-		.name		= "mout_mpll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_mpll,
-	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
-};
-
 static struct clk *clkset_uart_list[] = {
 	[6] = &clk_mout_mpll.clk,
 	[7] = &clk_mout_epll.clk,
-- 
1.6.2.5
