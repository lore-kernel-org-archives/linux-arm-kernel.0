From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:43 +0000
Subject: [PATCH 12/35] mfd: ab8500-debug: Better error handling on crash
In-Reply-To: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360933026-30325-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Stop trying to read i2c registers if one fail.

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Mattias WALLIN <mattias.wallin@stericsson.com>
---
 drivers/mfd/ab8500-debugfs.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 250b77b..8b15fc2 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -607,7 +607,6 @@ struct ab8500_register_dump
 	u8 bank;
 	u8 reg;
 	u8 value;
-	int ret;
 } ab8500_complete_register_dump[DUMP_MAX_REGS];
 
 extern int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
@@ -617,6 +616,7 @@ void ab8500_dump_all_banks_to_mem(void)
 {
 	int i, r = 0;
 	u8 bank;
+	int err = 0;
 
 	pr_info("Saving all ABB registers at \"ab8500_complete_register_dump\" "
 		"for crash analyze.\n");
@@ -629,11 +629,12 @@ void ab8500_dump_all_banks_to_mem(void)
 			     reg <= debug_ranges[bank].range[i].last;
 			     reg++) {
 				u8 value;
-				int err;
 
 				err = prcmu_abb_read(bank, reg, &value, 1);
 
-				ab8500_complete_register_dump[r].ret = err;
+				if (err < 0)
+					goto out;
+
 				ab8500_complete_register_dump[r].bank = bank;
 				ab8500_complete_register_dump[r].reg = reg;
 				ab8500_complete_register_dump[r].value = value;
@@ -643,11 +644,17 @@ void ab8500_dump_all_banks_to_mem(void)
 				if (r >= DUMP_MAX_REGS) {
 					pr_err("%s: too many register to dump!\n",
 						__func__);
-					return;
+					err = -EINVAL;
+					goto out;
 				}
 			}
 		}
 	}
+out:
+	if (err >= 0)
+		pr_info("Saved all ABB registers.\n");
+	else
+		pr_info("Failed to save all ABB registers.\n");
 }
 
 static int ab8500_all_banks_open(struct inode *inode, struct file *file)
-- 
1.7.10.4
