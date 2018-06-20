From: peda@axentia.se (Peter Rosin)
Date: Wed, 20 Jun 2018 07:18:02 +0200
Subject: [PATCH v2 09/10] mfd: 88pm860x-i2c: switch to i2c_lock_bus(...,
 I2C_LOCK_SEGMENT)
In-Reply-To: <20180620051803.12206-1-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
Message-ID: <20180620051803.12206-10-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mfd/88pm860x-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index 84e313107233..7b9052ea7413 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -146,14 +146,14 @@ int pm860x_page_reg_write(struct i2c_client *i2c, int reg,
 	unsigned char zero;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xFA, 0, &zero);
 	read_device(i2c, 0xFB, 0, &zero);
 	read_device(i2c, 0xFF, 0, &zero);
 	ret = write_device(i2c, reg, 1, &data);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -164,14 +164,14 @@ int pm860x_page_bulk_read(struct i2c_client *i2c, int reg,
 	unsigned char zero = 0;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xfa, 0, &zero);
 	read_device(i2c, 0xfb, 0, &zero);
 	read_device(i2c, 0xff, 0, &zero);
 	ret = read_device(i2c, reg, count, buf);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
-- 
2.11.0
