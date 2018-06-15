From: peda@axentia.se (Peter Rosin)
Date: Fri, 15 Jun 2018 12:15:04 +0200
Subject: [PATCH 09/11] media: tda18271: switch to i2c_lock_segment
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
Message-ID: <20180615101506.8012-10-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_segment. If the device does not sit behind a mux-locked mux,
the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/tuners/tda18271-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/tuners/tda18271-common.c b/drivers/media/tuners/tda18271-common.c
index 7e81cd887c13..93cce2bcd601 100644
--- a/drivers/media/tuners/tda18271-common.c
+++ b/drivers/media/tuners/tda18271-common.c
@@ -225,7 +225,7 @@ static int __tda18271_write_regs(struct dvb_frontend *fe, int idx, int len,
 	 */
 	if (lock_i2c) {
 		tda18271_i2c_gate_ctrl(fe, 1);
-		i2c_lock_adapter(priv->i2c_props.adap);
+		i2c_lock_segment(priv->i2c_props.adap);
 	}
 	while (len) {
 		if (max > len)
@@ -246,7 +246,7 @@ static int __tda18271_write_regs(struct dvb_frontend *fe, int idx, int len,
 		len -= max;
 	}
 	if (lock_i2c) {
-		i2c_unlock_adapter(priv->i2c_props.adap);
+		i2c_unlock_segment(priv->i2c_props.adap);
 		tda18271_i2c_gate_ctrl(fe, 0);
 	}
 
@@ -300,7 +300,7 @@ int tda18271_init_regs(struct dvb_frontend *fe)
 	 * as those could cause bad things
 	 */
 	tda18271_i2c_gate_ctrl(fe, 1);
-	i2c_lock_adapter(priv->i2c_props.adap);
+	i2c_lock_segment(priv->i2c_props.adap);
 
 	/* initialize registers */
 	switch (priv->id) {
@@ -516,7 +516,7 @@ int tda18271_init_regs(struct dvb_frontend *fe)
 	/* synchronize */
 	__tda18271_write_regs(fe, R_EP1, 1, false);
 
-	i2c_unlock_adapter(priv->i2c_props.adap);
+	i2c_unlock_segment(priv->i2c_props.adap);
 	tda18271_i2c_gate_ctrl(fe, 0);
 
 	return 0;
-- 
2.11.0
