From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 8 Dec 2010 13:07:20 +0000
Subject: [PATCH 2/3] ASoC: CS4271 codec support
In-Reply-To: <1291809772.31916.4.camel@r60e>
References: <1291809772.31916.4.camel@r60e>
Message-ID: <20101208130720.GB2716@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

I can't comment on the codec side of things but a couple of general comments 
inline. Otherwise looks good to me!

Jamie

On Wed, Dec 08, 2010 at 03:02:52PM +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Added support for CS4271 codec to ASoC.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
> ---
>  include/sound/cs4271.h    |   25 ++
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/cs4271.c |  607 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 638 insertions(+), 0 deletions(-)
> 
[...]
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> new file mode 100644
> index 0000000..c0d74da
> --- /dev/null
> +++ b/sound/soc/codecs/cs4271.c
> @@ -0,0 +1,607 @@
[...]
> +struct cs4271_private {
> +	/* SND_SOC_I2C or SND_SOC_SPI */
> +	enum snd_soc_control_type	bus_type;
> +	void				*control_data;
> +	unsigned int			mclk;
> +	/* SND_SOC_DAIFMT_I2S or SND_SOC_DAIFMT_LEFT_J */
> +	unsigned int			mode;
> +	unsigned int			master;
> +	/* GPIO driving Reset pin, if any */
> +	int gpio_nreset;
> +	/* GPIO that disable serial bus, if any */
> +	int gpio_disable;
Align gpio_nreset and gpio_disable with the other fields?

[...]
> +#if defined(CONFIG_SPI_MASTER)
> +static int __devinit cs4271_spi_probe(struct spi_device *spi)
> +{
> +	struct cs4271_private *cs4271;
> +	int ret;
> +
> +	cs4271 = kzalloc(sizeof(*cs4271), GFP_KERNEL);
> +	if (!cs4271)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, cs4271);
> +	cs4271->control_data = spi;
> +	cs4271->bus_type = SND_SOC_SPI;
> +
> +	ret = snd_soc_register_codec(&spi->dev, &soc_codec_dev_cs4271,
> +				     &cs4271_dai, 1);
> +	if (ret < 0)
> +		kfree(cs4271);
> +	return ret;
> +}
> +
> +static int __devexit cs4271_spi_remove(struct spi_device *spi)
> +{
> +	snd_soc_unregister_codec(&spi->dev);
> +	kfree(spi_get_drvdata(spi));
> +	return 0;
> +}
Is it worth using devm_kzalloc() for the i2c and spi probe functions to 
simplify the error handling and release functions? Admittedly they are fairly 
simple functions though.
[...]

> +/*
> + * We only register our serial bus driver here without
> + * assignment to particular chip. So if any of the below
> + * fails, there is some problem with I2C or SPI subsystem.
> + * In most cases this module will be compiled with support
> + * of only one serial bus.
> + */
> +static int __init cs4271_modinit(void)
> +{
> +	int ret;
> +
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +	ret = i2c_add_driver(&cs4271_i2c_driver);
> +	if (ret) {
> +		pr_err("Failed to register CS4271 I2C driver: %d\n", ret);
> +		return ret;
> +	}
> +#endif
> +
> +#if defined(CONFIG_SPI_MASTER)
> +	ret = spi_register_driver(&cs4271_spi_driver);
> +	if (ret) {
> +		pr_err("Failed to register CS4271 SPI driver: %d\n", ret);
> +		return ret;
> +	}
> +#endif
> +
> +	return 0;
> +}
> +module_init(cs4271_modinit);
> +
> +static void __exit cs4271_modexit(void)
> +{
> +#if defined(CONFIG_SPI_MASTER)
> +	spi_unregister_driver(&cs4271_spi_driver);
> +#endif
> +
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +	i2c_del_driver(&cs4271_i2c_driver);
> +#endif
> +}
> +module_exit(cs4271_modexit);
Doesn't the dependency on SND_SOC_I2C_AND_SPI mean that you will always have 
I2C and SPI_MASTER?
