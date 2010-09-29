From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 29 Sep 2010 17:20:55 +0900
Subject: [PATCH 1/7] SPI: add PrimeCell generic DMA to PL022 v12
In-Reply-To: <1285684441-21700-2-git-send-email-linus.walleij@stericsson.com>
References: <1285684441-21700-1-git-send-email-linus.walleij@stericsson.com>
	<1285684441-21700-2-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100929082055.GC4703@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 28, 2010 at 04:33:55PM +0200, Linus Walleij wrote:
> This extends the PL022 SSP/SPI driver with generic DMA engine
> support using the PrimeCell DMA engine interface. Also fix up the
> test code for the U300 platform.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Changes:
> - Switch CONFIG_DMADEVICES for CONFIG_DMA_ENGINE to counter
>   a compilation error spotted by Grant.
> ---
>  arch/arm/mach-u300/dummyspichip.c |    1 +
>  drivers/spi/amba-pl022.c          |  516 ++++++++++++++++++++++++++++++-------
>  include/linux/amba/pl022.h        |    6 +
>  3 files changed, 435 insertions(+), 88 deletions(-)
> 
> diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
> index 03f7936..b86e944 100644
> --- a/arch/arm/mach-u300/dummyspichip.c
> +++ b/arch/arm/mach-u300/dummyspichip.c
> @@ -267,6 +267,7 @@ static struct spi_driver pl022_dummy_driver = {
>  	.driver = {
>  		.name	= "spi-dummy",
>  		.owner	= THIS_MODULE,
> +		.bus = &spi_bus_type,

This shouldn't be necessary.  spi_register_driver already sets the bus
type field.

Otherwise, this patch looks good.  If you're okay with me dropping
this hunk, then I'll pick up this patch into my next-spi branch.

g.
