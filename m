From: jtzhou@marvell.com (Jett.Zhou)
Date: Mon, 14 Nov 2011 13:33:14 +0800
Subject: [V3 1/2] mfd: fix 88pm860x test bank i2c interface bug
Message-ID: <1321248795-27061-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two banks in 88pm8607. One is the normal bank, and the other
one is the test bank, it means it have the same register address in the
normal bank and test bank seperately.
For test bank register, it needs a special I2C sequence to acess as below,
    Touching to 0xFA address
    Touching to 0xFB address
    Touching to 0xFF address
    Accessing bank register
    Touching to 0xFE address
    Touching to 0xFC address
This sequence can't be interrupted. It means that we can't use
i2c_transfef() to implement touching 0xFA address. Otherwise, other i2c
operation may be inserted into 0xFA and 0xFB operation since the lock of
i2c_adapter is already released.
So for test bank we implemented specific i2c read/write operation;

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-i2c.c |  135 +++++++++++++++++++++++++++++---------------
 1 files changed, 89 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index e017dc8..f629d6f 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -126,23 +126,69 @@ out:
 }
 EXPORT_SYMBOL(pm860x_set_bits);
 
+static int read_device(struct i2c_client *i2c, int reg,
+		       int bytes, void *dest)
+{
+	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX + 3];
+	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX + 2];
+	struct i2c_adapter *adap = i2c->adapter;
+	struct i2c_msg msg[2] = {{i2c->addr, 0, 1, msgbuf0},
+				 {i2c->addr, I2C_M_RD, 0, msgbuf1},
+				};
+	int num = 1, ret = 0;
+
+	if (dest == NULL)
+		return -EINVAL;
+	msgbuf0[0] = (unsigned char)reg;	/* command */
+	msg[1].len = bytes;
+
+	/* if data needs to read back, num should be 2 */
+	if (bytes > 0)
+		num = 2;
+	ret = adap->algo->master_xfer(adap, msg, num);
+	memcpy(dest, msgbuf1, bytes);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int write_device(struct i2c_client *i2c, int reg,
+			int bytes, void *src)
+{
+	unsigned char buf[bytes + 1];
+	struct i2c_adapter *adap = i2c->adapter;
+	struct i2c_msg msg;
+	int ret;
+
+	buf[0] = (unsigned char)reg;
+	memcpy(&buf[1], src, bytes);
+	msg.addr = i2c->addr;
+	msg.flags = 0;
+	msg.len = bytes + 1;
+	msg.buf = buf;
+
+	ret = adap->algo->master_xfer(adap, &msg, 1);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
 int pm860x_page_reg_read(struct i2c_client *i2c, int reg)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero = 0;
 	unsigned char data;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, 1, &data);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = read_device(i2c, reg, 1, &data);
 	if (ret >= 0)
 		ret = (int)data;
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_read);
@@ -150,18 +196,17 @@ EXPORT_SYMBOL(pm860x_page_reg_read);
 int pm860x_page_reg_write(struct i2c_client *i2c, int reg,
 			  unsigned char data)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_write_device(i2c, reg, 1, &data);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = write_device(i2c, reg, 1, &data);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -169,18 +214,17 @@ EXPORT_SYMBOL(pm860x_page_reg_write);
 int pm860x_page_bulk_read(struct i2c_client *i2c, int reg,
 			  int count, unsigned char *buf)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero = 0;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, count, buf);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xfa, 0, &zero);
+	read_device(i2c, 0xfb, 0, &zero);
+	read_device(i2c, 0xff, 0, &zero);
+	ret = read_device(i2c, reg, count, buf);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
@@ -188,18 +232,18 @@ EXPORT_SYMBOL(pm860x_page_bulk_read);
 int pm860x_page_bulk_write(struct i2c_client *i2c, int reg,
 			   int count, unsigned char *buf)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero = 0;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_write_device(i2c, reg, count, buf);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = write_device(i2c, reg, count, buf);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_adapter(i2c->adapter);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_write);
@@ -207,25 +251,24 @@ EXPORT_SYMBOL(pm860x_page_bulk_write);
 int pm860x_page_set_bits(struct i2c_client *i2c, int reg,
 			 unsigned char mask, unsigned char data)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero;
 	unsigned char value;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, 1, &value);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = read_device(i2c, reg, 1, &value);
 	if (ret < 0)
 		goto out;
 	value &= ~mask;
 	value |= data;
-	ret = pm860x_write_device(i2c, reg, 1, &value);
+	ret = write_device(i2c, reg, 1, &value);
 out:
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_set_bits);
-- 
1.7.0.4
