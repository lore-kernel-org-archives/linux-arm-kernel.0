From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:16 +0900
Subject: [PATCH 06/14] ARM: S5PV310: Should be clk_sclk_apll not clk_mout_apll
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds clk_sclk_apll so that fixes on clk_mout_apll.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 892259b..8ffda6e 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -55,6 +55,14 @@ static struct clksrc_clk clk_mout_apll = {
 	},
 	.sources	= &clk_src_apll,
 	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
+};
+
+static struct clksrc_clk clk_sclk_apll = {
+	.clk	= {
+		.name		= "sclk_apll",
+		.id		= -1,
+		.parent		= &clk_mout_apll.clk,
+	},
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
 };
 
@@ -77,7 +85,7 @@ static struct clksrc_clk clk_mout_mpll = {
 };
 
 static struct clk *clkset_moutcore_list[] = {
-	[0] = &clk_mout_apll.clk,
+	[0] = &clk_sclk_apll.clk,
 	[1] = &clk_mout_mpll.clk,
 };
 
@@ -116,7 +124,7 @@ static struct clksrc_clk clk_armclk = {
 
 static struct clk *clkset_corebus_list[] = {
 	[0] = &clk_mout_mpll.clk,
-	[1] = &clk_mout_apll.clk,
+	[1] = &clk_sclk_apll.clk,
 };
 
 static struct clksrc_sources clkset_mout_corebus = {
@@ -146,7 +154,7 @@ static struct clksrc_clk clk_sclk_dmc = {
 
 static struct clk *clkset_aclk_top_list[] = {
 	[0] = &clk_mout_mpll.clk,
-	[1] = &clk_mout_apll.clk,
+	[1] = &clk_sclk_apll.clk,
 };
 
 static struct clksrc_sources clkset_aclk = {
@@ -325,6 +333,7 @@ static struct clksrc_clk clksrcs[] = {
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
+	&clk_sclk_apll,
 	&clk_mout_epll,
 	&clk_mout_mpll,
 	&clk_moutcore,
-- 
1.6.2.5
