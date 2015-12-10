From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 14:51 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <20151210133446.GC1573@katana>
References: <2144222.LfzPx9mJ0p@wuerfel> <20151210133446.GC1573@katana>
Message-ID: <2319149.G7spjXxTsa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 14:34:46 Wolfram Sang wrote:
> On Thu, Dec 10, 2015 at 02:14:49PM +0100, Arnd Bergmann wrote:
> > The emev2 driver stopped compiling in today's linux-next kernel:
> > 
> > drivers/i2c/busses/i2c-emev2.c: In function 'em_i2c_slave_irq':
> > drivers/i2c/busses/i2c-emev2.c:233:23: error: storage size of 'event' isn't known
> > drivers/i2c/busses/i2c-emev2.c:250:3: error: implicit declaration of function 'i2c_slave_event' [-Werror=implicit-function-declaration]
> > drivers/i2c/busses/i2c-emev2.c:250:32: error: 'I2C_SLAVE_STOP' undeclared (first use in this function)
> > 
> > It works again if we enable CONFIG_I2C_SLAVE, but it seems wrong
> > to add a dependency on that symbol:
> > 
> > * The symbol is user-selectable, but only one or two (including this
> >   one) bus drivers actually implement it, and it makes no sense
> >   if you don't have one of them.
> > 
> > * The other driver (R-Car) uses 'select I2C_SLAVE', which seems
> >   reasonable in principle, but we should not do that on user
> >   visible symbols.
> > 
> > * I2C slave mode could be implemented in a lot of other drivers
> >   as an optional feature, but we shouldn't require enabling it
> >   if we don't use it.
> > 
> > This changes the two drivers that provide I2C slave mode so they
> > can again build if the slave mode being disabled. To do this, I
> > move the definition of i2c_slave_event() and enum i2c_slave_event
> > out of the #ifdef and instead make the assignment of the reg_slave
> > and unreg_slave pointers optional in the bus drivers. The functions
> > implementing the feature are unused in that case, so they get
> > marked as __maybe_unused in order to still give compile-time
> > coverage.
> 
> Thanks a lot! Making this clear and consistent was on my todo-list,
> unfortunately below some other items.
> 
> Both drivers have quite orthogonal slave_irq routines. What do you think
> about grouping this and the reg/unreg-calls together and compile them
> conditionally on I2C_SLAVE? I think the code savings are worth it.

Ah, I had missed that part, good point. The change below should take
care of leaving out the extra code here. Do you want to just fold that
in?

	Arnd

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index 75d6095c5fe1..b01c9f30c545 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -303,7 +303,7 @@ static irqreturn_t em_i2c_irq_handler(int this_irq, void *dev_id)
 {
 	struct em_i2c_device *priv = dev_id;
 
-	if (em_i2c_slave_irq(priv))
+	if (IS_ENABLED(CONFIG_I2C_SLAVE) && em_i2c_slave_irq(priv))
 		return IRQ_HANDLED;
 
 	complete(&priv->msg_done);
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index e67824adeba0..a1ea66d6267e 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -428,7 +428,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	/* Only handle interrupts that are currently enabled */
 	msr &= rcar_i2c_read(priv, ICMIER);
 	if (!msr) {
-		if (rcar_i2c_slave_irq(priv))
+		if (IS_ENABLED(CONFIG_I2C_SLAVE) && rcar_i2c_slave_irq(priv))
 			return IRQ_HANDLED;
 
 		return IRQ_NONE;
