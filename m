From: liang.yang@amlogic.com (Liang Yang)
Date: Fri, 17 Aug 2018 21:03:59 +0800
Subject: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <20180801235045.5b4d8211@bbrezillon>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-3-yixun.lan@amlogic.com>
 <20180801235045.5b4d8211@bbrezillon>
Message-ID: <42877a0d-9830-0626-3f64-e49a326eaa3c@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
On 2018/8/2 5:50, Boris Brezillon wrote:

> Hi Yixun,
>
> On Thu, 19 Jul 2018 17:46:12 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> I haven't finished reviewing the driver yet (I'll try to do that later
> this week), but I already pointed a few things to fix/improve.
>
>> +
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
>> +			cmd = nfc->param.chip_select | NFC_CMD_CLE;
>> +			cmd |= instr->ctx.cmd.opcode & 0xff;
>> +			writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +			meson_nfc_cmd_idle(nfc, NAND_TWB_TIME_CYCLE);
> This is not necessarily TWB you have to wait after a CMD cycle. It can
> be tWHR. And you should definitely not hardcode the value, since,
> AFAIR, it depends on the selected SDR timings. Probably something you
> should calculate in ->setup_data_interface().

Indeed. TWB is not necessarily. And tWHR will be promised by NFC.
so I will delete it.

>> +			meson_nfc_drain_cmd(nfc);
> I don't know exactly how the NAND controller works, but it's usually
> not a good idea to execute the operation right away, especially if you
> have address/cmd/data cycles following this cmd and those can be
> packed in the same controller operation.

it doesn't need meson_nfc_drain_cmd(nfc) here. i will delete it next version

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
> Well, I'm not entirely sure what happens when you call
> read/write_buf(), but it seems you're doing that one byte at a time,
> and that sounds not so efficient given the operation you do for each
> byte read/written. Don't you have a way to tell the engine that you
> want to read/write X bytes?

As i known, there is no way to read/write X bytes once.

>> +			break;
>> +
>> +		case NAND_OP_WAITRDY_INSTR:
>> +			mdelay(instr->ctx.waitrdy.timeout_ms);
>> +			ret = nand_soft_waitrdy(chip,
>> +						instr->ctx.waitrdy.timeout_ms);
> Hm, i'd be surprised if the controller does not have a way to optimize
> waits on R/B transitions.

When i delete the delay here, erasing operation will be failed.
Does it mean NFC send 0x70 to nand device when rb is busy(low)?
If so, i will ask our NFC designer for comfirmation or grasping the waveform.

>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int meson_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +			       struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	int free_oob;
>> +
>> +	if (section >= chip->ecc.steps)
>> +		return -ERANGE;
>> +
>> +	free_oob = (section + 1) * 2;
>> +	oobregion->offset = section * chip->ecc.bytes + free_oob;
> Hm, this offset calculation looks weird. Are you sure it's correct?
> I'd bet on something like:
>
> 	oobregion->offset = 2 + (section * (chip->ecc.bytes + 4));

Each ecc page have 2 user bytes. Assume one 2KB+64B page size nand
flash using ECC8/1KB which ecc parity bytes is 14B.
     _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
    |             |  |      |             |  |     |  not  |
    |	1KB      |2B| 14B  |     1KB     |2B| 14B | used  |  (layout on nand)
    |_ _ _ _ _ _ _|_ |_ _ _ | _ _ _ _ _ _ |_ |_ _ _|_ _ _ _|
		    (2KB + 64B)
when reading from nand, I will format the page as follow:
     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _
    |             |             |  |     |  |      |  not  |
    |	1KB      |    1KB      |2B| 14B |2B|  14B | used  |(layout on ddr)
    |_ _ _ _ _ _ _|_ _ _ _ _ _ _|_ |_ _ _|_ |_ _ _ |_ _ _ _|
		    (2KB + 64B)
So i get "oobregion->offset = section * chip->ecc.bytes + free_oob".
Maybe i don't get what does 'section' mean. i think it means the ecc page number.

>> +	oobregion->length = chip->ecc.bytes;
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_ooblayout_free(struct mtd_info *mtd, int section,
>> +				struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +
>> +	if (section >= chip->ecc.steps)
>> +		return -ERANGE;
>> +
>> +	oobregion->offset = section * (2 + chip->ecc.bytes);
>> +	oobregion->length = 2;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
>> +	.ecc = meson_ooblayout_ecc,
>> +	.free = meson_ooblayout_free,
>> +};
>> +
>> +static int meson_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>> +	const struct meson_nand_ecc *meson_ecc = nfc->data->ecc;
>> +	int num = nfc->data->ecc_num;
>> +	int nsectors, i, bytes;
>> +
>> +	/* support only ecc hw mode */
>> +	if (nand->ecc.mode != NAND_ECC_HW) {
>> +		dev_err(dev, "ecc.mode not supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!nand->ecc.size || !nand->ecc.strength) {
>> +		/* use datasheet requirements */
>> +		nand->ecc.strength = nand->ecc_strength_ds;
>> +		nand->ecc.size = nand->ecc_step_ds;
>> +	}
>> +
>> +	if (nand->ecc.options & NAND_ECC_MAXIMIZE) {
>> +		nand->ecc.size = 1024;
>> +		nsectors = mtd->writesize / nand->ecc.size;
>> +		bytes = mtd->oobsize - 2 * nsectors;
>> +		bytes /= nsectors;
>> +
>> +		/* and bytes has to be even. */
>> +		if (bytes % 2)
>> +			bytes--;
>> +
>> +		nand->ecc.strength = bytes * 8 / fls(8 * nand->ecc.size);
>> +	} else {
>> +		if (nand->ecc.strength > meson_ecc[num - 1].strength) {
>> +			dev_err(dev, "not support ecc strength\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < num; i++) {
>> +		if (meson_ecc[i].strength == 0xff ||
>> +		    nand->ecc.strength < meson_ecc[i].strength)
>> +			break;
>> +	}
> I'd suggest that you look at nand_match_ecc_req(). It's likely that the
> selection logic you have here can be replaced by the generic function.

em, I will try it next version.
