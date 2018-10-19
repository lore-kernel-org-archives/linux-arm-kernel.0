From: liang.yang@amlogic.com (Liang Yang)
Date: Fri, 19 Oct 2018 15:29:13 +0800
Subject: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <20181018162449.3fe433e7@bbrezillon>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018162449.3fe433e7@bbrezillon>
Message-ID: <30ceed2f-03a2-8e4c-b267-df14d052f13d@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/10/18 22:24, Boris Brezillon wrote:
> On Thu, 18 Oct 2018 13:09:05 +0800
> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> 
>> +static int meson_nfc_exec_op(struct nand_chip *chip,
>> +			     const struct nand_operation *op, bool check_only)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct meson_nfc *nfc = nand_get_controller_data(chip);
>> +	const struct nand_op_instr *instr = NULL;
>> +	int ret = 0, cmd;
>> +	unsigned int op_id;
>> +	int i;
>> +
>> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
>> +		instr = &op->instrs[op_id];
>> +		switch (instr->type) {
>> +		case NAND_OP_CMD_INSTR:
>> +			if (instr->ctx.cmd.opcode == NAND_CMD_STATUS)
>> +				meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> 
> Hm, I don't want drivers to base their decisions on the opcode value.
> There's a ->delay_ns field in the instruction object, can't you use
> that one instead? Also, I don't understand why this is only needed for
> the STATUS command. It should normally be applied to all instructions.
> 
em, it should be applied to all instructions.
i will fix it and use instr->delay_ns instead.

>> +			cmd = nfc->param.chip_select | NFC_CMD_CLE;
>> +			cmd |= instr->ctx.cmd.opcode & 0xff;
>> +			writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +			if (instr->ctx.cmd.opcode == NAND_CMD_STATUS)
>> +				meson_nfc_cmd_idle(nfc, nfc->timing.twhr);
>> +			break;
>> +
>> +		case NAND_OP_ADDR_INSTR:
>> +			for (i = 0; i < instr->ctx.addr.naddrs; i++) {
>> +				cmd = nfc->param.chip_select | NFC_CMD_ALE;
>> +				cmd |= instr->ctx.addr.addrs[i] & 0xff;
>> +				writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +			}
>> +			break;
>> +
>> +		case NAND_OP_DATA_IN_INSTR:
>> +			meson_nfc_read_buf(mtd, instr->ctx.data.buf.in,
>> +					   instr->ctx.data.len);
>> +			break;
>> +
>> +		case NAND_OP_DATA_OUT_INSTR:
>> +			meson_nfc_write_buf(mtd, instr->ctx.data.buf.out,
>> +					    instr->ctx.data.len);
>> +			break;
>> +
>> +		case NAND_OP_WAITRDY_INSTR:
>> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
> 
> .
> 
