From: atull@opensource.altera.com (atull)
Date: Mon, 10 Oct 2016 13:29:48 -0500
Subject: [PATCH 1/3] fpga manager: Add cyclonespi driver for Altera fpgas
In-Reply-To: <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
References: <cover.1475783742.git.stillcompiling@gmail.com>
 <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
Message-ID: <alpine.DEB.2.02.1610101058390.28839@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Oct 2016, Joshua Clayton wrote:

> cyclonespi loads fpga firmware over spi, using the "passive serial"
> interface on Altera Cyclone FPGAS.
> 
> one of the simpler ways to set up an fpga at runtime.
> The signal interface is close to unidirectional spi with lsb first.
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  drivers/fpga/Kconfig      |   6 ++
>  drivers/fpga/Makefile     |   1 +
>  drivers/fpga/cyclonespi.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 180 insertions(+)
>  create mode 100644 drivers/fpga/cyclonespi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index cd84934..ccad5b1 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -13,6 +13,12 @@ config FPGA
>  

Hi Joshua,

This looks really good.  Mostly minor comments.

>  if FPGA
>  
> +config FPGA_MGR_CYCLONE_SPI

Suggestions here and below to keep PS in the name of things.
Such as FPGA_MGR_CYCLONE_PS_SPI.

> +	tristate "Altera Cyclone V SPI"

"Altera Cyclone V Passive Serial over SPI" ?

> +	depends on SPI
> +	help
> +	  FPGA manager driver support for Altera Cyclone V over SPI
> +
>  config FPGA_MGR_SOCFPGA
>  	tristate "Altera SOCFPGA FPGA Manager"
>  	depends on ARCH_SOCFPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8d83fc6..c03f40de 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -6,5 +6,6 @@
>  obj-$(CONFIG_FPGA)			+= fpga-mgr.o
>  
>  # FPGA Manager Drivers
> +obj-$(CONFIG_FPGA_MGR_CYCLONE_SPI)	+= cyclonespi.o

cyclone-ps-spi.o and change name of c file.

>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> diff --git a/drivers/fpga/cyclonespi.c b/drivers/fpga/cyclonespi.c
> new file mode 100644
> index 0000000..1ffa67c
> --- /dev/null
> +++ b/drivers/fpga/cyclonespi.c
> @@ -0,0 +1,173 @@
> +/**
> + * Copyright (c) 2015 United Western Technologies, Corporation
> + *
> + * Joshua Clayton <stillcompiling@gmail.com>
> + *
> + * Manage Altera fpga firmware that is loaded over spi.
> + * Firmware must be in binary "rbf" format.
> + * Works on Cyclone V. Should work on cyclone series.
> + * May work on other Altera fpgas.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Joshua Clayton <stillcompiling@gmail.com>");
> +MODULE_DESCRIPTION("Module to load Altera FPGA firmware over spi");

Please move these 3 MODULE_* lines to the bottom of this file.

> +
> +struct cyclonespi_conf {
> +	struct gpio_desc *reset;
> +	struct gpio_desc *status;
> +	struct spi_device *spi;
> +};
> +
> +static const struct of_device_id of_ef_match[] = {
> +	{ .compatible = "altr,cyclonespi-fpga-mgr", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_ef_match);
> +
> +static enum fpga_mgr_states cyclonespi_state(struct fpga_manager *mgr)
> +{
> +	return mgr->state;

fpga-mgr.c's fpga_mgr_register() reads the initial state
from this function.  Please return one of the values of enum
fpga_mgr_states here.  If state isn't known, then use
FPGA_MGR_STATE_UNKNOWN.

> +}
> +
> +static inline u32 revbit8x4(u32 n)
> +{
> +	n = ((n & 0xF0F0F0F0UL) >> 4) | ((n & 0x0F0F0F0FUL) << 4);
> +	n = ((n & 0xCCCCCCCCUL) >> 2) | ((n & 0x33333333UL) << 2);
> +	n = ((n & 0xAAAAAAAAUL) >> 1) | ((n & 0x55555555UL) << 1);
> +	return n;
> +}
> +
> +static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
> +				const char *buf, size_t count)
> +{
> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +	u32 *fw32 = (u32 *)buf;
> +	const u32 *fw_end = (u32 *)(buf + count);
> +
> +	if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> +		return -EINVAL;
> +	}
> +
> +	gpiod_set_value(conf->reset, 0);
> +	udelay(50);

Moritz brought up whether the delay/sleep values should be
configurable.  It looks like these are set values and have
probably been increased for good measure.  These could be
macros named to contain symbol names in the datasheet's PS
timing waveform, if that is where these are coming from.

The timing diagram has the Tcf2st0 as 800nSec max and
Tcf2st1 (below) as 40uSec.  I guess either we are looking at
different specs or you just found that you got better
results if you padded the values out?

I would normally suggest a convention of macro names
that maps neatly to the value names in the datasheet
such as CYCLONE_PS_TCF2ST0_USEC.  The problem is
the units.


> +	if (gpiod_get_value(conf->status) == 1) {
> +		dev_err(&mgr->dev, "Status pin should be low.\n");
> +		return -EIO;
> +	}
> +
> +	gpiod_set_value(conf->reset, 1);
> +	msleep(1);

CYCLONE_PS_TCF2ST1_USEC?  I'm not sure what to suggest
because the units in the timing diagram I'm looking at are
nanoseconds but this ended up being a mSec.

> +	if (gpiod_get_value(conf->status) == 0) {
> +		dev_err(&mgr->dev, "Status pin not ready.\n");
> +		return -EIO;
> +	}
> +
> +	/* set buffer to lsb first */
> +	while (fw32 < fw_end) {
> +		*fw32 = revbit8x4(*fw32);
> +		fw32++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
> +			   size_t count)

