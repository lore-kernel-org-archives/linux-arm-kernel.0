From: rogerq@ti.com (Roger Quadros)
Date: Mon, 4 Apr 2016 10:23:04 +0300
Subject: [PATCH 03/12] mtd: nand: omap2: rely on generic DT parsing done
 in nand_scan_ident()
In-Reply-To: <1459515272-31011-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <57021658.5060901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/16 15:54, Boris Brezillon wrote:
> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  drivers/memory/omap-gpmc.c | 7 -------
>  drivers/mtd/nand/omap2.c   | 9 ++++++---
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 21825dd..85aa85e 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -25,7 +25,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_mtd.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/omap-gpmc.h>
> @@ -1876,12 +1875,6 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  				break;
>  			}
>  
> -	gpmc_nand_data->flash_bbt = of_get_nand_on_flash_bbt(child);
> -
> -	val = of_get_nand_bus_width(child);
> -	if (val == 16)
> -		gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
> -
>  	gpmc_read_timings_dt(child, &gpmc_t);
>  	gpmc_nand_init(gpmc_nand_data, &gpmc_t);
>  
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 0749ca1..8921283 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1704,9 +1704,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	if (pdata->flash_bbt)
> -		nand_chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> -	else
> -		nand_chip->options |= NAND_SKIP_BBTSCAN;
> +		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
>  
>  	/* scan NAND device connected to chip controller */
>  	nand_chip->options |= pdata->devsize & NAND_BUSWIDTH_16;
> @@ -1716,6 +1714,11 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		goto return_error;
>  	}
>  
> +	if (nand_chip->bbt_options & NAND_BBT_USE_FLASH)
> +		nand_chip->bbt_options |= NAND_BBT_NO_OOB;
> +	else
> +		nand_chip->options |= NAND_SKIP_BBTSCAN;
> +
>  	/* re-populate low-level callbacks based on xfer modes */
>  	switch (pdata->xfer_type) {
>  	case NAND_OMAP_PREFETCH_POLLED:
> 
