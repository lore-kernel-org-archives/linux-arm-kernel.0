From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 02 Mar 2012 19:32:07 -0700
Subject: [PATCH 2/3 v3] of_spi: add generic binding support to specify ncs
 gpio
In-Reply-To: <1330682587-20636-2-git-send-email-plagnioj@jcrosoft.com>
References: <1330682587-20636-1-git-send-email-plagnioj@jcrosoft.com>
 <1330682587-20636-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120303023207.7241E3E2D8A@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  2 Mar 2012 11:03:06 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> This will allow to use gpio for chip select with no modification in the
> driver binding
> 
> When use the ncs-gpios, the gpio number will be passed via the controller_data
> and the number of chip select will automatically increased.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> v3:
> 	use devm_kzalloc
> 
> v2:
> 	specify the gpio array at controller level
> 
> Best Regards,
> J.
>  Documentation/devicetree/bindings/spi/spi-bus.txt |    6 +++
>  drivers/spi/spi.c                                 |   49 +++++++++++++++++++-
>  include/linux/spi/spi.h                           |    5 ++
>  3 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index e782add..5a24729 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -12,6 +12,7 @@ The SPI master node requires the following properties:
>  - #size-cells     - should be zero.
>  - compatible      - name of SPI bus controller following generic names
>      		recommended practice.
> +- ncs-gpios       - (optional) gpios chip select.

ncs?  What does the 'n' stand for?

>  No other properties are required in the SPI bus node.  It is assumed
>  that a driver for an SPI bus device will understand that it is an SPI bus.
>  However, the binding does not attempt to define the specific method for
> @@ -21,6 +22,8 @@ assumption that board specific platform code will be used to manage
>  chip selects.  Individual drivers can define additional properties to
>  support describing the chip select layout.
>  
> +If ncs-gpios is used the number of chip select will automatically increased.
> +
>  SPI slave nodes must be children of the SPI master node and can
>  contain the following properties.
>  - reg             - (required) chip select address of device.
> @@ -34,6 +37,9 @@ contain the following properties.
>  - spi-cs-high     - (optional) Empty property indicating device requires
>      		chip select active high
>  
> +If a gpio chipselect is used for the SPI slave the gpio number will be passed
> +via the controller_data
> +
>  SPI example for an MPC5200 SPI bus:
>  	spi at f00 {
>  		#address-cells = <1>;
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e2f4ca0..f3df51f 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -28,6 +28,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of_spi.h>
> +#include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/export.h>
>  
> @@ -339,15 +340,16 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
>  int spi_add_device(struct spi_device *spi)
>  {
>  	static DEFINE_MUTEX(spi_add_lock);
> -	struct device *dev = spi->master->dev.parent;
> +	struct spi_master *master = spi->master;
> +	struct device *dev = master->dev.parent;
>  	struct device *d;
>  	int status;
>  
>  	/* Chipselects are numbered 0..max; validate. */
> -	if (spi->chip_select >= spi->master->num_chipselect) {
> +	if (spi->chip_select >= master->num_chipselect) {
>  		dev_err(dev, "cs%d >= max %d\n",
>  			spi->chip_select,
> -			spi->master->num_chipselect);
> +			master->num_chipselect);
>  		return -EINVAL;
>  	}
>  
> @@ -371,6 +373,13 @@ int spi_add_device(struct spi_device *spi)
>  		goto done;
>  	}
>  
> +	if (master->num_gpio_chipselect &&
> +	    spi->chip_select >= master->first_gpio_chipselect) {
> +		int num = spi->chip_select - master->first_gpio_chipselect;

I'd rather see an unconditional array of gpios; which only get used if a
valid gpio number is assigned.

> +
> +		spi->controller_data = (void*)master->chipselect_gpios[num];

Controller_data cannot be used here since it is provided for use
by the controller driver.

> +	}
> +
>  	/* Drivers may modify this initial i/o setup, but will
>  	 * normally rely on the device being setup.  Devices
>  	 * using SPI_CS_HIGH can't coexist well otherwise...
> @@ -562,6 +571,36 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
>  }
>  EXPORT_SYMBOL_GPL(spi_alloc_master);
>  
> +static int of_spi_register_master(struct spi_master *master)
> +{
> +	int nb, i;
> +	int *cs;
> +	struct device_node *np = master->dev.of_node;
> +
> +	if (!np)
> +		return 0;
> +
> +	nb = of_gpio_named_count(np, "ncs-gpios");
> +
> +	if (nb < 1)
> +		return 0;
> +
> +	cs = devm_kzalloc(&master->dev, sizeof(int) * nb, GFP_KERNEL);
> +	master->chipselect_gpios = cs;

the chipselect gpios functionality should be available regardless
of whether or not DT is used.  This should be moved out of the of-specific
register function.

> +
> +	if (!master->chipselect_gpios)
> +		return -ENOMEM;
> +
> +	master->first_gpio_chipselect = master->num_chipselect;
> +	master->num_chipselect += nb;
> +	master->num_gpio_chipselect = nb;
> +
> +	for (i = 0; i < nb; i++)
> +		cs[i] = of_get_named_gpio(np, "ncs-gpios", i);
> +
> +	return 0;
> +}

This function should be #ifdefed out when !OF

> +
>  /**
>   * spi_register_master - register SPI master controller
>   * @master: initialized master, originally from spi_alloc_master()
> @@ -593,6 +632,10 @@ int spi_register_master(struct spi_master *master)
>  	if (!dev)
>  		return -ENODEV;
>  
> +	status = of_spi_register_master(master);
> +	if (status)
> +		return status;
> +
>  	/* even if it's just one always-selected device, there must
>  	 * be at least one chipselect
>  	 */
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 176fce9..d21c267 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -318,6 +318,11 @@ struct spi_master {
>  
>  	/* called on release() to free memory provided by spi_master */
>  	void			(*cleanup)(struct spi_device *spi);
> +
> +	/* gpio chip select */
> +	int			*chipselect_gpios;
> +	int			first_gpio_chipselect;
> +	int			num_gpio_chipselect;

s/chipselect/cs/ would be quite a bit less verbose

>  };
>  
>  static inline void *spi_master_get_devdata(struct spi_master *master)
> -- 
> 1.7.7
> 

-- 
email sent from notmuch.vim plugin
