From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Nov 2017 21:50:25 +0100
Subject: [PATCH 5/5] mtd: nand: add ->exec_op() implementation
In-Reply-To: <20171130170132.27522-6-miquel.raynal@free-electrons.com>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
 <20171130170132.27522-6-miquel.raynal@free-electrons.com>
Message-ID: <20171130215025.67f74437@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Nov 2017 18:01:32 +0100
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Introduce a new interface to instruct NAND controllers to send specific
> NAND operations. The new interface takes the form of a single method
> called ->exec_op(). This method is designed to replace ->cmd_ctrl(),
> ->cmdfunc() and ->read/write_byte/word/buf() hooks.  
> 
> ->exec_op() is passed a set of instructions describing the operation  
> to execute. Each instruction has a type (ADDR, CMD, DATA, WAITRDY)
> and delay. The type is directly matching the description of NAND
> operations in various NAND datasheet and standards (ONFI, JEDEC), the
> delay is here to help simple controllers wait enough time between each
> instruction. Advanced controllers with integrated timings control can
> ignore these delays.
> 
> Advanced controllers (that are not limited to independent ADDR, CMD and
> DATA cycles) may use the parser added by this commit to get the best
> matching hook, if any. The instructions may be split by the parser in
> order to comply with the controller constraints filled in an array of
> supported patterns.
> 
> For instance, if a controller driver declares supporting up to 4 address
> cycles and then writes up to 512 bytes within one pattern (both are
> optional in this pattern):
>         NAND_OP_PARSER_PAT_ADDR_ELEM(true, 4)
>         NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, 512)
> It means that if the matching operation is made of 5 address cycles
> followed by 1024 bytes to write, then the controller will be asked to:
>         - send 4 address cycles (the first four cycles),
>         - send 1 address cycle (the last one) +
>           write 512 bytes (the first half),
>         - write 512 bytes again (the second half).
> 
> Various other helpers are also added to ease NAND controller drivers
> writing.
> 
> This new interface should really ease the support of new vendor specific
> operations, and at least report whether the command is supported or not
> by a given controller, which was not possible before.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/mtd/nand/nand_base.c  | 1037 +++++++++++++++++++++++++++++++++++++++--
>  drivers/mtd/nand/nand_hynix.c |    9 +
>  include/linux/mtd/rawnand.h   |  391 +++++++++++++++-
>  3 files changed, 1397 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 52965a8aeb2c..46bf31aff909 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -689,6 +689,59 @@ static void nand_wait_status_ready(struct mtd_info *mtd, unsigned long timeo)
>  };
>  
>  /**
> + * nand_soft_waitrdy - Read the status waiting for it to be ready
> + * @chip: NAND chip structure
> + * @timeout_ms: Timeout in ms
> + *
> + * Poll the status using ->exec_op() until it is ready unless it takes too
> + * much time.
> + *
> + * This helper is intended to be used by drivers without R/B pin available to
> + * poll for the chip status until ready and may be called at any time in the
> + * middle of any set of instruction. The READ_STATUS just need to ask a single
> + * time for it and then any read will return the status. Once the READ_STATUS
> + * cycles are done, the function will send a READ0 command to cancel the
> + * "READ_STATUS state" and let the normal flow of operation to continue.
> + *
> + * This helper *cannot* send a WAITRDY command or ->exec_op() implementations

					  ^ instruction

> + * using it will enter an infinite loop.

Hm, not sure why this would be the case, but okay. Maybe you should
move this comment outside the kernel doc header, since this is an
implementation detail, not something the caller/user should be aware of.

There's another important aspect to mention here: this function can only
be called from an ->exec_op() implementation if this implementation is
re-entrant.

> + *
> + * Return 0 if the NAND chip is ready, a negative error otherwise.
> + */
> +int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
> +{
> +	u8 status = 0;
> +	int ret;
> +
> +	if (!chip->exec_op)
> +		return -ENOTSUPP;
> +
> +	ret = nand_status_op(chip, NULL);
> +	if (ret)
> +		return ret;
> +
> +	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms);
> +	do {
> +		ret = nand_read_data_op(chip, &status, sizeof(status), true);
> +		if (ret)
> +			break;
> +
> +		if (status & NAND_STATUS_READY)
> +			break;
> +
> +		udelay(100);

Sounds a bit high, especially for a read page which takes around 20us.

> +	} while	(time_before(jiffies, timeout_ms));
> +
> +	nand_exit_status_op(chip);
> +
> +	if (ret)
> +		return ret;
> +
> +	return status & NAND_STATUS_READY ? 0 : -ETIMEDOUT;
> +};
> +EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
> +
> +/**
>   * nand_command - [DEFAULT] Send command to NAND device
>   * @mtd: MTD device structure
>   * @command: the command to be sent
> @@ -1238,6 +1291,134 @@ static int nand_init_data_interface(struct nand_chip *chip)
>  }
>  
>  /**
> + * nand_fill_column_cycles - fill the column fields on an address array
> + * @chip: The NAND chip
> + * @addrs: Array of address cycles to fill
> + * @offset_in_page: The offset in the page
> + *
> + * Fills the first or the two first bytes of the @addrs field depending
> + * on the NAND bus width and the page size.
> + */
> +static int nand_fill_column_cycles(struct nand_chip *chip, u8 *addrs,
> +				   unsigned int offset_in_page)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
> +	/* Make sure the offset is less than the actual page size. */
> +	if (offset_in_page > mtd->writesize + mtd->oobsize)
> +		return -EINVAL;
> +
> +	/*
> +	 * On small page NANDs, there's a dedicated command to access the OOB
> +	 * area, and the column address is relative to the start of the OOB
> +	 * area, not the start of the page. Asjust the address accordingly.
> +	 */
> +	if (mtd->writesize <= 512 && offset_in_page >= mtd->writesize)
> +		offset_in_page -= mtd->writesize;
> +
> +	/*
> +	 * The offset in page is expressed in bytes, if the NAND bus is 16-bit
> +	 * wide, then it must be divided by 2.
> +	 */
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		if (WARN_ON(offset_in_page % 2))
> +			return -EINVAL;
> +
> +		offset_in_page /= 2;
> +	}
> +
> +	addrs[0] = offset_in_page;
> +
> +	/* Small pages use 1 cycle for the columns, while large page need 2 */

								^ pages

