From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 Sep 2009 16:06:12 +0200
Subject: [PATCH] i2c: imx: check busy bit when START/STOP
In-Reply-To: <4e090d470909290654r6fb36cb4h505662c7cb84b1f8@mail.gmail.com>
References: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
	<20090929132505.GM27039@pengutronix.de>
	<4e090d470909290654r6fb36cb4h505662c7cb84b1f8@mail.gmail.com>
Message-ID: <20090929140612.GN27039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2009 at 09:54:05PM +0800, Richard Zhao wrote:
> Thanks, Sacha. See comments inline.
> 
> On Tue, Sep 29, 2009 at 9:25 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Richard,
> >
> >
> > On Tue, Sep 29, 2009 at 07:41:44PM +0800, Richard Zhao wrote:
> >> After START, wait busy bit to be set and
> >> after STOP, wait busy bit to be clear.
> >>
> >> Disable clock when it's possible to save power.
> >>
> >> Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
> >> ---
> >> ?drivers/i2c/busses/i2c-imx.c | ?116 ++++++++++++++++++++++++++++++++----------
> >> ?1 files changed, 88 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> >> index 4afba3e..59cde70 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -120,19 +120,40 @@ struct imx_i2c_struct {
> >> ? ? ? wait_queue_head_t ? ? ? queue;
> >> ? ? ? unsigned long ? ? ? ? ? i2csr;
> >> ? ? ? unsigned int ? ? ? ? ? ?disable_delay;
> >> + ? ? unsigned int ? ? ? ? ? ?ifdr; /* IMX_I2C_IFDR */
> >> ?};
> >>
> >> ?/** Functions for IMX I2C adapter driver
> >> ***************************************
> >> ?*******************************************************************************/
> >>
> >> -static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
> >> +#ifdef CONFIG_I2C_DEBUG_BUS
> >> +#define reg_dump(i2c_imx) \
> >> +{ \
> >> + ? ? printk(KERN_DEBUG "fun %s:%d ", __func__, __LINE__); \
> >> + ? ? printk(KERN_DEBUG "IADR %02x IFDR %02x I2CR %02x I2SR %02x\n", \
> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_IADR), \
> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_IFDR), \
> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_I2CR), \
> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_I2SR)); \
> >> +}
> >> +#else
> >> +#define reg_dump(i2c_imx)
> >> +#endif
> >> +
> >
> > Can you please remove this reg_dump? If we really need this it should be
> > in an extra patch and not clutter this one.
> I think it's needed. It helps much to debug and don't effect
> performance by default.
> >
> >> +static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
> >> ?{
> >> ? ? ? unsigned long orig_jiffies = jiffies;
> >> + ? ? unsigned int temp;
> >>
> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >>
> >> ? ? ? /* wait for bus not busy */
> >
> > This comment seems wrong now. This function waits for busy or not busy
> > depending on for_busy.
> Right. Thanks
> >
> >> - ? ? while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) {
> >> + ? ? temp = readb(i2c_imx->base + IMX_I2C_I2SR);
> >> + ? ? while (1) {
> >> + ? ? ? ? ? ? if (for_busy && (temp & I2SR_IBB))
> >> + ? ? ? ? ? ? ? ? ? ? break;
> >> + ? ? ? ? ? ? if (!for_busy && !(temp & I2SR_IBB))
> >> + ? ? ? ? ? ? ? ? ? ? break;
> >> ? ? ? ? ? ? ? if (signal_pending(current)) {
> >> ? ? ? ? ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev,
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "<%s> I2C Interrupted\n", __func__);
> >> @@ -141,9 +162,11 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
> >> ? ? ? ? ? ? ? if (time_after(jiffies, orig_jiffies + HZ / 1000)) {
> >> ? ? ? ? ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev,
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "<%s> I2C bus is busy\n", __func__);
> >> + ? ? ? ? ? ? ? ? ? ? reg_dump(i2c_imx);
> >> ? ? ? ? ? ? ? ? ? ? ? return -EIO;
> >> ? ? ? ? ? ? ? }
> >> ? ? ? ? ? ? ? schedule();
> >> + ? ? ? ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2SR);
> >> ? ? ? }
> >>
> >> ? ? ? return 0;
> >> @@ -158,9 +181,11 @@ static int i2c_imx_trx_complete(struct
> >> imx_i2c_struct *i2c_imx)
> >>
> >> ? ? ? if (unlikely(result < 0)) {
> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0\n", __func__);
> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
> >> ? ? ? ? ? ? ? return result;
> >> ? ? ? } else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
> >> ? ? ? ? ? ? ? return -ETIMEDOUT;
> >> ? ? ? }
> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
> >> @@ -172,6 +197,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
> >> ?{
> >> ? ? ? if (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
> >> ? ? ? ? ? ? ? return -EIO; ?/* No ACK */
> >> ? ? ? }
> >>
> >> @@ -179,20 +205,37 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
> >> ? ? ? return 0;
> >> ?}
> >>
> >> -static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> >> +static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> >> ?{
> >> ? ? ? unsigned int temp = 0;
> >> + ? ? int result;
> >>
> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >>
> >> + ? ? clk_enable(i2c_imx->clk);
> >> + ? ? writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
> >> ? ? ? /* Enable I2C controller */
> >> + ? ? writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> >> ? ? ? writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> >> +
> >> + ? ? result = i2c_imx_bus_busy(i2c_imx, 0);
> >> + ? ? if (result) {
> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
> >> + ? ? ? ? ? ? return result;
> >> + ? ? }
> >> +
> >> ? ? ? /* Start I2C transaction */
> >> ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> >> ? ? ? temp |= I2CR_MSTA;
> >> ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> >> + ? ? result = i2c_imx_bus_busy(i2c_imx, 1);
> >> + ? ? if (result) {
> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
> >> + ? ? ? ? ? ? return result;
> >> + ? ? }
> >> ? ? ? temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> >> ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> >> + ? ? return result;
> >> ?}
> >>
> >> ?static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> >> @@ -202,18 +245,21 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> >> ? ? ? /* Stop I2C transaction */
> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >> ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> >> - ? ? temp &= ~I2CR_MSTA;
> >> + ? ? temp &= ~(I2CR_MSTA | I2CR_MTX);
> >
> > This change seems unrelated. Is it necessary?
> Yes. It's about STOP. It's better clear MTX. We must generate STOP
> before read the last byte of Data register. If not, there will be an
> extra 9bit clock.
> >
> >> ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> >> - ? ? /* setup chip registers to defaults */
> >> - ? ? writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> >> - ? ? writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> >> ? ? ? /*
> >> ? ? ? ?* This delay caused by an i.MXL hardware bug.
> >> ? ? ? ?* If no (or too short) delay, no "STOP" bit will be generated.
> >> ? ? ? ?*/
> >> ? ? ? udelay(i2c_imx->disable_delay);
> >> +
> >> +
> >
> > double blank line
> Right.
> >
> >> + ? ? if (i2c_imx_bus_busy(i2c_imx, 0))
> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
> >> +
> >> ? ? ? /* Disable I2C controller */
> >> ? ? ? writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> >> + ? ? clk_disable(i2c_imx->clk);
> >> ?}
> >>
> >> ?static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> >> @@ -233,17 +279,19 @@ static void __init i2c_imx_set_clk(struct
> >> imx_i2c_struct *i2c_imx,
> >> ? ? ? else
> >> ? ? ? ? ? ? ? for (i = 0; i2c_clk_div[i][0] < div; i++);
> >>
> >> - ? ? /* Write divider value to register */
> >> - ? ? writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
> >
> > Why can't we write this value directly anymore...
> clock will be enable/disable in start/stop
> >
> >> -
> >> - ? ? /*
> >> - ? ? ?* There dummy delay is calculated.
> >> - ? ? ?* It should be about one I2C clock period long.
> >> - ? ? ?* This delay is used in I2C bus disable function
> >> - ? ? ?* to fix chip hardware bug.
> >> - ? ? ?*/
> >> - ? ? i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
> >> - ? ? ? ? ? ? + (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
> >> + ? ? /* Store divider value */
> >> + ? ? i2c_imx->ifdr = i2c_clk_div[i][1];
> >
> > ...but have to store it in a variable instead?
> To save power, because i2c is not aways be accessed, and it's very low
> speed bus.
> >
> >> +
> >> + ? ? if (cpu_is_mx1()) {
> >> + ? ? ? ? ? ? /*
> >> + ? ? ? ? ? ? ?* There dummy delay is calculated.
> >> + ? ? ? ? ? ? ?* It should be about one I2C clock period long.
> >> + ? ? ? ? ? ? ?* This delay is used in I2C bus disable function
> >> + ? ? ? ? ? ? ?* to fix chip hardware bug.
> >> + ? ? ? ? ? ? ?*/
> >> + ? ? ? ? ? ? i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
> >> + ? ? ? ? ? ? ? ? ? ? + (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
> >> + ? ? }
> >>
> >> ? ? ? /* dev_dbg() can't be used, because adapter is not yet registered */
> >> ?#ifdef CONFIG_I2C_DEBUG_BUS
> >> @@ -344,7 +392,7 @@ static int i2c_imx_read(struct imx_i2c_struct
> >> *i2c_imx, struct i2c_msg *msgs)
> >> ? ? ? ? ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev,
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "<%s> clear MSTA\n", __func__);
> >> ? ? ? ? ? ? ? ? ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> >> - ? ? ? ? ? ? ? ? ? ? temp &= ~I2CR_MSTA;
> >> + ? ? ? ? ? ? ? ? ? ? temp &= ~(I2CR_MSTA | I2CR_MTX);
> >> ? ? ? ? ? ? ? ? ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> >> ? ? ? ? ? ? ? } else if (i == (msgs->len - 2)) {
> >> ? ? ? ? ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev,
> >> @@ -369,14 +417,24 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> >> ? ? ? struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
> >>
> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >> -
> >> +#ifdef CONFIG_I2C_DEBUG_BUS
> >> + ? ? for (i = 0; i < num; i++) {
> >> + ? ? ? ? ? ? printk(KERN_DEBUG "msg%d addr %02x RD %d cnt %d d:", i,
> >> + ? ? ? ? ? ? ? ? ? ? msgs[i].addr, msgs[i].flags & I2C_M_RD, msgs[i].len);
> >> + ? ? ? ? ? ? if (!(msgs[i].flags & I2C_M_RD)) {
> >> + ? ? ? ? ? ? ? ? ? ? int j;
> >> + ? ? ? ? ? ? ? ? ? ? for (j = 0; j < msgs[i].len; j++)
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? printk("%02x ", msgs[i].buf[j]);
> >> + ? ? ? ? ? ? }
> >> + ? ? ? ? ? ? printk("\n");
> >> + ? ? }
> >> +#endif
> >> ? ? ? /* Check if i2c bus is not busy */
> >> - ? ? result = i2c_imx_bus_busy(i2c_imx);
> >> - ? ? if (result)
> >> - ? ? ? ? ? ? goto fail0;
> >
> > When removing the code you should also remove the comment.
> Right
> >
> >>
> >> ? ? ? /* Start I2C transfer */
> >> - ? ? i2c_imx_start(i2c_imx);
> >> + ? ? result = i2c_imx_start(i2c_imx);
> >> + ? ? if (result)
> >> + ? ? ? ? ? ? goto fail0;
> >>
> >> ? ? ? /* read/write data */
> >> ? ? ? for (i = 0; i < num; i++) {
> >> @@ -386,6 +444,11 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> >> ? ? ? ? ? ? ? ? ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> >> ? ? ? ? ? ? ? ? ? ? ? temp |= I2CR_RSTA;
> >> ? ? ? ? ? ? ? ? ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> >> + ? ? ? ? ? ? ? ? ? ? result = ?i2c_imx_bus_busy(i2c_imx, 1);
> >> + ? ? ? ? ? ? ? ? ? ? if (result) {
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg_dump(i2c_imx);
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto fail0;
> >> + ? ? ? ? ? ? ? ? ? ? }
> >> ? ? ? ? ? ? ? }
> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev,
> >> ? ? ? ? ? ? ? ? ? ? ? "<%s> transfer message: %d\n", __func__, i);
> >> @@ -442,7 +505,7 @@ static int __init i2c_imx_probe(struct
> >> platform_device *pdev)
> >> ? ? ? int irq;
> >> ? ? ? int ret;
> >>
> >> - ? ? dev_dbg(&pdev->dev, "<%s>\n", __func__);
> >> + ? ? dev_info(&pdev->dev, "<%s>\n", __func__);
> >
> > no
> Why? I even don't know how many i2c controllers we have, if I didn't
> get sysfs working. And it only print once.
> >
> >>
> >> ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> ? ? ? if (!res) {
> >> @@ -500,7 +563,6 @@ static int __init i2c_imx_probe(struct
> >> platform_device *pdev)
> >> ? ? ? ? ? ? ? dev_err(&pdev->dev, "can't get I2C clock\n");
> >> ? ? ? ? ? ? ? goto fail3;
> >> ? ? ? }
> >> - ? ? clk_enable(i2c_imx->clk);
> >
> > I think it's generally a good idea to start/stop the clocks when needed
> > as you do here. It should be an extra patch though.
> You think I should split the patch to three: IBB, reg_dump, clk dis/en ?
> The idea is good, more easy to revert. but sometimes, I think it make
> small things too complex.
> Anyway, I'll follow your suggestion.

In case of regressions everybody will thank you for doing it.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