Please fix checkpatch.pl warnings.  Here and a few other places it
says "CHECK: Alignment should match open parenthesis"

> +{
> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +	const char *fw_data = buf;
> +	const char *fw_data_end = fw_data + count;
> +
> +	while (fw_data < fw_data_end) {
> +		int ret;
> +		int stride = fw_data_end - fw_data;
> +
> +		if (stride > SZ_4K)
> +			stride = SZ_4K;
> +
> +		ret = spi_write(conf->spi, fw_data, stride);
> +		if (ret) {
> +			dev_err(&mgr->dev, "spi error in firmware write: %d\n",
> +					ret);
> +			return ret;
> +		}
> +		fw_data += stride;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cyclonespi_write_complete(struct fpga_manager *mgr, u32 flags)
> +{
> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +
> +	if (gpiod_get_value(conf->status) == 0) {
> +		dev_err(&mgr->dev, "Error during configuration.\n");
> +		return -EIO;
> +	}

Does your hardware give you access to the CONF_DONE pin?
If so, can you get better status info from that?

> +
> +	return 0;
> +}
> +
> +static const struct fpga_manager_ops cyclonespi_ops = {
> +	.state = cyclonespi_state,
> +	.write_init = cyclonespi_write_init,
> +	.write = cyclonespi_write,
> +	.write_complete = cyclonespi_write_complete,
> +};
> +
> +static int cyclonespi_probe(struct spi_device *spi)
> +{
> +	struct cyclonespi_conf *conf = devm_kzalloc(&spi->dev, sizeof(*conf),
> +						GFP_KERNEL);
> +
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	conf->spi = spi;
> +	conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(conf->reset)) {
> +		dev_err(&spi->dev, "Failed to get reset gpio: %ld\n",
> +			PTR_ERR(conf->reset));
> +		return PTR_ERR(conf->reset);
> +	}
> +
> +	conf->status = devm_gpiod_get(&spi->dev, "status", GPIOD_IN);
> +	if (IS_ERR(conf->status)) {
> +		dev_err(&spi->dev, "Failed to get status gpio: %ld\n",
> +				PTR_ERR(conf->status));
> +		return PTR_ERR(conf->status);
> +	}
> +
> +	return fpga_mgr_register(&spi->dev, "Altera SPI FPGA Manager",
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
> +		.name   = "cyclonespi",
> +		.owner  = THIS_MODULE,
> +		.of_match_table = of_match_ptr(of_ef_match),
> +	},
> +	.probe  = cyclonespi_probe,
> +	.remove = cyclonespi_remove,
> +};
> +
> +module_spi_driver(cyclonespi_driver)
> -- 
> 2.7.4
> 
> 
