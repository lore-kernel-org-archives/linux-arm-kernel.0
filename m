From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Jun 2017 10:58:17 +0800
Subject: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <20170619193130.velebm7p3r5ggaos@ninjato>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
Message-ID: <20170620025815.GA4818@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for taking time help review.

On Mon, Jun 19, 2017 at 09:31:30PM +0200, Wolfram Sang wrote:
> Hi Shawn,
> 
> On Sun, May 28, 2017 at 12:59:36PM +0800, Shawn Guo wrote:
> > From: Baoyou Xie <baoyou.xie@linaro.org>
> > 
> > This patch adds i2c controller driver for ZTE's zx2967 family.
> > 
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Jun Nie <jun.nie@linaro.org>
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> What about this patch from the old series updating the MAINTAINERS entry?
> I think it is a good idea?
> 
> http://patchwork.ozlabs.org/patch/731006/

Oh, yes, I should have mentioned it in the cover-letter.  Instead of
changing MAINTAINERS file in different subsystem patch series, which may
introduce merge conflicts, we plan to update it with a separate patch
adding all driver entries that lands on mainline, and get it in through
arm-soc tree.  Are you okay with that?

> 
> > ---
> >  drivers/i2c/busses/Kconfig      |   9 +
> >  drivers/i2c/busses/Makefile     |   1 +
> >  drivers/i2c/busses/i2c-zx2967.c | 610 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 620 insertions(+)
> >  create mode 100644 drivers/i2c/busses/i2c-zx2967.c
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 144cbadc7c72..f9f0ed61df2e 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -1258,4 +1258,13 @@ config I2C_OPAL
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called as i2c-opal.
> >  
> > +config I2C_ZX2967
> > +	tristate "ZTE ZX2967 I2C support"
> > +	depends on ARCH_ZX
> 
> || COMPILE_TEST?

Yeah, good suggestion.

