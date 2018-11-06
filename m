From: liang.yang@amlogic.com (Liang Yang)
Date: Tue, 6 Nov 2018 18:00:37 +0800
Subject: [PATCH v6 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <20181106102851.61deb97a@bbrezillon>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
 <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
 <20181105165321.7ea2b45f@bbrezillon>
 <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
 <20181106102851.61deb97a@bbrezillon>
Message-ID: <ff02373e-c97b-182d-5b43-83d1e8f6d51a@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/11/6 17:28, Boris Brezillon wrote:
> On Tue, 6 Nov 2018 17:08:00 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>> On 2018/11/5 23:53, Boris Brezillon wrote:
>>> On Fri, 2 Nov 2018 00:42:21 +0800
>>> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>>    
>>>> +
>>>> +static inline u8 meson_nfc_read_byte(struct mtd_info *mtd)
>>>> +{
>>>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +	u32 cmd;
>>>> +
>>>> +	cmd = nfc->param.chip_select | NFC_CMD_DRD | 0;
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +	meson_nfc_drain_cmd(nfc);
>>>
>>> You probably don't want to drain the FIFO every time you read a byte on
>>> the bus, and I guess the INPUT FIFO is at least as big as the CMD
>>> FIFO, right? If that's the case, you should queue as much DRD cmd as
>>> possible and only sync when the user explicitly requests it or when
>>> the INPUT/READ FIFO is full.
>>>    
>> Register 'NFC_REG_BUF' can holds only 4 bytes, also DRD sends only one
>> nand cycle to read one byte and covers the 1st byte every time reading.
>> i think nfc controller is faster than nand cycle, but really it is not
>> high efficiency when reading so many bytes once.
>> Or use dma command here like read_page and read_page_raw.
> 
> Yep, that's also an alternative, though you'll have to make sure the
> buffer passed through the nand_op_inst is DMA-safe, and use a bounce
> buffer when that's not the case.
> 
ok, i will try dma here.

>>>> +
>>>> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>>
>>> As for the read_byte() implementation, I don't think you should force a
>>> sync here.
>>>    
>> ok, it can send 30 bytes (command fifo size subtract 2 idle command )
>> once with a sync.
> 
> Okay, still better than syncing after each transmitted byte.
> 
>> Or use dma command.
> 
> I guess that's the best option.
> 
ok, i will try dma here.
>>
>>>> +}
>>>> +
>>>> +static void meson_nfc_write_buf(struct mtd_info *mtd,
>>>> +				const u8 *buf, int len)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < len; i++)
>>>> +		meson_nfc_write_byte(mtd, buf[i]);
>>>> +}
>>>> +
>>>> +static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>> +						int page, bool in)
>>>> +{
>>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +	const struct nand_sdr_timings *sdr =
>>>> +		nand_get_sdr_timings(&nand->data_interface);
>>>> +	int cs = nfc->param.chip_select;
>>>> +	int i, cmd0, cmd_num;
>>>> +	int ret = 0;
>>>> +
>>>> +	cmd0 = in ? NAND_CMD_READ0 : NAND_CMD_SEQIN;
>>>> +	cmd_num = sizeof(struct nand_rw_cmd) / sizeof(int);
>>>> +	if (!in)
>>>> +		cmd_num--;
>>>> +
>>>> +	nfc->cmdfifo.rw.cmd0 = cs | NFC_CMD_CLE | cmd0;
>>>> +	for (i = 0; i < MAX_CYCLE_COLUMN_ADDRS; i++)
>>>> +		nfc->cmdfifo.rw.col[i] = cs | NFC_CMD_ALE | 0;
>>>> +
>>>> +	for (i = 0; i < MAX_CYCLE_ROW_ADDRS; i++)
>>>> +		nfc->cmdfifo.rw.row[i] = cs | NFC_CMD_ALE | ROW_ADDER(page, i);
>>>> +
>>>> +	nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>>>
>>> Having a fixed size array for the column and row address cycles does
>>> not sound like a good idea to me (depending on the NAND chip you
>>> connect, the number of cycles for the row and column differ), which
>>> makes me realize the nand_rw_cmd struct is not such a good thing...
>>>    
>> em , i will fix it by adding the size of the column and row address.
>> is that ok?
>>
>>>> +
>>>> +	for (i = 0; i < cmd_num; i++)
>>>> +		writel(nfc->cmdfifo.cmd[i], nfc->reg_base + NFC_REG_CMD);
>>>
>>> ... why not write directly to the CMD reg?
>>>    
>>
>> it seems that too many writel(xxx, nfc->reg_base + NFC_REG_CMD) in one
>> function; so I want to cache all the commands and write it in a loop.
> 
> Not sure why it makes a difference since you'll end up writing to
> NFC_REG_CMD anyway.
> 
> BTW, you can probably use the writel_relaxed() instead of writel() when
> writing to the CMD FIFO.
> 
ok.
>>
>>>> +
>>>> +	if (in)
>>>> +		meson_nfc_queue_rb(nfc, sdr->tR_max);
>>>> +	else
>>>> +		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int meson_nfc_write_page_sub(struct nand_chip *nand, const u8 *buf,
>>>> +				    int page, int raw)
>>>> +{
>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>> +	const struct nand_sdr_timings *sdr =
>>>> +		nand_get_sdr_timings(&nand->data_interface);
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +	dma_addr_t daddr, iaddr;
>>>> +	u32 cmd;
>>>> +	int ret;
>>>> +
>>>> +	daddr = dma_map_single(nfc->dev, (void *)meson_chip->data_buf,
>>>> +			       mtd->writesize + mtd->oobsize,
>>>> +			       DMA_TO_DEVICE);
>>>> +	ret = dma_mapping_error(nfc->dev, daddr);
>>>> +	if (ret) {
>>>> +		dev_err(nfc->dev, "dma mapping error\n");
>>>> +		goto err;
>>>> +	}
>>>> +
>>>> +	iaddr = dma_map_single(nfc->dev, (void *)meson_chip->info_buf,
>>>> +			       nand->ecc.steps * PER_INFO_BYTE,
>>>> +			       DMA_TO_DEVICE);
>>>> +	ret = dma_mapping_error(nfc->dev, iaddr);
>>>> +	if (ret) {
>>>> +		dev_err(nfc->dev, "dma mapping error\n");
>>>> +		goto err_map_daddr;
>>>> +	}
>>>> +
>>>> +	ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRWRITE);
>>>> +	if (ret)
>>>> +		goto err_map_iaddr;
>>>> +
>>>> +	cmd = GENCMDDADDRL(NFC_CMD_ADL, daddr);
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +	cmd = GENCMDDADDRH(NFC_CMD_ADH, daddr);
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +	cmd = GENCMDIADDRL(NFC_CMD_AIL, iaddr);
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +	cmd = GENCMDIADDRH(NFC_CMD_AIH, iaddr);
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +	meson_nfc_cmd_seed(nfc, page);
>>>> +
>>>> +	meson_nfc_cmd_access(nand, raw, DIRWRITE);
>>>> +
>>>> +	ret = meson_nfc_wait_dma_finish(nfc);
>>>> +	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +	meson_nfc_queue_rb(nfc, sdr->tPROG_max);
>>>
>>> Don't you have a way to queue the PAGEPROG and WAIT_RB instructions
>>> before the DMA finishes?
>>>    
>>
>> it runs:
>> 1) dma transfer ddr data to nand page cache.
>> 2) wait dma finish
>> 3) send the PAGEPROG command
>> 4) wait rb finish
>>
>> meson_nfc_wait_dma_finish(nfc) waits command fifo empty. Maybe it is
>> difficult or uncessary to queue the PAGEPROG command and WAIT_RB between
>> 1) and 2).
>>
>> is that right?
>>
> 
> Isn't the controller engine able to wait on the data transfer to be
> complete before sending the next instruction in the CMD FIFO pipe?
> I'm pretty sure it's able to do that, which would make
> meson_nfc_wait_dma_finish() useless, and all you'd have to do is wait
> for the CMD FIFO to be empty (assuming it guarantees the last command
> has been executed).
> Maybe the nfc design is difference. dedicated nfc dma engine is 
concatenated with the command fifo, there is no other status to check 
whether dma is done.

>>
>>>> +	}
>>>
>>> Don't you need a call to meson_nfc_wait_cmd_finish() here?
>>>    
>> it will be called in queue_rb, read_buf and write_buf. but i have no
>> idea whether it still needs to be called corresponding to
>> CMD_INSTR/ADDR_INSTR.To be strict, it should be called.
> 
> No, the synchronization is only needed before returning from
> ->exec_op(). Everything before can be queued without being
> executed. Of course, if you run out of entries in the CMD/INPUT
> FIFOs you'll have to do some sort of synchronization, but that should
> be taken care of in your helpers.
> 
ok, i will add it.
> .
> 
