From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 27 Oct 2017 17:37:27 +0200
Subject: [PATCH] mfd: ab8500-debugfs: Use common error handling code in
 ab8500_print_modem_registers()
Message-ID: <7af3098c-21fd-aa16-237f-0359d312cac7@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 27 Oct 2017 17:20:45 +0200

Add jump targets so that two error messages are stored only once
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/ab8500-debugfs.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index c1c815241e02..37f39b2a1aa1 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1620,18 +1620,15 @@ static int ab8500_print_modem_registers(struct seq_file *s, void *p)
 
 	err = abx500_get_register_interruptible(dev,
 		AB8500_REGU_CTRL1, AB8500_SUPPLY_CONTROL_REG, &orig_value);
-	if (err < 0) {
-		dev_err(dev, "ab->read fail %d\n", err);
-		return err;
-	}
+	if (err < 0)
+		goto report_read_failure;
+
 	/* Config 1 will allow APE side to read SIM registers */
 	err = abx500_set_register_interruptible(dev,
 		AB8500_REGU_CTRL1, AB8500_SUPPLY_CONTROL_REG,
 		AB8500_SUPPLY_CONTROL_CONFIG_1);
-	if (err < 0) {
-		dev_err(dev, "ab->write fail %d\n", err);
-		return err;
-	}
+	if (err < 0)
+		goto report_write_failure;
 
 	seq_printf(s, " bank 0x%02X:\n", bank);
 
@@ -1641,19 +1638,25 @@ static int ab8500_print_modem_registers(struct seq_file *s, void *p)
 	for (reg = AB8500_FIRST_SIM_REG; reg <= last_sim_reg; reg++) {
 		err = abx500_get_register_interruptible(dev,
 			bank, reg, &value);
-		if (err < 0) {
-			dev_err(dev, "ab->read fail %d\n", err);
-			return err;
-		}
+		if (err < 0)
+			goto report_read_failure;
+
 		seq_printf(s, "  [0x%02X/0x%02X]: 0x%02X\n", bank, reg, value);
 	}
 	err = abx500_set_register_interruptible(dev,
 		AB8500_REGU_CTRL1, AB8500_SUPPLY_CONTROL_REG, orig_value);
-	if (err < 0) {
-		dev_err(dev, "ab->write fail %d\n", err);
-		return err;
-	}
+	if (err < 0)
+		goto report_write_failure;
+
 	return 0;
+
+report_read_failure:
+	dev_err(dev, "ab->read fail %d\n", err);
+	return err;
+
+report_write_failure:
+	dev_err(dev, "ab->write fail %d\n", err);
+	return err;
 }
 
 static int ab8500_modem_open(struct inode *inode, struct file *file)
-- 
2.14.3
