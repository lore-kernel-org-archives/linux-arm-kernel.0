From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:22 +0000
Subject: [S3C-CLK] ARM: SAMSUNG: Do not register set_parent call if no source
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-15-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is no source register defined, do not register a clksrc
clock with a valid .set_parent in the ops.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/clock-clksrc.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
index aaf7d5e..33c633a 100644
--- a/arch/arm/plat-samsung/clock-clksrc.c
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -86,7 +86,7 @@ static int s3c_setparent_clksrc(struct clk *clk, struct clk *parent)
 			break;
 		}
 
-	if (src_nr >= 0 && sclk->reg_src.reg) {
+	if (src_nr >= 0) {
 		clk->parent = parent;
 
 		clksrc &= ~mask;
@@ -162,6 +162,12 @@ static struct clk_ops clksrc_ops_nodiv = {
 	.set_parent	= s3c_setparent_clksrc,
 };
 
+static struct clk_ops clksrc_ops_nosrc = {
+	.get_rate	= s3c_getrate_clksrc,
+	.set_rate	= s3c_setrate_clksrc,
+	.round_rate	= s3c_roundrate_clksrc,
+};
+
 void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
 {
 	int ret;
@@ -174,6 +180,8 @@ void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
 		if (!clksrc->clk.ops) {
 			if (!clksrc->reg_div.reg)
 				clksrc->clk.ops = &clksrc_ops_nodiv;
+			else if (!clksrc->reg_src.reg)
+				clksrc->clk.ops = &clksrc_ops_nosrc;
 			else
 				clksrc->clk.ops = &clksrc_ops;
 		}
-- 
1.6.0.4
