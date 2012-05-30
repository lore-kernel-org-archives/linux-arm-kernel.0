From: marc@cpdesign.com.au (Marc Reilly)
Date: Thu, 31 May 2012 09:47:29 +1000
Subject: [PATCH 2/2] MFD: mc13xxx workaround SPI hardware bug on i.Mx
In-Reply-To: <1338282389-26177-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
 <1338282389-26177-2-git-send-email-philippe.retornaz@epfl.ch>
 <1338282389-26177-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <201205310947.30369.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipe,

Thanks for fixing this.

Acked-by: Marc Reilly <marc@cpdesign.com.au>

Cheers,
Marc

(Some real trivial spelling corrections inline below. I'd ignore them unless 
you do a V2)


On Tuesday, May 29, 2012 07:06:29 PM Philippe R?tornaz wrote:
> The MC13xxx PMIC is mainly used on i.Mx SoC. On thoses SoC the SPI

s/thoses/these

> hardware will deassert CS line as soon as the SPI FIFO is empty.
> The MC13xxx hardware is very sensitive to CS line change as it
> corrupts the transfert if CS is deasserted in the middle of a register

s/transfert/transfer

> read or write.
> It is not possible to use the CS line as a GPIO on some SoC, so we
> need to workaround this by implementing a single SPI transfer to
> access the PMIC.
> 
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
> ---
>  drivers/mfd/mc13xxx-spi.c |   65
> ++++++++++++++++++++++++++++++++++++++++++++- 1 files changed, 64
> insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
> index 5d1969f..03df422 100644
> --- a/drivers/mfd/mc13xxx-spi.c
> +++ b/drivers/mfd/mc13xxx-spi.c
> @@ -54,6 +54,67 @@ static struct regmap_config mc13xxx_regmap_spi_config =
> { .max_register = MC13XXX_NUMREGS,
> 
>  	.cache_type = REGCACHE_NONE,
> +	.use_single_rw = 1,
> +};
> +
> +static int mc13xxx_spi_read(void *context, const void *reg, size_t
> reg_size, +				void *val, size_t val_size)
> +{
> +	unsigned char w[4] = { *((unsigned char *) reg), 0, 0, 0};
> +	unsigned char r[4];
> +	unsigned char *p = val;
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_transfer t = {
> +		.tx_buf = w,
> +		.rx_buf = r,
> +		.len = 4,
> +	};
> +
> +	struct spi_message m;
> +	int ret;
> +
> +	if (val_size != 3 || reg_size != 1)
> +		return -ENOTSUPP;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);
> +	ret = spi_sync(spi, &m);
> +
> +	memcpy(p, &r[1], 3);
> +
> +	return ret;
> +}
> +
> +static int mc13xxx_spi_write(void *context, const void *data, size_t
> count) +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +
> +	if (count != 4)
> +		return -ENOTSUPP;
> +
> +	return spi_write(spi, data, count);
> +}
> +
> +/*
> + * We cannot use regmap-spi generic bus implementation here.
> + * The MC13783 chip will get corrupted if CS signal is deasserted
> + * and on i.Mx31 SoC (the target SoC for MC13783 PMIC) the SPI controller
> + * has the following errata (DSPhl22960):
> + * "The CSPI negates SS when the FIFO becomes empty with
> + * SSCTL= 0. Software cannot guarantee that the FIFO will not
> + * drain because of higher priority interrupts and the
> + * non-realtime characteristics of the operating system. As a
> + * result, the SS will negate before all of the data has been
> + * transferred to/from the peripheral."
> + * We workaround this by accessing the SPI controller with a
> + * single transfert.

s/transfert/transfer

> + */
> +
> +static struct regmap_bus regmap_mc13xxx_bus = {
> +	.write = mc13xxx_spi_write,
> +	.read = mc13xxx_spi_read,
>  };
> 
>  static int mc13xxx_spi_probe(struct spi_device *spi)
> @@ -78,7 +139,9 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
>  	mc13xxx->dev = &spi->dev;
>  	mutex_init(&mc13xxx->lock);
> 
> -	mc13xxx->regmap = regmap_init_spi(spi, &mc13xxx_regmap_spi_config);
> +	mc13xxx->regmap = regmap_init(&spi->dev, &regmap_mc13xxx_bus, &spi->dev,
> +					&mc13xxx_regmap_spi_config);
> +
>  	if (IS_ERR(mc13xxx->regmap)) {
>  		ret = PTR_ERR(mc13xxx->regmap);
>  		dev_err(mc13xxx->dev, "Failed to initialize register map: %d\n",
