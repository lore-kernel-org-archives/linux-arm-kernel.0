From: standby24x7@gmail.com (Masanari Iida)
Date: Tue, 11 Feb 2014 22:15:07 +0900
Subject: [PATCH] clk:at91: Fix memory leak in of_at91_clk_master_setup()
Message-ID: <1392124507-14463-1-git-send-email-standby24x7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cppcheck detected following error
[clk-master.c:245]: (error) Memory leak: characteristics

The original code forgot to free characteristics when
irq_of_parse_and_map() failed.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/clk/at91/clk-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index bd313f7..c1af80b 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -242,7 +242,7 @@ of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq)
-		return;
+		goto out_free_characteristics;
 
 	clk = at91_clk_register_master(pmc, irq, name, num_parents,
 				       parent_names, layout,
-- 
1.9.rc1
