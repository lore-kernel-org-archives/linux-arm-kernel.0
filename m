From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 11:04:32 -0800
Subject: [PATCH v3 22/28] mtd: nand: pxa3xx: Introduce multiple page
 I/O support
In-Reply-To: <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131105190432.GQ20061@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:55:29AM -0300, Ezequiel Garcia wrote:
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -826,7 +887,8 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
>  	prepare_start_command(info, command);
>  
>  	info->state = STATE_PREPARED;
> -	exec_cmd = prepare_set_command(info, command, column, page_addr);
> +	exec_cmd = prepare_set_command(info, command, -1, column, page_addr);

Is it safe to use -1 for the third parameter (ext_cmd_type)? AFAICT,
this doesn't make for correct input to the NDCB0_EXT_CMD_TYPE() macro.

> +
>  	if (exec_cmd) {
>  		init_completion(&info->cmd_complete);
>  		init_completion(&info->dev_ready);
> @@ -844,6 +906,91 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
>  	info->state = STATE_IDLE;
>  }
>  
> +static void armada370_nand_cmdfunc(struct mtd_info *mtd,
> +				   const unsigned command,
> +				   int column, int page_addr)
> +{
> +	struct pxa3xx_nand_host *host = mtd->priv;
> +	struct pxa3xx_nand_info *info = host->info_data;
> +	int ret, exec_cmd, ext_cmd_type;
> +
> +	/*
> +	 * if this is a x16 device ,then convert the input

Misplaced comma/whitespace.

> +	 * "byte" address into a "word" address appropriate
> +	 * for indexing a word-oriented device
> +	 */
> +	if (info->reg_ndcr & NDCR_DWIDTH_M)
> +		column /= 2;
> +
> +	/*
> +	 * There may be different NAND chip hooked to
> +	 * different chip select, so check whether
> +	 * chip select has been changed, if yes, reset the timing
> +	 */
> +	if (info->cs != host->cs) {
> +		info->cs = host->cs;
> +		nand_writel(info, NDTR0CS0, info->ndtr0cs0);
> +		nand_writel(info, NDTR1CS0, info->ndtr1cs0);
> +	}
> +
> +	/* Select the extended command for the first command */
> +	switch (command) {
> +	case NAND_CMD_READ0:
> +	case NAND_CMD_READOOB:
> +		ext_cmd_type = EXT_CMD_TYPE_MONO;
> +		break;
> +	}

You have no default case for this switch statement, leaving ext_cmd_type
uninitialized in some cases. You add the other cases in a later patch,
but this patch is temporarily broken.

> +
> +	prepare_start_command(info, command);
> +
> +	/*
> +	 * Prepare the "is ready" completion before starting a command
> +	 * transaction sequence. If the command is not executed the
> +	 * completion will be completed, see below.
> +	 *
> +	 * We can do that inside the loop because the command variable
> +	 * is invariant and thus so is the exec_cmd.
> +	 */
> +	atomic_set(&info->is_ready, 0);
> +	init_completion(&info->dev_ready);
> +	do {
> +		info->state = STATE_PREPARED;
> +		exec_cmd = prepare_set_command(info, command, ext_cmd_type,
> +					       column, page_addr);

[...]

> @@ -1155,7 +1306,30 @@ static int armada370_ecc_init(struct pxa3xx_nand_info *info,
>  			      struct nand_ecc_ctrl *ecc,
>  			      int strength, int page_size)
>  {
> -	/* Unimplemented yet */
> +	if (strength == 4 && page_size == 4096) {

You compare only to ecc_strength_ds, and not ecc_step_ds. While it is
likely that a 4-bit ECC NAND will have a 512-byte ECC step size, you
should probably check this.

What about strength < 4? Shouldn't you be able to support a 1-bit ECC
NAND with your 4-bit ECC?

Also, do you plan to support non-ONFI NAND? Remember that nand_base
doesn't guarantee giving you a non-zero ECC strength. You might need a
DT binding to specify this, if it's not automatically detectable.

> +		ecc->mode = NAND_ECC_HW;
> +		ecc->size = 512;
> +		ecc->layout = &ecc_layout_4KB_bch4bit;
> +		ecc->strength = 4;
> +
> +		info->ecc_bch = 1;
> +		info->chunk_size = 2048;
> +		info->spare_size = 32;
> +		info->ecc_size = 32;
> +		return 1;
> +
> +	} else if (strength == 8 && page_size == 4096) {
> +		ecc->mode = NAND_ECC_HW;
> +		ecc->size = 512;
> +		ecc->layout = &ecc_layout_4KB_bch8bit;
> +		ecc->strength = 8;

These ECC parameters (8-bit per 512 and 4-bit per 512) sound reasonable
and consistent with other ECC schemes I've seen. But I'm still not clear
if we are 100% certain that matches the actual hardware implementation.
Did you do any further research since the last time we talked about
this?

> +
> +		info->ecc_bch = 1;
> +		info->chunk_size = 1024;
> +		info->spare_size = 0;
> +		info->ecc_size = 32;
> +		return 1;
> +	}
>  	return 0;
>  }
>  

Brian
