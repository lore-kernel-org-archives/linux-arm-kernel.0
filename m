From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 1 Dec 2017 12:07:59 +0100
Subject: [PATCH 5/5] mtd: nand: add ->exec_op() implementation
In-Reply-To: <20171130170132.27522-6-miquel.raynal@free-electrons.com>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
 <20171130170132.27522-6-miquel.raynal@free-electrons.com>
Message-ID: <20171201120759.5b64ec86@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Nov 2017 18:01:32 +0100
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

>  EXPORT_SYMBOL_GPL(nand_write_data_op);
>  
>  /**
> + * struct nand_op_parser_ctx - Context used by the parser
> + * @instrs: array of all the instructions that must be addressed
> + * @ninstrs: length of the @instrs array
> + * @instr_idx: index of the instruction in the @instrs array that matches the
> + *	       first instruction of the subop structure
> + * @instr_start_off: offset at which the first instruction of the subop
> + *		     structure must start if it is and address or a data

						   ^ an

> + *		     instruction

@subop is missing.

> + *
> + * This structure is used by the core to handle splitting lengthy instructions
> + * into sub-operations.

Not only lengthy instructions (data or addr instructions that are too
long to be handled in one go), it also helps splitting an operation into
sub-operations that the NAND controller can handle.

I think you should just say:

"
This structure is used by the core to split NAND operations into
sub-operations that can be handled by the NAND controller
"

> + */
> +struct nand_op_parser_ctx {
> +	const struct nand_op_instr *instrs;
> +	unsigned int ninstrs;
> +	unsigned int instr_idx;
> +	unsigned int instr_start_off;
> +	struct nand_subop subop;
> +};
> +
> +/**
> + * nand_op_parser_must_split_instr - Checks if an instruction must be split
> + * @pat: the parser pattern that match
				    *matches

and this is a pattern element, not the whole pattern

> + * @instr: the instruction array to check

That's not true, in this function you only check a single intruction,
not the whole array.

> + * @start_offset: the offset from which to start in the first instruction of the
> + *		  @instr array

Again @instr is not treated as an array in this function. An maybe you
should say that @start_offset is updated with the new context offset
when the function returns true.

> + *
> + * Some NAND controllers are limited and cannot send X address cycles with a
> + * unique operation, or cannot read/write more than Y bytes at the same time.
> + * In this case, split the instruction that does not fit in a single
> + * controller-operation into two or more chunks.
> + *
> + * Returns true if the instruction must be split, false otherwise.
> + * The @start_offset parameter is also updated to the offset at which the next
> + * bundle of instruction must start (if an address or a data instruction).

Okay, you say it here. Better move this explanation next to the param
definition.

> + */
> +static bool
> +nand_op_parser_must_split_instr(const struct nand_op_parser_pattern_elem *pat,
> +				const struct nand_op_instr *instr,
> +				unsigned int *start_offset)
> +{
> +	switch (pat->type) {
> +	case NAND_OP_ADDR_INSTR:
> +		if (!pat->addr.maxcycles)
> +			break;
> +
> +		if (instr->ctx.addr.naddrs - *start_offset >
> +		    pat->addr.maxcycles) {
> +			*start_offset += pat->addr.maxcycles;
> +			return true;
> +		}
> +		break;
> +
> +	case NAND_OP_DATA_IN_INSTR:
> +	case NAND_OP_DATA_OUT_INSTR:
> +		if (!pat->data.maxlen)
> +			break;
> +
> +		if (instr->ctx.data.len - *start_offset > pat->data.maxlen) {
> +			*start_offset += pat->data.maxlen;
> +			return true;
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * nand_op_parser_match_pat - Checks a pattern

				 Checks if a pattern matches the
				 instructions remaining in the parser
				 context

> + * @pat: the parser pattern to check if it matches

	    ^ pattern to test

> + * @ctx: the context structure to match with the pattern @pat

	    ^ parser context

> + *
> + * Check if *one* given pattern matches the given sequence of instructions

      Check if @pat matches the set or a sub-set of instructions
      remaining in @ctx. Returns true if this is the case, false
      otherwise. When true is returned @ctx->subop is updated with
      the set of instructions to be passed to the controller driver.

> + */
> +static bool
> +nand_op_parser_match_pat(const struct nand_op_parser_pattern *pat,
> +			 struct nand_op_parser_ctx *ctx)
> +{
> +	unsigned int i, j, boundary_off = ctx->instr_start_off;
> +
> +	ctx->subop.ninstrs = 0;
> +
> +	for (i = ctx->instr_idx, j = 0; i < ctx->ninstrs && j < pat->nelems;) {
> +		const struct nand_op_instr *instr = &ctx->instrs[i];
> +
> +		/*
> +		 * The pattern instruction does not match the operation
> +		 * instruction. If the instruction is marked optional in the
> +		 * pattern definition, we skip the pattern element and continue
> +		 * to the next one. If the element is mandatory, there's no
> +		 * match and we can return false directly.
> +		 */
> +		if (instr->type != pat->elems[j].type) {
> +			if (!pat->elems[j].optional)
> +				return false;
> +
> +			j++;
> +			continue;
> +		}
> +
> +		/*
> +		 * Now check the pattern element constraints. If the pattern is
> +		 * not able to handle the whole instruction in a single step,
> +		 * we'll have to break it down into several instructions.
> +		 * The *boudary_off value comes back updated to point to the
> +		 * limit between the split instruction (the end of the original
> +		 * chunk, the start of new next one).
> +		 */
> +		if (nand_op_parser_must_split_instr(&pat->elems[j], instr,
> +						    &boundary_off)) {
> +			ctx->subop.ninstrs++;
> +			j++;
> +			break;
> +		}
> +
> +		ctx->subop.ninstrs++;
> +		i++;
> +		j++;
> +		boundary_off = 0;
> +	}
> +
> +	/*
> +	 * This can happen if all instructions of a pattern are optional.
> +	 * Still, if there's not at least one instruction handled by this
> +	 * pattern, this is not a match, and we should try the next one (if
> +	 * any).
> +	 */
> +	if (!ctx->subop.ninstrs)
> +		return false;
> +
> +	/*
> +	 * We had a match on the pattern head, but the pattern may be longer
> +	 * than the instructions we're asked to execute. We need to make sure
> +	 * there's no mandatory elements in the pattern tail.
> +	 *
> +	 * The case where all the operations of a pattern have been checked but
> +	 * the number of instructions is bigger is handled right after this by
> +	 * returning true on the pattern match, which will order the execution
> +	 * of the subset of instructions later defined, while updating the
> +	 * context ids to the next chunk of instructions.
> +	 */
> +	for (; j < pat->nelems; j++) {
> +		if (!pat->elems[j].optional)
> +			return false;
> +	}
> +
> +	/*
> +	 * We have a match: update the ctx and return true. The subop structure
> +	 * will be used by the pattern's ->exec() function.
> +	 */
> +	ctx->subop.instrs = &ctx->instrs[ctx->instr_idx];
> +	ctx->subop.first_instr_start_off = ctx->instr_start_off;
> +	ctx->subop.last_instr_end_off = boundary_off;
> +
> +	/*
> +	 * Update the pointers so the calling function will be able to recall
> +	 * this one with a new subset of instructions.
> +	 *
> +	 * In the case where the last operation of this set is split, point to
> +	 * the last unfinished job, knowing the starting offset.
> +	 */
> +	ctx->instr_idx = i;
> +	ctx->instr_start_off = boundary_off;
> +
> +	return true;
> +}
> +
> +#if IS_ENABLED(CONFIG_DYNAMIC_DEBUG) || defined(DEBUG)
> +static void nand_op_parser_trace(const struct nand_op_parser_ctx *ctx)
> +{
> +	const struct nand_op_instr *instr;
> +	char *prefix = "      ";
> +	char *buf;
> +	unsigned int len, off = 0;
> +	int i, j;
> +
> +	pr_debug("executing subop:\n");
> +
> +	for (i = 0; i < ctx->ninstrs; i++) {
> +		instr = &ctx->instrs[i];
> +
> +		/*
> +		 * ctx->instr_idx is not reliable because it may already have
> +		 * been updated by the parser. Use pointers comparison instead.
> +		 */
> +		if (instr == &ctx->subop.instrs[0])
> +			prefix = "    ->";
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			pr_debug("%sCMD      [0x%02x]\n", prefix,
> +				 instr->ctx.cmd.opcode);
> +			break;
> +		case NAND_OP_ADDR_INSTR:
> +			/*
> +			 * A log line is much less than 50 bytes, plus 5 bytes
> +			 * per address cycle to display.
> +			 */
> +			len = 50 + 5 * instr->ctx.addr.naddrs;
> +			buf = kzalloc(len, GFP_KERNEL);
> +			if (!buf)
> +				return;
> +
> +			off += snprintf(buf, len, "ADDR     [%d cyc:",
> +					instr->ctx.addr.naddrs);
> +			for (j = 0; j < instr->ctx.addr.naddrs; j++)
> +				off += snprintf(&buf[off], len - off,
> +						" 0x%02x",
> +						instr->ctx.addr.addrs[j]);
> +			pr_debug("%s%s]\n", prefix, buf);
> +			break;
> +		case NAND_OP_DATA_IN_INSTR:
> +			pr_debug("%sDATA_IN  [%d B%s]\n", prefix,
> +				 instr->ctx.data.len,
> +				 instr->ctx.data.force_8bit ?
> +				 ", force 8-bit" : "");
> +			break;
> +		case NAND_OP_DATA_OUT_INSTR:
> +			pr_debug("%sDATA_OUT [%d B%s]\n", prefix,
> +				 instr->ctx.data.len,
> +				 instr->ctx.data.force_8bit ?
> +				 ", force 8-bit" : "");
> +			break;
> +		case NAND_OP_WAITRDY_INSTR:
> +			pr_debug("%sWAITRDY  [max %d ms]\n", prefix,
> +				 instr->ctx.waitrdy.timeout_ms);
> +			break;
> +		}
> +
> +		if (instr == &ctx->subop.instrs[ctx->subop.ninstrs - 1])
> +			prefix = "      ";
> +	}
> +}
> +#else
> +static void nand_op_parser_trace(const struct nand_op_parser_ctx *ctx)
> +{
> +	/* NOP */
> +}
> +#endif
> +
> +/**
> + * nand_op_parser_exec_op - exec_op parser
> + * @chip: the NAND chip
> + * @parser: the parser to use given by the controller driver

	       patterns description provided by the controller driver

> + * @op: the NAND operation to address
> + * @check_only: flag asking if the entire operation could be handled

		   when true, the function only checks if @op can be
		   handled but does not execute the operation

> + *
> + * Function that must be called by each driver that implement the "exec_op API"
> + * in their own ->exec_op() implementation.
> + *
> + * The function iterates on all the instructions asked and make use of internal
> + * parsers to find matches between the instruction list and the handled patterns
> + * filled by the controller drivers inside the @parser structure. If needed, the
> + * instructions could be split into sub-operations and be executed sequentially.

      Helper function designed to ease integration of NAND controller
      drivers that only support a limited set of instruction sequences.
      The supported sequences are described in @parser, and the
      framework takes care of splitting @op into multi sub-operations
      (if required) and pass them back to @pattern->exec() if
      @check_only is set to false.

      NAND controller drivers should call this function from their
      ->exec_op() implementation.

> + */
> +int nand_op_parser_exec_op(struct nand_chip *chip,
> +			   const struct nand_op_parser *parser,
> +			   const struct nand_operation *op, bool check_only)
> +{
> +	struct nand_op_parser_ctx ctx = {
> +		.instrs = op->instrs,
> +		.ninstrs = op->ninstrs,
> +	};
> +	unsigned int i;
> +
> +	while (ctx.instr_idx < op->ninstrs) {
> +		int ret;
> +
> +		for (i = 0; i < parser->npatterns; i++) {
> +			const struct nand_op_parser_pattern *pattern;
> +
> +			pattern = &parser->patterns[i];
> +			if (!nand_op_parser_match_pat(pattern, &ctx))
> +				continue;
> +
> +			nand_op_parser_trace(&ctx);
> +
> +			if (check_only)
> +				break;
> +
> +			ret = pattern->exec(chip, &ctx.subop);
> +			if (ret)
> +				return ret;
> +
> +			break;
> +		}
> +
> +		if (i == parser->npatterns) {
> +			pr_debug("->exec_op() parser: pattern not found!\n");
> +			return -ENOTSUPP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nand_op_parser_exec_op);
> +
> +static bool nand_instr_is_data(const struct nand_op_instr *instr)
> +{
> +	return instr && (instr->type == NAND_OP_DATA_IN_INSTR ||
> +			 instr->type == NAND_OP_DATA_OUT_INSTR);
> +}
> +
> +static bool nand_subop_instr_is_valid(const struct nand_subop *subop,
> +				      unsigned int instr_idx)
> +{
> +	return subop && instr_idx < subop->ninstrs;
> +}
> +
> +static int nand_subop_get_start_off(const struct nand_subop *subop,
> +				    unsigned int instr_idx)
> +{
> +	if (instr_idx)
> +		return 0;
> +
> +	return subop->first_instr_start_off;
> +}
> +
> +/**
> + * nand_subop_get_addr_start_off - Get the start offset in an address array
> + * @subop: The entire sub-operation
> + * @instr_idx: Index of the instruction inside the sub-operation
> + *
> + * Instructions arrays may be split by the parser between instructions,
> + * and also in the middle of an address instruction if the number of cycles
> + * to assert in one operation is not supported by the controller.

	 s/assert/send/ or s/assert/issue/

> + *
> + * For this, instead of using the first index of the ->addr.addrs field from the
> + * address instruction, the NAND controller driver must use this helper that
> + * will either return 0 if the index does not point to the first instruction of
> + * the sub-operation, or the offset of the next starting offset inside the
> + * address cycles.

Wow, I'm lost. Can we just drop this paragraph?

> + *
> + * Returns the offset of the first address cycle to assert from the pointed
> + * address instruction.

This is not clear either, but I can't find a clearer explanation right
now.

> + */
> +int nand_subop_get_addr_start_off(const struct nand_subop *subop,
> +				  unsigned int instr_idx)
> +{
> +	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
> +	    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR)
> +		return -EINVAL;
> +
> +	return nand_subop_get_start_off(subop, instr_idx);
> +}
> +EXPORT_SYMBOL_GPL(nand_subop_get_addr_start_off);
> +
> +/**
> + * nand_subop_get_num_addr_cyc - Get the remaining address cycles to assert
> + * @subop: The entire sub-operation
> + * @instr_idx: Index of the instruction inside the sub-operation
> + *
> + * Instructions arrays may be split by the parser between instructions,
> + * and also in the middle of an address instruction if the number of cycles
> + * to assert in one operation is not supported by the controller.

Ditto, we can drop this explanation.

> + *
> + * Returns the number of address cycles to assert from the pointed address
> + * instruction.

	Returns the number of address cycles to issue.

> + */
> +int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
> +				unsigned int instr_idx)
> +{
> +	int start_off, end_off;
> +
> +	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
> +	    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR)
> +		return -EINVAL;
> +
> +	start_off = nand_subop_get_addr_start_off(subop, instr_idx);
> +
> +	if (instr_idx == subop->ninstrs - 1 &&
> +	    subop->last_instr_end_off)
> +		end_off = subop->last_instr_end_off;
> +	else
> +		end_off = subop->instrs[instr_idx].ctx.addr.naddrs;
> +
> +	return end_off - start_off;
> +}
> +EXPORT_SYMBOL_GPL(nand_subop_get_num_addr_cyc);
> +
> +/**
> + * nand_subop_get_data_start_off - Get the start offset in a data array
> + * @subop: The entire sub-operation
> + * @instr_idx: Index of the instruction inside the sub-operation
> + *
> + * Instructions arrays may be split by the parser between instructions,
> + * and also in the middle of a data instruction if the number of bytes to access
> + * in one operation is greater that the controller limit.
> + *
> + * Returns the data offset inside the pointed data instruction buffer from which
> + * to start.

Ditto: let's find a clearer way to explain what this function does.

> + */
> +int nand_subop_get_data_start_off(const struct nand_subop *subop,
> +				  unsigned int instr_idx)
> +{
> +	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
> +	    !nand_instr_is_data(&subop->instrs[instr_idx]))
> +		return -EINVAL;
> +
> +	return nand_subop_get_start_off(subop, instr_idx);
> +}
> +EXPORT_SYMBOL_GPL(nand_subop_get_data_start_off);
> +
> +/**
> + * nand_subop_get_data_len - Get the number of bytes to retrieve
> + * @subop: The entire sub-operation
> + * @instr_idx: Index of the instruction inside the sub-operation
> + *
> + * Instructions arrays may be split by the parser between instructions,
> + * and also in the middle of a data instruction if the number of bytes to access
> + * in one operation is greater that the controller limit.
> + *
> + * For this, instead of using the ->data.len field from the data instruction,
> + * the NAND controller driver must use this helper that will return the actual
> + * length of data to move between the first and last offset asked for this
> + * particular instruction.
> + *
> + * Returns the length of the data to move from the pointed data instruction.

Ditto.

> + */
> +int nand_subop_get_data_len(const struct nand_subop *subop,
> +			    unsigned int instr_idx)
> +{
> +	int start_off = 0, end_off;
> +
> +	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
> +	    !nand_instr_is_data(&subop->instrs[instr_idx]))
> +		return -EINVAL;
> +
> +	start_off = nand_subop_get_data_start_off(subop, instr_idx);
> +
> +	if (instr_idx == subop->ninstrs - 1 &&
> +	    subop->last_instr_end_off)
> +		end_off = subop->last_instr_end_off;
> +	else
> +		end_off = subop->instrs[instr_idx].ctx.data.len;
> +
> +	return end_off - start_off;
> +}
> +EXPORT_SYMBOL_GPL(nand_subop_get_data_len);
> +
> +/**
>   * nand_reset - Reset and initialize a NAND device
>   * @chip: The NAND chip
>   * @chipnr: Internal die id
> @@ -4002,11 +4977,11 @@ static void nand_set_defaults(struct nand_chip *chip)
>  		chip->chip_delay = 20;
>  
>  	/* check, if a user supplied command function given */
> -	if (chip->cmdfunc == NULL)
> +	if (!chip->cmdfunc && !chip->exec_op)
>  		chip->cmdfunc = nand_command;
>  
>  	/* check, if a user supplied wait function given */
> -	if (chip->waitfunc == NULL)
> +	if (!chip->waitfunc)
>  		chip->waitfunc = nand_wait;
>  
>  	if (!chip->select_chip)
> @@ -4894,15 +5869,21 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
>  	if (!mtd->name && mtd->dev.parent)
>  		mtd->name = dev_name(mtd->dev.parent);
>  
> -	if ((!chip->cmdfunc || !chip->select_chip) && !chip->cmd_ctrl) {
> +	/*
> +	 * ->cmdfunc() is legacy and will only be used if ->exec_op() is not
> +	 * populated.
> +	 */
> +	if (!chip->exec_op) {
>  		/*
> -		 * Default functions assigned for chip_select() and
> -		 * cmdfunc() both expect cmd_ctrl() to be populated,
> -		 * so we need to check that that's the case
> +		 * Default functions assigned for ->cmdfunc() and
> +		 * ->select_chip() both expect ->cmd_ctrl() to be populated.
>  		 */
> -		pr_err("chip.cmd_ctrl() callback is not provided");
> -		return -EINVAL;
> +		if ((!chip->cmdfunc || !chip->select_chip) && !chip->cmd_ctrl) {
> +			pr_err("->cmd_ctrl() should be provided\n");
> +			return -EINVAL;
> +		}
>  	}
> +
>  	/* Set the default functions */
>  	nand_set_defaults(chip);
>  
> diff --git a/drivers/mtd/nand/nand_hynix.c b/drivers/mtd/nand/nand_hynix.c
> index bae0da2aa2a8..d542908a0ebb 100644
> --- a/drivers/mtd/nand/nand_hynix.c
> +++ b/drivers/mtd/nand/nand_hynix.c
> @@ -81,6 +81,15 @@ static int hynix_nand_cmd_op(struct nand_chip *chip, u8 cmd)
>  {
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  
> +	if (chip->exec_op) {
> +		struct nand_op_instr instrs[] = {
> +			NAND_OP_CMD(cmd, 0),
> +		};
> +		struct nand_operation op = NAND_OPERATION(instrs);
> +
> +		return nand_exec_op(chip, &op);
> +	}
> +
>  	chip->cmdfunc(mtd, cmd, -1, -1);
>  
>  	return 0;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 0be959a478db..053b506f4800 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -751,6 +751,349 @@ struct nand_manufacturer_ops {
>  };
>  
>  /**
> + * struct nand_op_cmd_instr - Definition of a command instruction
> + * @opcode: the command to assert in one cycle
> + */
> +struct nand_op_cmd_instr {
> +	u8 opcode;
> +};
> +
> +/**
> + * struct nand_op_addr_instr - Definition of an address instruction
> + * @naddrs: length of the @addrs array
> + * @addrs: array containing the address cycles to assert
> + */
> +struct nand_op_addr_instr {
> +	unsigned int naddrs;
> +	const u8 *addrs;
> +};
> +
> +/**
> + * struct nand_op_data_instr - Definition of a data instruction
> + * @len: number of data bytes to move
> + * @in: buffer to fill when reading from the NAND chip
> + * @out: buffer to read from when writing to the NAND chip
> + * @force_8bit: force 8-bit access
> + *
> + * Please note that "in" and "out" are inverted from the ONFI specification
> + * and are from the controller perspective, so a "in" is a read from the NAND
> + * chip while a "out" is a write to the NAND chip.
> + */
> +struct nand_op_data_instr {
> +	unsigned int len;
> +	union {
> +		void *in;
> +		const void *out;
> +	} buf;
> +	bool force_8bit;
> +};
> +
> +/**
> + * struct nand_op_waitrdy_instr - Definition of a wait ready instruction
> + * @timeout_ms: maximum delay while waiting for the ready/busy pin in ms
> + */
> +struct nand_op_waitrdy_instr {
> +	unsigned int timeout_ms;
> +};
> +
> +/**
> + * enum nand_op_instr_type - Enumeration of all instruction types
> + * @NAND_OP_CMD_INSTR: command instruction
> + * @NAND_OP_ADDR_INSTR: address instruction
> + * @NAND_OP_DATA_IN_INSTR: data in instruction
> + * @NAND_OP_DATA_OUT_INSTR: data out instruction
> + * @NAND_OP_WAITRDY_INSTR: wait ready instruction
> + */
> +enum nand_op_instr_type {
> +	NAND_OP_CMD_INSTR,
> +	NAND_OP_ADDR_INSTR,
> +	NAND_OP_DATA_IN_INSTR,
> +	NAND_OP_DATA_OUT_INSTR,
> +	NAND_OP_WAITRDY_INSTR,
> +};
> +
> +/**
> + * struct nand_op_instr - Generic definition of an instruction
> + * @type: an enumeration of the instruction type
> + * @cmd/@addr/@data/@waitrdy: extra data associated to the instruction.
> + *                            You'll have to use the appropriate element
> + *                            depending on @type
> + * @delay_ns: delay to apply by the controller after the instruction has been
> + *	      actually executed (most of them are directly handled by the
		       ^ sent on the bus
> + *	      controllers once the timings negociation has been done)
> + */
> +struct nand_op_instr {
> +	enum nand_op_instr_type type;
> +	union {
> +		struct nand_op_cmd_instr cmd;
> +		struct nand_op_addr_instr addr;
> +		struct nand_op_data_instr data;
> +		struct nand_op_waitrdy_instr waitrdy;
> +	} ctx;
> +	unsigned int delay_ns;
> +};
> +
> +/*
> + * Special handling must be done for the WAITRDY timeout parameter as it usually
> + * is either tPROG (after a prog), tR (before a read), tRST (during a reset) or
> + * tBERS (during an erase) which all of them are u64 values that cannot be
> + * divided by usual kernel macros and must be handled with the special
> + * DIV_ROUND_UP_ULL() macro.
> + */
> +#define __DIVIDE(dividend, divisor) ({					\
> +	sizeof(dividend) == sizeof(u32) ?				\
> +		DIV_ROUND_UP(dividend, divisor) :			\
> +		DIV_ROUND_UP_ULL(dividend, divisor);			\
> +		})
> +#define PSEC_TO_NSEC(x) __DIVIDE(x, 1000)
> +#define PSEC_TO_MSEC(x) __DIVIDE(x, 1000000000)
> +
> +#define NAND_OP_CMD(id, ns)						\
> +	{								\
> +		.type = NAND_OP_CMD_INSTR,				\
> +		.ctx.cmd.opcode = id,					\
> +		.delay_ns = ns,						\
> +	}
> +
> +#define NAND_OP_ADDR(ncycles, cycles, ns)				\
> +	{								\
> +		.type = NAND_OP_ADDR_INSTR,				\
> +		.ctx.addr = {						\
> +			.naddrs = ncycles,				\
> +			.addrs = cycles,				\
> +		},							\
> +		.delay_ns = ns,						\
> +	}
> +
> +#define NAND_OP_DATA_IN(l, buf, ns)					\
> +	{								\
> +		.type = NAND_OP_DATA_IN_INSTR,				\
> +		.ctx.data = {						\
> +			.len = l,					\
> +			.buf.in = buf,					\
> +			.force_8bit = false,				\
> +		},							\
> +		.delay_ns = ns,						\
> +	}
> +
> +#define NAND_OP_DATA_OUT(l, buf, ns)					\
> +	{								\
> +		.type = NAND_OP_DATA_OUT_INSTR,				\
> +		.ctx.data = {						\
> +			.len = l,					\
> +			.buf.out = buf,					\
> +			.force_8bit = false,				\
> +		},							\
> +		.delay_ns = ns,						\
> +	}
> +
> +#define NAND_OP_8BIT_DATA_IN(l, b, ns)					\
> +	{								\
> +		.type = NAND_OP_DATA_IN_INSTR,				\
> +		.ctx.data = {						\
> +			.len = l,					\
> +			.buf.in = b,					\
> +			.force_8bit = true,				\
> +		},							\
> +		.delay_ns = ns,						\
> +	}
> +
> +#define NAND_OP_8BIT_DATA_OUT(l, b, ns)					\
> +	{								\
> +		.type = NAND_OP_DATA_OUT_INSTR,				\
> +		.ctx.data = {						\
> +			.len = l,					\
> +			.buf.out = b,					\
> +			.force_8bit = true,				\
> +		},							\
> +		.delay_ns = ns,						\
> +	}
> +
> +#define NAND_OP_WAIT_RDY(tout_ms, ns)					\
> +	{								\
> +		.type = NAND_OP_WAITRDY_INSTR,				\
> +		.ctx.waitrdy.timeout_ms = tout_ms,			\
> +		.delay_ns = ns,						\
> +	}
> +
> +/**
> + * struct nand_subop - a sub operation
> + * @instrs: array of instructions
> + * @ninstrs: length of the @instrs array
> + * @first_instr_start_off: offset to start from for the first instruction
> + *			   of the sub-operation
> + * @last_instr_end_off: offset to end at (excluded) for the last instruction
> + *			of the sub-operation
> + *
> + * Both parameters @first_instr_start_off and @last_instr_end_off apply for the
> + * address cycles in the case of address, or for data offset in the case of data

					   ^ instructions

> + * transfers. Otherwise, it is irrelevant.
      ^ intructions

> + *
> + * When an operation cannot be handled as is by the NAND controller, it will
> + * be split by the parser and the remaining pieces will be handled as

			     into sub-operations which will be passed
      to the controller driver.

> + * sub-operations.
> + */
> +struct nand_subop {
> +	const struct nand_op_instr *instrs;
> +	unsigned int ninstrs;
> +	unsigned int first_instr_start_off;
> +	unsigned int last_instr_end_off;
> +};
> +
> +int nand_subop_get_addr_start_off(const struct nand_subop *subop,
> +				  unsigned int op_id);
> +int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
> +				unsigned int op_id);
> +int nand_subop_get_data_start_off(const struct nand_subop *subop,
> +				  unsigned int op_id);
> +int nand_subop_get_data_len(const struct nand_subop *subop,
> +			    unsigned int op_id);
> +
> +/**
> + * struct nand_op_parser_addr_constraints - Constraints for address instructions
> + * @maxcycles: maximum number of cycles that the controller can assert by
> + *	       instruction
> + */
> +struct nand_op_parser_addr_constraints {
> +	unsigned int maxcycles;
> +};
> +
> +/**
> + * struct nand_op_parser_data_constraints - Constraints for data instructions
> + * @maxlen: maximum data length that the controller can handle with one
> + *	    instruction
> + */
> +struct nand_op_parser_data_constraints {
> +	unsigned int maxlen;
> +};
> +
> +/**
> + * struct nand_op_parser_pattern_elem - One element of a pattern
> + * @type: the instructuction type
> + * @optional: if this element of the pattern is optional or mandatory

		 ^ whether

> + * @addr/@data: address or data constraint (number of cycles or data length)
> + */
> +struct nand_op_parser_pattern_elem {
> +	enum nand_op_instr_type type;
> +	bool optional;
> +	union {
> +		struct nand_op_parser_addr_constraints addr;
> +		struct nand_op_parser_data_constraints data;
> +	};
> +};
> +
> +#define NAND_OP_PARSER_PAT_CMD_ELEM(_opt)			\
> +	{							\
> +		.type = NAND_OP_CMD_INSTR,			\
> +		.optional = _opt,				\
> +	}
> +
> +#define NAND_OP_PARSER_PAT_ADDR_ELEM(_opt, _maxcycles)		\
> +	{							\
> +		.type = NAND_OP_ADDR_INSTR,			\
> +		.optional = _opt,				\
> +		.addr.maxcycles = _maxcycles,			\
> +	}
> +
> +#define NAND_OP_PARSER_PAT_DATA_IN_ELEM(_opt, _maxlen)		\
> +	{							\
> +		.type = NAND_OP_DATA_IN_INSTR,			\
> +		.optional = _opt,				\
> +		.data.maxlen = _maxlen,				\
> +	}
> +
> +#define NAND_OP_PARSER_PAT_DATA_OUT_ELEM(_opt, _maxlen)		\
> +	{							\
> +		.type = NAND_OP_DATA_OUT_INSTR,			\
> +		.optional = _opt,				\
> +		.data.maxlen = _maxlen,				\
> +	}
> +
> +#define NAND_OP_PARSER_PAT_WAITRDY_ELEM(_opt)			\
> +	{							\
> +		.type = NAND_OP_WAITRDY_INSTR,			\
> +		.optional = _opt,				\
> +	}
> +
> +/**
> + * struct nand_op_parser_pattern - A complete pattern
> + * @elems: array of pattern elements
> + * @nelems: number of pattern elements in @elems array
> + * @exec: the function that will actually execute this pattern, written in the
> + *	  controller driver
> + *
> + * This is a complete pattern that is a list of elements, each one reprensenting
> + * one instruction with its constraints. Controller drivers must declare as much
> + * patterns as they support and give the list of the supported patterns (created
> + * with the help of the following macro) when calling nand_op_parser_exec_op()
> + * which is the preferred approach for advanced controllers as the main thing to
> + * do in the driver implementation of ->exec_op(). Once there is a match between
> + * the pattern and an operation, the either the core just wanted to know if the

			 	  (or a subset of this operation)

> + * operation was supporter (through the use of the check_only boolean) or it
> + * calls the @exec function to actually do the operation.
> + */
> +struct nand_op_parser_pattern {
> +	const struct nand_op_parser_pattern_elem *elems;
> +	unsigned int nelems;
> +	int (*exec)(struct nand_chip *chip, const struct nand_subop *subop);
> +};
> +
