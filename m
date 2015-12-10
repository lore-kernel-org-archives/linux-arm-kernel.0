From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 14:14:49 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
Message-ID: <2144222.LfzPx9mJ0p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The emev2 driver stopped compiling in today's linux-next kernel:

drivers/i2c/busses/i2c-emev2.c: In function 'em_i2c_slave_irq':
drivers/i2c/busses/i2c-emev2.c:233:23: error: storage size of 'event' isn't known
drivers/i2c/busses/i2c-emev2.c:250:3: error: implicit declaration of function 'i2c_slave_event' [-Werror=implicit-function-declaration]
drivers/i2c/busses/i2c-emev2.c:250:32: error: 'I2C_SLAVE_STOP' undeclared (first use in this function)

It works again if we enable CONFIG_I2C_SLAVE, but it seems wrong
to add a dependency on that symbol:

* The symbol is user-selectable, but only one or two (including this
  one) bus drivers actually implement it, and it makes no sense
  if you don't have one of them.

* The other driver (R-Car) uses 'select I2C_SLAVE', which seems
  reasonable in principle, but we should not do that on user
  visible symbols.

* I2C slave mode could be implemented in a lot of other drivers
  as an optional feature, but we shouldn't require enabling it
  if we don't use it.

This changes the two drivers that provide I2C slave mode so they
can again build if the slave mode being disabled. To do this, I
move the definition of i2c_slave_event() and enum i2c_slave_event
out of the #ifdef and instead make the assignment of the reg_slave
and unreg_slave pointers optional in the bus drivers. The functions
implementing the feature are unused in that case, so they get
marked as __maybe_unused in order to still give compile-time
coverage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c31d0a00021d ("i2c: emev2: add slave support")

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 69c46fe13777..1c8d53f34dd3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -985,7 +985,6 @@ config I2C_XLP9XX
 config I2C_RCAR
 	tristate "Renesas R-Car I2C Controller"
 	depends on ARCH_SHMOBILE || COMPILE_TEST
-	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
 	  R-Car I2C controller.
diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index 96bb4e749012..75d6095c5fe1 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -316,7 +316,7 @@ static u32 em_i2c_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
 }
 
-static int em_i2c_reg_slave(struct i2c_client *slave)
+static int __maybe_unused em_i2c_reg_slave(struct i2c_client *slave)
 {
 	struct em_i2c_device *priv = i2c_get_adapdata(slave->adapter);
 
@@ -334,7 +334,7 @@ static int em_i2c_reg_slave(struct i2c_client *slave)
 	return 0;
 }
 
-static int em_i2c_unreg_slave(struct i2c_client *slave)
+static int __maybe_unused em_i2c_unreg_slave(struct i2c_client *slave)
 {
 	struct em_i2c_device *priv = i2c_get_adapdata(slave->adapter);
 
@@ -350,8 +350,10 @@ static int em_i2c_unreg_slave(struct i2c_client *slave)
 static struct i2c_algorithm em_i2c_algo = {
 	.master_xfer = em_i2c_xfer,
 	.functionality = em_i2c_func,
+#ifdef CONFIG_I2C_SLAVE
 	.reg_slave      = em_i2c_reg_slave,
 	.unreg_slave    = em_i2c_unreg_slave,
+#endif
 };
 
 static int em_i2c_probe(struct platform_device *pdev)
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 3ed1f0aa5eeb..e67824adeba0 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -521,7 +521,7 @@ out:
 	return ret;
 }
 
-static int rcar_reg_slave(struct i2c_client *slave)
+static int __maybe_unused rcar_reg_slave(struct i2c_client *slave)
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(slave->adapter);
 
@@ -542,7 +542,7 @@ static int rcar_reg_slave(struct i2c_client *slave)
 	return 0;
 }
 
-static int rcar_unreg_slave(struct i2c_client *slave)
+static int __maybe_unused rcar_unreg_slave(struct i2c_client *slave)
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(slave->adapter);
 
@@ -568,8 +568,10 @@ static u32 rcar_i2c_func(struct i2c_adapter *adap)
 static const struct i2c_algorithm rcar_i2c_algo = {
 	.master_xfer	= rcar_i2c_master_xfer,
 	.functionality	= rcar_i2c_func,
+#ifdef CONFIG_I2C_SLAVE
 	.reg_slave	= rcar_reg_slave,
 	.unreg_slave	= rcar_unreg_slave,
+#endif
 };
 
 static const struct of_device_id rcar_i2c_dt_ids[] = {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 51028f351d13..69871e5ee44a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -254,7 +254,6 @@ static inline void i2c_set_clientdata(struct i2c_client *dev, void *data)
 
 /* I2C slave support */
 
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 enum i2c_slave_event {
 	I2C_SLAVE_READ_REQUESTED,
 	I2C_SLAVE_WRITE_REQUESTED,
@@ -269,9 +268,12 @@ extern int i2c_slave_unregister(struct i2c_client *client);
 static inline int i2c_slave_event(struct i2c_client *client,
 				  enum i2c_slave_event event, u8 *val)
 {
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	return client->slave_cb(client, event, val);
-}
+#else
+	return 0;
 #endif
+}
 
 /**
  * struct i2c_board_info - template for device creation
