From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 11 Mar 2012 19:25:37 +0100
Subject: [PATCH 1/4 v5] of_spi: add generic binding support to specify
 cs gpio
In-Reply-To: <20120311140731.2D4F93E0979@localhost>
References: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.co>
 <1331317544-21735-1-git-send-email-plagnioj@jcrosoft.com>
 <20120311140731.2D4F93E0979@localhost>
Message-ID: <20120311182537.GS27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:07 Sun 11 Mar     , Grant Likely wrote:
> On Fri,  9 Mar 2012 19:25:44 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > This will allow to use gpio for chip select with no modification in the
> > driver binding
> > 
> > When use the cs-gpios, the gpio number will be passed via the cs_gpio field
> > and the number of chip select will automatically increased.
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Cc: spi-devel-general at lists.sourceforge.net
> > ---
> > v5:
> > 	update grant comment to simplify the cs_gpio management
> > 
> > Best Regards,
> > J.
> >  Documentation/devicetree/bindings/spi/spi-bus.txt |    6 ++
> >  drivers/spi/spi.c                                 |   55 +++++++++++++++++++-
> >  include/linux/spi/spi.h                           |    4 ++
> >  3 files changed, 62 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > index e782add..c253379 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > @@ -12,6 +12,7 @@ The SPI master node requires the following properties:
> >  - #size-cells     - should be zero.
> >  - compatible      - name of SPI bus controller following generic names
> >      		recommended practice.
> > +- cs-gpios	  - (optional) gpios chip select.
> >  No other properties are required in the SPI bus node.  It is assumed
> >  that a driver for an SPI bus device will understand that it is an SPI bus.
> >  However, the binding does not attempt to define the specific method for
> > @@ -21,6 +22,8 @@ assumption that board specific platform code will be used to manage
> >  chip selects.  Individual drivers can define additional properties to
> >  support describing the chip select layout.
> >  
> > +If cs-gpios is used the number of chip select will automatically increased.
> > +
> >  SPI slave nodes must be children of the SPI master node and can
> >  contain the following properties.
> >  - reg             - (required) chip select address of device.
> > @@ -34,6 +37,9 @@ contain the following properties.
> >  - spi-cs-high     - (optional) Empty property indicating device requires
> >      		chip select active high
> >  
> > +If a gpio chipselect is used for the SPI slave the gpio number will be passed
> > +via the cs_gpio
> > +
> >  SPI example for an MPC5200 SPI bus:
> >  	spi at f00 {
> >  		#address-cells = <1>;
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index b2ccdea..446eee5 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/of_spi.h>
> > +#include <linux/of_gpio.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/export.h>
> >  
> > @@ -322,6 +323,7 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
> >  	spi->dev.parent = &master->dev;
> >  	spi->dev.bus = &spi_bus_type;
> >  	spi->dev.release = spidev_release;
> > +	spi->cs_gpio = -EINVAL;
> >  	device_initialize(&spi->dev);
> >  	return spi;
> >  }
> > @@ -339,15 +341,16 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
> >  int spi_add_device(struct spi_device *spi)
> >  {
> >  	static DEFINE_MUTEX(spi_add_lock);
> > -	struct device *dev = spi->master->dev.parent;
> > +	struct spi_master *master = spi->master;
> > +	struct device *dev = master->dev.parent;
> >  	struct device *d;
> >  	int status;
> >  
> >  	/* Chipselects are numbered 0..max; validate. */
> > -	if (spi->chip_select >= spi->master->num_chipselect) {
> > +	if (spi->chip_select >= master->num_chipselect) {
> >  		dev_err(dev, "cs%d >= max %d\n",
> >  			spi->chip_select,
> > -			spi->master->num_chipselect);
> > +			master->num_chipselect);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -371,6 +374,9 @@ int spi_add_device(struct spi_device *spi)
> >  		goto done;
> >  	}
> >  
> > +	if (master->cs_gpios)
> > +		spi->cs_gpio = master->cs_gpios[spi->chip_select];
> > +
> 
> I still don't understand the need for this.  Only the master driver will need
> this data, and it is already stored in the master->cs_gpios array.  Why
> does it need to get duplicated into the spi_device?
yeah can drop it
> 
> >  	/* Drivers may modify this initial i/o setup, but will
> >  	 * normally rely on the device being setup.  Devices
> >  	 * using SPI_CS_HIGH can't coexist well otherwise...
> > @@ -561,6 +567,45 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
> >  }
> >  EXPORT_SYMBOL_GPL(spi_alloc_master);
> >  
> > +#ifdef CONFIG_OF
> > +static int of_spi_register_master(struct spi_master *master)
> > +{
> > +	int nb, i;
> > +	int *cs;
> > +	struct device_node *np = master->dev.of_node;
> > +
> > +	if (!np)
> > +		return 0;
> > +
> > +	nb = of_gpio_named_count(np, "cs-gpios");
> > +
> > +	if (nb < 1)
> > +		return 0;
> > +
> > +	cs = devm_kzalloc(&master->dev,
> > +			  sizeof(int) * (master->num_chipselect + nb),
> > +			  GFP_KERNEL);
> 
> sizeof(*cs)
> 
> > +	master->cs_gpios = cs;
> > +
> > +	if (!master->cs_gpios)
> > +		return -ENOMEM;
> > +
> > +	memset(cs, -EINVAL, master->num_chipselect);
> > +	master->num_chipselect += nb;
> 
> Looks buggy.  Should be:
> 	if (nb > master->num_chipselect)
> 		master->num_chipselect = nb;
> 
> However, this is actually quite risky.  Changing the size of
> num_chipselect without the driver knowing about it will most likely
> cause breakage in drivers.  Drivers may use it as an array index, and
> if it gets increased then there will be problems.  In fact, drivers
> are probably using spi->chip_select as an array or register index so I
> don't think it can be transparently extended to include gpios.
> 
> So, this function must change.  It cannot be called automatically
> from spi_register_master().  It needs to be a library function that spi bus
> drivers must call explicitly so they are prepared for a change in the
> num_chipselect value.
I'll prefer to let the spi framework manage it
> 
> Also, if we're doing this, then the gpio cs manipulation hook should be
> moved out of spi_bitbang and into the core spi_master.  There should
> also be a stock function for manipulating gpio chip selects. I don't want
> spi driver authors under the impression that they should open code the
> chip select manipulation.
yeah I was thinking about it too

how about we split it in two

num_hw_cs manage by the drivers

and

num_gpio_cs for cs gpio

and num_chipselect (hw + cs) will for internal use

the gpio cs will be after the hw cs.

and we move the gpio cs from spi_bitbang to spi_master

Best Regards,
J.

> > +	cs += master->num_chipselect;
> > +
> > +	for (i = 0; i < nb; i++)
> > +		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
> > +
> > +	return 0;
> > +}
> > +#else
> > +static int of_spi_register_master(struct spi_master *master)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  /**
> >   * spi_register_master - register SPI master controller
> >   * @master: initialized master, originally from spi_alloc_master()
> > @@ -592,6 +637,10 @@ int spi_register_master(struct spi_master *master)
> >  	if (!dev)
> >  		return -ENODEV;
> >  
> > +	status = of_spi_register_master(master);
> > +	if (status)
> > +		return status;
> > +
> >  	/* even if it's just one always-selected device, there must
> >  	 * be at least one chipselect
> >  	 */
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index 176fce9..328d492 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -89,6 +89,7 @@ struct spi_device {
> >  	void			*controller_state;
> >  	void			*controller_data;
> >  	char			modalias[SPI_NAME_SIZE];
> > +	int			cs_gpio;	/* chip select gpio */
> >  
> >  	/*
> >  	 * likely need more hooks for more protocol options affecting how
> > @@ -318,6 +319,9 @@ struct spi_master {
> >  
> >  	/* called on release() to free memory provided by spi_master */
> >  	void			(*cleanup)(struct spi_device *spi);
> > +
> > +	/* gpio chip select */
> > +	int			*cs_gpios;
> >  };
> >  
> >  static inline void *spi_master_get_devdata(struct spi_master *master)
> > -- 
> > 1.7.7
> > 
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss at lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
> -- 
> Grant Likely, B.Sc, P.Eng.
> Secret Lab Technologies,Ltd.
