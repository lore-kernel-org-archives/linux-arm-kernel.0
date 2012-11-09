From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:32:13 +0900
Subject: [PATCH 2/2] ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
In-Reply-To: <1352446333-20082-1-git-send-email-horms@verge.net.au>
References: <1352446333-20082-1-git-send-email-horms@verge.net.au>
Message-ID: <1352446333-20082-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

FSI's external clock is controled by FSI driver.
Global sh7372_fsiXck_clk is no-longer needed now.

But it needs to set external clock rate by platform,
so, this patch supports clk_get() interface.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c        |   18 ++++++++++--------
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 --
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index fbd1863..3ca6757 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -295,10 +295,10 @@ struct clk sh7372_pllc2_clk = {
 };
 
 /* External input clock (pin name: FSIACK/FSIBCK ) */
-struct clk sh7372_fsiack_clk = {
+static struct clk fsiack_clk = {
 };
 
-struct clk sh7372_fsibck_clk = {
+static struct clk fsibck_clk = {
 };
 
 static struct clk *main_clks[] = {
@@ -314,8 +314,8 @@ static struct clk *main_clks[] = {
 	&pllc1_clk,
 	&pllc1_div2_clk,
 	&sh7372_pllc2_clk,
-	&sh7372_fsiack_clk,
-	&sh7372_fsibck_clk,
+	&fsiack_clk,
+	&fsibck_clk,
 };
 
 static void div4_kick(struct clk *clk)
@@ -399,14 +399,14 @@ static struct clk *hdmi_parent[] = {
 static struct clk *fsiackcr_parent[] = {
 	[0] = &pllc1_div2_clk,
 	[1] = &sh7372_pllc2_clk,
-	[2] = &sh7372_fsiack_clk, /* external input for FSI A */
+	[2] = &fsiack_clk, /* external input for FSI A */
 	[3] = NULL,	/* setting prohibited */
 };
 
 static struct clk *fsibckcr_parent[] = {
 	[0] = &pllc1_div2_clk,
 	[1] = &sh7372_pllc2_clk,
-	[2] = &sh7372_fsibck_clk, /* external input for FSI B */
+	[2] = &fsibck_clk, /* external input for FSI B */
 	[3] = NULL,	/* setting prohibited */
 };
 
@@ -507,6 +507,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pllc1_clk", &pllc1_clk),
 	CLKDEV_CON_ID("pllc1_div2_clk", &pllc1_div2_clk),
 	CLKDEV_CON_ID("pllc2_clk", &sh7372_pllc2_clk),
+	CLKDEV_CON_ID("fsiack", &fsiack_clk),
+	CLKDEV_CON_ID("fsibck", &fsibck_clk),
 
 	/* DIV4 clocks */
 	CLKDEV_CON_ID("i_clk", &div4_clks[DIV4_I]),
@@ -604,8 +606,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("spu2", "sh_fsi2", &mstp_clks[MSTP223]),
 	CLKDEV_ICK_ID("diva", "sh_fsi2", &fsidivs[FSIDIV_A]),
 	CLKDEV_ICK_ID("divb", "sh_fsi2", &fsidivs[FSIDIV_B]),
-	CLKDEV_ICK_ID("xcka", "sh_fsi2", &sh7372_fsiack_clk),
-	CLKDEV_ICK_ID("xckb", "sh_fsi2", &sh7372_fsibck_clk),
+	CLKDEV_ICK_ID("xcka", "sh_fsi2", &fsiack_clk),
+	CLKDEV_ICK_ID("xckb", "sh_fsi2", &fsibck_clk),
 };
 
 void __init sh7372_clock_init(void)
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 26cd101..b582fac 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -477,8 +477,6 @@ extern struct clk sh7372_extal2_clk;
 extern struct clk sh7372_dv_clki_clk;
 extern struct clk sh7372_dv_clki_div2_clk;
 extern struct clk sh7372_pllc2_clk;
-extern struct clk sh7372_fsiack_clk;
-extern struct clk sh7372_fsibck_clk;
 
 extern void sh7372_intcs_suspend(void);
 extern void sh7372_intcs_resume(void);
-- 
1.7.10.4
