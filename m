From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 19:48:29 +0200
Subject: [PATCH v4 19/35] mtd: rawnand: sh_flctl: move all NAND chip
 related setup in one function
In-Reply-To: <20180720151527.16038-20-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-20-miquel.raynal@bootlin.com>
Message-ID: <20180721194829.44e9b29f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:11 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> @@ -1007,6 +1007,16 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
>  	struct sh_flctl *flctl = mtd_to_flctl(mtd);
>  	struct nand_chip *chip = &flctl->chip;
>  
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		/*
> +		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
> +		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
> +		 * flctl->flcmncr_base to pdata->flcmncr_val.
> +		 */
> +		flctl->pdata->flcmncr_val |= SEL_16BIT;
> +		flctl->flcmncr_base = flctl->pdata->flcmncr_val;

pdata->flcmncr_val is not used after this point. I think you can just do

		flctl->flcmncr_base |= SEL_16BIT;

and get rid of the ftcl->pdata field you add in this patch.

> +	}
> +
