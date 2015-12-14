From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Dec 2015 23:27:22 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <20151214135206.GA1520@katana>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <15285750.UWXWiNJ6YU@wuerfel> <20151214135206.GA1520@katana>
Message-ID: <13702087.6o87OAVdIx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 December 2015 14:52:06 Wolfram Sang wrote:
> > > What about not ifdeffing the inline function and keep the build error
> > > whenever someone uses it without I2C_SLAVE being selected?
> > 
> > The inline function is only added there for the case that I2C_SLAVE is
> > disabled, so that would be pointless.
> > 
> > However, what we could do is move the extern declaration outside of
> > the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
> > check should then ensure that it never actually gets called, and we
> > get a link error if some driver gets it wrong.
> 
> Yes, that's what I meant: move the whole function (as it was before your
> patch) out of the CONFIG_I2C_SLAVE block. We should get a compiler error
> even, because for !I2C_SLAVE, the client struct will not have the
> slave_cb member.
> 

But we don't want a compile-error for randconfig builds, and we don't
want unnecessary #ifdef in the driver. 

This change on top of my earlier patch should do what I meant:

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0236e5f2b5be..536641bad92d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -265,15 +265,15 @@ enum i2c_slave_event {
 extern int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
 extern int i2c_slave_unregister(struct i2c_client *client);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 static inline int i2c_slave_event(struct i2c_client *client,
 				  enum i2c_slave_event event, u8 *val)
 {
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	return client->slave_cb(client, event, val);
+}
 #else
-	return 0;
+extern int i2c_slave_event(struct i2c_client *client, enum i2c_slave_event event, u8 *val);
 #endif
-}
 
 /**
  * struct i2c_board_info - template for device creation



	Arnd
