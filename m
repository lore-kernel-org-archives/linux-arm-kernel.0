From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 28 Jul 2014 08:25:14 +0200
Subject: [PATCH 2/2] spi: orion: add support for multiple chip selects
In-Reply-To: <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <53D5ECCA.7030806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2014 11:53 PM, Thomas Petazzoni wrote:
> Until now, the spi-orion driver was limited to supporting only one
> internal chip select (i.e not the GPIO ones, but the ones directly
> handled by the SPI controller). However, recent Marvell platforms
> potentially have more than one chip select, so this commit adds
> support for a new 'ncs' DT property, which indicates how many chip
> selects are available on this platform.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> We could certainly discuss:
> 
>  * Whether 'ncs' should be the number of *connected* chip selects, or
>    the number of *usable* chip selects.
> 
>  * If it's the number of *usable* chip selects, then maybe it
>    shouldn't be a DT property, but rather something that the driver
>    "knows" thanks to the compatible string (which then, would be
>    different from one SoC to the other, since Armada XP and Armada 375
>    for example don't have the same number of chip selects).
> 
> Suggestions welcome.

Thomas,

I guess Documentation/devicetree/bindings/spi/spi-bus.txt is quite clear
about it:

"""
The SPI master node requires the following properties:
...
Optional property:
- num-cs : total number of chipselects

If cs-gpios is used the number of chip select will automatically increased
with max(cs-gpios > hw cs)

So if for example the controller has 2 CS lines, and the cs-gpios
property looks like this:

cs-gpios = <&gpio1 0 0> <0> <&gpio1 1 0> <&gpio1 2 0>;

Then it should be configured so that num_chipselect = 4 with the
following mapping:

cs0 : &gpio1 0 0
cs1 : native
cs2 : &gpio1 1 0
cs3 : &gpio1 2 0
"""

So, "num-cs" describes the number of *available* chip select signals. As
they can comprise extra cs lines that are GPIO and not dedicated
controller signals (native above), it cannot be something the driver
knows.

As long as you only use native cs lines, omit the cs-gpios property, if
there is any GPIO cs lines, insert <0> where you want native ones.
Although, I wonder how the driver learns about reg = <1> is actually the
controller's cs0 in the example above?

The actual number of *used* chip selects is then determined by
corresponding child node's reg property.

Sebastian

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-orion.txt |  3 +++
>  drivers/spi/spi-orion.c                             | 16 ++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
> index a3ff50f..0388c48 100644
> --- a/Documentation/devicetree/bindings/spi/spi-orion.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
> @@ -6,6 +6,8 @@ Required properties:
>  - cell-index : Which of multiple SPI controllers is this.
>  Optional properties:
>  - interrupts : Is currently not used.
> +- ncs : Number of chip selects used on the platform. Defaults to 1 when
> +  unspecified.
>  
>  Example:
>         spi at 10600 {
> @@ -15,5 +17,6 @@ Example:
>  	       cell-index = <0>;
>  	       reg = <0x10600 0x28>;
>  	       interrupts = <23>;
> +	       ncs = <2>;
>  	       status = "disabled";
>         };
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index c206a4a..8145855 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -23,7 +23,6 @@
>  
>  #define DRIVER_NAME			"orion_spi"
>  
> -#define ORION_NUM_CHIPSELECTS		1 /* only one slave is supported*/
>  #define ORION_SPI_WAIT_RDY_MAX_LOOP	2000 /* in usec */
>  
>  #define ORION_SPI_IF_CTRL_REG		0x00
> @@ -38,6 +37,8 @@
>  #define ORION_SPI_CLK_PRESCALE_MASK	0x1F
>  #define ORION_SPI_MODE_MASK		(ORION_SPI_MODE_CPOL | \
>  					 ORION_SPI_MODE_CPHA)
> +#define ORION_SPI_CS(cs)		((cs) << 2)
> +#define ORION_SPI_CS_MASK		GENMASK(4, 2)
>  
>  struct orion_spi {
>  	struct spi_master	*master;
> @@ -150,6 +151,11 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
>  	if (rc)
>  		return rc;
>  
> +	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG,
> +			  ORION_SPI_CS_MASK);
> +	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
> +			  ORION_SPI_CS(spi->chip_select));
> +
>  	if (bits_per_word == 16)
>  		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
>  				  ORION_SPI_IF_8_16_BIT_MODE);
> @@ -346,6 +352,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	unsigned long tclk_hz;
>  	int status = 0;
> +	u32 ncs;
>  
>  	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
>  	if (master == NULL) {
> @@ -366,7 +373,12 @@ static int orion_spi_probe(struct platform_device *pdev)
>  	master->mode_bits = SPI_CPHA | SPI_CPOL;
>  
>  	master->transfer_one_message = orion_spi_transfer_one_message;
> -	master->num_chipselect = ORION_NUM_CHIPSELECTS;
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "ncs", &ncs))
> +		master->num_chipselect = 1;
> +	else
> +		master->num_chipselect = ncs;
> +
>  	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
>  
>  	platform_set_drvdata(pdev, master);
> 
