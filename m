From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 17 Aug 2018 15:56:08 +0200
Subject: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <42877a0d-9830-0626-3f64-e49a326eaa3c@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-3-yixun.lan@amlogic.com>
 <20180801235045.5b4d8211@bbrezillon>
 <42877a0d-9830-0626-3f64-e49a326eaa3c@amlogic.com>
Message-ID: <20180817155608.5929b37a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Aug 2018 21:03:59 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> Hi Boris,
> On 2018/8/2 5:50, Boris Brezillon wrote:
> 
> > Hi Yixun,
> >
> > On Thu, 19 Jul 2018 17:46:12 +0800
> > Yixun Lan <yixun.lan@amlogic.com> wrote:
> >
> > I haven't finished reviewing the driver yet (I'll try to do that later
> > this week), but I already pointed a few things to fix/improve.
> >  
> >> +
> >> +static int meson_nfc_exec_op(struct nand_chip *chip,
> >> +			     const struct nand_operation *op, bool check_only)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(chip);
> >> +	struct meson_nfc *nfc = nand_get_controller_data(chip);
> >> +	const struct nand_op_instr *instr = NULL;
> >> +	int ret = 0, cmd;
> >> +	unsigned int op_id;
> >> +	int i;
> >> +
> >> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
> >> +		instr = &op->instrs[op_id];
> >> +		switch (instr->type) {
> >> +		case NAND_OP_CMD_INSTR:
> >> +			cmd = nfc->param.chip_select | NFC_CMD_CLE;
> >> +			cmd |= instr->ctx.cmd.opcode & 0xff;
> >> +			writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +			meson_nfc_cmd_idle(nfc, NAND_TWB_TIME_CYCLE);  
> > This is not necessarily TWB you have to wait after a CMD cycle. It can
> > be tWHR. And you should definitely not hardcode the value, since,
> > AFAIR, it depends on the selected SDR timings. Probably something you
> > should calculate in ->setup_data_interface().  
> 
> Indeed. TWB is not necessarily. And tWHR will be promised by NFC.
> so I will delete it.

Are you sure the engine always applies a tWHR delay, even when tWB is
expected? tWB should be applied everytime you are about to wait for a
R/B transition. tWHR is about switching IO pins from input to output on
the NAND chip side.

> 
> >> +			meson_nfc_drain_cmd(nfc);  
> > I don't know exactly how the NAND controller works, but it's usually
> > not a good idea to execute the operation right away, especially if you
> > have address/cmd/data cycles following this cmd and those can be
> > packed in the same controller operation.  
> 
> it doesn't need meson_nfc_drain_cmd(nfc) here. i will delete it next version

What's the CMD queue depth? I think you'll have to ensure the requested
op fits in the CMD FIFO and split things in several sub-ops if it does
not.

> 
> >> +			break;
> >> +
> >> +		case NAND_OP_ADDR_INSTR:
> >> +			for (i = 0; i < instr->ctx.addr.naddrs; i++) {
> >> +				cmd = nfc->param.chip_select | NFC_CMD_ALE;
> >> +				cmd |= instr->ctx.addr.addrs[i] & 0xff;
> >> +				writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> +			}
> >> +			break;
> >> +
> >> +		case NAND_OP_DATA_IN_INSTR:
> >> +			meson_nfc_read_buf(mtd, instr->ctx.data.buf.in,
> >> +					   instr->ctx.data.len);
> >> +			break;
> >> +
> >> +		case NAND_OP_DATA_OUT_INSTR:
> >> +			meson_nfc_write_buf(mtd, instr->ctx.data.buf.out,
> >> +					    instr->ctx.data.len);  
> > Well, I'm not entirely sure what happens when you call
> > read/write_buf(), but it seems you're doing that one byte at a time,
> > and that sounds not so efficient given the operation you do for each
> > byte read/written. Don't you have a way to tell the engine that you
> > want to read/write X bytes?  
> 
> As i known, there is no way to read/write X bytes once.

Okay, then maybe you can queue several byte read/write reqs before
flushing the queue (meson_nfc_drain_cmd() +
meson_nfc_wait_cmd_finish()).

> 
> >> +			break;
> >> +
> >> +		case NAND_OP_WAITRDY_INSTR:
> >> +			mdelay(instr->ctx.waitrdy.timeout_ms);
> >> +			ret = nand_soft_waitrdy(chip,
> >> +						instr->ctx.waitrdy.timeout_ms);  
> > Hm, i'd be surprised if the controller does not have a way to optimize
> > waits on R/B transitions.  
> 
> When i delete the delay here, erasing operation will be failed.
> Does it mean NFC send 0x70 to nand device when rb is busy(low)?

I was not even talking about the delay, but yes, mdelay() seems way too
big. Remember that it's a timeout, and you usually don't have to wait
that much. You can do ndelay(instr->ctx.delay_ns) before calling
nand_soft_waitrdy() to make sure tWB is enforced.

Anyway, that's not what I was initially referring to. What I meant is
that nand_soft_waitrdy() should be replaced by native R/B pin or status
polling wait logic so that the CPU is released while waiting for a R/B
transition.

> If so, i will ask our NFC designer for comfirmation or grasping the waveform.

You have to wait tWB, that's for sure.

> 
> >> +			break;
> >> +		}
> >> +	}
> >> +	return ret;
> >> +}
> >> +
> >> +static int meson_ooblayout_ecc(struct mtd_info *mtd, int section,
> >> +			       struct mtd_oob_region *oobregion)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +	int free_oob;
> >> +
> >> +	if (section >= chip->ecc.steps)
> >> +		return -ERANGE;
> >> +
> >> +	free_oob = (section + 1) * 2;
> >> +	oobregion->offset = section * chip->ecc.bytes + free_oob;  
> > Hm, this offset calculation looks weird. Are you sure it's correct?
> > I'd bet on something like:
> >
> > 	oobregion->offset = 2 + (section * (chip->ecc.bytes + 4));  
> 
> Each ecc page have 2 user bytes. Assume one 2KB+64B page size nand
> flash using ECC8/1KB which ecc parity bytes is 14B.
>      _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
>     |             |  |      |             |  |     |  not  |
>     |	1KB      |2B| 14B  |     1KB     |2B| 14B | used  |  (layout on nand)
>     |_ _ _ _ _ _ _|_ |_ _ _ | _ _ _ _ _ _ |_ |_ _ _|_ _ _ _|
> 		    (2KB + 64B)
> when reading from nand, I will format the page as follow:
>      _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _
>     |             |             |  |     |  |      |  not  |
>     |	1KB      |    1KB      |2B| 14B |2B|  14B | used  |(layout on ddr)
>     |_ _ _ _ _ _ _|_ _ _ _ _ _ _|_ |_ _ _|_ |_ _ _ |_ _ _ _|
> 		    (2KB + 64B)
> So i get "oobregion->offset = section * chip->ecc.bytes + free_oob".

Okay, but I prefer when it's written like that:

	oobregion->offset = 2 + (section * (2 + chip->ecc.bytes));

> Maybe i don't get what does 'section' mean. i think it means the ecc page number.

Section is just the free OOB or ECC section number. It starts at 0 and
goes up to N - 1, where N usually is the number of ECC steps you have in
a page.
