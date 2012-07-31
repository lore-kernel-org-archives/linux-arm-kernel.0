From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 31 Jul 2012 13:53:00 -0700
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <1341555449-17507-6-git-send-email-marex@denx.de>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
Message-ID: <20120731205300.GA25721@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 06:17:25AM -0000, Marek Vasut wrote:
> This is slightly reworked version of the SPI driver.
> Support for DT has been added and it's been converted
> to queued API.
> 
> Based on previous attempt by:
> Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Detlev Zundel <dzu@denx.de>
> CC: Dong Aisheng <b29396@freescale.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Wolfgang Denk <wd@denx.de>
> 
> ---
> drivers/spi/Kconfig   |    7 +
>  drivers/spi/Makefile  |    1 +
>  drivers/spi/spi-mxs.c |  427 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 435 insertions(+)
>  create mode 100644 drivers/spi/spi-mxs.c
> 
> V2: Fix my patch version management
>     Select STMP_DEVICE (thanks Shawn for pointing this out)
> 
Hi,

I have one question about this patch.

[ ... ]

> index 0000000..3c0b1ac
> --- /dev/null
> +++ b/drivers/spi/spi-mxs.c

[ ... ]

> +
> +static int __devinit mxs_spi_probe(struct platform_device *pdev)
> +{

[ ... ]

> +out_host_free:
> +	clk_disable_unprepare(ssp->clk);
> +	spi_master_put(host);
> +	kfree(host);
> +	return ret;
> +}
> +
> +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *host;
> +	struct mxs_spi *spi;
> +	struct mxs_ssp *ssp;
> +
> +	host = platform_get_drvdata(pdev);
> +	spi = spi_master_get_devdata(host);
> +	ssp = &spi->ssp;
> +
> +	spi_unregister_master(host);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	clk_disable_unprepare(ssp->clk);
> +
> +	spi_master_put(host);
> +	kfree(host);
> +

Is the kfree() here and in the probe function really necessary ? 

Couple of reasons for asking: No other SPI master driver calls it in the remove
function (unless I missed it), most drivers don't call it in the probe
function error path, and if I call it in the remove function in a SPI master
driver I am working on, and load/unload the module several times in a row, I get
a nasty kernel crash.

Thanks,
Guenter
