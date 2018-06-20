From: peda@axentia.se (Peter Rosin)
Date: Wed, 20 Jun 2018 07:17:58 +0200
Subject: [PATCH v2 05/10] media: drxk_hard: switch to i2c_lock_bus(...,
 I2C_LOCK_SEGMENT)
In-Reply-To: <20180620051803.12206-1-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
Message-ID: <20180620051803.12206-6-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/dvb-frontends/drxk_hard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 5a26ad93be10..29c36f95d624 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -213,7 +213,7 @@ static inline u32 log10times100(u32 value)
 
 static int drxk_i2c_lock(struct drxk_state *state)
 {
-	i2c_lock_adapter(state->i2c);
+	i2c_lock_bus(state->i2c, I2C_LOCK_SEGMENT);
 	state->drxk_i2c_exclusive_lock = true;
 
 	return 0;
@@ -224,7 +224,7 @@ static void drxk_i2c_unlock(struct drxk_state *state)
 	if (!state->drxk_i2c_exclusive_lock)
 		return;
 
-	i2c_unlock_adapter(state->i2c);
+	i2c_unlock_bus(state->i2c, I2C_LOCK_SEGMENT);
 	state->drxk_i2c_exclusive_lock = false;
 }
 
-- 
2.11.0
