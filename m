From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Mar 2014 22:26:13 +0100
Subject: [RFC PATCH] i2c: new bus driver for efm32
In-Reply-To: <20140310075558.GD2571@katana>
References: <1392027598-29015-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140310075558.GD2571@katana>
Message-ID: <20140313212613.GB15674@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Mar 10, 2014 at 08:55:58AM +0100, Wolfram Sang wrote:
> > +#include <linux/platform_data/efm32-i2c.h>
> 
> Shouldn't a new platform like efm32 be DT only?
it is, at least in mainline. My (not very strong) POV is that it's not
much effort/code size to support both. I dropped the non-DT part, it's
easily readded if need should arise.

> > +
> > +struct efm32_i2c_ddata {
> > +	struct i2c_adapter adapter;
> > +	spinlock_t lock;
> 
> No need, see later.
Ok.
 
> > ...
> > +static u32 efm32_i2c_read32(struct efm32_i2c_ddata *ddata, unsigned offset)
> > +{
> > +	return readl(ddata->base + offset);
> > +}
> > +
> > +static void efm32_i2c_write32(struct efm32_i2c_ddata *ddata,
> > +		unsigned offset, u32 value)
> > +{
> > +	writel(value, ddata->base + offset);
> > +}
> 
> Do those two really help readability?
I like them to add debug code, usually trace_printk.

> > +static void efm32_i2c_send_next_msg(struct efm32_i2c_ddata *ddata)
> > +{
> > +	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];
> > +
> > +	dev_dbg(&ddata->adapter.dev, "send msg %zu/%zu (addr = %x, flags = %x, if = %08x)\n",
> > +			ddata->current_msg, ddata->num_msgs, cur_msg->addr,
> > +			cur_msg->flags, efm32_i2c_read32(ddata, REG_IF));
> 
> Remove. We have stuff like this in the core and will soon get tracing
> functionality.
ok, dropped with several other dev_dbg.

> > +	switch (state & REG_STATE_STATE__MASK) {
> > +	case REG_STATE_STATE_IDLE:
> > +		/* arbitration lost? */
> > +		complete(&ddata->done);
> 
> If arbitration is lost, you should return -EAGAIN.
ok.

> > +		break;
> > +	case REG_STATE_STATE_WAIT:
> > +		/* huh, this shouldn't happen */
> > +		BUG();
> 
> Is this really a reason to halt the kernel?
No, probably not. What do you suggest? Reinit the hardware, report and
return an error?

> > +static int efm32_i2c_master_xfer(struct i2c_adapter *adap,
> > +		struct i2c_msg *msgs, int num)
> > +{
> > +	struct efm32_i2c_ddata *ddata = i2c_get_adapdata(adap);
> > +	int ret = -EBUSY;
> > +
> > +	spin_lock_irq(&ddata->lock);
> > +
> > +	if (ddata->msgs)
> > +		/*
> > +		 * XXX: can .master_xfer be called when the previous is still
> > +		 * running?
> > +		 */
> 
> Check the core. It has per adapter locks. So the lock can go away.
ok. So I can also drop the "if (ddata->msgs)" check, right?
 
> > +		goto out_unlock;
> > +
> > +	ddata->msgs = msgs;
> > +	ddata->num_msgs = num;
> > +	ddata->current_word = 0;
> > +	ddata->current_msg = 0;
> > +
> > +	init_completion(&ddata->done);
> 
> reinit_completion() here and init_completion() in probe.
*nod*

> > +
> > +	dev_dbg(&ddata->adapter.dev, "state: %08x, status: %08x\n",
> > +			efm32_i2c_read32(ddata, REG_STATE),
> > +			efm32_i2c_read32(ddata, REG_STATUS));
> > +
> > +	efm32_i2c_send_next_msg(ddata);
> > +
> > +	spin_unlock_irq(&ddata->lock);
> > +
> > +	wait_for_completion(&ddata->done);
> > +
> > +	spin_lock_irq(&ddata->lock);
> > +
> > +	if (ddata->current_msg >= ddata->num_msgs)
> > +		ret = ddata->num_msgs;
> > +	else
> > +		ret = -EIO;
> 
> Check Documentation/i2c/fault-codes for more fine grained responses.
ok, I have EAGAIN for arbitration lost, ENXIO for NAck in address phase
and EIO for NAck in data phase now. Sounds good?
 
> > +
> > +	ddata->msgs = NULL;
> > +
> > +out_unlock:
> > +	spin_unlock_irq(&ddata->lock);
> > +	return ret;
> > +}
> > +
> > +static u32 efm32_i2c_functionality(struct i2c_adapter *adap)
> > +{
> > +	/* XXX: some more? */
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> 
> That is usually enough. Make sure you checked SMBUS_QUICK, though
> (i2cdetect -q ...).
Both -q and -r seem to do the right thing.

> > +	ret = of_property_read_u32(np, "location", &location);
> 
> Huh? Is this an accepted binding? Doesn't look like it because of a
> generic name and IMO a specific use-case. BTW the binding documentation
> for this driver is missing.
Well, I got it in for the serial and spi driver. It wasn't without
discussion, but for lack of better approaches it was accepted. The
problem is that there are two places to care for to setup the pin muxing
on efm32. The pins that are used in the (here) i2c function are
selected in the ROUTE register in the I2C module's address space.
Still I need to configure the pins in the GPIO module as
input; pushpull; open drain or open collector (and a few more details
like driver strength). You could abstract that with a big list of
phandles and so have pinmuxing only in the pin controler device, but
that's ugly, error prone to use and implement, not understandable with
the hardware reference and (I guess) not how the hardware works
internally.
Regarding the generic name: I don't care much, but I don't have a
problem with it. IMHO it's implicitly name-spaced by the compatible
string which starts with "efm32," and so is fine. I'd like to have the
same property name for all efm32 device drivers and "location" matches
the hardware reference manual (apart from capitalization).

> > ...
> > +	/* i2c core takes care about bus numbering using an alias */
> > +	ddata->adapter.nr = -1;
> 
> In case of DT only, drop this and simply use i2c_add_adapter.
done

> 
> > +
> > +	return 0;
> > +}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to determine base address\n");
> 
> devm_ioremap_resource() checks for a valid resource. Drop this.
But resource_size doesn't ...
 
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (resource_size(res) < 0x42) {
> > +		dev_err(&pdev->dev, "memory resource too small\n");
> > +		return -EINVAL;
> > +	}
> 
> I'd drop this check since, but I won't force you to.
I'd understand your sentence with s/since//, not sure about it as is.
Anyhow, I like this check.

> > +	rate = clk_get_rate(ddata->clk);
> > +	if (!rate) {
> > +		dev_err(&pdev->dev, "there is no input clock available\n");
> > +		ret = -EIO;
> > +		goto err_disable_clk;
> > +	}
> > +	clkdiv = DIV_ROUND_UP(rate, 8 * ddata->pdata.frequency) - 1;
> > +	if (clkdiv >= 0x200) {
> > +		dev_err(&pdev->dev,
> > +				"input clock too fast (%lu) to divide down to bus freq (%lu)",
> > +				rate, ddata->pdata.frequency);
> > +		ret = -EIO;
> > +		goto err_disable_clk;
> > +	}
> 
> -EIO for clocks errors? Is this common?
Changed to ENODEV. Ok?

> > +static int efm32_i2c_remove(struct platform_device *pdev)
> > +{
> > +	struct efm32_i2c_ddata *ddata = platform_get_drvdata(pdev);
> > +
> > +	free_irq(ddata->irq, ddata);
> > +	clk_disable_unprepare(ddata->clk);
> 
> No i2c_del_adapter()?
added.

I fixed the driver in my tree for now, will resend when we settled on
the things still open.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
