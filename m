From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 12 Apr 2011 03:32:59 +0200
Subject: [PATCH] clkdev: add debugfs support
Message-ID: <1302571979-11097-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

create a file in /sys/kernel/debug/clkdev

with the list of lookup with the con_id, dev_id and the clock rate

as this

dev_id               con_id               rate
(null)               clk32k                   32768 Hz
(null)               main                  16367660 Hz
(null)               plla                 199919178 Hz
(null)               mck                   99959589 Hz
at91_mci.0           mci_clk               99959589 Hz
at91_mci.1           mci_clk               99959589 Hz
atmel_spi.0          spi_clk               99959589 Hz

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/clk/clkdev.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 0fc0a79..5c3a6fb 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -19,6 +19,8 @@
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
@@ -174,3 +176,41 @@ void clkdev_drop(struct clk_lookup *cl)
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
+
+#ifdef CONFIG_DEBUG_FS
+static int clkdev_clk_show(struct seq_file *s, void *unused)
+{
+	struct clk_lookup *p;
+
+	seq_printf(s, "%-20s %-20s rate\n", "dev_id", "con_id");
+
+	list_for_each_entry(p, &clocks, node) {
+
+		seq_printf(s, "%-20s %-20s %9ld Hz\n",
+			p->dev_id, p->con_id, clk_get_rate(p->clk));
+	}
+	return 0;
+}
+
+static int clkdev_clk_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, clkdev_clk_show, NULL);
+}
+
+static const struct file_operations clkdev_clk_operations = {
+	.open		= clkdev_clk_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init clkdev_clk_debugfs_init(void)
+{
+	/* /sys/kernel/debug/clkdev */
+	(void) debugfs_create_file("clkdev", S_IFREG | S_IRUGO, NULL, NULL,
+				   &clkdev_clk_operations);
+
+	return 0;
+}
+postcore_initcall(clkdev_clk_debugfs_init);
+#endif
-- 
1.7.4.1
