From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 25 Dec 2012 16:55:55 +0530
Subject: [PATCH 2/2] i2c-exynos5: add debugfs support for registers
In-Reply-To: <1356434755-13702-1-git-send-email-ch.naveen@samsung.com>
References: <1354021236-28596-2-git-send-email-ch.naveen@samsung.com>
 <1356434755-13702-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1356434755-13702-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the dev_vdbg with debugfs function calls
in i2c-exynos5.c driver.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
Changes since v1:
The debugfs implementation is a suggestion by Felipe Balbi.
Its not tested, Implemented only for review purpose..

 drivers/i2c/busses/i2c-exynos5.c |  140 +++++++++++++++++++++++++++++---------
 1 file changed, 109 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 7614f60..2d2da22 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/debugfs.h>
 
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -55,6 +56,7 @@ struct exynos5_i2c {
 
 	int			bus_num;
 	int			speed_mode;
+	struct dentry		*debugfs_root;
 };
 
 static const struct of_device_id exynos5_i2c_match[] = {
@@ -63,39 +65,112 @@ static const struct of_device_id exynos5_i2c_match[] = {
 };
 MODULE_DEVICE_TABLE(of, exynos5_i2c_match);
 
-/* TODO: Should go to debugfs */
-static inline void dump_i2c_register(struct exynos5_i2c *i2c)
+static int exynos5_i2c_regs_show(struct seq_file *s, void *data)
 {
-	dev_vdbg(i2c->dev, "Register dump(%d) :\n %x\n %x\n %x\n %x\n"
-		" %x\n %x\n %x\n %x\n %x\n"
-		" %x\n %x\n %x\n %x\n %x\n"
-		" %x\n %x\n %x\n %x\n %x\n"
-		" %x\n %x\n %x\n %x\n %x\n",
-		i2c->suspended,
-		readl(i2c->regs + HSI2C_CTL),
-		readl(i2c->regs + HSI2C_FIFO_CTL),
-		readl(i2c->regs + HSI2C_TRAILIG_CTL),
-		readl(i2c->regs + HSI2C_CLK_CTL),
-		readl(i2c->regs + HSI2C_CLK_SLOT),
-		readl(i2c->regs + HSI2C_INT_ENABLE),
-		readl(i2c->regs + HSI2C_INT_STATUS),
-		readl(i2c->regs + HSI2C_ERR_STATUS),
-		readl(i2c->regs + HSI2C_FIFO_STATUS),
-		readl(i2c->regs + HSI2C_TX_DATA),
-		readl(i2c->regs + HSI2C_RX_DATA),
-		readl(i2c->regs + HSI2C_CONF),
-		readl(i2c->regs + HSI2C_AUTO_CONF),
-		readl(i2c->regs + HSI2C_TIMEOUT),
-		readl(i2c->regs + HSI2C_MANUAL_CMD),
-		readl(i2c->regs + HSI2C_TRANS_STATUS),
-		readl(i2c->regs + HSI2C_TIMING_HS1),
-		readl(i2c->regs + HSI2C_TIMING_HS2),
-		readl(i2c->regs + HSI2C_TIMING_HS3),
-		readl(i2c->regs + HSI2C_TIMING_FS1),
-		readl(i2c->regs + HSI2C_TIMING_FS2),
-		readl(i2c->regs + HSI2C_TIMING_FS3),
-		readl(i2c->regs + HSI2C_TIMING_SLA),
+	struct exynos5_i2c *i2c = (struct exynos5_i2c *)s->private;
+
+	if (i2c->suspended) {
+		seq_printf(s, "i2c suspended, can't read registers\n");
+		return 0;
+	}
+
+	pm_runtime_get_sync(i2c->dev);
+
+	seq_printf(s, "CTL:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_CTL));
+	seq_printf(s, "FIFO_CTL:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_FIFO_CTL));
+	seq_printf(s, "TRAILIG_CTL:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TRAILIG_CTL));
+	seq_printf(s, "CLK_CTL:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_CLK_CTL));
+	seq_printf(s, "CLK_SLOT:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_CLK_SLOT));
+	seq_printf(s, "INT_ENABLE:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_INT_ENABLE));
+	seq_printf(s, "INT_STATUS:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_INT_STATUS));
+	seq_printf(s, "FIFO_STATUS:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_FIFO_STATUS));
+	seq_printf(s, "TX_DATA:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TX_DATA));
+	seq_printf(s, "RX_DATA:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_RX_DATA));
+	seq_printf(s, "CONF:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_CONF));
+	seq_printf(s, "AUTO_CONF:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_AUTO_CONF));
+	seq_printf(s, "TIMEOUT:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMEOUT));
+	seq_printf(s, "MANUAL_CMD:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_MANUAL_CMD));
+	seq_printf(s, "TRANS_STATUS:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TRANS_STATUS));
+	seq_printf(s, "TIMING_HS1:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMING_HS1));
+	seq_printf(s, "TIMING_HS2:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMING_HS2));
+	seq_printf(s, "TIMING_HS3:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMING_HS3));
+	seq_printf(s, "TIMING_FS1:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMING_FS1));
+	seq_printf(s, "TIMING_FS2:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMING_FS2));
+	seq_printf(s, "TIMING_FS3:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMING_FS3));
+	seq_printf(s, "TIMING_SLA:\t\t0x%08x\n",
+		readl(i2c->regs + HSI2C_TIMING_SLA));
+	seq_printf(s, "ADDR:\t\t0x%08x\n",
 		readl(i2c->regs + HSI2C_ADDR));
+
+	pm_runtime_mark_last_busy(i2c->dev);
+	pm_runtime_put_autosuspend(i2c->dev);
+
+	return 0;
+}
+
+static int exynos5_i2c_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, exynos5_i2c_regs_show, inode->i_private);
+}
+
+static const struct file_operations exynos5_i2c_regs_fops = {
+	.open           = exynos5_i2c_regs_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static void exynos5_i2c_debugfs(struct exynos5_i2c *i2c)
+{
+	if (i2c->debugfs_root)
+		debugfs_create_file("regs", S_IRUSR, i2c->debugfs_root,
+			i2c, &exynos5_i2c_regs_fops);
+}
+
+static void exynos5_i2c_add_debugfs(struct exynos5_i2c *i2c)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir(dev_name(i2c->dev), NULL);
+	if (IS_ERR(root))
+		/* Don't complain -- debugfs just isn't enabled */
+		return;
+	if (!root)
+		/* Complain -- debugfs is enabled, but it failed to
+		 * create the directory. */
+		goto err_root;
+
+	i2c->debugfs_root = root;
+	return;
+
+ err_root:
+	dev_err(i2c->dev, "failed to initialize debugfs\n");
+}
+
+void exynos5_i2c_remove_debugfs(struct exynos5_i2c *i2c)
+{
+	debugfs_remove_recursive(i2c->debugfs_root);
 }
 
 static inline void exynos5_i2c_stop(struct exynos5_i2c *i2c, int ret)
@@ -553,6 +628,8 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s: Exynos5 HS-I2C adapter\n",
 		dev_name(&i2c->adap.dev));
 
+	exynos5_i2c_add_debugfs(i2c);
+	exynos5_i2c_debugfs(i2c);
 	clk_disable_unprepare(i2c->clk);
 	pm_runtime_mark_last_busy(i2c->dev);
 	pm_runtime_put_autosuspend(i2c->dev);
@@ -586,6 +663,7 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
 
 	iounmap(i2c->regs);
 	platform_set_drvdata(pdev, NULL);
+	exynos5_i2c_remove_debugfs(i2c);
 
 	return 0;
 }
-- 
1.7.9.5
