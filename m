From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:58 +0000
Subject: [PATCH 18/26] mfd: ab8500-core: Allow the possibility to dump all
 AB8500 registers
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>

Implement an API so that a user may dump all AB8500 registers
via debugfs file access.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
Reviewed-by: Linus WALLEIJ <linus.walleij@stericsson.com>
Reviewed-by: Jonas ABERG <jonas.aberg@stericsson.com>
---
 drivers/mfd/ab8500-core.c         |    1 +
 drivers/mfd/ab8500-debugfs.c      |   13 +++++++++++++
 include/linux/mfd/abx500/ab8500.h |    6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 1667c77..0f84fc0 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -319,6 +319,7 @@ static struct abx500_ops ab8500_ops = {
 	.mask_and_set_register = ab8500_mask_and_set_register,
 	.event_registers_startup_state_get = NULL,
 	.startup_irq_enabled = NULL,
+	.dump_all_banks = ab8500_dump_all_banks,
 };
 
 static void ab8500_irq_lock(struct irq_data *data)
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index a1ce55e..ec57e43 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -581,6 +581,19 @@ static int ab8500_print_all_banks(struct seq_file *s, void *p)
 	return 0;
 }
 
+/* Dump registers to kernel log */
+void ab8500_dump_all_banks(struct device *dev)
+{
+	unsigned int i;
+
+	printk(KERN_INFO"ab8500 register values:\n");
+
+	for (i = 1; i < AB8500_NUM_BANKS; i++) {
+		printk(KERN_INFO" bank %u:\n", i);
+		ab8500_registers_print(dev, i, NULL);
+	}
+}
+
 static int ab8500_all_banks_open(struct inode *inode, struct file *file)
 {
 	struct seq_file *s;
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 3f4e6d1..4c8d966 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -345,4 +345,10 @@ static inline int is_ab8500_2p0(struct ab8500 *ab)
 	return (is_ab8500(ab) && (ab->chip_id == AB8500_CUT2P0));
 }
 
+#ifdef CONFIG_AB8500_DEBUG
+void ab8500_dump_all_banks(struct device *dev);
+#else
+static inline void ab8500_dump_all_banks(struct device *dev) {}
+#endif
+
 #endif /* MFD_AB8500_H */
-- 
1.7.9.5
