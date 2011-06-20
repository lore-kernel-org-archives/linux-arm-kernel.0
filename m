From: peterhuewe@gmx.de (Peter Huewe)
Date: Mon, 20 Jun 2011 23:01:37 +0200
Subject: [PATCH 1/2 v3] mfd/ab3550: Convert to kstrtou8_from_user
In-Reply-To: <20110620195037.GA2534@p183.telecom.by>
References: <20110620195037.GA2534@p183.telecom.by>
Message-ID: <1308603698-32166-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the code for getting an number from a
userspace buffer by a simple call to kstrou8_from_user.
This makes it easier to read and less error prone.

Since the old buffers held only values up to 255, we don't need
kstrtoul, but rather kstrtou8.

Kernel Version: v3.0-rc3

Changes in v2:
- Use kstrtou8 instead of kstrtoul due to small numbers
- Dropped then unnecessary checks
Changes in v3:
- Drop now unnecessary local variables
- Change the debug_address and debug_bank members to u8 since they hold
  only values up to 255, and also remove the now superfluous u8 casts
(Remarks from Alexey Dobriyan, Thanks!)

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/mfd/ab3550-core.c |   79 +++++++++++++-------------------------------
 1 files changed, 24 insertions(+), 55 deletions(-)

diff --git a/drivers/mfd/ab3550-core.c b/drivers/mfd/ab3550-core.c
index 3d7dce6..bd0df90 100644
--- a/drivers/mfd/ab3550-core.c
+++ b/drivers/mfd/ab3550-core.c
@@ -73,8 +73,8 @@ struct ab3550 {
 	u8 startup_events[AB3550_NUM_EVENT_REG];
 	bool startup_events_read;
 #ifdef CONFIG_DEBUG_FS
-	unsigned int debug_bank;
-	unsigned int debug_address;
+	u8 debug_bank;
+	u8 debug_address;
 #endif
 };
 
@@ -879,20 +879,13 @@ static ssize_t ab3550_bank_write(struct file *file,
 	size_t count, loff_t *ppos)
 {
 	struct ab3550 *ab = ((struct seq_file *)(file->private_data))->private;
-	char buf[32];
-	int buf_size;
-	unsigned long user_bank;
+	u8 user_bank;
 	int err;
 
-	/* Get userspace string and assure termination */
-	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	buf[buf_size] = 0;
-
-	err = strict_strtoul(buf, 0, &user_bank);
+	/* Get userspace string and convert to number */
+	err = kstrtou8_from_user(user_buf, count, 0, &user_bank);
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
@@ -923,27 +916,14 @@ static ssize_t ab3550_address_write(struct file *file,
 	size_t count, loff_t *ppos)
 {
 	struct ab3550 *ab = ((struct seq_file *)(file->private_data))->private;
-	char buf[32];
-	int buf_size;
-	unsigned long user_address;
 	int err;
 
-	/* Get userspace string and assure termination */
-	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	buf[buf_size] = 0;
-
-	err = strict_strtoul(buf, 0, &user_address);
+	/* Get userspace string and convert to number */
+	err = kstrtou8_from_user(user_buf, count, 0, &ab->debug_address);
 	if (err)
-		return -EINVAL;
-	if (user_address > 0xff) {
-		dev_err(&ab->i2c_client[0]->dev,
-			"debugfs error input > 0xff\n");
-		return -EINVAL;
-	}
-	ab->debug_address = user_address;
-	return buf_size;
+		return err;
+
+	return count;
 }
 
 static int ab3550_val_print(struct seq_file *s, void *p)
@@ -952,8 +932,8 @@ static int ab3550_val_print(struct seq_file *s, void *p)
 	int err;
 	u8 regvalue;
 
-	err = get_register_interruptible(ab, (u8)ab->debug_bank,
-		(u8)ab->debug_address, &regvalue);
+	err = get_register_interruptible(ab, ab->debug_bank,
+		ab->debug_address, &regvalue);
 	if (err)
 		return -EINVAL;
 	seq_printf(s, "0x%02X\n", regvalue);
@@ -971,38 +951,27 @@ static ssize_t ab3550_val_write(struct file *file,
 	size_t count, loff_t *ppos)
 {
 	struct ab3550 *ab = ((struct seq_file *)(file->private_data))->private;
-	char buf[32];
-	int buf_size;
-	unsigned long user_val;
+	u8 user_val;
 	int err;
 	u8 regvalue;
 
-	/* Get userspace string and assure termination */
-	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	buf[buf_size] = 0;
-
-	err = strict_strtoul(buf, 0, &user_val);
+	/* Get userspace string and convert to number */
+	err = kstrtou8_from_user(user_buf, count, 0, &user_val);
 	if (err)
-		return -EINVAL;
-	if (user_val > 0xff) {
-		dev_err(&ab->i2c_client[0]->dev,
-			"debugfs error input > 0xff\n");
-		return -EINVAL;
-	}
+		return err;
+
 	err = mask_and_set_register_interruptible(
-		ab, (u8)ab->debug_bank,
-		(u8)ab->debug_address, 0xFF, (u8)user_val);
+		ab, ab->debug_bank,
+		ab->debug_address, 0xFF, user_val);
 	if (err)
 		return -EINVAL;
 
-	get_register_interruptible(ab, (u8)ab->debug_bank,
-		(u8)ab->debug_address, &regvalue);
+	get_register_interruptible(ab, ab->debug_bank,
+		ab->debug_address, &regvalue);
 	if (err)
 		return -EINVAL;
 
-	return buf_size;
+	return count;
 }
 
 static const struct file_operations ab3550_bank_fops = {
-- 
1.7.3.4
