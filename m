From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 08:35:41 +0200
Subject: [PATCH v4 02/35] mtd: rawnand: cafe: convert driver to nand_scan()
In-Reply-To: <20180720151527.16038-3-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-3-miquel.raynal@bootlin.com>
Message-ID: <20180721083541.5a52771a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:14:54 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/cafe_nand.c | 130 +++++++++++++++++++++++----------------
>  1 file changed, 76 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
> index ac0be933a490..c303c261dd8d 100644
> --- a/drivers/mtd/nand/raw/cafe_nand.c
> +++ b/drivers/mtd/nand/raw/cafe_nand.c
> @@ -71,7 +71,9 @@ struct cafe_priv {
>  	unsigned char *dmabuf;
>  };
>  
> -static int usedma = 1;
> +#define CAFE_DEFAULT_DMA	1
> +
> +static int usedma = CAFE_DEFAULT_DMA;

Not sure you need a macro for that.

>  module_param(usedma, int, 0644);
>  
>  static int skipbbt = 0;
> @@ -593,6 +595,76 @@ static int cafe_mul(int x)
>  	return gf4096_mul(x, 0xe01);
>  }
>  
> +static int cafe_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct cafe_priv *cafe = nand_get_controller_data(chip);
> +	int err = 0;
> +
> +	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev, 2112,
> +					  &cafe->dmaaddr, GFP_KERNEL);
> +	if (!cafe->dmabuf)
> +		return -ENOMEM;
> +
> +	/* Set up DMA address */
> +	cafe_writel(cafe, lower_32_bits(cafe->dmaaddr), NAND_DMA_ADDR0);
> +	cafe_writel(cafe, upper_32_bits(cafe->dmaaddr), NAND_DMA_ADDR1);
> +
> +	cafe_dev_dbg(&cafe->pdev->dev, "Set DMA address to %x (virt %p)\n",
> +		     cafe_readl(cafe, NAND_DMA_ADDR0), cafe->dmabuf);
> +
> +	/* Restore the DMA flag */
> +	usedma = CAFE_DEFAULT_DMA;

This is wrong. The user might have passed a different value to usedma
when loading the module (or on the kernel cmdline), and you're simply
ignoring it. I see 2 solutions to solve that:

1/ add a ->usedma field to the cafe_priv struct which you initialize to
   0 in the probe function (already done if you kzalloc() the struct)
   and update it here:

	cafe->usedma = usedma.

   then you have to patch all places where usedma was tested and
   replace this test by a test on cafe->usedma

2/ add a static in old_usedma which you assign to usedma value in the
   probe and then restore the usedma value here:

	usedma = old_usedma

I prefer option #1.
