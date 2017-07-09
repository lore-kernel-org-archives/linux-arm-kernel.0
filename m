From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Sun, 9 Jul 2017 15:57:44 -0500
Subject: [PATCH] i2c: stm32f4: constify i2c_algorithm structure
Message-ID: <20170709205744.GA18652@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for i2c_algorithm structures that are only stored in
the algo field of an i2c_adapter structure. This field is
declared const, so i2c_algorithm structures that have this
property can be declared as const also.

This issue was identified using Coccinelle and the following
semantic patch:

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct i2c_algorithm i at p = { ... };

@ok@
identifier r.i;
struct i2c_adapter e;
position p;
@@
e.algo = &i at p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
@@
i at p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct i2c_algorithm i = { ... };

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/i2c/busses/i2c-stm32f4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index f9dd7e8..9d6f110 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -751,7 +751,7 @@ static u32 stm32f4_i2c_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm stm32f4_i2c_algo = {
+static const struct i2c_algorithm stm32f4_i2c_algo = {
 	.master_xfer = stm32f4_i2c_xfer,
 	.functionality = stm32f4_i2c_func,
 };
-- 
2.5.0
