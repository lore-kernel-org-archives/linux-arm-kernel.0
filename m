From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 29 Mar 2018 15:33:22 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <20180329131054.22506-1-peda@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
Message-ID: <20180329153322.5e2fc1e7@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Mar 2018 15:10:54 +0200
Peter Rosin <peda@axentia.se> wrote:

> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> flash accesses have a tendency to cause display disturbances. Add a
> module param to disable DMA from the NAND controller, since that fixes
> the display problem for me.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index b2f00b398490..2ff7a77c7b8e 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -129,6 +129,11 @@
>  #define DEFAULT_TIMEOUT_MS			1000
>  #define MIN_DMA_LEN				128
>  
> +static bool atmel_nand_avoid_dma __read_mostly;
> +
> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);

I'm not a big fan of those driver specific cmdline parameters. Can't we
instead give an higher priority to HLCDC master using the bus matrix?

> +
>  enum atmel_nand_rb_type {
>  	ATMEL_NAND_NO_RB,
>  	ATMEL_NAND_NATIVE_RB,
> @@ -1977,7 +1982,7 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>  		return ret;
>  	}
>  
> -	if (nc->caps->has_dma) {
> +	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
>  		dma_cap_mask_t mask;
>  
>  		dma_cap_zero(mask);



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
