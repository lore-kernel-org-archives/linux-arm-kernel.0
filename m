From: linuxzsc@gmail.com (Richard Zhao)
Date: Sun, 4 Oct 2009 20:23:25 +0800
Subject: [PATCH 3/4] i2c: imx: add macros and printk to make debug easy
In-Reply-To: <4e090d470910010230h387cdc88h94f33bee405e6165@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-3-git-send-email-linuxzsc@gmail.com>
	<20091001072934.GX27039@pengutronix.de>
	<4e090d470910010101r6839cc9ax4fe84f04a1afbb00@mail.gmail.com>
	<20091001082610.GB27039@pengutronix.de>
	<4e090d470910010230h387cdc88h94f33bee405e6165@mail.gmail.com>
Message-ID: <4e090d470910040523p415b56e2ycf9f163b70b37f25@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2009 at 5:30 PM, Richard Zhao <linuxzsc@gmail.com> wrote:
> On Thu, Oct 1, 2009 at 4:26 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> On Thu, Oct 01, 2009 at 04:01:50PM +0800, Richard Zhao wrote:
>>> On Thu, Oct 1, 2009 at 3:29 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>>> > On Thu, Oct 01, 2009 at 09:13:32AM +0800, Richard Zhao wrote:
>>> >> When CONFIG_I2C_DEBUG_BUS is enabled, it helps dump registers at operation
>>> >> fail condition, and print i2c_msg to xfer.
>>> >>
>>> >> Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
>>> >
>>> > Honestly I don't think we need this. It makes the driver too verbose for
>>> > my taste.
>>> >
>>> > Sascha
>>> >
>>> >
>>> >>
>>> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>>> >> index c1e541c..87faea4 100644
>>> >> --- a/drivers/i2c/busses/i2c-imx.c
>>> >> +++ b/drivers/i2c/busses/i2c-imx.c
>>> >> @@ -125,6 +125,20 @@ struct imx_i2c_struct {
>>> >> ?/** Functions for IMX I2C adapter driver ***************************************
>>> >> ?*******************************************************************************/
>>> >>
>>> >> +#ifdef CONFIG_I2C_DEBUG_BUS
>>> >> +#define reg_dump(i2c_imx) \
>>> >> +{ \
>>> >> + ? ? printk(KERN_DEBUG "fun %s:%d ", __func__, __LINE__); \
>>> >> + ? ? printk(KERN_DEBUG "IADR %02x IFDR %02x I2CR %02x I2SR %02x\n", \
>>> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_IADR), \
>>> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_IFDR), \
>>> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_I2CR), \
>>> >> + ? ? ? ? ? ? readb(i2c_imx->base + IMX_I2C_I2SR)); \
>>> >> +}
>>> >> +#else
>>> >> +#define reg_dump(i2c_imx)
>>> >> +#endif
>>> >> +
>>> >> ?static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
>>> >> ?{
>>> >> ? ? ? unsigned long orig_jiffies = jiffies;
>>> >> @@ -146,6 +160,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
>>> >> ? ? ? ? ? ? ? if (time_after(jiffies, orig_jiffies + HZ / 1000)) {
>>> >> ? ? ? ? ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev,
>>> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "<%s> I2C bus is busy\n", __func__);
>>> >> + ? ? ? ? ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >> ? ? ? ? ? ? ? ? ? ? ? return -EIO;
>>> >> ? ? ? ? ? ? ? }
>>> >> ? ? ? ? ? ? ? schedule();
>>> >> @@ -164,9 +179,11 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
>>> >>
>>> >> ? ? ? if (unlikely(result < 0)) {
>>> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0\n", __func__);
>>> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >> ? ? ? ? ? ? ? return result;
>>> >> ? ? ? } else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>>> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
>>> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >> ? ? ? ? ? ? ? return -ETIMEDOUT;
>>> >> ? ? ? }
>>> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
>>> >> @@ -178,6 +195,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
>>> >> ?{
>>> >> ? ? ? if (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
>>> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
>>> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >> ? ? ? ? ? ? ? return -EIO; ?/* No ACK */
>>> >> ? ? ? }
>>> >>
>>> >> @@ -197,17 +215,20 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>>> >> ? ? ? writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>>> >>
>>> >> ? ? ? result = i2c_imx_bus_busy(i2c_imx, 0);
>>> >> - ? ? if (result)
>>> >> + ? ? if (result) {
>>> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >> ? ? ? ? ? ? ? return result;
>>> >> + ? ? }
>>> >>
>>> >> ? ? ? /* Start I2C transaction */
>>> >> ? ? ? temp = readb(i2c_imx->base + IMX_I2C_I2CR);
>>> >> ? ? ? temp |= I2CR_MSTA;
>>> >> ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>>> >> ? ? ? result = i2c_imx_bus_busy(i2c_imx, 1);
>>> >> - ? ? if (result)
>>> >> + ? ? if (result) {
>>> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >> ? ? ? ? ? ? ? return result;
>>> >> -
>>> >> + ? ? }
>>> >> ? ? ? temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>>> >> ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>>> >> ? ? ? return result;
>>> >> @@ -228,7 +249,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>>> >> ? ? ? ?*/
>>> >> ? ? ? udelay(i2c_imx->disable_delay);
>>> >>
>>> >> - ? ? i2c_imx_bus_busy(i2c_imx, 0);
>>> >> + ? ? if (i2c_imx_bus_busy(i2c_imx, 0))
>>> >> + ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >>
>>> >> ? ? ? /* Disable I2C controller */
>>> >> ? ? ? writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>>> >> @@ -389,7 +411,18 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>>> >> ? ? ? struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
>>> >>
>>> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>>> >> -
>>> >> +#ifdef CONFIG_I2C_DEBUG_BUS
>>> >> + ? ? for (i = 0; i < num; i++) {
>>> >> + ? ? ? ? ? ? printk(KERN_DEBUG "msg%d addr %02x RD %d cnt %d d:", i,
>>> >> + ? ? ? ? ? ? ? ? ? ? msgs[i].addr, msgs[i].flags & I2C_M_RD, msgs[i].len);
>>> >> + ? ? ? ? ? ? if (!(msgs[i].flags & I2C_M_RD)) {
>>> >> + ? ? ? ? ? ? ? ? ? ? int j;
>>> >> + ? ? ? ? ? ? ? ? ? ? for (j = 0; j < msgs[i].len; j++)
>>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? printk("%02x ", msgs[i].buf[j]);
>>> >> + ? ? ? ? ? ? }
>>> >> + ? ? ? ? ? ? printk("\n");
>>> >> + ? ? }
>>> >> +#endif
>>> >> ? ? ? /* Start I2C transfer */
>>> >> ? ? ? result = i2c_imx_start(i2c_imx);
>>> >> ? ? ? if (result)
>>> >> @@ -404,8 +437,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>>> >> ? ? ? ? ? ? ? ? ? ? ? temp |= I2CR_RSTA;
>>> >> ? ? ? ? ? ? ? ? ? ? ? writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>>> >> ? ? ? ? ? ? ? ? ? ? ? result = ?i2c_imx_bus_busy(i2c_imx, 1);
>>> >> - ? ? ? ? ? ? ? ? ? ? if (result)
>>> >> + ? ? ? ? ? ? ? ? ? ? if (result) {
>>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg_dump(i2c_imx);
>>> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto fail0;
>>> >> + ? ? ? ? ? ? ? ? ? ? }
>>> >> ? ? ? ? ? ? ? }
>>> >> ? ? ? ? ? ? ? dev_dbg(&i2c_imx->adapter.dev,
>>> >> ? ? ? ? ? ? ? ? ? ? ? "<%s> transfer message: %d\n", __func__, i);
>>> >> @@ -562,7 +597,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>>> >> ? ? ? ? ? ? ? res_size, i2c_imx->res->start);
>>> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>>> >> ? ? ? ? ? ? ? i2c_imx->adapter.name);
>>> >> - ? ? dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>>> >> + ? ? dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>>> >>
>>> >> ? ? ? return 0; ? /* Return OK */
>>> >>
>>> >> --
>>> >> 1.6.0.4
>>> >>
>>> >>
>>> >
>>> > --
>>> > Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
>>> > Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>>> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
>>> > Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>>> >
>>>
>>> 1. i2c is more important bus in embedded system than PC. Many PMICs
>>> are connected to cpu via i2c. Before system boot up, we depend much on
>>> printk message.
>>> 2. When we add a new i2c device, it's easy to have problems. Maybe
>>> it's hw issue, one device fails, all ones in the same bus fails. In
>>> such condition, debug message is very helpfull.
>>
>> The driver already consists to 15% of debug statements, there is
>> definitely no need to add even more. If anything, you could concentrate
>> on making the output more useful.
> The dump_reg are only added when operation fails. It's not used to
> track function call path or anything else.
> I'm not supposed to show detailed message when there's operation fail?
> The reason to add a switch to disable it is, when i2c tools scan the
> bus, it will cause operation fail.
>
> Richard
>>
>> Sascha
>>
>> --
>> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
>> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
>> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>>
>

Hi Sascha,

Follow your suggestion. I will remove the patch.

Thanks
Richard
