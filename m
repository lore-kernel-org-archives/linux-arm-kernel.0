From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 19:33:11 +0100
Subject: [PATCH] clk: samsung: Initialize clock table with error pointers
Message-ID: <1391711591-19416-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before this patch, the driver was simply zeroing the clock table, which
is incorrect, because invalid clock numbers returned NULL instead of
error pointers. This patch fixes this by changing the driver to
initialize the array with PTR_ERR(-ENOENT).

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 91bec3e..f3a71d0 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -58,12 +58,17 @@ struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
 void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 			     unsigned long nr_clks)
 {
+	int i;
+
 	reg_base = base;
 
-	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	clk_table = kmalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
 	if (!clk_table)
 		panic("could not allocate clock lookup table\n");
 
+	for (i = 0; i < nr_clks; ++i)
+		clk_table[i] = ERR_PTR(-ENOENT);
+
 	if (!np)
 		return;
 
-- 
1.8.5.2
