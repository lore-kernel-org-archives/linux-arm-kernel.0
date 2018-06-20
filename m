From: peda@axentia.se (Peter Rosin)
Date: Wed, 20 Jun 2018 07:17:57 +0200
Subject: [PATCH v2 04/10] media: af9013: switch to i2c_lock_bus(...,
 I2C_LOCK_SEGMENT)
In-Reply-To: <20180620051803.12206-1-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
Message-ID: <20180620051803.12206-5-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/dvb-frontends/af9013.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/af9013.c b/drivers/media/dvb-frontends/af9013.c
index 482bce49819a..99361c113bca 100644
--- a/drivers/media/dvb-frontends/af9013.c
+++ b/drivers/media/dvb-frontends/af9013.c
@@ -1312,10 +1312,10 @@ static int af9013_wregs(struct i2c_client *client, u8 cmd, u16 reg,
 	memcpy(&buf[3], val, len);
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = __i2c_transfer(client->adapter, msg, 1);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 1) {
@@ -1353,10 +1353,10 @@ static int af9013_rregs(struct i2c_client *client, u8 cmd, u16 reg,
 	buf[2] = cmd;
 
 	if (lock)
-		i2c_lock_adapter(client->adapter);
+		i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = __i2c_transfer(client->adapter, msg, 2);
 	if (lock)
-		i2c_unlock_adapter(client->adapter);
+		i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	if (ret < 0) {
 		goto err;
 	} else if (ret != 2) {
-- 
2.11.0