> 
> > +	default y
> > +	help
> > +	  Selecting this option will add ZX2967 I2C driver.
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called i2c-zx2967.
> > +
> >  endmenu
> 
> ...
> 
> > +static int zx2967_i2c_reset_hardware(struct zx2967_i2c_info *zx_i2c)
> > +{
> > +	u32 val;
> > +	u32 clk_div;
> > +	u32 status;
> > +
> > +	val = I2C_MASTER | I2C_IRQ_MSK_ENABLE;
> > +	zx2967_i2c_writel(zx_i2c, val, REG_CMD);
> > +
> > +	clk_div = clk_get_rate(zx_i2c->clk) / zx_i2c->clk_freq - 1;
> > +	zx2967_i2c_writel(zx_i2c, clk_div, REG_CLK_DIV_FS);
> > +	zx2967_i2c_writel(zx_i2c, clk_div, REG_CLK_DIV_HS);
> > +
> > +	zx2967_i2c_writel(zx_i2c, I2C_FIFO_MAX - 1, REG_WRCONF);
> > +	zx2967_i2c_writel(zx_i2c, I2C_FIFO_MAX - 1, REG_RDCONF);
> > +	zx2967_i2c_writel(zx_i2c, 1, REG_RDCONF);
> > +
> > +	zx2967_i2c_flush_fifos(zx_i2c);
> > +
> > +	status = zx2967_i2c_readl(zx_i2c, REG_STAT);
> > +	if (status & I2C_SR_BUSY)
> > +		return -EBUSY;
> > +	if (status & (I2C_SR_EDEVICE | I2C_SR_EDATA))
> > +		return -EIO;
> 
> Is this the error handling (NACK, etc)? Then, it got lost now since we
> don't reset the hardware anymore after timeouts. But that would have
> meant that errors are only detected after the timeout was reached
> instead of instantly? If so, no good design. But maybe I misunderstand.

Hmm, this doesn't make too much sense now, since this reset function is
only being called at probe time to ensure the device is in a sane
initial state.  There is no data transfer happening at this point at
all.  I will drop these error bits checking from here, and add the error
handling in irq handler.

> 
> > +
> > +	enable_irq(zx_i2c->irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static void zx2967_i2c_isr_clr(struct zx2967_i2c_info *zx_i2c)
> > +{
> > +	u32 status;
> > +
> > +	status = zx2967_i2c_readl(zx_i2c, REG_STAT);
> > +	status |= I2C_IRQ_ACK_CLEAR;
> > +	zx2967_i2c_writel(zx_i2c, status, REG_STAT);
> > +}
> > +
> > +static irqreturn_t zx2967_i2c_isr(int irq, void *dev_id)
> > +{
> > +	u32 status;
> > +	struct zx2967_i2c_info *zx_i2c = (struct zx2967_i2c_info *)dev_id;
> > +
> > +	status = zx2967_i2c_readl(zx_i2c, REG_STAT) & I2C_INT_MASK;
> > +	zx2967_i2c_isr_clr(zx_i2c);
> > +
> > +	if (status & I2C_ERROR_MASK)
> > +		return IRQ_HANDLED;
> 
> I would have expected the error handling here.

Yes, we should check error status here.

> 
> > +
> > +	if (status & I2C_TRANS_DONE)
> > +		complete(&zx_i2c->complete);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> ...
> 
> > +static int zx2967_smbus_xfer_read(struct zx2967_i2c_info *zx_i2c, int size,
> > +				  union i2c_smbus_data *data)
> > +{
> > +	unsigned long time_left;
> > +	u8 buf[2];
> > +	u32 val;
> > +
> > +	reinit_completion(&zx_i2c->complete);
> > +
> > +	val = zx2967_i2c_readl(zx_i2c, REG_CMD);
> > +	val |= I2C_CMB_RW_EN;
> > +	zx2967_i2c_writel(zx_i2c, val, REG_CMD);
> > +
> > +	val = zx2967_i2c_readl(zx_i2c, REG_CMD);
> > +	val |= I2C_START;
> > +	zx2967_i2c_writel(zx_i2c, val, REG_CMD);
> > +
> > +	time_left = wait_for_completion_timeout(&zx_i2c->complete,
> > +						I2C_TIMEOUT);
> > +	if (time_left == 0)
> > +		return -ETIMEDOUT;
> > +
> > +	switch (size) {
> > +	case I2C_SMBUS_BYTE:
> > +	case I2C_SMBUS_BYTE_DATA:
> > +		val = zx2967_i2c_readl(zx_i2c, REG_DATA);
> > +		data->byte = val;
> > +		break;
> > +	case I2C_SMBUS_WORD_DATA:
> > +	case I2C_SMBUS_PROC_CALL:
> > +		buf[0] = zx2967_i2c_readl(zx_i2c, REG_DATA);
> > +		buf[1] = zx2967_i2c_readl(zx_i2c, REG_DATA);
> > +		data->word = (buf[0] << 8) | buf[1];
> > +		break;
> > +	default:
> > +		dev_warn(DEV(zx_i2c), "Unsupported transaction %d\n", size);
> 
> I wouldn't print something here. If an unsupported SMBus transfer is
> used, your driver will fall back to emulate them via I2C. No need to
> print a warning then.

Okay, will drop it.

> 
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +#define ZX2967_I2C_FUNCS (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |	\
> > +		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |	\
> > +		I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL |	\
> > +		I2C_FUNC_I2C | I2C_FUNC_SMBUS_I2C_BLOCK)
> > +
> > +static u32 zx2967_i2c_func(struct i2c_adapter *adap)
> > +{
> > +	return ZX2967_I2C_FUNCS;
> > +}
> 
> No strong opinion but I think we can return that value directly without
> a define.

I do not have a strong opinion either, but since you ask, I will do what
you are asking here.

> 
> ...
> 
> > +	ret = i2c_add_numbered_adapter(&zx_i2c->adap);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to add zx2967 i2c adapter\n");
> 
> Drop the message, the core will do the reporting.

Okay, will do.

> 
> > +		goto err_clk_unprepare;
> > +	}
> 
> How was this driver tested BTW?

The driver is being used to access an Audio codec on the I2C bus.

Shawn
