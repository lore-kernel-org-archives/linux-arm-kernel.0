From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 15:48:40 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <20151217120157.GC3958@katana>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <13702087.6o87OAVdIx@wuerfel> <20151217120157.GC3958@katana>
Message-ID: <7947081.psvz6dklxq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 13:01:57 Wolfram Sang wrote:
> On Mon, Dec 14, 2015 at 11:27:22PM +0100, Arnd Bergmann wrote:
> > On Monday 14 December 2015 14:52:06 Wolfram Sang wrote:
> > > > > What about not ifdeffing the inline function and keep the build error
> > > > > whenever someone uses it without I2C_SLAVE being selected?
> > > > 
> > > > The inline function is only added there for the case that I2C_SLAVE is
> > > > disabled, so that would be pointless.
> > > > 
> > > > However, what we could do is move the extern declaration outside of
> > > > the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
> > > > check should then ensure that it never actually gets called, and we
> > > > get a link error if some driver gets it wrong.
> > > 
> > > Yes, that's what I meant: move the whole function (as it was before your
> > > patch) out of the CONFIG_I2C_SLAVE block. We should get a compiler error
> > > even, because for !I2C_SLAVE, the client struct will not have the
> > > slave_cb member.
> > > 
> > 
> > But we don't want a compile-error for randconfig builds, and we don't
> > want unnecessary #ifdef in the driver. 
> 
> My conclusion for now is:
> 
> There needs something to be done surely, but currently I don't have the
> bandwidth to do it or even play around with it. I am not fully happy
> with your patches as well because __maybe_unused has some kind of "last
> resort" feeling to me.

I generally like __maybe_unused, but it's a matter of personal preference.
We could avoid the __maybe_unused if the reg_slave/unreg_slave callback
pointers are always available in struct i2c_algorithm.

> So, to get the build failures away immediately I'd simply submit a patch
> for the emev driver to select I2C_SLAVE and postpone the proper fix to
> later.
> 
> That being said, thanks a lot for your input. I will surely come back to it.


Just for reference, see below for my combined patch, in case you decide
to use that at a later point.

	Arnd

8<---
Subject: [PATCH] i2c: emev2 depends on i2c slave mode

The emev2 driver stopped compiling in today's linux-next kernel:

drivers/i2c/busses/i2c-emev2.c: In function 'em_i2c_slave_irq':
drivers/i2c/busses/i2c-emev2.c:233:23: error: storage size of 'event' isn't known
drivers/i2c/busses/i2c-emev2.c:250:3: error: implicit declaration of function 'i2c_slave_event' [-Werror=implicit-function-declaration]
drivers/i2c/busses/i2c-emev2.c:250:32: error: 'I2C_SLAVE_STOP' undeclared (first use in this function)

It works again if we enable CONFIG_I2C_SLAVE, but it seems  wrong
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

---

 drivers/i2c/busses/Kconfig     | 1 -
 drivers/i2c/busses/i2c-emev2.c | 8 +++++---
 drivers/i2c/busses/i2c-rcar.c  | 8 +++++---
 include/linux/i2c.h            | 4 +++-
 4 files changed, 13 insertions(+), 8 deletions(-)


diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index eaa7b4a0e484..f205b9fa7a74 100644
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
index 96bb4e749012..b01c9f30c545 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -303,7 +303,7 @@ static irqreturn_t em_i2c_irq_handler(int this_irq, void *dev_id)
 {
 	struct em_i2c_device *priv = dev_id;
 
-	if (em_i2c_slave_irq(priv))
+	if (IS_ENABLED(CONFIG_I2C_SLAVE) && em_i2c_slave_irq(priv))
 		return IRQ_HANDLED;
 
 	complete(&priv->msg_done);
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
index b2389c492579..ab7fa78b8030 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -430,7 +430,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	/* Only handle interrupts that are currently enabled */
 	msr &= rcar_i2c_read(priv, ICMIER);
 	if (!msr) {
-		if (rcar_i2c_slave_irq(priv))
+		if (IS_ENABLED(CONFIG_I2C_SLAVE) && rcar_i2c_slave_irq(priv))
 			return IRQ_HANDLED;
 
 		return IRQ_NONE;
@@ -523,7 +523,7 @@ out:
 	return ret;
 }
 
-static int rcar_reg_slave(struct i2c_client *slave)
+static int __maybe_unused rcar_reg_slave(struct i2c_client *slave)
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(slave->adapter);
 
@@ -544,7 +544,7 @@ static int rcar_reg_slave(struct i2c_client *slave)
 	return 0;
 }
 
-static int rcar_unreg_slave(struct i2c_client *slave)
+static int __maybe_unused rcar_unreg_slave(struct i2c_client *slave)
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(slave->adapter);
 
@@ -570,8 +570,10 @@ static u32 rcar_i2c_func(struct i2c_adapter *adap)
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
index bc2b19ad9357..2b0b08b183e0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -254,7 +254,6 @@ static inline void i2c_set_clientdata(struct i2c_client *dev, void *data)
 
 /* I2C slave support */
 
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 enum i2c_slave_event {
 	I2C_SLAVE_READ_REQUESTED,
 	I2C_SLAVE_WRITE_REQUESTED,
@@ -266,11 +265,14 @@ enum i2c_slave_event {
 extern int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
 extern int i2c_slave_unregister(struct i2c_client *client);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 static inline int i2c_slave_event(struct i2c_client *client,
 				  enum i2c_slave_event event, u8 *val)
 {
 	return client->slave_cb(client, event, val);
 }
+#else
+extern int i2c_slave_event(struct i2c_client *client, enum i2c_slave_event event, u8 *val);
 #endif
 
 /**
