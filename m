From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 08:42:53 +0000
Subject: [PATCH] ARM: S5PC1XX: Register pd0 and hd0 clocks,
	remove unecessary dummy_enable
In-Reply-To: <1263804176-8417-1-git-send-email-ben-linux@fluff.org>
References: <1263804176-8417-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263804176-8417-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_hd0 and clk_pd0 where given a local dummy_enable call due to
not being registered with the clock code, which they really should have
been. Register these two clocks and remove the clk_dummy_enable as this
is done by the default clock registration code.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s5pc1xx/clock.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/plat-s5pc1xx/clock.c
index aec0305..387f231 100644
--- a/arch/arm/plat-s5pc1xx/clock.c
+++ b/arch/arm/plat-s5pc1xx/clock.c
@@ -64,18 +64,12 @@ struct clk clk_54m = {
 	.rate		= 54000000,
 };
 
-static int clk_dummy_enable(struct clk *clk, int enable)
-{
-	return 0;
-}
-
 struct clk clk_hd0 = {
 	.name		= "hclkd0",
 	.id		= -1,
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
-	.enable		= clk_dummy_enable,
 	.ops		= &clk_ops_def_setrate,
 };
 
@@ -86,7 +80,6 @@ struct clk clk_pd0 = {
 	.parent		= NULL,
 	.ctrlbit	= 0,
 	.ops		= &clk_ops_def_setrate,
-	.enable		= clk_dummy_enable,
 };
 
 static int s5pc1xx_clk_gate(void __iomem *reg, struct clk *clk, int enable)
@@ -680,6 +673,8 @@ static struct clk s5pc100_init_clocks[] = {
 static struct clk *clks[] __initdata = {
 	&clk_ext,
 	&clk_epll,
+	&clk_pd0,
+	&clk_hd0,
 	&clk_27m,
 	&clk_48m,
 	&clk_54m,
-- 
1.6.0.4
