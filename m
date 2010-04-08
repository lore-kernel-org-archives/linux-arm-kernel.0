From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 8 Apr 2010 15:33:03 +0200
Subject: [PATCH v2] ARM: MXC: mxc_nand: support i.MX21
In-Reply-To: <o2oba216b431004080520u924ffafby3a88e18471b560b@mail.gmail.com>
References: <q2tba216b431004060652jeb9df33eqd141836e46980f00@mail.gmail.com>
	<20100407134039.GE3688@pengutronix.de>
	<o2oba216b431004080520u924ffafby3a88e18471b560b@mail.gmail.com>
Message-ID: <20100408133303.GK3688@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 02:20:36PM +0200, Ivo Clarysse wrote:
> Allow mxc_nand.c to function on i.MX21 SoCs, since:
> 
> 1) On i.MX21, if the NFC_INT_MASK bit in NFC_CONFIG1 is set, the NFC_INT
>  bit of NFC_CONFIG2 always reads out zero, even if an operation is
>  completed.
> 
> 2) On i.MX21, sending a RESET command to the NAND flash controller does
>  not trigger an interrupt, nor does it cause the NFC_INT bit of
>  NFC_CONFIG2 to get set.
> 
> This patch:
> 
> - Uses enable_irq / disable_irq_nosync instead of NFC_INT_MASK
>   to mask NFC interrupts (allowing NFC_CONFIG2:NFC_INT to used on i.MX21)
> 
> - (Re-)sets all NFC registers after reset

Looks much better without all the i.MX21 specific handling. Can you
please make two patches out of it? One which fixes the reset command and
factors out the init sequence to preset() and one patch which adds
i.MX21 support.

Sascha

> 
> Signed-off-by: Ivo Clarysse <ivo.clarysse@gmail.com>
> ---
> --- linux-2.6.33.2/drivers/mtd/nand/mxc_nand.c	2010-04-02
> 01:02:33.000000000 +0200
> +++ linux-2.6.33.2-mine/drivers/mtd/nand/mxc_nand.c	2010-04-08
> 14:01:58.000000000 +0200
> @@ -38,7 +38,7 @@
>  #define DRIVER_NAME "mxc_nand"
> 
>  #define nfc_is_v21()		(cpu_is_mx25() || cpu_is_mx35())
> -#define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27())
> +#define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
> 
>  /* Addresses for NFC registers */
>  #define NFC_BUF_SIZE		0xE00
> @@ -168,11 +168,7 @@
>  {
>  	struct mxc_nand_host *host = dev_id;
> 
> -	uint16_t tmp;
> -
> -	tmp = readw(host->regs + NFC_CONFIG1);
> -	tmp |= NFC_INT_MSK; /* Disable interrupt */
> -	writew(tmp, host->regs + NFC_CONFIG1);
> +	disable_irq_nosync(irq);
> 
>  	wake_up(&host->irq_waitq);
> 
> @@ -184,15 +180,13 @@
>   */
>  static void wait_op_done(struct mxc_nand_host *host, int useirq)
>  {
> -	uint32_t tmp;
> -	int max_retries = 2000;
> +	uint16_t tmp;
> +	int max_retries = 8000;
> 
>  	if (useirq) {
>  		if ((readw(host->regs + NFC_CONFIG2) & NFC_INT) == 0) {
> 
> -			tmp = readw(host->regs + NFC_CONFIG1);
> -			tmp  &= ~NFC_INT_MSK;	/* Enable interrupt */
> -			writew(tmp, host->regs + NFC_CONFIG1);
> +			enable_irq(host->irq);
> 
>  			wait_event(host->irq_waitq,
>  				readw(host->regs + NFC_CONFIG2) & NFC_INT);
> @@ -226,8 +220,23 @@
>  	writew(cmd, host->regs + NFC_FLASH_CMD);
>  	writew(NFC_CMD, host->regs + NFC_CONFIG2);
> 
> -	/* Wait for operation to complete */
> -	wait_op_done(host, useirq);
> +	if (cpu_is_mx21() && (cmd == NAND_CMD_RESET)) {
> +		int max_retries = 100;
> +		/* Reset completion is indicated by NFC_CONFIG2 */
> +		/* being set to 0 */
> +		while (max_retries-- > 0) {
> +			if (readw(host->regs + NFC_CONFIG2) == 0) {
> +				break;
> +			}
> +			udelay(1);
> +		}
> +		if (max_retries < 0)
> +			DEBUG(MTD_DEBUG_LEVEL0, "%s: RESET failed\n",
> +			      __func__);
> +	} else {
> +		/* Wait for operation to complete */
> +		wait_op_done(host, useirq);
> +	}
>  }
> 
>  /* This function sends an address (or partial address) to the
> @@ -542,6 +551,41 @@
>  	}
>  }
> 
> +static void preset(struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand_chip = mtd->priv;
> +	struct mxc_nand_host *host = nand_chip->priv;
> +	uint16_t tmp;
> +
> +	/* enable interrupt, disable spare enable */
> +	tmp = readw(host->regs + NFC_CONFIG1);
> +	tmp &= ~NFC_INT_MSK;
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
> @@ -559,6 +603,10 @@
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
> @@ -679,7 +727,6 @@
>  	struct mxc_nand_platform_data *pdata = pdev->dev.platform_data;
>  	struct mxc_nand_host *host;
>  	struct resource *res;
> -	uint16_t tmp;
>  	int err = 0, nr_parts = 0;
>  	struct nand_ecclayout *oob_smallpage, *oob_largepage;
> 
> @@ -743,51 +790,17 @@
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
> @@ -796,14 +809,8 @@
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
> @@ -817,6 +824,14 @@
>  		this->options |= NAND_USE_FLASH_BBT;
>  	}
> 
> +	init_waitqueue_head(&host->irq_waitq);
> +
> +	host->irq = platform_get_irq(pdev, 0);
> +
> +	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
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
