From: b32955@freescale.com (Huang Shijie)
Date: Mon, 22 Aug 2011 12:59:11 +0800
Subject: [PATCH v9 1/3] MTD : add the common code for GPMI-NAND controller
	driver
In-Reply-To: <201108201343.20420.marek.vasut@gmail.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<1313581828-16625-2-git-send-email-b32955@freescale.com>
	<201108201343.20420.marek.vasut@gmail.com>
Message-ID: <4E51E21F.3060804@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks for your comments.
>> +
>> +static inline int get_ecc_chunk_size(struct gpmi_nand_data *this)
>> +{
>> +	/* for historical reason */
>> +	return 512;
>
> Can't we just #define this? Or will there ever be something else possible here ?
> I thought this is the only possible behaviour on MXS.
>
Please keep it here, it maybe changed in the future.
It ever had some code for ONFI nand, but i removed it.
>> +}
>> +
>> +int common_nfc_set_geometry(struct gpmi_nand_data *this)
>> +{
>> +	struct bch_geometry *geo =&this->bch_geometry;
>> +	struct mtd_info *mtd =&this->mil.mtd;
>> +	unsigned int metadata_size;
>> +	unsigned int status_size;
>> +	unsigned int chunk_data_size_in_bits;
>> +	unsigned int chunk_ecc_size_in_bits;
>> +	unsigned int chunk_total_size_in_bits;
>> +	unsigned int block_mark_chunk_number;
>> +	unsigned int block_mark_chunk_bit_offset;
>> +	unsigned int block_mark_bit_offset;
>> +	int gf_len = 13;/* use GP13 by default */
>> +
>> +	/* We only support BCH now. */
>> +	geo->ecc_algorithm = "BCH";
>> +
>> +	/*
>> +	 * We always choose a metadata size of 10. Don't try to make sense of
>> +	 * it -- this is really only for historical compatibility.
>> +	 */
> Historical compat or you mean "the chip was designed this way, see datasheet
> section x.y.z"? ;-)
>
Just for historical compatibility.
it's better to keep it as now, there is no need to change it.
>> +	geo->metadata_size_in_bytes = 10;
>> +
>> +	/* ECC chunks */
>> +	geo->ecc_chunk_size_in_bytes = get_ecc_chunk_size(this);
>> +
>> +	/*
>> +	 * Compute the total number of ECC chunks in a page. This includes the
>> +	 * slightly larger chunk at the beginning of the page, which contains
>> +	 * both data and metadata.
>> +	 */
>> +	geo->ecc_chunk_count = mtd->writesize / geo->ecc_chunk_size_in_bytes;
>> +
>> +	/*
>> +	 * We use the same ECC strength for all chunks, including the first one.
>> +	 */
>> +	geo->ecc_strength = get_ecc_strength(this);
>> +	if (!geo->ecc_strength) {
>> +		pr_info("Page size:%d, OOB:%d\n", mtd->writesize, mtd->oobsize);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Compute the page size, include page and oob. */
>> +	geo->page_size_in_bytes = mtd->writesize + mtd->oobsize;
>> +	geo->payload_size_in_bytes = mtd->writesize;
>> +
>> +	/*
>> +	 * In principle, computing the auxiliary buffer geometry is NFC
>> +	 * version-specific. However, at this writing, all versions share the
>> +	 * same model, so this code can also be shared.
>> +	 *
>> +	 * The auxiliary buffer contains the metadata and the ECC status. The
>> +	 * metadata is padded to the nearest 32-bit boundary. The ECC status
>> +	 * contains one byte for every ECC chunk, and is also padded to the
>> +	 * nearest 32-bit boundary.
>> +	 */
>> +	metadata_size = ALIGN(geo->metadata_size_in_bytes, 4);
>> +	status_size   = ALIGN(geo->ecc_chunk_count, 4);
>> +
>> +	geo->auxiliary_size_in_bytes = metadata_size + status_size;
>> +	geo->auxiliary_status_offset = metadata_size;
>> +
>> +	/* Check if we're going to do block mark swapping. */
>> +	if (!this->swap_block_mark)
>> +		return 0;
>> +
>> +	/*
>> +	 * If control arrives here, we're doing block mark swapping, so we need
>> +	 * to compute the byte and bit offsets of the physical block mark within
>> +	 * the ECC-based view of the page data. In principle, this isn't a
>> +	 * difficult computation -- but it's very important and it's easy to get
>> +	 * it wrong, so we do it carefully.
>> +	 *
>> +	 * Note that this calculation is simpler because we use the same ECC
>> +	 * strength for all chunks, including the zero'th one, which contains
>> +	 * the metadata. The calculation would be slightly more complicated
>> +	 * otherwise.
>> +	 *
>> +	 * We start by computing the physical bit offset of the block mark. We
>> +	 * then subtract the number of metadata and ECC bits appearing before
>> +	 * the mark to arrive at its bit offset within the data alone.
>> +	 */
>> +
>> +	/* Compute some important facts about chunk geometry. */
>> +	chunk_data_size_in_bits = geo->ecc_chunk_size_in_bytes * 8;
>> +	chunk_ecc_size_in_bits  = geo->ecc_strength * gf_len;
>> +	chunk_total_size_in_bits = chunk_data_size_in_bits
>> +					+ chunk_ecc_size_in_bits;
>> +
>> +	/* Compute the bit offset of the block mark within the physical page. */
>> +	block_mark_bit_offset = mtd->writesize * 8;
>> +
>> +	/* Subtract the metadata bits. */
>> +	block_mark_bit_offset -= geo->metadata_size_in_bytes * 8;
>> +
>> +	/*
>> +	 * Compute the chunk number (starting at zero) in which the block mark
>> +	 * appears.
>> +	 */
>> +	block_mark_chunk_number =
>> +			block_mark_bit_offset / chunk_total_size_in_bits;
>> +
>> +	/*
>> +	 * Compute the bit offset of the block mark within its chunk, and
>> +	 * validate it.
>> +	 */
>> +	block_mark_chunk_bit_offset =
>> +		block_mark_bit_offset -
>> +			(block_mark_chunk_number * chunk_total_size_in_bits);
>> +
>> +	if (block_mark_chunk_bit_offset>  chunk_data_size_in_bits) {
>> +		/*
>> +		 * If control arrives here, the block mark actually appears in
>> +		 * the ECC bits of this chunk. This wont' work.
>> +		 */
>> +		pr_info("Unsupported page geometry : %u:%u\n",
>> +				mtd->writesize, mtd->oobsize);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Now that we know the chunk number in which the block mark appears,
>> +	 * we can subtract all the ECC bits that appear before it.
>> +	 */
>> +	block_mark_bit_offset -=
>> +			block_mark_chunk_number * chunk_ecc_size_in_bits;
>> +
>> +	/*
>> +	 * We now know the absolute bit offset of the block mark within the
>> +	 * ECC-based data. We can now compute the byte offset and the bit
>> +	 * offset within the byte.
>> +	 */
>> +	geo->block_mark_byte_offset = block_mark_bit_offset / 8;
>> +	geo->block_mark_bit_offset  = block_mark_bit_offset % 8;
>> +
>> +	return 0;
>> +}
>> +
>> +struct dma_chan *get_dma_chan(struct gpmi_nand_data *this)
>> +{
>> +	int chip = this->mil.current_chip;
>> +
>> +	BUG_ON(chip<  0);
>> +	return this->dma_chans[chip];
>> +}
>> +
>> +/* Can we use the upper's buffer directly for DMA? */
>> +void prepare_data_dma(struct gpmi_nand_data *this, enum dma_data_direction
>> dr) +{
>> +	struct mil *mil =&this->mil;
>> +	struct scatterlist *sgl =&mil->data_sgl;
> I still see the "MIL" present -- can't we just merge the library and this ?
>
the   `mil` is just a data structure to contain the fields now.
Maybe I should change the name of it.

>> +	int ret;
>> +
>> +	mil->direct_dma_map_ok = true;
>> +
>> +	/* first try to map the upper buffer directly */
>> +	sg_init_one(sgl, mil->upper_buf, mil->upper_len);
>> +	ret = dma_map_sg(this->dev, sgl, 1, dr);
>> +	if (ret == 0) {
>> +		/* We have to use our own DMA buffer. */
>> +		sg_init_one(sgl, mil->data_buffer_dma, PAGE_SIZE);
>> +
>> +		if (dr == DMA_TO_DEVICE)
>> +			memcpy(mil->data_buffer_dma, mil->upper_buf,
>> +				mil->upper_len);
>> +
>> +		ret = dma_map_sg(this->dev, sgl, 1, dr);
>> +		BUG_ON(ret == 0);
>> +
>> +		mil->direct_dma_map_ok = false;
>> +	}
>> +}
>> +
>> +/* This will be called after the DMA operation is finished. */
>> +static void dma_irq_callback(void *param)
>> +{
>> +	struct gpmi_nand_data *this = param;
>> +	struct mil *mil =&this->mil;
>> +	struct completion *dma_c =&this->dma_done;
>> +
>> +	complete(dma_c);
>> +
>> +	switch (this->dma_type) {
>> +	case DMA_FOR_COMMAND:
>> +		dma_unmap_sg(this->dev,&mil->cmd_sgl, 1, DMA_TO_DEVICE);
>> +		break;
>> +
>> +	case DMA_FOR_READ_DATA:
>> +		dma_unmap_sg(this->dev,&mil->data_sgl, 1, DMA_FROM_DEVICE);
>> +		if (mil->direct_dma_map_ok == false)
>> +			memcpy(mil->upper_buf, mil->data_buffer_dma,
>> +				mil->upper_len);
>> +		break;
>> +
>> +	case DMA_FOR_WRITE_DATA:
>> +		dma_unmap_sg(this->dev,&mil->data_sgl, 1, DMA_TO_DEVICE);
>> +		break;
>> +
>> +	case DMA_FOR_READ_ECC_PAGE:
>> +	case DMA_FOR_WRITE_ECC_PAGE:
>> +		/* We have to wait the BCH interrupt to finish. */
>> +		break;
>> +
>> +	default:
>> +		BUG();
>> +	}
>> +}
>> +
>> +static void show_bch_geometry(struct bch_geometry *geo)
>> +{
>> +	pr_info("---------------------------------------\n");
>> +	pr_info("	BCH Geometry\n");
>> +	pr_info("---------------------------------------\n");
>> +	pr_info("ECC Algorithm          : %s\n", geo->ecc_algorithm);
>> +	pr_info("ECC Strength           : %u\n", geo->ecc_strength);
>> +	pr_info("Page Size in Bytes     : %u\n", geo->page_size_in_bytes);
>> +	pr_info("Metadata Size in Bytes : %u\n", geo->metadata_size_in_bytes);
>> +	pr_info("ECC Chunk Size in Bytes: %u\n", geo->ecc_chunk_size_in_bytes);
>> +	pr_info("ECC Chunk Count        : %u\n", geo->ecc_chunk_count);
>> +	pr_info("Payload Size in Bytes  : %u\n", geo->payload_size_in_bytes);
>> +	pr_info("Auxiliary Size in Bytes: %u\n", geo->auxiliary_size_in_bytes);
>> +	pr_info("Auxiliary Status Offset: %u\n", geo->auxiliary_status_offset);
>> +	pr_info("Block Mark Byte Offset : %u\n", geo->block_mark_byte_offset);
>> +	pr_info("Block Mark Bit Offset  : %u\n", geo->block_mark_bit_offset);
>> +}
> We don't need this.
>
I just use it for debug.
Why do not need it? :)
I think it's useful to debug.
>> +
>> +int start_dma_without_bch_irq(struct gpmi_nand_data *this,
>> +				struct dma_async_tx_descriptor *desc)
>> +{
>> +	struct completion *dma_c =&this->dma_done;
>> +	int err;
>> +
>> +	init_completion(dma_c);
>> +
>> +	desc->callback		= dma_irq_callback;
>> +	desc->callback_param	= this;
>> +	dmaengine_submit(desc);
>> +
>> +	/* Wait for the interrupt from the DMA block. */
>> +	err = wait_for_completion_timeout(dma_c, msecs_to_jiffies(1000));
>> +	err = (!err) ? -ETIMEDOUT : 0;
>> +	if (err) {
>> +		pr_info("DMA timeout, last DMA :%d\n", this->last_dma_type);
>> +		if (gpmi_debug&  GPMI_DEBUG_CRAZY) {
>> +			struct bch_geometry *geo =&this->bch_geometry;
>> +
>> +			gpmi_show_regs(this);
>> +			show_bch_geometry(geo);
>> +			panic("-----------DMA FAILED------------------");
> No, dev_err() or something.
> \
ok, no problem.
> Also, I don't like you using pr_ stuff, I think you can use dev_ stuff, can't you?
>
>> +		}
>> +	}
>> +	return err;
>> +}
>> +
>> +/*
>> + * This function is used in BCH reading or BCH writing pages.
>> + * It will wait for the BCH interrupt as long as ONE second.
>> + * Actually, we must wait for two interrupts :
>> + *	[1] firstly the DMA interrupt and
>> + *	[2] secondly the BCH interrupt.
>> + *
>> + * @this:	Per-device data structure.
>> + * @desc:	DMA channel
> Does this conform to kerneldoc ?
>
it's redundant, i will remove the description for the parameters.
But keep the description for the function.
>> + */
>> +int start_dma_with_bch_irq(struct gpmi_nand_data *this,
>> +			struct dma_async_tx_descriptor *desc)
>> +{
>> +	int err;
>> +
>> +	/* Prepare to receive an interrupt from the BCH block. */
>> +	init_completion(&this->bch_done);
>> +
>> +	/* start the DMA */
>> +	start_dma_without_bch_irq(this, desc);
>> +
>> +	/* Wait for the interrupt from the BCH block. */
>> +	err = wait_for_completion_timeout(&this->bch_done,
>> +					msecs_to_jiffies(1000));
>> +	err = (!err) ? -ETIMEDOUT : 0;
>> +	if (err) {
>> +		pr_info("BCH timeout!!!\n");
> One ! is enough!!!
ok.
>> +		if (gpmi_debug&  GPMI_DEBUG_CRAZY) {
> GPMI_DEBUG_CRAZY should probably be GPMI_DEBUG_VERBOSE ?
>
ok, thanks
>> +			struct bch_geometry *geo =&this->bch_geometry;
>> +
>> +			gpmi_show_regs(this);
>> +			show_bch_geometry(geo);
>> +			panic("-----------BCH FAILED------------------");
> dev_err()
>
>> +		}
>> +	}
>> +	return err;
>> +}
>> +
>> +static int __devinit acquire_register_block(struct gpmi_nand_data *this,
>> +			const char *resource_name, void **reg_block_base)
>> +{
>> +	struct platform_device *pdev = this->pdev;
>> +	struct resource *r;
>> +	void *p;
>> +
>> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, resource_name);
>> +	if (!r) {
>> +		pr_info("Can't get resource for %s\n", resource_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* remap the register block */
>> +	p = ioremap(r->start, resource_size(r));
>> +	if (!p) {
>> +		pr_info("Can't remap %s\n", resource_name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	*reg_block_base = p;
>> +	return 0;
>> +}
>> +
>> +static void release_register_block(struct gpmi_nand_data *this,
>> +				void *reg_block_base)
>> +{
>> +	iounmap(reg_block_base);
>> +}
>> +
>> +static int __devinit acquire_interrupt(struct gpmi_nand_data *this,
>> +			const char *resource_name,
>> +			irq_handler_t interrupt_handler, int *lno, int *hno)
>> +{
>> +	struct platform_device *pdev = this->pdev;
>> +	struct resource *r;
>> +	int err;
>> +
>> +	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, resource_name);
>> +	if (!r) {
>> +		pr_info("Can't get resource for %s\n", resource_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	BUG_ON(r->start != r->end);
>> +	err = request_irq(r->start, interrupt_handler, 0, resource_name, this);
>> +	if (err) {
>> +		pr_info("Can't own %s\n", resource_name);
>> +		return err;
>> +	}
>> +
>> +	*lno = r->start;
>> +	*hno = r->end;
>> +	return 0;
>> +}
>> +
>>
>> +
>> +static int __devinit acquire_resources(struct gpmi_nand_data *this)
>> +{
>> +	struct resources *r =&this->resources;
>> +	int error;
>> +
>> +	/* Attempt to acquire the GPMI register block. */
>> +	error = acquire_register_block(this,
>> +				GPMI_NAND_GPMI_REGS_ADDR_RES_NAME,
>> +				&r->gpmi_regs);
> You're already passing "this", why pass r->gpmi_regs? Please fix globally.
>
ok, thanks
>
>> +static int gpmi_dev_ready(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand = mtd->priv;
>> +	struct gpmi_nand_data *this = nand->priv;
>> +	struct mil *mil =&this->mil;
>> +
>> +	return gpmi_is_ready(this, mil->current_chip);
>> +}
>> +
>> +static void gpmi_select_chip(struct mtd_info *mtd, int chip)
>> +{
>> +	struct nand_chip *nand = mtd->priv;
>> +	struct gpmi_nand_data *this = nand->priv;
>> +	struct mil *mil =&this->mil;
>> +
>> +	if ((mil->current_chip<  0)&&  (chip>= 0))
>> +		gpmi_begin(this);
>> +	else if ((mil->current_chip>= 0)&&  (chip<  0))
>> +		gpmi_end(this);
>> +	else
>> +		;
> Do you need this else branch at all?
>
It needs a warning here.
>> +
>> +	mil->current_chip = chip;
>> +}
>> +
>> +static void gpmi_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
>> +{
>> +	struct nand_chip *nand = mtd->priv;
>> +	struct gpmi_nand_data *this = nand->priv;
>> +	struct mil *mil =&this->mil;
>> +
>> +	logio(GPMI_DEBUG_READ);
>> +	/* save the info in mil{} for future */
>> +	mil->upper_buf	= buf;
>> +	mil->upper_len	= len;
>> +
>> +	gpmi_read_data(this);
>> +}
>> +
>> +static void gpmi_write_buf(struct mtd_info *mtd, const uint8_t *buf, int
>> len) +{
>> +	struct nand_chip *nand = mtd->priv;
>> +	struct gpmi_nand_data *this = nand->priv;
>> +	struct mil *mil =&this->mil;
>> +
>> +	logio(GPMI_DEBUG_WRITE);
>> +	/* save the info in mil{} for future */
>> +	mil->upper_buf	= (uint8_t *)buf;
>> +	mil->upper_len	= len;
>> +
>> +	gpmi_send_data(this);
>> +}
>> +
>> +static uint8_t gpmi_read_byte(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand = mtd->priv;
>> +	struct gpmi_nand_data *this = nand->priv;
>> +	struct mil *mil =&this->mil;
>> +	uint8_t *buf = mil->data_buffer_dma;
>> +
>> +	gpmi_read_buf(mtd, buf, 1);
>> +	return buf[0];
>> +}
>> +
>>
>> +static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
>> +{
>> +	struct nand_chip *nand = mtd->priv;
>> +	struct gpmi_nand_data *this = nand->priv;
>> +	int block, ret = 0;
>> +
>> +	/* Get block number */
>> +	block = (int)(ofs>>  nand->bbt_erase_shift);
>> +	if (nand->bbt)
>> +		nand->bbt[block>>  2] |= 0x01<<  ((block&  0x03)<<  1);
>> +
>> +	/* Do we have a flash based bad block table ? */
>> +	if (nand->options&  NAND_USE_FLASH_BBT)
>> +		ret = nand_update_bbt(mtd, ofs);
> if (stuff)
> 	return nand_update_bbt();
>
I can not return it here, I need to update the ecc_stats too.
> stuff from else branch
> .
> .
> .
>
> Besides, please don't declare variables in the middle of code.
>
why?
it's no harm to declare the variables in the {}.

>> +	else {
>> +		struct mil *mil	=&this->mil;
>> +		uint8_t *block_mark;
>> +		int column, page, status, chipnr;
>> +
>> +		chipnr = (int)(ofs>>  nand->chip_shift);
>> +		nand->select_chip(mtd, chipnr);
>> +
>> +		column = this->swap_block_mark ? mtd->writesize : 0;
>> +
>> +		/* Write the block mark. */
>> +		block_mark = mil->data_buffer_dma;
>> +		block_mark[0] = 0; /* bad block marker */
>> +
>> +		/* Shift to get page */
>> +		page = (int)(ofs>>  nand->page_shift);
>> +
>> +		nand->cmdfunc(mtd, NAND_CMD_SEQIN, column, page);
>> +		nand->write_buf(mtd, block_mark, 1);
>> +		nand->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
>> +
>> +		status = nand->waitfunc(mtd, nand);
>> +		if (status&  NAND_STATUS_FAIL)
>> +			ret = -EIO;
>> +
>> +		nand->select_chip(mtd, -1);
>> +	}
>> +	if (!ret)
>> +		mtd->ecc_stats.badblocks++;
>> +
>> +	return ret;
>> +}
>> +
>> +static int __devinit nand_boot_set_geometry(struct gpmi_nand_data *this)
>> +{
>> +	struct boot_rom_geometry *geometry =&this->rom_geometry;
>> +
>> +	/*
>> +	 * Set the boot block stride size.
>> +	 *
>> +	 * In principle, we should be reading this from the OTP bits, since
>> +	 * that's where the ROM is going to get it. In fact, we don't have any
>> +	 * way to read the OTP bits, so we go with the default and hope for the
>> +	 * best.
>> +	 */
>> +	geometry->stride_size_in_pages = 64;
>> +
>> +	/*
>> +	 * Set the search area stride exponent.
>> +	 *
>> +	 * In principle, we should be reading this from the OTP bits, since
>> +	 * that's where the ROM is going to get it. In fact, we don't have any
>> +	 * way to read the OTP bits, so we go with the default and hope for the
>> +	 * best.
>> +	 */
>> +	geometry->search_area_stride_exponent = 2;
>> +
>> +	if (gpmi_debug&  GPMI_DEBUG_INIT)
>> +		pr_info("stride size in page : %d, search areas : %d\n",
>> +			geometry->stride_size_in_pages,
>> +			geometry->search_area_stride_exponent);
>> +	return 0;
>> +}
>> +
>> +static const char  *fingerprint = "STMP";
>> +static int __devinit mx23_check_transcription_stamp(struct gpmi_nand_data
>> *this) +{
>> +	struct boot_rom_geometry *rom_geo =&this->rom_geometry;
>> +	struct mil *mil =&this->mil;
>> +	struct mtd_info *mtd =&mil->mtd;
>> +	struct nand_chip *nand =&mil->nand;
>> +	unsigned int search_area_size_in_strides;
>> +	unsigned int stride;
>> +	unsigned int page;
>> +	loff_t byte;
>> +	uint8_t *buffer = nand->buffers->databuf;
>> +	int saved_chip_number;
>> +	int found_an_ncb_fingerprint = false;
>> +
>> +	/* Compute the number of strides in a search area. */
>> +	search_area_size_in_strides = 1<<  rom_geo->search_area_stride_exponent;
>> +
>> +	/* Select chip 0. */
>> +	saved_chip_number = mil->current_chip;
>> +	nand->select_chip(mtd, 0);
>> +
>> +	/*
>> +	 * Loop through the first search area, looking for the NCB fingerprint.
>> +	 */
>> +	pr_info("Scanning for an NCB fingerprint...\n");
>> +
>> +	for (stride = 0; stride<  search_area_size_in_strides; stride++) {
>> +		/* Compute the page and byte addresses. */
>> +		page = stride * rom_geo->stride_size_in_pages;
>> +		byte = page   * mtd->writesize;
>> +
>> +		pr_info("  Looking for a fingerprint in page 0x%x\n", page);
> pr_info? Why, who cares, I'd prefer dev_dbg()?
>
thanks
>> +
>> +		/*
>> +		 * Read the NCB fingerprint. The fingerprint is four bytes long
>> +		 * and starts in the 12th byte of the page.
>> +		 */
>> +		nand->cmdfunc(mtd, NAND_CMD_READ0, 12, page);
>> +		nand->read_buf(mtd, buffer, strlen(fingerprint));
>> +
>> +		/* Look for the fingerprint. */
>> +		if (!memcmp(buffer, fingerprint, strlen(fingerprint))) {
>> +			found_an_ncb_fingerprint = true;
>> +			break;
>> +		}
>> +
>> +	}
>> +
>> +	/* Deselect chip 0. */
>> +	nand->select_chip(mtd, saved_chip_number);
>> +
>> +	if (found_an_ncb_fingerprint)
>> +		pr_info("  Found a fingerprint\n");
>> +	else
>> +		pr_info("  No fingerprint found\n");
>> +	return found_an_ncb_fingerprint;
>> +}
>> +
>> +/* Writes a transcription stamp. */
>> +static int __devinit mx23_write_transcription_stamp(struct gpmi_nand_data
>> *this) +{
>> +	struct device *dev = this->dev;
>> +	struct boot_rom_geometry *rom_geo =&this->rom_geometry;
>> +	struct mil *mil =&this->mil;
>> +	struct mtd_info *mtd =&mil->mtd;
>> +	struct nand_chip *nand =&mil->nand;
>> +	unsigned int block_size_in_pages;
>> +	unsigned int search_area_size_in_strides;
>> +	unsigned int search_area_size_in_pages;
>> +	unsigned int search_area_size_in_blocks;
>> +	unsigned int block;
>> +	unsigned int stride;
>> +	unsigned int page;
>> +	loff_t       byte;
>> +	uint8_t      *buffer = nand->buffers->databuf;
>> +	int saved_chip_number;
>> +	int status;
>> +
>> +	/* Compute the search area geometry. */
>> +	block_size_in_pages = mtd->erasesize / mtd->writesize;
>> +	search_area_size_in_strides = 1<<  rom_geo->search_area_stride_exponent;
>> +	search_area_size_in_pages = search_area_size_in_strides *
>> +					rom_geo->stride_size_in_pages;
>> +	search_area_size_in_blocks =
>> +		  (search_area_size_in_pages + (block_size_in_pages - 1)) /
>> +				    block_size_in_pages;
>> +
>> +	pr_info("-------------------------------------------\n");
>> +	pr_info("Search Area Geometry\n");
>> +	pr_info("-------------------------------------------\n");
>> +	pr_info("Search Area in Blocks : %u\n", search_area_size_in_blocks);
>> +	pr_info("Search Area in Strides: %u\n", search_area_size_in_strides);
>> +	pr_info("Search Area in Pages  : %u\n", search_area_size_in_pages);
> Maybe if you debug it, yes ... but I certainly don't want such ascii-art in my
> log during normal operation.
>
ok.
>> addr_t auxiliary);
>> +
>> +/* ONFI or TOGGLE nand */
>> +bool is_ddr_nand(struct gpmi_nand_data *);
>> +
>> +/* for log */
>> +extern int gpmi_debug;
> Why this extern ?
>
this header can be included by gpmi-nand.c and gpmi-lib.c.

>> +#define GPMI_DEBUG_INIT		0x0001
>> +#define GPMI_DEBUG_READ		0x0002
>> +#define GPMI_DEBUG_WRITE	0x0004
>> +#define GPMI_DEBUG_ECC_READ	0x0008
>> +#define GPMI_DEBUG_ECC_WRITE	0x0010
>> +#define GPMI_DEBUG_CRAZY	0x0020
>> +
>> +#ifdef pr_fmt
>> +#undef pr_fmt
>> +#endif
>> +
>> +#define pr_fmt(fmt) "[ %s : %.3d ] " fmt, __func__, __LINE__
>> +
>> +#define logio(level)				\
>> +		do {				\
>> +			if (gpmi_debug&  level)	\
>> +				pr_info("\n");	\
>> +		} while (0)
> Do you really need this ?
>
not really.

thanks

Huang Shijie
