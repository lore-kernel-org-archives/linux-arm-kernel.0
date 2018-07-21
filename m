From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 19:34:46 +0200
Subject: [PATCH v4 17/35] mtd: rawnand: omap2: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-18-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-18-miquel.raynal@bootlin.com>
Message-ID: <20180721193446.499c2d7d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:09 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

>  static int omap_nand_probe(struct platform_device *pdev)
>  {
>  	struct omap_nand_info		*info;
>  	struct mtd_info			*mtd;
>  	struct nand_chip		*nand_chip;
>  	int				err;
> -	dma_cap_mask_t			mask;
>  	struct resource			*res;
>  	struct device			*dev = &pdev->dev;
> -	int				min_oobbytes = BADBLOCK_MARKER_LENGTH;
> -	int				oobbytes_per_step;
>  
>  	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
>  				GFP_KERNEL);
> @@ -1967,6 +2221,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	info->phys_base = res->start;
>  
>  	nand_chip->controller = &omap_gpmc_controller;
> +	nand_chip->controller->ops = &omap_nand_controller_ops;

Move this assignment here [1].

>  
>  	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
>  	nand_chip->cmd_ctrl  = omap_hwcontrol;

[1]https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/mtd/nand/raw/omap2.c#L148
