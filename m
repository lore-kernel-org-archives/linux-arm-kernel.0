From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 11 Sep 2015 15:53:40 -0700
Subject: [PATCH v3] mtd: nand: sunxi: rely on nand_dt_init initialization
In-Reply-To: <1441182625-525-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1441182625-525-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150911225340.GI11487@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 10:30:25AM +0200, Boris Brezillon wrote:
> nand_dt_init(), called from nand_scan_ident(), is already parsing the
> generic MTD/NAND DT properties, and initializing the nand_chip struct
> accordingly.
> Rely on this initialization instead of manually parsing those properties.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Changes since v2:
> - fix a bug forcing ecc.mode to HW_ECC
> Changes since v1:
> - drop unused strength and blk_size variables
> ---
>  drivers/mtd/nand/sunxi_nand.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index 0c29f6c..d644548 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
[...]
> @@ -1224,15 +1211,18 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  	/* Default tR value specified in the ONFI spec (chapter 4.15.1) */
>  	nand->chip_delay = 200;
>  	nand->controller = &nfc->controller;
> +	/*
> +	 * Set the ECC mode to the default value in case nothing is specified
> +	 * in the DT.
> +	 */
> +	nand->ecc.mode = NAND_ECC_HW;
> +	nand->dn = np;

Renamed dn -> flash_node, due to [1], and applied to l2-mtd.git/next

>  	nand->select_chip = sunxi_nfc_select_chip;
>  	nand->cmd_ctrl = sunxi_nfc_cmd_ctrl;
>  	nand->read_buf = sunxi_nfc_read_buf;
>  	nand->write_buf = sunxi_nfc_write_buf;
>  	nand->read_byte = sunxi_nfc_read_byte;
>  
> -	if (of_get_nand_on_flash_bbt(np))
> -		nand->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> -
>  	mtd = &chip->mtd;
>  	mtd->dev.parent = dev;
>  	mtd->priv = nand;

Brian

[1] http://patchwork.ozlabs.org/patch/514205/
