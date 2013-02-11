From: wolfram@the-dreams.de (Wolfram Sang)
Date: Mon, 11 Feb 2013 23:52:08 +0100
Subject: [PATCH V3] i2c: add bcm2835 driver
In-Reply-To: <1360381978-26092-1-git-send-email-swarren@wwwdotorg.org>
References: <1360381978-26092-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130211225208.GA9893@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Feb 08, 2013 at 08:52:58PM -0700, Stephen Warren wrote:
> This implements a very basic I2C host driver for the BCM2835 SoC. Missing
> features so far are:
> 
> * 10-bit addressing.
> * DMA.
> 
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---

...

> +struct bcm2835_i2c_dev {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct i2c_adapter adapter;
> +	struct completion completion;
> +	u32 msg_err;
> +	u8 *msg_buf;
> +	size_t msg_buf_remaining;
> +};
> +
> +static inline void bcm2835_i2c_writel(struct bcm2835_i2c_dev *i2c_dev,
> +				      u32 reg, u32 val)
> +{
> +	writel(val, i2c_dev->regs + reg);
> +}
> +
> +static inline u32 bcm2835_i2c_readl(struct bcm2835_i2c_dev *i2c_dev, u32 reg)
> +{
> +	return readl(i2c_dev->regs + reg);
> +}

Hmm, not sure if those functions add readability, but no need to change.

> +
> +static void bcm2835_fill_txfifo(struct bcm2835_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +
> +	for (;;) {
> +		if (!i2c_dev->msg_buf_remaining)
> +			return;
> +		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
> +		if (!(val & BCM2835_I2C_S_TXD))
> +			break;
> +		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_FIFO,
> +				   *i2c_dev->msg_buf);
> +		i2c_dev->msg_buf++;
> +		i2c_dev->msg_buf_remaining--;
> +	}

while (i2c_dev->msg_buf_remaining) ...

?

> +}
> +
> +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +
> +	for (;;) {
> +		if (!i2c_dev->msg_buf_remaining)
> +			return;
> +		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
> +		if (!(val & BCM2835_I2C_S_RXD))
> +			break;
> +		*i2c_dev->msg_buf = bcm2835_i2c_readl(i2c_dev,
> +						      BCM2835_I2C_FIFO);
> +		i2c_dev->msg_buf++;
> +		i2c_dev->msg_buf_remaining--;
> +	}

ditto?

...

> +	ret = wait_for_completion_timeout(&i2c_dev->completion,
> +					  BCM2835_I2C_TIMEOUT);
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
> +	if (WARN_ON(ret == 0)) {
> +		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> +		return -ETIMEDOUT;
> +	}

I'd suggest to skip the WARN_ON. Timeout is the expected case when you
want to read from an EEPROM which is just in the process of
erasing/writing data from the previous command.

...

> +	adap = &i2c_dev->adapter;
> +	i2c_set_adapdata(adap, i2c_dev);
> +	adap->owner = THIS_MODULE;
> +	adap->class = I2C_CLASS_HWMON;

Do you really need the class?

> +	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
> +	adap->algo = &bcm2835_i2c_algo;
> +	adap->dev.parent = &pdev->dev;
> +	adap->nr = -1;

If you are using '-1' anyhow, you could skip setting it and simply call
i2c_add_adapter(). Or you can init it here to pdev->id. Whatever you
prefer.

> +
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
> +
> +	return i2c_add_numbered_adapter(adap);
> +}
> +
> +static int bcm2835_i2c_remove(struct platform_device *pdev)
> +{
> +	struct bcm2835_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&i2c_dev->adapter);

Is it guaranteed that interrupts cannot occur anymore? Otherwise OOPS
might happen, since the adapter is cleared here already but devm will
remove the interrupt only a little later.

Thanks,

   Wolfram
