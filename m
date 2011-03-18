From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Mar 2011 08:34:36 +0100
Subject: [PATCH] mtd/mxc_nand: add support for multiple chips on V21
	devices
In-Reply-To: <2731521d2fd2224b7b28cc9ced044fc026d4fdb7.1300085993.git.baruch@tkos.co.il>
References: <2731521d2fd2224b7b28cc9ced044fc026d4fdb7.1300085993.git.baruch@tkos.co.il>
Message-ID: <20110318073436.GZ29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 09:01:56AM +0200, Baruch Siach wrote:
> Do the following to add support for up to 4 chips on V21 devices (i.MX25 and
> i.MX35):
> 
> * implement .select_chip for V21
> * adjust existing NFC_V1_V2_BUF_ADDR writes to take chip select into account
> * unlock all chip selects at preset_v1_v2()
> * scan up to 4 devices at .probe
> 
> This has been tested on i.MX25 with two attached NAND chip (on one die).

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/mtd/nand/mxc_nand.c |   51 +++++++++++++++++++++++++++----------------
>  1 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 0fc80db..55c5ac4 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -56,8 +56,14 @@
>  #define NFC_V1_V2_WRPROT		(host->regs + 0x12)
>  #define NFC_V1_UNLOCKSTART_BLKADDR	(host->regs + 0x14)
>  #define NFC_V1_UNLOCKEND_BLKADDR	(host->regs + 0x16)
> -#define NFC_V21_UNLOCKSTART_BLKADDR	(host->regs + 0x20)
> -#define NFC_V21_UNLOCKEND_BLKADDR	(host->regs + 0x22)
> +#define NFC_V21_UNLOCKSTART_BLKADDR0	(host->regs + 0x20)
> +#define NFC_V21_UNLOCKSTART_BLKADDR1	(host->regs + 0x24)
> +#define NFC_V21_UNLOCKSTART_BLKADDR2	(host->regs + 0x28)
> +#define NFC_V21_UNLOCKSTART_BLKADDR3	(host->regs + 0x2c)
> +#define NFC_V21_UNLOCKEND_BLKADDR0	(host->regs + 0x22)
> +#define NFC_V21_UNLOCKEND_BLKADDR1	(host->regs + 0x26)
> +#define NFC_V21_UNLOCKEND_BLKADDR2	(host->regs + 0x2a)
> +#define NFC_V21_UNLOCKEND_BLKADDR3	(host->regs + 0x2e)
>  #define NFC_V1_V2_NF_WRPRST		(host->regs + 0x18)
>  #define NFC_V1_V2_CONFIG1		(host->regs + 0x1a)
>  #define NFC_V1_V2_CONFIG2		(host->regs + 0x1c)
> @@ -152,6 +158,7 @@ struct mxc_nand_host {
>  	int			clk_act;
>  	int			irq;
>  	int			eccsize;
> +	int			active_cs;
>  
>  	struct completion	op_completion;
>  
> @@ -445,7 +452,7 @@ static void send_page_v1_v2(struct mtd_info *mtd, unsigned int ops)
>  	for (i = 0; i < bufs; i++) {
>  
>  		/* NANDFC buffer 0 is used for page read/write */
> -		writew(i, NFC_V1_V2_BUF_ADDR);
> +		writew((host->active_cs << 4) | i, NFC_V1_V2_BUF_ADDR);
>  
>  		writew(ops, NFC_V1_V2_CONFIG2);
>  
> @@ -470,7 +477,7 @@ static void send_read_id_v1_v2(struct mxc_nand_host *host)
>  	struct nand_chip *this = &host->nand;
>  
>  	/* NANDFC buffer 0 is used for device ID output */
> -	writew(0x0, NFC_V1_V2_BUF_ADDR);
> +	writew(host->active_cs << 4, NFC_V1_V2_BUF_ADDR);
>  
>  	writew(NFC_ID, NFC_V1_V2_CONFIG2);
>  
> @@ -505,7 +512,7 @@ static uint16_t get_dev_status_v1_v2(struct mxc_nand_host *host)
>  	uint32_t store;
>  	uint16_t ret;
>  
> -	writew(0x0, NFC_V1_V2_BUF_ADDR);
> +	writew(host->active_cs << 4, NFC_V1_V2_BUF_ADDR);
>  
>  	/*
>  	 * The device status is stored in main_area0. To
> @@ -686,24 +693,24 @@ static void mxc_nand_select_chip(struct mtd_info *mtd, int chip)
>  	struct nand_chip *nand_chip = mtd->priv;
>  	struct mxc_nand_host *host = nand_chip->priv;
>  
> -	switch (chip) {
> -	case -1:
> +	if (chip == -1) {
>  		/* Disable the NFC clock */
>  		if (host->clk_act) {
>  			clk_disable(host->clk);
>  			host->clk_act = 0;
>  		}
> -		break;
> -	case 0:
> +		return;
> +	}
> +
> +	if (!host->clk_act) {
>  		/* Enable the NFC clock */
> -		if (!host->clk_act) {
> -			clk_enable(host->clk);
> -			host->clk_act = 1;
> -		}
> -		break;
> +		clk_enable(host->clk);
> +		host->clk_act = 1;
> +	}
>  
> -	default:
> -		break;
> +	if (nfc_is_v21()) {
> +		host->active_cs = chip;
> +		writew(host->active_cs << 4, NFC_V1_V2_BUF_ADDR);
>  	}
>  }
>  
> @@ -835,8 +842,14 @@ static void preset_v1_v2(struct mtd_info *mtd)
>  
>  	/* Blocks to be unlocked */
>  	if (nfc_is_v21()) {
> -		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR);
> -		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR);
> +		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR0);
> +		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR1);
> +		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR2);
> +		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR3);
> +		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR0);
> +		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR1);
> +		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR2);
> +		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR3);
>  	} else if (nfc_is_v1()) {
>  		writew(0x0, NFC_V1_UNLOCKSTART_BLKADDR);
>  		writew(0x4000, NFC_V1_UNLOCKEND_BLKADDR);
> @@ -1201,7 +1214,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
>  		irq_control_v1_v2(host, 1);
>  
>  	/* first scan to find the device and get the page size */
> -	if (nand_scan_ident(mtd, 1, NULL)) {
> +	if (nand_scan_ident(mtd, nfc_is_v21() ? 4 : 1, NULL)) {
>  		err = -ENXIO;
>  		goto escan;
>  	}
> -- 
> 1.7.2.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