> +	if (mtd->writesize <= 512)
> +		return 1;
> +
> +	addrs[1] = offset_in_page >> 8;
> +
> +	return 2;
> +}
> +
> +static int nand_sp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
> +				     unsigned int offset_in_page, void *buf,
> +				     unsigned int len)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	const struct nand_sdr_timings *sdr =
> +		nand_get_sdr_timings(&chip->data_interface);
> +	u8 addrs[4];
> +	struct nand_op_instr instrs[] = {
> +		NAND_OP_CMD(NAND_CMD_READ0, 0),
> +		NAND_OP_ADDR(3, addrs, PSEC_TO_NSEC(sdr->tWB_max)),
> +		NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tR_max),
> +				 PSEC_TO_NSEC(sdr->tRR_min)),
> +		NAND_OP_DATA_IN(len, buf, 0),
> +	};
> +	struct nand_operation op = NAND_OPERATION(instrs);
> +	int ret;
> +
> +	/* Drop the DATA_OUT instruction if len is set to 0. */

		    ^ DATA_IN

> +	if (!len)
> +		op.ninstrs--;
> +
> +	if (offset_in_page >= mtd->writesize)
> +		instrs[0].ctx.cmd.opcode = NAND_CMD_READOOB;
> +	else if (offset_in_page >= 256 &&
> +		 !(chip->options & NAND_BUSWIDTH_16))
> +		instrs[0].ctx.cmd.opcode = NAND_CMD_READ1;
> +
> +	ret = nand_fill_column_cycles(chip, addrs, offset_in_page);
> +	if (ret < 0)
> +		return ret;
> +
> +	addrs[1] = page;
> +	addrs[2] = page >> 8;
> +
> +	if (chip->options & NAND_ROW_ADDR_3) {
> +		addrs[3] = page >> 16;
> +		instrs[1].ctx.addr.naddrs++;
> +	}
> +
> +	return nand_exec_op(chip, &op);
> +}

[...]

> @@ -1363,6 +1609,81 @@ int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
>  }
>  EXPORT_SYMBOL_GPL(nand_read_oob_op);
>  
> +static int nand_exec_prog_page_op(struct nand_chip *chip, unsigned int page,
> +				  unsigned int offset_in_page, const void *buf,
> +				  unsigned int len, bool prog)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	const struct nand_sdr_timings *sdr =
> +		nand_get_sdr_timings(&chip->data_interface);
> +	u8 addrs[5] = {};
> +	struct nand_op_instr instrs[] = {
> +		/*
> +		 * The first instruction will be dropped if we're dealing
> +		 * with a large page NAND and adjusted if we're dealing
> +		 * with a small page NAND and the page offset is > 255.
> +		 */
> +		NAND_OP_CMD(NAND_CMD_READ0, 0),
> +		NAND_OP_CMD(NAND_CMD_SEQIN, 0),
> +		NAND_OP_ADDR(0, addrs, PSEC_TO_NSEC(sdr->tADL_min)),
> +		NAND_OP_DATA_OUT(len, buf, 0),
> +		NAND_OP_CMD(NAND_CMD_PAGEPROG, PSEC_TO_NSEC(sdr->tWB_max)),
> +		NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tPROG_max), 0),
> +	};
> +	struct nand_operation op = NAND_OPERATION(instrs);
> +	int naddrs = nand_fill_column_cycles(chip, addrs, offset_in_page);
> +	int ret;
> +	u8 status;
> +
> +	if (naddrs < 0)
> +		return naddrs;
> +
> +	addrs[naddrs++] = page;
> +	addrs[naddrs++] = page >> 8;
> +	if (chip->options & NAND_ROW_ADDR_3)
> +		addrs[naddrs++] = page >> 16;
> +
> +	instrs[2].ctx.addr.naddrs = naddrs;
> +
> +	/* Drop the lasts instructions if we're not programming the page. */

		    ^ last two

> +	if (!prog) {
> +		op.ninstrs -= 2;
> +		/* Also drop the DATA_OUT instruction if empty. */
> +		if (!len)
> +			op.ninstrs--;
> +	}
> +
> +	if (mtd->writesize <= 512) {
> +		/*
> +		 * Small pages need some more tweaking: we have to adjust the
> +		 * first instruction depending on the page offset we're trying
> +		 * to access.
> +		 */
> +		if (offset_in_page >= mtd->writesize)
> +			instrs[0].ctx.cmd.opcode = NAND_CMD_READOOB;
> +		else if (offset_in_page >= 256 &&
> +			 !(chip->options & NAND_BUSWIDTH_16))
> +			instrs[0].ctx.cmd.opcode = NAND_CMD_READ1;
> +	} else {
> +		/*
> +		 * Drop the first command if we're dealing with a large page
> +		 * NAND.
> +		 */
> +		op.instrs++;
> +		op.ninstrs--;
> +	}
> +
> +	ret = nand_exec_op(chip, &op);
> +	if (!prog || ret)
> +		return ret;
> +
> +	ret = nand_status_op(chip, &status);
> +	if (ret)
> +		return ret;
> +
> +	return status;
> +}
> +
