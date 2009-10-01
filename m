From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Oct 2009 10:38:31 +0200
Subject: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
In-Reply-To: <4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com>
Message-ID: <20091001083831.GD27039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 04:03:20PM +0800, Richard Zhao wrote:
> On Thu, Oct 1, 2009 at 9:13 AM, Richard Zhao <linuxzsc@gmail.com> wrote:
> > After START/RESTART, wait for busy bit to be set and
> > after STOP, wait for busy bit to be clear.
> >
> > Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > index 4afba3e..156cc95 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -125,14 +125,19 @@ struct imx_i2c_struct {
> > ?/** Functions for IMX I2C adapter driver ***************************************
> > ?*******************************************************************************/
> >
> > -static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
> > +static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
> > ?{
> > ? ? ? ?unsigned long orig_jiffies = jiffies;
> > + ? ? ? unsigned int temp;
> >
> > ? ? ? ?dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > - ? ? ? /* wait for bus not busy */
> > - ? ? ? while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) {
> > + ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2SR);
> > + ? ? ? while (1) {
> > + ? ? ? ? ? ? ? if (for_busy && (temp & I2SR_IBB))
> > + ? ? ? ? ? ? ? ? ? ? ? break;
> > + ? ? ? ? ? ? ? if (!for_busy && !(temp & I2SR_IBB))
> > + ? ? ? ? ? ? ? ? ? ? ? break;
> > ? ? ? ? ? ? ? ?if (signal_pending(current)) {
> > ? ? ? ? ? ? ? ? ? ? ? ?dev_dbg(&i2c_imx->adapter.dev,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"<%s> I2C Interrupted\n", __func__);
> > @@ -144,6 +149,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
> > ? ? ? ? ? ? ? ? ? ? ? ?return -EIO;
> > ? ? ? ? ? ? ? ?}
> > ? ? ? ? ? ? ? ?schedule();
> > + ? ? ? ? ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2SR);
> > ? ? ? ?}
> >
> > ? ? ? ?return 0;
> > @@ -179,20 +185,32 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
> > ? ? ? ?return 0;
> > ?}
> >
> > -static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> > +static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> > ?{
> > ? ? ? ?unsigned int temp = 0;
> > + ? ? ? int result;
> >
> > ? ? ? ?dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > ? ? ? ?/* Enable I2C controller */
> > + ? ? ? writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> > ? ? ? ?writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> > +
> > + ? ? ? result = i2c_imx_bus_busy(i2c_imx, 0);
> > + ? ? ? if (result)
> > + ? ? ? ? ? ? ? return result;
> > +
> > ? ? ? ?/* Start I2C transaction */
> > ? ? ? ?temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> > ? ? ? ?temp |= I2CR_MSTA;
> > ? ? ? ?writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > + ? ? ? result = i2c_imx_bus_busy(i2c_imx, 1);
> > + ? ? ? if (result)
> > + ? ? ? ? ? ? ? return result;
> > +
> > ? ? ? ?temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> > ? ? ? ?writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > + ? ? ? return result;
> > ?}
> >
> > ?static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> > @@ -202,16 +220,16 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> > ? ? ? ?/* Stop I2C transaction */
> > ? ? ? ?dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> > ? ? ? ?temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> > - ? ? ? temp &= ~I2CR_MSTA;
> > + ? ? ? temp &= ~(I2CR_MSTA | I2CR_MTX);
> > ? ? ? ?writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > - ? ? ? /* setup chip registers to defaults */
> > - ? ? ? writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> > - ? ? ? writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> > ? ? ? ?/*
> > ? ? ? ? * This delay caused by an i.MXL hardware bug.
> > ? ? ? ? * If no (or too short) delay, no "STOP" bit will be generated.
> > ? ? ? ? */
> > ? ? ? ?udelay(i2c_imx->disable_delay);
> > +
> > + ? ? ? i2c_imx_bus_busy(i2c_imx, 0);
> > +
> > ? ? ? ?/* Disable I2C controller */
> > ? ? ? ?writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> > ?}
> > @@ -344,7 +362,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
> > ? ? ? ? ? ? ? ? ? ? ? ?dev_dbg(&i2c_imx->adapter.dev,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"<%s> clear MSTA\n", __func__);
> > ? ? ? ? ? ? ? ? ? ? ? ?temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> > - ? ? ? ? ? ? ? ? ? ? ? temp &= ~I2CR_MSTA;
> > + ? ? ? ? ? ? ? ? ? ? ? temp &= ~(I2CR_MSTA | I2CR_MTX);
> > ? ? ? ? ? ? ? ? ? ? ? ?writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > ? ? ? ? ? ? ? ?} else if (i == (msgs->len - 2)) {
> > ? ? ? ? ? ? ? ? ? ? ? ?dev_dbg(&i2c_imx->adapter.dev,
> > @@ -370,14 +388,11 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> >
> > ? ? ? ?dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > - ? ? ? /* Check if i2c bus is not busy */
> > - ? ? ? result = i2c_imx_bus_busy(i2c_imx);
> > + ? ? ? /* Start I2C transfer */
> > + ? ? ? result = i2c_imx_start(i2c_imx);
> > ? ? ? ?if (result)
> > ? ? ? ? ? ? ? ?goto fail0;
> >
> > - ? ? ? /* Start I2C transfer */
> > - ? ? ? i2c_imx_start(i2c_imx);
> > -
> > ? ? ? ?/* read/write data */
> > ? ? ? ?for (i = 0; i < num; i++) {
> > ? ? ? ? ? ? ? ?if (i) {
> > @@ -386,6 +401,9 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> > ? ? ? ? ? ? ? ? ? ? ? ?temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> > ? ? ? ? ? ? ? ? ? ? ? ?temp |= I2CR_RSTA;
> > ? ? ? ? ? ? ? ? ? ? ? ?writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > + ? ? ? ? ? ? ? ? ? ? ? result = ?i2c_imx_bus_busy(i2c_imx, 1);
> > + ? ? ? ? ? ? ? ? ? ? ? if (result)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto fail0;
> > ? ? ? ? ? ? ? ?}
> > ? ? ? ? ? ? ? ?dev_dbg(&i2c_imx->adapter.dev,
> > ? ? ? ? ? ? ? ? ? ? ? ?"<%s> transfer message: %d\n", __func__, i);
> > --
> > 1.6.0.4
> >
> >
> 
> Hi Sascha,
> 
> So I assume you have no comments about this patch ?

No, I'm still thinking about it. The commit message says *what* you're
doing, but not *why*. Is it a concrete bug that you fix or is it just
because it might be a good idea to do so?
Also, we leave i2c_imx_xfer with the controller in a well defined state.
So if we leave this function with the controller in non busy state, why
do we have to check for non busy again when we enter it again?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
