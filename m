From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 12:59:04 +0000
Subject: [PATCH 1/4] spi: Add new driver for STMicroelectronics' SPI
 Controller
In-Reply-To: <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20141127125904.GV7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:43:53AM +0000, Lee Jones wrote:

> +config SPI_ST
> +	tristate "STMicroelectronics SPI SSC-based driver"

Please select a more specific symbol, I bet ST already have other sPI
controllers.  Based on the descripton SPI_ST_SSC might work.

> +	depends on ARCH_STI

Please add an || COMPILE_TEST unless there's a good reason not to,
there's no obvious one.  You may have an OF dependency though if the
functions you call aren't stubbed, I've not checked.

> +struct spi_st {
> +	/* SSC SPI Controller */
> +	struct spi_bitbang	bitbang;

Is there a good reason for using bitbang over the core transmit_one()
interface?  The operations are basically the same but more modern and
the functionality is more discoverable.

> +static void spi_st_gpio_chipselect(struct spi_device *spi, int is_active)
> +{
> +	int cs = spi->cs_gpio;
> +	int out;
> +
> +	if (cs == -ENOENT)
> +		return;
> +
> +	out = (spi->mode & SPI_CS_HIGH) ? is_active : !is_active;
> +	gpio_set_value(cs, out);

The core can handle GPIO chip selects automatically.

> +static int spi_st_setup_transfer(struct spi_device *spi,
> +				 struct spi_transfer *t)
> +{
> +	struct spi_st *spi_st = spi_master_get_devdata(spi->master);
> +	u32 spi_st_clk, sscbrg, var, hz;
> +	u8 bits_per_word;
> +
> +	bits_per_word 	= t ? t->bits_per_word	: spi->bits_per_word;
> +	hz		= t ? t->speed_hz	: spi->max_speed_hz;

Please avoid the ternery operator; in this case the core should already
be ensuring that these parameters are configured on every transfer.

> +	/* Actually, can probably support 2-16 without any other changees */
> +	if (bits_per_word != 8 && bits_per_word != 16) {
> +		dev_err(&spi->dev, "unsupported bits_per_word %d\n",
> +			bits_per_word);
> +		return -EINVAL;
> +	}

Set bits_per_word_mask and the core will do this.

> +	} else if (spi_st->bits_per_word == 8 && !(t->len & 0x1)) {
> +		/*
> +		 * If transfer is even-length, and 8 bits-per-word, then
> +		 * implement as half-length 16 bits-per-word transfer
> +		 */
> +		spi_st->bytes_per_word = 2;
> +		spi_st->words_remaining = t->len/2;
> +
> +		/* Set SSC_CTL to 16 bits-per-word */
> +		ctl = readl_relaxed(spi_st->base + SSC_CTL);
> +		writel_relaxed((ctl | 0xf), spi_st->base + SSC_CTL);
> +
> +		readl_relaxed(spi_st->base + SSC_RBUF);

No byte swapping issues here?

> +	init_completion(&spi_st->done);

reinit_completion().

> +	/* Wait for transfer to complete */
> +	wait_for_completion(&spi_st->done);

Should have a timeout of some kind, if you use transfer_one() it'll
provide one.

> +	pm_runtime_put(spi_st->dev);

The core can do runtime PM for you.

> +	printk("LEE: %s: %s()[%d]: Probing\n", __FILE__, __func__, __LINE__);

Tsk.

> +	spi_st->clk = of_clk_get_by_name(np, "ssc");
> +	if (IS_ERR(spi_st->clk)) {
> +		dev_err(&pdev->dev, "Unable to request clock\n");
> +		ret = PTR_ERR(spi_st->clk);
> +		goto free_master;
> +	}

Why is this of_get_clk_by_name() and not just devm_clk_get()?

> +	/* Disable I2C and Reset SSC */
> +	writel_relaxed(0x0, spi_st->base + SSC_I2C);
> +	var = readw(spi_st->base + SSC_CTL);
> +	var |= SSC_CTL_SR;
> +	writel_relaxed(var, spi_st->base + SSC_CTL);
> +
> +	udelay(1);
> +	var = readl_relaxed(spi_st->base + SSC_CTL);
> +	var &= ~SSC_CTL_SR;
> +	writel_relaxed(var, spi_st->base + SSC_CTL);
> +
> +	/* Set SSC into slave mode before reconfiguring PIO pins */
> +	var = readl_relaxed(spi_st->base + SSC_CTL);
> +	var &= ~SSC_CTL_MS;
> +	writel_relaxed(var, spi_st->base + SSC_CTL);

We requested the interrupt before putting the hardware into a known good
state - it'd be safer to do things the other way around.

> +	dev_info(&pdev->dev, "registered SPI Bus %d\n", master->bus_num);

This is just noise, remove it.

> +	/* by default the device is on */
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);

You should do this before registering the device so that we don't get
confused about runtime PM if we start using the device immediately.

> +#ifdef CONFIG_PM_SLEEP
> +static int spi_st_suspend(struct device *dev)

> +static SIMPLE_DEV_PM_OPS(spi_st_pm, spi_st_suspend, spi_st_resume);

These look like they should be runtime PM ops too - I'd expect to at
least have the clocks disabled by runtime PM, 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/6bf59a0b/attachment.sig>
