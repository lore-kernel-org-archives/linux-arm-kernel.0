From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 15 Mar 2018 16:23:20 +0100
Subject: [PATCH 02/52] mtd: rawnand: bf5xx: fix probe function error path
In-Reply-To: <20180302170400.6712-3-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
 <20180302170400.6712-3-miquel.raynal@bootlin.com>
Message-ID: <20180315162320.38f06fe7@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  2 Mar 2018 18:03:10 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> An error after nand_scan_tail() should trigger a nand_release().
> The helper mtd_device_register() (wrapped by bf5xx_nand_add_partition())
> returns an error code that should be checked and nand_release() called
> accordingly.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/bf5xx_nand.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/bf5xx_nand.c b/drivers/mtd/nand/raw/bf5xx_nand.c
> index 9a1d8d104570..da7a6083b0e5 100644
> --- a/drivers/mtd/nand/raw/bf5xx_nand.c
> +++ b/drivers/mtd/nand/raw/bf5xx_nand.c
> @@ -831,11 +831,16 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
>  #endif
>  
>  	/* add NAND partition */
> -	bf5xx_nand_add_partition(info);
> +	err = bf5xx_nand_add_partition(info);
> +	if (err)
> +		goto out_err_release_nand;
>  
>  	dev_dbg(&pdev->dev, "initialised ok\n");
> +
>  	return 0;
>  
> +out_err_release_nand:
> +	nand_release(mtd);

You should call nand_cleanup() here not nand_release(), because the
mtd device has not been registered and nand_release() does both
mtd_device_unregister() and nand_cleanup().

I'll let you check the other patches.

>  out_err_nand_scan:
>  	bf5xx_nand_dma_remove(info);
>  out_err:



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
