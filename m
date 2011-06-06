From: peterhuewe@gmx.de (Peter Huewe)
Date: Mon,  6 Jun 2011 22:43:31 +0200
Subject: [PATCH 1/2] mfd/ab3550: Use kstrtoul_from_user
Message-ID: <1307393012-32582-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the code for getting an unsigned long from a
userspace buffer by a simple call to kstroul_from_user.
This makes it easier to read and less error prone.

Kernel Version: v3.0-rc2

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/mfd/ab3550-core.c |   41 +++++++++++------------------------------
 1 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/ab3550-core.c b/drivers/mfd/ab3550-core.c
index 3d7dce6..56ba194 100644
--- a/drivers/mfd/ab3550-core.c
+++ b/drivers/mfd/ab3550-core.c
@@ -879,20 +879,13 @@ static ssize_t ab3550_bank_write(struct file *file,
 	size_t count, loff_t *ppos)
 {
 	struct ab3550 *ab = ((struct seq_file *)(file->private_data))->private;
-	char buf[32];
-	int buf_size;
 	unsigned long user_bank;
 	int err;
 
 	/* Get userspace string and assure termination */
-	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	buf[buf_size] = 0;
-
-	err = strict_strtoul(buf, 0, &user_bank);
+	err = kstrtoul_from_user(user_buf, count, 0, &user_bank);
 	if (err)
-		return -EINVAL;
+		return err;
 
 	if (user_bank >= AB3550_NUM_BANKS) {
 		dev_err(&ab->i2c_client[0]->dev,
@@ -902,7 +895,7 @@ static ssize_t ab3550_bank_write(struct file *file,
 
 	ab->debug_bank = user_bank;
 
-	return buf_size;
+	return count;
 }
 
 static int ab3550_address_print(struct seq_file *s, void *p)
@@ -923,27 +916,21 @@ static ssize_t ab3550_address_write(struct file *file,
 	size_t count, loff_t *ppos)
 {
 	struct ab3550 *ab = ((struct seq_file *)(file->private_data))->private;
-	char buf[32];
-	int buf_size;
 	unsigned long user_address;
 	int err;
 
 	/* Get userspace string and assure termination */
-	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	buf[buf_size] = 0;
-
-	err = strict_strtoul(buf, 0, &user_address);
+	err = kstrtoul_from_user(user_buf, count, 0, &user_address);
 	if (err)
-		return -EINVAL;
+		return err;
+
 	if (user_address > 0xff) {
 		dev_err(&ab->i2c_client[0]->dev,
 			"debugfs error input > 0xff\n");
 		return -EINVAL;
 	}
 	ab->debug_address = user_address;
-	return buf_size;
+	return count;
 }
 
 static int ab3550_val_print(struct seq_file *s, void *p)
@@ -971,21 +958,15 @@ static ssize_t ab3550_val_write(struct file *file,
 	size_t count, loff_t *ppos)
 {
 	struct ab3550 *ab = ((struct seq_file *)(file->private_data))->private;
-	char buf[32];
-	int buf_size;
 	unsigned long user_val;
 	int err;
 	u8 regvalue;
 
 	/* Get userspace string and assure termination */
-	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	buf[buf_size] = 0;
-
-	err = strict_strtoul(buf, 0, &user_val);
+	err = kstrtoul_from_user(user_buf, count, 0, &user_val);
 	if (err)
-		return -EINVAL;
+		return err;
+
 	if (user_val > 0xff) {
 		dev_err(&ab->i2c_client[0]->dev,
 			"debugfs error input > 0xff\n");
@@ -1002,7 +983,7 @@ static ssize_t ab3550_val_write(struct file *file,
 	if (err)
 		return -EINVAL;
 
-	return buf_size;
+	return count;
 }
 
 static const struct file_operations ab3550_bank_fops = {
-- 
1.7.3.4
