From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Sat, 24 Sep 2016 13:36:53 +0800
Subject: [PATCH 2/2] mfd: ab8500-debugfs: remove unused function
Message-ID: <1474695413-30460-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 1 warning when building kernel with W=1:
drivers/mfd/ab8500-debugfs.c:1395:6: warning: no previous prototype for 'ab8500_dump_all_banks_to_mem' [-Wmissing-prototypes]

In fact, this function is called by no one and not exported,
so this patch removes it.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c | 54 --------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 0aecd7b..9f04a25 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1382,60 +1382,6 @@ void ab8500_dump_all_banks(struct device *dev)
 	}
 }
 
-/* Space for 500 registers. */
-#define DUMP_MAX_REGS 700
-static struct ab8500_register_dump
-{
-	u8 bank;
-	u8 reg;
-	u8 value;
-} ab8500_complete_register_dump[DUMP_MAX_REGS];
-
-/* This shall only be called upon kernel panic! */
-void ab8500_dump_all_banks_to_mem(void)
-{
-	int i, r = 0;
-	u8 bank;
-	int err = 0;
-
-	pr_info("Saving all ABB registers for crash analysis.\n");
-
-	for (bank = 0; bank < AB8500_NUM_BANKS; bank++) {
-		for (i = 0; i < debug_ranges[bank].num_ranges; i++) {
-			u8 reg;
-
-			for (reg = debug_ranges[bank].range[i].first;
-			     reg <= debug_ranges[bank].range[i].last;
-			     reg++) {
-				u8 value;
-
-				err = prcmu_abb_read(bank, reg, &value, 1);
-
-				if (err < 0)
-					goto out;
-
-				ab8500_complete_register_dump[r].bank = bank;
-				ab8500_complete_register_dump[r].reg = reg;
-				ab8500_complete_register_dump[r].value = value;
-
-				r++;
-
-				if (r >= DUMP_MAX_REGS) {
-					pr_err("%s: too many register to dump!\n",
-						__func__);
-					err = -EINVAL;
-					goto out;
-				}
-			}
-		}
-	}
-out:
-	if (err >= 0)
-		pr_info("Saved all ABB registers.\n");
-	else
-		pr_info("Failed to save all ABB registers.\n");
-}
-
 static int ab8500_all_banks_open(struct inode *inode, struct file *file)
 {
 	struct seq_file *s;
-- 
2.7.4
