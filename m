From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 May 2010 10:20:13 +0200
Subject: [PATCH 11/20] mtd: pxa3xx_nand: add debug messege
In-Reply-To: <AANLkTilMUQHJDzVrO5FXeEE8udXkDwS240Vrl1lIkdyG@mail.gmail.com>
References: <AANLkTilMUQHJDzVrO5FXeEE8udXkDwS240Vrl1lIkdyG@mail.gmail.com>
Message-ID: <4BED07BD.7090403@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang wrote:
>>From 10e0c31fac5a8ebeb314d609cea24351097b1aae Mon Sep 17 00:00:00 2001
> From: Lei Wen <leiwen@marvell.com>
> Date: Tue, 30 Mar 2010 20:58:58 +0800
> Subject: [PATCH] mtd: pxa3xx_nand: add debug messege
> 
> Add debug messege to those key route to help find out problem.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index fb1af4c..0674b52 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -30,6 +30,12 @@
>  #define NAND_STOP_DELAY		(2 * HZ/50)
>  #define PAGE_CHUNK_SIZE		(2048)
>  #define BCH_THRESHOLD           (8)
> +#undef PXA3XX_NAND_DEBUG
> +#ifdef PXA3XX_NAND_DEBUG
> +#define DBG_NAND(x)	do{x;}while(0)
> +#else
> +#define DBG_NAND(x)
> +#endif

If you really need to get this in mainline, try using pr_debug() for
this, add

#if PXA3XX_NAND_DEBUG
#define DEBUG
#endif

to activate debugging.

> 
>  /* registers and bit definitions */
>  #define NDCR		(0x00) /* Control register */
> @@ -411,6 +417,8 @@ static void pxa3xx_nand_start(struct pxa3xx_nand *nand)
>  	}
> 
>  	/* clear status bits and run */
> +	DBG_NAND(printk("@@@ndcr set: %x, ndeccctrl set %x\n",
> +				ndcr, ndeccctrl));
>  	nand_writel(nand, NDCR, 0);
>  	nand_writel(nand, NDECCCTRL, ndeccctrl);
>  	nand_writel(nand, NDSR, NDSR_MASK);
> @@ -456,6 +464,8 @@ static void handle_data_pio(struct pxa3xx_nand *nand)
>  {
>  	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
> 
> +	DBG_NAND(printk("data size %x, oob size %x\n",
> +				nand->data_size, nand->oob_size));
>  	if (nand->state & STATE_IS_WRITE) {
>  		__raw_writesl(nand->mmio_base + NDDB, info->data_buff,
>  				DIV_ROUND_UP(nand->data_size, 4));
> @@ -492,6 +502,8 @@ static void start_data_dma(struct pxa3xx_nand
> *nand, int dir_out)
>  		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
>  	}
> 
> +	DBG_NAND(printk("DMA START:DMA dcmd %x, dsadr %x, dtadr %x, len %x\n",
> +				desc->dcmd, desc->dsadr, desc->dtadr, dma_len));
>  	DRCMR(nand->drcmr_dat) = DRCMR_MAPVLD | info->data_dma_ch;
>  	DDADR(info->data_dma_ch) = info->data_desc_addr;
>  	DCSR(info->data_dma_ch) |= DCSR_RUN;
> @@ -505,6 +517,7 @@ static void pxa3xx_nand_data_dma_irq(int channel,
> void *data)
>  	dcsr = DCSR(channel);
>  	DCSR(channel) = dcsr;
> 
> +	DBG_NAND(printk("DMA IRQ: dcsr %x\n", dcsr));
>  	if (dcsr & DCSR_BUSERR) {
>  		nand->retcode = ERR_DMABUSERR;
>  	}
> @@ -528,6 +541,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  	info            = nand->info[cs];
> 
>  	status = nand_readl(nand, NDSR);
> +	DBG_NAND(if (status != 0)
> +		printk("\t\tstatus %x, cs %x\n", status, cs));
>  	nand->bad_count = (status & NDSR_ERR_CNT_MASK) >> 16;
>  	if (status & NDSR_DBERR)
>  		nand->retcode = ERR_DBERR;
> @@ -562,6 +577,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  		nand_writel(nand, NDCB0, info->ndcb0);
>  		nand_writel(nand, NDCB0, info->ndcb1);
>  		nand_writel(nand, NDCB0, info->ndcb2);
> +		DBG_NAND(printk("\tndcb0 %x ndcb1 %x ndcb2 %x\n",
> +				info->ndcb0, info->ndcb1, info->ndcb2));
>  	}
> 
>  	/* clear NDSR to let the controller exit the IRQ */
> @@ -754,6 +771,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
> *mtd, unsigned command,
>  		nand_writel(nand, NDTR1CS0, info->ndtr1cs0);
>  	}
> 
> +	DBG_NAND(printk("command %x, page %x\n", command, page_addr));
>  	exec_cmd = prepare_command_pool(nand, command, column, page_addr);
>  	if (exec_cmd) {
>  		init_completion(&nand->cmd_complete);
> @@ -940,6 +958,7 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
>  	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
> 
>  	if (nand->retcode == ERR_SBERR) {
> +		DBG_NAND(printk("###correctable error detected\n"););
>  		switch (nand->use_ecc) {
>  		case ECC_BCH:
>  			if (nand->bad_count > BCH_THRESHOLD)
> @@ -956,8 +975,10 @@ static int pxa3xx_nand_read_page_hwecc(struct
> mtd_info *mtd,
>  		int buf_blank;
> 
>  		buf_blank = is_buf_blank(buf, mtd->writesize);
> -		if (!buf_blank)
> +		if (!buf_blank) {
> +			DBG_NAND(printk("###uncorrectable error!!!\n"));
>  			mtd->ecc_stats.failed++;
> +		}
>  	}
> 
>  	return 0;


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100514/94e0927e/attachment.sig>
