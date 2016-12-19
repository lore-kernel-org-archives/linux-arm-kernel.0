From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Dec 2016 08:23:26 +0100
Subject: [PATCH v6 4/5] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <abaad69b5dd15c086826cc9b6e2d52aefb04f9ef.1481918884.git.stillcompiling@gmail.com>
References: <cover.1481918884.git.stillcompiling@gmail.com>
 <abaad69b5dd15c086826cc9b6e2d52aefb04f9ef.1481918884.git.stillcompiling@gmail.com>
Message-ID: <20161219072326.fael3uughtghexl4@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 03:17:53PM -0800, Joshua Clayton wrote:
> cyclone-ps-spi loads FPGA firmware over spi, using the "passive serial"
> interface on Altera Cyclone FPGAS.
> 
> This is one of the simpler ways to set up an FPGA at runtime.
> The signal interface is close to unidirectional spi with lsb first.
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  drivers/fpga/Kconfig          |   7 ++
>  drivers/fpga/Makefile         |   1 +
>  drivers/fpga/cyclone-ps-spi.c | 186 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+)
>  create mode 100644 drivers/fpga/cyclone-ps-spi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index ce861a2..e6c032d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -20,6 +20,13 @@ config FPGA_REGION
>  	  FPGA Regions allow loading FPGA images under control of
>  	  the Device Tree.
>  
> +config FPGA_MGR_CYCLONE_PS_SPI
> +	tristate "Altera Cyclone FPGA Passive Serial over SPI"
> +	depends on SPI
> +	help
> +	  FPGA manager driver support for Altera Cyclone using the
> +	  passive serial interface over SPI
> +
>  config FPGA_MGR_SOCFPGA
>  	tristate "Altera SOCFPGA FPGA Manager"
>  	depends on ARCH_SOCFPGA || COMPILE_TEST
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8df07bc..a112bef 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_FPGA)			+= fpga-mgr.o
>  
>  # FPGA Manager Drivers
> +obj-$(CONFIG_FPGA_MGR_CYCLONE_PS_SPI)	+= cyclone-ps-spi.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> diff --git a/drivers/fpga/cyclone-ps-spi.c b/drivers/fpga/cyclone-ps-spi.c
> new file mode 100644
> index 0000000..f9126f9
> --- /dev/null
> +++ b/drivers/fpga/cyclone-ps-spi.c
> @@ -0,0 +1,186 @@
> +/**
> + * Altera Cyclone Passive Serial SPI Driver
> + *
> + *  Copyright (c) 2017 United Western Technologies, Corporation

In which timezone it's already 2017? s/  / /

> + *
> + *  Joshua Clayton <stillcompiling@gmail.com>
> + *
> + * Manage Altera FPGA firmware that is loaded over spi using the passive
> + * serial configuration method.
> + * Firmware must be in binary "rbf" format.
> + * Works on Cyclone V. Should work on cyclone series.
> + * May work on other Altera FPGAs.

I can test this later on an Arria 10. I'm not sure what the connection
between "Cyclone" and "Arria" is, but the protocol looks similar.

> + *
> + */
> +
> +#include <linux/bitrev.h>
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sizes.h>
> +
> +#define FPGA_RESET_TIME		50   /* time in usecs to trigger FPGA config */
> +#define FPGA_MIN_DELAY		50   /* min usecs to wait for config status */
> +#define FPGA_MAX_DELAY		1000 /* max usecs to wait for config status */
> +
> +struct cyclonespi_conf {
> +	struct gpio_desc *config;
> +	struct gpio_desc *status;
> +	struct spi_device *spi;
> +};
> +
> +static const struct of_device_id of_ef_match[] = {
> +	{ .compatible = "altr,cyclone-ps-spi-fpga-mgr", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_ef_match);

barebox already has such a driver, the binding is available at

	https://git.pengutronix.de/cgit/barebox/tree/Documentation/devicetree/bindings/firmware/altr,passive-serial.txt

(This isn't completely accurate because nstat is optional in the driver.)

> +static enum fpga_mgr_states cyclonespi_state(struct fpga_manager *mgr)
> +{
> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +
> +	if (gpiod_get_value(conf->status))
> +		return FPGA_MGR_STATE_RESET;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int cyclonespi_write_init(struct fpga_manager *mgr,
> +				 struct fpga_image_info *info,
> +				 const char *buf, size_t count)
> +{
> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +	int i;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> +		return -EINVAL;
> +	}
> +
> +	gpiod_set_value(conf->config, 1);
> +	usleep_range(FPGA_RESET_TIME, FPGA_RESET_TIME + 20);
> +	if (!gpiod_get_value(conf->status)) {
> +		dev_err(&mgr->dev, "Status pin should be low.\n");

You write this when get_value returns 0. There is something fishy.

> +		return -EIO;
> +	}
> +
> +	gpiod_set_value(conf->config, 0);
> +	for (i = 0; i < (FPGA_MAX_DELAY / FPGA_MIN_DELAY); i++) {
> +		usleep_range(FPGA_MIN_DELAY, FPGA_MIN_DELAY + 20);
> +		if (!gpiod_get_value(conf->status))
> +			return 0;
> +	}
> +
> +	dev_err(&mgr->dev, "Status pin not ready.\n");
> +	return -EIO;

For Arria 10 the documentation has:

	To ensure a successful configuration, send the entire
	configuration data to the device. CONF_DONE is released high
	when the device receives all the configuration data
	successfully. After CONF_DONE goes high, send two additional
	falling edges on DCLK to begin initialization and enter user
	mode.

ISTR this is necessary for Arria V, too.

> +}
> +
> +static void rev_buf(void *buf, size_t len)
> +{
> +	u32 *fw32 = (u32 *)buf;
> +	const u32 *fw_end = (u32 *)(buf + len);
> +
> +	/* set buffer to lsb first */
> +	while (fw32 < fw_end) {
> +		*fw32 = bitrev8x4(*fw32);
> +		fw32++;
> +	}

Is the size of the firmware always a multiple of 32 bit? If len isn't a
multiple of 4 you access data after the end of buf.

> +}
> +
> +static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
> +			    size_t count)
> +{
> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +	const char *fw_data = buf;
> +	const char *fw_data_end = fw_data + count;
> +
> +	while (fw_data < fw_data_end) {
> +		int ret;
> +		size_t stride = min(fw_data_end - fw_data, SZ_4K);
> +
> +		rev_buf((void *)fw_data, stride);

This isn't necessary if the spi controller supports SPI_LSB_FIRST. At
least the mvebu spi core can do this for you. (The driver doesn't
support it yet, though.)

> +		ret = spi_write(conf->spi, fw_data, stride);
> +		if (ret) {
> +			dev_err(&mgr->dev, "spi error in firmware write: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		fw_data += stride;
> +	}
> +
> +	return 0;
> +}
> [...]
> +static int cyclonespi_probe(struct spi_device *spi)
> +{
> +	struct cyclonespi_conf *conf = devm_kzalloc(&spi->dev, sizeof(*conf),
> +						GFP_KERNEL);

please indent to the opening (.

> +
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	conf->spi = spi;
> +	conf->config = devm_gpiod_get(&spi->dev, "config", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->config)) {
> +		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
> +			PTR_ERR(conf->config));
> +		return PTR_ERR(conf->config);
> +	}
> +
> +	conf->status = devm_gpiod_get(&spi->dev, "status", GPIOD_IN);
> +	if (IS_ERR(conf->status)) {
> +		dev_err(&spi->dev, "Failed to get status gpio: %ld\n",
> +			PTR_ERR(conf->status));
> +		return PTR_ERR(conf->status);
> +	}
> +
> +	return fpga_mgr_register(&spi->dev,
> +				 "Altera Cyclone PS SPI FPGA Manager",
> +				 &cyclonespi_ops, conf);
> +}
> +
> +static int cyclonespi_remove(struct spi_device *spi)
> +{
> +	fpga_mgr_unregister(&spi->dev);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver cyclonespi_driver = {
> +	.driver = {
> +		.name   = "cyclone-ps-spi",
> +		.owner  = THIS_MODULE,
> +		.of_match_table = of_match_ptr(of_ef_match),
> +	},
> +	.probe  = cyclonespi_probe,
> +	.remove = cyclonespi_remove,
> +};

I'm not a big fan of aligning the assignment operators. This tends to
get out of sync or results in bigger than necessary changes in follow up
patches. Note that it's out of sync already now, so I suggest to use a
single space before =.

> +
> +module_spi_driver(cyclonespi_driver)
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Joshua Clayton <stillcompiling@gmail.com>");
> +MODULE_DESCRIPTION("Module to load Altera FPGA firmware over spi");
> -- 

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
