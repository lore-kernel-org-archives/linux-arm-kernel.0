From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 15:44:43 +0100
Subject: [PATCH 1/4] mfd: 88pm860x-i2c: Purge unused functions
Message-ID: <1409237086-21421-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following functions appear to be unused since v2.6.39:

  pm860x_page_reg_read()
  pm860x_page_bulk_write()
  pm860x_page_set_bits()

Let's remove them.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/88pm860x-i2c.c | 64 ----------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index a93b4d0..7063cfd 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -140,26 +140,6 @@ static int write_device(struct i2c_client *i2c, int reg,
 	return 0;
 }
 
-int pm860x_page_reg_read(struct i2c_client *i2c, int reg)
-{
-	unsigned char zero = 0;
-	unsigned char data;
-	int ret;
-
-	i2c_lock_adapter(i2c->adapter);
-	read_device(i2c, 0xFA, 0, &zero);
-	read_device(i2c, 0xFB, 0, &zero);
-	read_device(i2c, 0xFF, 0, &zero);
-	ret = read_device(i2c, reg, 1, &data);
-	if (ret >= 0)
-		ret = (int)data;
-	read_device(i2c, 0xFE, 0, &zero);
-	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
-	return ret;
-}
-EXPORT_SYMBOL(pm860x_page_reg_read);
-
 int pm860x_page_reg_write(struct i2c_client *i2c, int reg,
 			  unsigned char data)
 {
@@ -195,47 +175,3 @@ int pm860x_page_bulk_read(struct i2c_client *i2c, int reg,
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
-
-int pm860x_page_bulk_write(struct i2c_client *i2c, int reg,
-			   int count, unsigned char *buf)
-{
-	unsigned char zero = 0;
-	int ret;
-
-	i2c_lock_adapter(i2c->adapter);
-	read_device(i2c, 0xFA, 0, &zero);
-	read_device(i2c, 0xFB, 0, &zero);
-	read_device(i2c, 0xFF, 0, &zero);
-	ret = write_device(i2c, reg, count, buf);
-	read_device(i2c, 0xFE, 0, &zero);
-	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
-	i2c_unlock_adapter(i2c->adapter);
-	return ret;
-}
-EXPORT_SYMBOL(pm860x_page_bulk_write);
-
-int pm860x_page_set_bits(struct i2c_client *i2c, int reg,
-			 unsigned char mask, unsigned char data)
-{
-	unsigned char zero;
-	unsigned char value;
-	int ret;
-
-	i2c_lock_adapter(i2c->adapter);
-	read_device(i2c, 0xFA, 0, &zero);
-	read_device(i2c, 0xFB, 0, &zero);
-	read_device(i2c, 0xFF, 0, &zero);
-	ret = read_device(i2c, reg, 1, &value);
-	if (ret < 0)
-		goto out;
-	value &= ~mask;
-	value |= data;
-	ret = write_device(i2c, reg, 1, &value);
-out:
-	read_device(i2c, 0xFE, 0, &zero);
-	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
-	return ret;
-}
-EXPORT_SYMBOL(pm860x_page_set_bits);
-- 
1.9.1
