From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  2 Sep 2014 17:27:51 +0200
Subject: [PATCH] clk: at91: fix num_parents test in at91sam9260 slow clk
 implementation
Message-ID: <1409671671-13544-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The slow clk block provided by at91sam9260 and derived SoCs should always
have 2 parents.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---

Hello Mike,

Could you take this fix for the next 3.17 rc ?
Without this fix you won't be able to use programmable clks (the slow
clk is one of the parents of prog clks), and these prog clks are used,
among other things, to provide clks to external audio chips.

No need to backport this fix to previous stable releases, as CCF support
for at91sam9260 (and derived) SoCs only appeared in 3.17.

Best Regards,

Boris

 drivers/clk/at91/clk-slow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 0300c46..32f7c1b 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -447,7 +447,7 @@ void __init of_at91sam9260_clk_slow_setup(struct device_node *np,
 	int i;
 
 	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
-	if (num_parents <= 0 || num_parents > 1)
+	if (num_parents != 2)
 		return;
 
 	for (i = 0; i < num_parents; ++i) {
-- 
1.9.1
