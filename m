From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 10:23:01 -0800
Subject: [PATCH v3 13/28] mtd: nand: pxa3xx: Add bad block handling
In-Reply-To: <1383656135-8627-14-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-14-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131105182301.GN20061@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

I wrote up some comments on your v2 series while on a plane Sunday, but
I didn't make time to send them out until now. Oh well.

On Tue, Nov 05, 2013 at 09:55:20AM -0300, Ezequiel Garcia wrote:
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -1128,6 +1152,14 @@ KEEP_CONFIG:
>  
>  	if (nand_scan_ident(mtd, 1, def))
>  		return -ENODEV;
> +
> +	if (pdata->flash_bbt) {
> +		chip->bbt_options |= NAND_BBT_USE_FLASH |
> +				     NAND_BBT_NO_OOB_BBM;

You're using NAND_BBT_NO_OOB_BBM? So you are unable to write bad block
markers to flash at all? Is this related to your independent patch for
trying to scan BBM from the data area? Could you instead write a
nand_chip.block_markbad() callback routine that would program BBM to the
appropriate data area?

Or, if you really want to avoid programming new BBMs, then you should
probably describe this decision in the patch description more clearly.

> +		chip->bbt_td = &bbt_main_descr;
> +		chip->bbt_md = &bbt_mirror_descr;
> +	}
> +
>  	/* calculate addressing information */
>  	if (mtd->writesize >= 2048)
>  		host->col_addr_cycles = 2;
> @@ -1323,6 +1355,7 @@ static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
>  	if (of_get_property(np, "marvell,nand-keep-config", NULL))
>  		pdata->keep_config = 1;
>  	of_property_read_u32(np, "num-cs", &pdata->num_cs);
> +	pdata->flash_bbt = of_get_nand_on_flash_bbt(np);

Now that you're using the "nand-on-flash-bbt" property, you should
document it in Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
like the other drivers do. (It's already documented generically in
Documentation/.../nand.txt, but I think it's good practice to explicitly
note which drivers support the binding, since nand_base doesn't do this
generically for all NAND drivers.)

>  
>  	pdev->dev.platform_data = pdata;
>  

Brian
