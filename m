From: b32955@freescale.com (Huang Shijie)
Date: Thu, 14 Apr 2011 10:20:00 +0800
Subject: [PATCH v5 2/4] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <19877.65411.687158.113390@ipc1.ka-ro>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>	<1302675881-18862-3-git-send-email-b32955@freescale.com>
	<19877.65411.687158.113390@ipc1.ka-ro>
Message-ID: <4DA659D0.9030504@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> Huang Shijie writes:
>> +int common_nfc_set_geometry(struct gpmi_nfc_data *this)
>> +{
>> +	struct nfc_geometry       *geo =&this->nfc_geometry;
>> +	struct mtd_info		  *mtd =&this->mil.mtd;
>> +	struct nand_chip	*chip =&this->mil.nand;
>>
> inconsistent indentation. You should decide whether to use<TAB>  or
> <SPACE>  for indentation. This is a global issue.
ok. thanks.
>> +	unsigned int              metadata_size;
>> +	unsigned int              status_size;
>> +	unsigned int              chunk_data_size_in_bits;
>> +	unsigned int              chunk_ecc_size_in_bits;
>> +	unsigned int              chunk_total_size_in_bits;
>> +	unsigned int              block_mark_chunk_number;
>> +	unsigned int              block_mark_chunk_bit_offset;
>> +	unsigned int              block_mark_bit_offset;
>> +
>> +	/* We only support BCH now. */
>> +	geo->ecc_algorithm = "BCH";
>> +
>> +	/*
>> +	 * We always choose a metadata size of 10. Don't try to make sense of
>> +	 * it -- this is really only for historical compatibility.
>> +	 */
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
>> +		log("Unsupported page geometry.");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Compute the page size, include page and oob. */
>> +	geo->page_size_in_bytes = mtd->writesize + mtd->oobsize;
>> +
>> +	/*
>> +	 * ONFI/TOGGLE nand needs GF14, so re-culculate DMA page size.
>>
> s/culculate/calculate/
>
>> +	 * The ONFI nand must do the reculation,
>>
> s/reculation/recalculation/
>
>> +	 * else it will fail in DMA in some platform(such as imx50).
>> +	 */
>> +	if (is_ddr_nand(chip))
>> +		geo->page_size_in_bytes = mtd->writesize +
>> +				geo->metadata_size_in_bytes +
>> +			(geo->ecc_strength * 14 * 8 / geo->ecc_chunk_count);
>> +
>> +	geo->payload_size_in_bytes = mtd->writesize;
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
>> +	metadata_size = (geo->metadata_size_in_bytes + 0x3)&  ~0x3;
>> +	status_size   = (geo->ecc_chunk_count        + 0x3)&  ~0x3;
>>
> You might use:
> metadata_size = ALIGN(geo->metadata_size_in_bytes, 4);
> status_size = ALIGN(geo->ecc_chunk_count, 4);
>
thanks.
>> +	geo->auxiliary_size_in_bytes = metadata_size + status_size;
>> +	geo->auxiliary_status_offset = metadata_size;
>> +
>> +	/* Check if we're going to do block mark swapping. */
>> +	if (!this->swap_block_mark)
>> +		return 0;
>> +
>> +	/*
>> +
>>
>>
>> +
>> +static int mil_pre_bbt_scan(struct gpmi_nfc_data  *this)
>> +{
>> +	struct nand_chip *nand =&this->mil.nand;
>> +	struct mtd_info *mtd =&this->mil.mtd;
>> +	struct nand_ecclayout *layout = nand->ecc.layout;
>> +	struct nfc_hal *nfc = this->nfc;
>> +	int error;
>> +
>> +	/* fix the ECC layout before the scanning */
>> +	layout->eccbytes          = 0;
>> +	layout->oobavail          = mtd->oobsize;
>> +	layout->oobfree[0].offset = 0;
>> +	layout->oobfree[0].length = mtd->oobsize;
>> +
>> +	mtd->oobavail = nand->ecc.layout->oobavail;
>> +
>> +	/* Set up swap block-mark, must be set before the mil_set_geometry() */
>> +	this->swap_block_mark = true;
>> +	if (GPMI_IS_MX23(this))
>> +		this->swap_block_mark = false;
>>
> if ... else ...?
else is "true" by default.
>> +	/* Set up the medium geometry */
>> +	error = mil_set_geometry(this);
>> +	if (error)
>> +		return error;
>> +
>> +	/* extra init */
>> +	if (nfc->extra_init) {
>> +		error = nfc->extra_init(this);
>> +		if (error != 0)
>> +			return error;
>> +	}
>> +
>> +	/* NAND boot init, depends on the mil_set_geometry(). */
>> +	return nand_boot_init(this);
>> +}
>> +
>> +static int mil_scan_bbt(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand = mtd->priv;
>> +	struct gpmi_nfc_data *this = nand->priv;
>> +	int                      error;
>> +
>> +	/* Prepare for the BBT scan. */
>> +	error = mil_pre_bbt_scan(this);
>> +	if (error)
>> +		return error;
>> +
>> +	/* use the default BBT implementation */
>> +	return nand_default_bbt(mtd);
>> +}
>> +
>> +static const char *cmd_parse = "cmdlinepart";
>> +static int mil_partitions_init(struct gpmi_nfc_data *this)
>> +{
>> +	struct gpmi_nfc_platform_data *pdata = this->pdata;
>> +	struct mil *mil =&this->mil;
>> +	struct mtd_info *mtd =&mil->mtd;
>> +	int  error = 0;
>> +
>> +	/* The complicated partitions layout use this. */
>> +	if (pdata->partitions&&  pdata->partition_count>  0)
>> +		return add_mtd_partitions(mtd, pdata->partitions,
>> +						pdata->partition_count);
>> +
>> +	/* use the command line for simple partitions layout */
>> +	mil->partition_count = parse_mtd_partitions(mtd,
>> +						&cmd_parse,
>> +						&mil->partitions, 0);
>> +	if (mil->partition_count)
>> +		error = add_mtd_partitions(mtd, mil->partitions,
>> +						mil->partition_count);
>>
> I would do the cmdline parsing first, so that any compiled-in
> partitioning can be overridden with cmdline parameters.
>
ok, thanks.
>> +	return error;
>> +}
>> +
>> +static void mil_partitions_exit(struct gpmi_nfc_data *this)
>> +{
>> +	struct mil *mil =&this->mil;
>> +
>> +	if (mil->partition_count) {
>> +		struct mtd_info *mtd =&mil->mtd;
>> +
>> +		del_mtd_partitions(mtd);
>> +		kfree(mil->partitions);
>> +		mil->partition_count = 0;
>> +	}
>> +}
>> +
>> +/* Initializes the MTD Interface Layer */
>> +int gpmi_nfc_mil_init(struct gpmi_nfc_data *this)
>> +{
>> +	struct gpmi_nfc_platform_data  *pdata =  this->pdata;
>> +	struct mil                     *mil   =&this->mil;
>> +	struct mtd_info                *mtd   =&mil->mtd;
>> +	struct nand_chip               *nand  =&mil->nand;
>> +	int                            error;
>> +
>> +	/* Initialize MIL data */
>> +	mil->current_chip	= -1;
>> +	mil->command_length	=  0;
>> +	mil->page_buffer_virt	=  0;
>>
> 	mil->page_buffer_virt	=  NULL;
>
>> +	mil->page_buffer_phys	= ~0;
>> +	mil->page_buffer_size	=  0;
>> +
>> +	/* Initialize the MTD data structures */
>> +	mtd->priv		= nand;
>> +	mtd->name		= "gpmi-nfc-main";
>>
> Why not 'gpmi-nfc' like the driver name?
>
ok. Yes, the current driver name is a little long.

Best Regards
Huang Shijie
> Lothar Wa?mann
