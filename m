From: peda@axentia.se (Peter Rosin)
Date: Fri, 15 Jun 2018 12:14:57 +0200
Subject: [PATCH 02/11] tpm/tpm_i2c_infineon: switch to i2c_lock_segment
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
Message-ID: <20180615101506.8012-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_segment. If the device does not sit behind a mux-locked mux,
the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/char/tpm/tpm_i2c_infineon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 6116cd05e228..b2889405b4fa 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -117,7 +117,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 	/* Lock the adapter for the duration of the whole sequence. */
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_segment(tpm_dev.client->adapter);
 
 	if (tpm_dev.chip_type == SLB9645) {
 		/* use a combined read for newer chips
@@ -192,7 +192,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 	}
 
 out:
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_segment(tpm_dev.client->adapter);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 
@@ -224,7 +224,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_segment(tpm_dev.client->adapter);
 
 	/* prepend the 'register address' to the buffer */
 	tpm_dev.buf[0] = addr;
@@ -243,7 +243,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 		usleep_range(sleep_low, sleep_hi);
 	}
 
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_segment(tpm_dev.client->adapter);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 
-- 
2.11.0
