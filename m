From: nicola@corna.info (Nicola Corna)
Date: Thu, 29 Oct 2015 12:34:24 +0100
Subject: [PATCH v2 2/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-algo-bit.c
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Message-ID: <1446118467-26453-2-git-send-email-nicola@corna.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C_AQ_NO_CLK_STRETCH to drivers/i2c/algos/i2c-algo-bit.c when getscl
is not available.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 drivers/i2c/algos/i2c-algo-bit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 899bede..9d233bb 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -617,6 +617,10 @@ const struct i2c_algorithm i2c_bit_algo = {
 };
 EXPORT_SYMBOL(i2c_bit_algo);
 
+const struct i2c_adapter_quirks i2c_bit_quirk_no_clk_stretch = {
+	.flags = I2C_AQ_NO_CLK_STRETCH,
+};
+
 /*
  * registering functions to load algorithms at runtime
  */
@@ -635,6 +639,8 @@ static int __i2c_bit_add_bus(struct i2c_adapter *adap,
 	/* register new adapter to i2c module... */
 	adap->algo = &i2c_bit_algo;
 	adap->retries = 3;
+	if (bit_adap->getscl == NULL)
+		adap->quirks = &i2c_bit_quirk_no_clk_stretch;
 
 	ret = add_adapter(adap);
 	if (ret < 0)
-- 
2.6.1
