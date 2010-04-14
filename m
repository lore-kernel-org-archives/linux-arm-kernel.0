From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Apr 2010 09:01:51 +0200
Subject: [PATCH v3 1/2] MXC: mxc_nand: set NFC registers after reset
In-Reply-To: <u2uba216b431004080714hc8f8dfcaz5c8eeca56efe44f8@mail.gmail.com>
References: <u2uba216b431004080714hc8f8dfcaz5c8eeca56efe44f8@mail.gmail.com>
Message-ID: <20100414070151.GF7882@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 04:14:44PM +0200, Ivo Clarysse wrote:
> This patch allows the mxc_nand driver to reset the NAND
> flash controller.  NFC registers are (re-)set after
> completion of the reset, as a reset will have reverted
> the NFC registers to their default values.
> 
> Signed-off-by: Ivo Clarysse <ivo.clarysse@gmail.com>

Both applied to mxc-master.

I usually prefer pushing these patches via the mtd tree but they too
often get stuck somewhere. I found several mxc-nand related patches in
mtd-master, one of them fixing the not implemented reset command.

Sascha


> ---
> diff -u -r -N linux-2.6.33.2/drivers/mtd/nand/mxc_nand.c
> linux-2.6.33.2-reset/drivers/mtd/nand/mxc_nand.c
> --- linux-2.6.33.2/drivers/mtd/nand/mxc_nand.c	2010-04-02
> 01:02:33.000000000 +0200
> +++ linux-2.6.33.2-reset/drivers/mtd/nand/mxc_nand.c	2010-04-08
> 15:54:10.000000000 +0200
> @@ -542,6 +542,41 @@
>  	}
>  }
> 
> +static void preset(struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand_chip = mtd->priv;
> +	struct mxc_nand_host *host = nand_chip->priv;
> +	uint16_t tmp;
> +
> +	/* disable interrupt, disable spare enable */
> +	tmp = readw(host->regs + NFC_CONFIG1);
> +	tmp |= NFC_INT_MSK;
> +	tmp &= ~NFC_SP_EN;
> +	if (nand_chip->ecc.mode == NAND_ECC_HW) {
> +		tmp |= NFC_ECC_EN;
> +	} else {
> +		tmp &= ~NFC_ECC_EN;
> +	}
> +	writew(tmp, host->regs + NFC_CONFIG1);
> +	/* preset operation */
> +
> +	/* Unlock the internal RAM Buffer */
> +	writew(0x2, host->regs + NFC_CONFIG);
> +
> +	/* Blocks to be unlocked */
> +	if (nfc_is_v21()) {
> +		writew(0x0, host->regs + NFC_V21_UNLOCKSTART_BLKADDR);
> +		writew(0xffff, host->regs + NFC_V21_UNLOCKEND_BLKADDR);
> +	} else if (nfc_is_v1()) {
> +		writew(0x0, host->regs + NFC_V1_UNLOCKSTART_BLKADDR);
> +		writew(0x4000, host->regs + NFC_V1_UNLOCKEND_BLKADDR);
> +	} else
> +		BUG();
> +
> +	/* Unlock Block Command for given address range */
> +	writew(0x4, host->regs + NFC_WRPROT);
> +}
> +
>  /* Used by the upper layer to write command to NAND Flash for
>   * different operations to be carried out on NAND Flash */
>  static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
> @@ -559,6 +594,10 @@
> 
>  	/* Command pre-processing step */
>  	switch (command) {
> +	case NAND_CMD_RESET:
> +		send_cmd(host, command, false);
> +		preset(mtd);
> +		break;
> 
>  	case NAND_CMD_STATUS:
>  		host->buf_start = 0;
> @@ -679,7 +718,6 @@
>  	struct mxc_nand_platform_data *pdata = pdev->dev.platform_data;
>  	struct mxc_nand_host *host;
>  	struct resource *res;
> -	uint16_t tmp;
>  	int err = 0, nr_parts = 0;
>  	struct nand_ecclayout *oob_smallpage, *oob_largepage;
> 
> @@ -743,51 +781,17 @@
>  		host->spare_len = 64;
>  		oob_smallpage = &nandv2_hw_eccoob_smallpage;
>  		oob_largepage = &nandv2_hw_eccoob_largepage;
> +		this->ecc.bytes = 9;
>  	} else if (nfc_is_v1()) {
>  		host->regs = host->base;
>  		host->spare0 = host->base + 0x800;
>  		host->spare_len = 16;
>  		oob_smallpage = &nandv1_hw_eccoob_smallpage;
>  		oob_largepage = &nandv1_hw_eccoob_largepage;
> -	} else
> -		BUG();
> -
> -	/* disable interrupt and spare enable */
> -	tmp = readw(host->regs + NFC_CONFIG1);
> -	tmp |= NFC_INT_MSK;
> -	tmp &= ~NFC_SP_EN;
> -	writew(tmp, host->regs + NFC_CONFIG1);
> -
> -	init_waitqueue_head(&host->irq_waitq);
> -
> -	host->irq = platform_get_irq(pdev, 0);
> -
> -	err = request_irq(host->irq, mxc_nfc_irq, 0, DRIVER_NAME, host);
> -	if (err)
> -		goto eirq;
> -
> -	/* Reset NAND */
> -	this->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
> -
> -	/* preset operation */
> -	/* Unlock the internal RAM Buffer */
> -	writew(0x2, host->regs + NFC_CONFIG);
> -
> -	/* Blocks to be unlocked */
> -	if (nfc_is_v21()) {
> -		writew(0x0, host->regs + NFC_V21_UNLOCKSTART_BLKADDR);
> -	        writew(0xffff, host->regs + NFC_V21_UNLOCKEND_BLKADDR);
> -		this->ecc.bytes = 9;
> -	} else if (nfc_is_v1()) {
> -		writew(0x0, host->regs + NFC_V1_UNLOCKSTART_BLKADDR);
> -	        writew(0x4000, host->regs + NFC_V1_UNLOCKEND_BLKADDR);
>  		this->ecc.bytes = 3;
>  	} else
>  		BUG();
> 
> -	/* Unlock Block Command for given address range */
> -	writew(0x4, host->regs + NFC_WRPROT);
> -
>  	this->ecc.size = 512;
>  	this->ecc.layout = oob_smallpage;
> 
> @@ -796,14 +800,8 @@
>  		this->ecc.hwctl = mxc_nand_enable_hwecc;
>  		this->ecc.correct = mxc_nand_correct_data;
>  		this->ecc.mode = NAND_ECC_HW;
> -		tmp = readw(host->regs + NFC_CONFIG1);
> -		tmp |= NFC_ECC_EN;
> -		writew(tmp, host->regs + NFC_CONFIG1);
>  	} else {
>  		this->ecc.mode = NAND_ECC_SOFT;
> -		tmp = readw(host->regs + NFC_CONFIG1);
> -		tmp &= ~NFC_ECC_EN;
> -		writew(tmp, host->regs + NFC_CONFIG1);
>  	}
> 
>  	/* NAND bus width determines access funtions used by upper layer */
> @@ -817,6 +815,14 @@
>  		this->options |= NAND_USE_FLASH_BBT;
>  	}
> 
> +	init_waitqueue_head(&host->irq_waitq);
> +
> +	host->irq = platform_get_irq(pdev, 0);
> +
> +	err = request_irq(host->irq, mxc_nfc_irq, 0, DRIVER_NAME, host);
> +	if (err)
> +		goto eirq;
> +
>  	/* first scan to find the device and get the page size */
>  	if (nand_scan_ident(mtd, 1)) {
>  		err = -ENXIO;
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
