From: peda@axentia.se (Peter Rosin)
Date: Wed, 20 Jun 2018 07:17:55 +0200
Subject: [PATCH v2 02/10] i2c: mux: pca9541: switch to i2c_lock_bus(...,
 I2C_LOCK_SEGMENT)
In-Reply-To: <20180620051803.12206-1-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
Message-ID: <20180620051803.12206-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..bc7c8cee5a8c 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -345,11 +345,11 @@ static int pca9541_probe(struct i2c_client *client,
 
 	/*
 	 * I2C accesses are unprotected here.
-	 * We have to lock the adapter before releasing the bus.
+	 * We have to lock the I2C segment before releasing the bus.
 	 */
-	i2c_lock_adapter(adap);
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
 	pca9541_release_bus(client);
-	i2c_unlock_adapter(adap);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
 
 	/* Create mux adapter */
 
-- 
2.11.0
