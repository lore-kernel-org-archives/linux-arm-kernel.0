From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 28 Aug 2017 12:32:41 +0530
Subject: [PATCH 3/3] clk: ux500: prcc: constify clk_ops.
In-Reply-To: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503903761-21730-4-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_ops are not supposed to change at runtime. All functions
working with clk_ops provided by <linux/clk-provider.h> work
with const clk_ops. So mark the non-const clk_ops as const.

Here, Function "clk_reg_prcc" is used to initialized clk_init_data.
clk_init_data is working with const clk_ops. So make clk_reg_prcc
non-const clk_ops argument as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/ux500/clk-prcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index 0e95076..f505927 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -79,13 +79,13 @@ static int clk_prcc_is_enabled(struct clk_hw *hw)
 	return clk->is_enabled;
 }
 
-static struct clk_ops clk_prcc_pclk_ops = {
+static const struct clk_ops clk_prcc_pclk_ops = {
 	.enable = clk_prcc_pclk_enable,
 	.disable = clk_prcc_pclk_disable,
 	.is_enabled = clk_prcc_is_enabled,
 };
 
-static struct clk_ops clk_prcc_kclk_ops = {
+static const struct clk_ops clk_prcc_kclk_ops = {
 	.enable = clk_prcc_kclk_enable,
 	.disable = clk_prcc_kclk_disable,
 	.is_enabled = clk_prcc_is_enabled,
@@ -96,7 +96,7 @@ static struct clk *clk_reg_prcc(const char *name,
 				resource_size_t phy_base,
 				u32 cg_sel,
 				unsigned long flags,
-				struct clk_ops *clk_prcc_ops)
+				const struct clk_ops *clk_prcc_ops)
 {
 	struct clk_prcc *clk;
 	struct clk_init_data clk_prcc_init;
-- 
1.9.1
