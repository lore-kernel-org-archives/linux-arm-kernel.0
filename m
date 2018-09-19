From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Wed, 19 Sep 2018 10:44:54 +0300
Subject: [PATCH v2] mtd: rawnand: atmel: Fix potential NULL pointer
 dereference
In-Reply-To: <20180918135555.GA18114@embeddedor.com>
References: <20180918135555.GA18114@embeddedor.com>
Message-ID: <61472393-b699-45b4-6d74-cfa774669ad2@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/18/2018 04:55 PM, Gustavo A. R. Silva wrote:
> There is a potential execution path in which function
> of_find_compatible_node() returns NULL. In such a case,
> we end up having a NULL pointer dereference when accessing
> pointer *nfc_np* in function of_clk_get().
> 
> So, we better don't take any chances and fix this by null
> checking pointer *nfc_np* before calling of_clk_get().
> 
> Addresses-Coverity-ID: 1473052 ("Dereference null return value")
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
> Changes in v2:
>  - Add Fixes tag to the commit log.
>  - Remove blank line before null checking nfc_np.
> 
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index a38633a..5bfbe97 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2034,6 +2034,10 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
>  	nand_np = dev->of_node;
>  	nfc_np = of_find_compatible_node(dev->of_node, NULL,
>  					 "atmel,sama5d3-nfc");
> +	if (!nfc_np) {
> +		dev_err(dev, "Could not find device node for sama5d3-nfc\n");
> +		return -ENODEV;
> +	}
>  
>  	nc->clk = of_clk_get(nfc_np, 0);
>  	if (IS_ERR(nc->clk)) {
> 
