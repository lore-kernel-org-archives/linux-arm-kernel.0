From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 28 Aug 2017 12:32:40 +0530
Subject: [PATCH 2/3] clk: ux500: sysctrl: constify clk_ops.
In-Reply-To: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503903761-21730-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_ops are not supposed to change at runtime. All functions
working with clk_ops provided by <linux/clk-provider.h> work
with const clk_ops. So mark the non-const clk_ops as const.

Here, Function "clk_reg_sysctrl" is used to initialized clk_init_data.
clk_init_data is working with const clk_ops. So make clk_reg_sysctrl
non-const clk_ops argument as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/ux500/clk-sysctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
index 266ddea..8a4e93c 100644
--- a/drivers/clk/ux500/clk-sysctrl.c
+++ b/drivers/clk/ux500/clk-sysctrl.c
@@ -98,18 +98,18 @@ static u8 clk_sysctrl_get_parent(struct clk_hw *hw)
 	return clk->parent_index;
 }
 
-static struct clk_ops clk_sysctrl_gate_ops = {
+static const struct clk_ops clk_sysctrl_gate_ops = {
 	.prepare = clk_sysctrl_prepare,
 	.unprepare = clk_sysctrl_unprepare,
 };
 
-static struct clk_ops clk_sysctrl_gate_fixed_rate_ops = {
+static const struct clk_ops clk_sysctrl_gate_fixed_rate_ops = {
 	.prepare = clk_sysctrl_prepare,
 	.unprepare = clk_sysctrl_unprepare,
 	.recalc_rate = clk_sysctrl_recalc_rate,
 };
 
-static struct clk_ops clk_sysctrl_set_parent_ops = {
+static const struct clk_ops clk_sysctrl_set_parent_ops = {
 	.set_parent = clk_sysctrl_set_parent,
 	.get_parent = clk_sysctrl_get_parent,
 };
@@ -124,7 +124,7 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
 				unsigned long rate,
 				unsigned long enable_delay_us,
 				unsigned long flags,
-				struct clk_ops *clk_sysctrl_ops)
+				const struct clk_ops *clk_sysctrl_ops)
 {
 	struct clk_sysctrl *clk;
 	struct clk_init_data clk_sysctrl_init;
-- 
1.9.1
