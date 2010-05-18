From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 18 May 2010 14:29:32 +0800
Subject: [Linux-arm-nuc900] NUC900 nand driver Patch
In-Reply-To: <4BD99D4A.2020908@gmail.com>
References: <4BD99D4A.2020908@gmail.com>
Message-ID: <AANLkTilp8zYk-o3FhBrS4UNvz8lwQReooXx-PCv7Xs34@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wills,

Please send your patch to me as a attached file.

thanks!

? 2010?4?29? ??10:52?Wills Wang <wills.wang.cn@gmail.com> ???
> There is a patch for NUC900 nand driver, it fix up the bug access for
> incorrect register address and NULL pointer.
>
> --- linux-2.6.34-rc5/drivers/mtd/nand/nuc900_nand.c 2010-04-29
> 14:35:04.000000000 +0000
> +++ linux-2.6.34-rc5/drivers/mtd/nand/nuc900_nand.c 2010-04-29
> 14:42:22.000000000 +0000
> @@ -132,7 +153,7 @@
> {
> unsigned int val;
> spin_lock(&nand->lock);
> - val = __raw_readl(REG_SMISR);
> + val = __raw_readl(nand->reg + REG_SMISR);
> val &= READYBUSY;
> spin_unlock(&nand->lock);
>
> @@ -150,6 +171,19 @@
> return ready;
> }
>
> +static void nuc900_nand_select_chip(struct mtd_info *mtd, int chipnr)
> +{
> + switch (chipnr) {
> + case -1:
> + break;
> + case 0:
> + break;
> +
> + default:
> + BUG();
> + }
> +}
> +
> static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int
> command,
> int column, int page_addr)
> {
> @@ -240,7 +274,6 @@
> ;
> }
>
> -
> static void nuc900_nand_enable(struct nuc900_nand *nand)
> {
> unsigned int val;
> @@ -250,7 +283,7 @@
> val = __raw_readl(nand->reg + REG_FMICSR);
>
> if (!(val & NAND_EN))
> - __raw_writel(val | NAND_EN, REG_FMICSR);
> + __raw_writel(val | NAND_EN, nand->reg + REG_FMICSR);
>
> val = __raw_readl(nand->reg + REG_SMCSR);
>
> @@ -286,7 +319,7 @@
> goto fail1;
> }
> clk_enable(nuc900_nand->clk);
> -
> + chip->select_chip = nuc900_nand_select_chip;
> chip->cmdfunc = nuc900_nand_command_lp;
> chip->dev_ready = nuc900_nand_devready;
> chip->read_byte = nuc900_nand_read_byte;
>
> --
> ????"NUC900 Linux BSP????".
> NUC900 Linux????????????
> NUC900 at googlegroups.com
> ?????????
> NUC900+unsubscribe at googlegroups.com
> ??????????
> https://groups.google.com/group/NUC900?hl=zh-CN
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
