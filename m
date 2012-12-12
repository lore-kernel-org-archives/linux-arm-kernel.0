From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 12 Dec 2012 16:13:08 +0100
Subject: [PATCH 1/1] spi/atmel: add DT support
In-Reply-To: <50AF7C19.8000306@atmel.com>
References: <20121121151713.1F8873E0A47@localhost>
 <1353674679-13158-1-git-send-email-plagnioj@jcrosoft.com>
 <50AF7C19.8000306@atmel.com>
Message-ID: <20121212151308.GK4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:37 Fri 23 Nov     , Nicolas Ferre wrote:
> On 11/23/2012 01:44 PM, Jean-Christophe PLAGNIOL-VILLARD :
> > the atmel_spi use only gpio for chip select
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Seems simple and nice:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
grant is ok to have this for 3.8?

Best Regards,
J.
> 
> > Cc: spi-devel-general at lists.sourceforge.net
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > Hi Grant,
> > 
> > 	can we have this for 3.8
> > 	This patch is presetnt on the ML sing Feb 2012 and was depinding on
> > 	the cs-gpio dt that you just apply
> > 
> > Best Regards,
> > J.
> >  .../devicetree/bindings/spi/spi_atmel.txt          |   26 ++++++++++++++++++++
> >  drivers/spi/spi-atmel.c                            |   17 ++++++++++++-
> >  2 files changed, 42 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> > new file mode 100644
> > index 0000000..07e04cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> > @@ -0,0 +1,26 @@
> > +Atmel SPI device
> > +
> > +Required properties:
> > +- compatible : should be "atmel,at91rm9200-spi".
> > +- reg: Address and length of the register set for the device
> > +- interrupts: Should contain spi interrupt
> > +- cs-gpios: chipselects
> > +
> > +Example:
> > +
> > +spi1: spi at fffcc000 {
> > +	compatible = "atmel,at91rm9200-spi";
> > +	reg = <0xfffcc000 0x4000>;
> > +	interrupts = <13 4 5>;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	cs-gpios = <&pioB 3 0>;
> > +	status = "okay";
> > +
> > +	mmc-slot at 0 {
> > +		compatible = "mmc-spi-slot";
> > +		reg = <0>;
> > +		gpios = <&pioC 4 0>;	/* CD */
> > +		spi-max-frequency = <25000000>;
> > +	};
> > +};
> > diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> > index 61fb0ec..1615222 100644
> > --- a/drivers/spi/spi-atmel.c
> > +++ b/drivers/spi/spi-atmel.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_data/atmel.h>
> > +#include <linux/of.h>
> >  
> >  #include <asm/io.h>
> >  #include <asm/gpio.h>
> > @@ -768,6 +769,10 @@ static int atmel_spi_setup(struct spi_device *spi)
> >  
> >  	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
> >  	npcs_pin = (unsigned int)spi->controller_data;
> > +
> > +	if (gpio_is_valid(spi->cs_gpio))
> > +		npcs_pin = spi->cs_gpio;
> > +
> >  	asd = spi->controller_state;
> >  	if (!asd) {
> >  		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
> > @@ -937,8 +942,9 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
> >  	/* the spi->mode bits understood by this driver: */
> >  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> >  
> > +	master->dev.of_node = pdev->dev.of_node;
> >  	master->bus_num = pdev->id;
> > -	master->num_chipselect = 4;
> > +	master->num_chipselect = master->dev.of_node ? 0 : 4;
> >  	master->setup = atmel_spi_setup;
> >  	master->transfer = atmel_spi_transfer;
> >  	master->cleanup = atmel_spi_cleanup;
> > @@ -1064,11 +1070,20 @@ static int atmel_spi_resume(struct platform_device *pdev)
> >  #define	atmel_spi_resume	NULL
> >  #endif
> >  
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id atmel_spi_dt_ids[] = {
> > +	{ .compatible = "atmel,at91rm9200-spi" },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
> > +#endif
> >  
> >  static struct platform_driver atmel_spi_driver = {
> >  	.driver		= {
> >  		.name	= "atmel_spi",
> >  		.owner	= THIS_MODULE,
> > +		.of_match_table	= of_match_ptr(atmel_spi_dt_ids),
> >  	},
> >  	.suspend	= atmel_spi_suspend,
> >  	.resume		= atmel_spi_resume,
> > 
> 
> 
> -- 
> Nicolas Ferre
