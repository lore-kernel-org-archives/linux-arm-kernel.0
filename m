From: peda@axentia.se (Peter Rosin)
Date: Wed, 16 May 2018 09:16:46 +0200
Subject: [PATCH v2 1/2] i2c: algos: make use of i2c_8bit_addr_from_msg
In-Reply-To: <20180516071647.29277-1-peda@axentia.se>
References: <20180516071647.29277-1-peda@axentia.se>
Message-ID: <20180516071647.29277-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/algos/i2c-algo-bit.c | 4 +---
 drivers/i2c/algos/i2c-algo-pca.c | 5 +----
 drivers/i2c/algos/i2c-algo-pcf.c | 8 ++------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 3df0efd69ae3..4a34f311e1ff 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -519,9 +519,7 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
 			}
 		}
 	} else {		/* normal 7bit address	*/
-		addr = msg->addr << 1;
-		if (flags & I2C_M_RD)
-			addr |= 1;
+		addr = i2c_8bit_addr_from_msg(msg);
 		if (flags & I2C_M_REV_DIR_ADDR)
 			addr ^= 1;
 		ret = try_address(i2c_adap, addr, retries);
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index e370804ec8bc..883a290f6a4d 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -112,11 +112,8 @@ static int pca_address(struct i2c_algo_pca_data *adap,
 		       struct i2c_msg *msg)
 {
 	int sta = pca_get_con(adap);
-	int addr;
+	int addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = ((0x7f & msg->addr) << 1);
-	if (msg->flags & I2C_M_RD)
-		addr |= 1;
 	DEB2("=== SLAVE ADDRESS %#04x+%c=%#04x\n",
 	     msg->addr, msg->flags & I2C_M_RD ? 'R' : 'W', addr);
 
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 270d84bfc2c6..5c29a4d397cf 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -291,13 +291,9 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
-	unsigned short flags = msg->flags;
-	unsigned char addr;
+	unsigned char addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = msg->addr << 1;
-	if (flags & I2C_M_RD)
-		addr |= 1;
-	if (flags & I2C_M_REV_DIR_ADDR)
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 	i2c_outb(adap, addr);
 
-- 
2.11.0
