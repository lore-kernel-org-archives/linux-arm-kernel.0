From: shijie8@gmail.com (Huang Shijie)
Date: Mon, 22 Aug 2011 10:12:27 -0400
Subject: [PATCH v9 1/3] MTD : add the common code for GPMI-NAND controller
	driver
In-Reply-To: <201108221602.27201.marek.vasut@gmail.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<201108221509.49721.marek.vasut@gmail.com>
	<CAMiH66H-xPNARxBJ+xAWubZz2-hoJgAQtOX2=Pi8NE3vrFD_ag@mail.gmail.com>
	<201108221602.27201.marek.vasut@gmail.com>
Message-ID: <CAMiH66FZZUqAdRqJGvrkEcsmQMSpEYboj=SxXW2CDHiBBsWmeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 22, 2011 at 10:02 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Monday, August 22, 2011 04:00:46 PM Huang Shijie wrote:
>> hi,
>>
>> On Mon, Aug 22, 2011 at 9:09 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> > On Monday, August 22, 2011 06:59:11 AM Huang Shijie wrote:
>> >> Hi,
>> >>
>> >> thanks for your comments.
>> >>
>> >> >> +
>> >> >> +static inline int get_ecc_chunk_size(struct gpmi_nand_data *this)
>> >> >> +{
>> >> >> + ?/* for historical reason */
>> >> >> + ?return 512;
>> >> >
>> >> > Can't we just #define this? Or will there ever be something else
>> >> > possible here ? I thought this is the only possible behaviour on MXS.
>> >>
>> >> Please keep it here, it maybe changed in the future.
>> >> It ever had some code for ONFI nand, but i removed it.
>> >
>> > well if you #define it now, you can always replace the defined value with
>> > a function later.
>>
>> ok.
>>
>> >> >> +}
>> >> >> +
>> >> >> +int common_nfc_set_geometry(struct gpmi_nand_data *this)
>> >> >> +{
>> >> >> + ?struct bch_geometry *geo =&this->bch_geometry;
>> >> >> + ?struct mtd_info *mtd =&this->mil.mtd;
>> >> >> + ?unsigned int metadata_size;
>> >> >> + ?unsigned int status_size;
>> >> >> + ?unsigned int chunk_data_size_in_bits;
>> >> >> + ?unsigned int chunk_ecc_size_in_bits;
>> >> >> + ?unsigned int chunk_total_size_in_bits;
>> >> >> + ?unsigned int block_mark_chunk_number;
>> >> >> + ?unsigned int block_mark_chunk_bit_offset;
>> >> >> + ?unsigned int block_mark_bit_offset;
>> >> >> + ?int gf_len = 13;/* use GP13 by default */
>> >> >> +
>> >> >> + ?/* We only support BCH now. */
>> >> >> + ?geo->ecc_algorithm = "BCH";
>> >> >> +
>> >> >> + ?/*
>> >> >> + ? * We always choose a metadata size of 10. Don't try to make sense
>> >> >> of + ? * it -- this is really only for historical compatibility. +
>> >> >> */
>> >> >
>> >> > Historical compat or you mean "the chip was designed this way, see
>> >> > datasheet section x.y.z"? ;-)
>> >>
>> >> Just for historical compatibility.
>> >> it's better to keep it as now, there is no need to change it.
>> >
>> > I'm just trying to make sense of it ... from the docs, it seems like a
>> > chip design thing. So this is compat with STMP37xx and 36xx ? Or even
>> > something older and more obscure ?
>>
>> it ?seems the rom of the chip use the value. ?I will check it tomorrow.
>>
>> >> >> + ?geo->metadata_size_in_bytes = 10;
>> >> >> +
>> >> >> + ?/* ECC chunks */
>> >> >> + ?geo->ecc_chunk_size_in_bytes = get_ecc_chunk_size(this);
>> >
>> > ?[ ... ]
>> >
>> >> >> +
>> >> >> +/* Can we use the upper's buffer directly for DMA? */
>> >> >> +void prepare_data_dma(struct gpmi_nand_data *this, enum
>> >> >> dma_data_direction dr) +{
>> >> >> + ?struct mil *mil =&this->mil;
>> >> >> + ?struct scatterlist *sgl =&mil->data_sgl;
>> >> >
>> >> > I still see the "MIL" present -- can't we just merge the library and
>> >> > this ?
>> >>
>> >> the ? `mil` is just a data structure to contain the fields now.
>> >> Maybe I should change the name of it.
>> >
>> > Probably, I still have a feeling of this like it's the old freescale
>> > driver heritage and doesn't make sense now.
>>
>> ok, I will change the name.
>>
>> >> >> + ?int ret;
>> >> >> +
>> >> >> + ?mil->direct_dma_map_ok = true;
>> >> >>
>> >> >> +static void show_bch_geometry(struct bch_geometry *geo)
>> >> >> +{
>> >> >> + ?pr_info("---------------------------------------\n");
>> >> >> + ?pr_info(" ? ? ? BCH Geometry\n");
>> >> >> + ?pr_info("---------------------------------------\n");
>> >> >> + ?pr_info("ECC Algorithm ? ? ? ? ?: %s\n", geo->ecc_algorithm);
>> >> >> + ?pr_info("ECC Strength ? ? ? ? ? : %u\n", geo->ecc_strength);
>> >> >> + ?pr_info("Page Size in Bytes ? ? : %u\n", geo->page_size_in_bytes);
>> >> >> + ?pr_info("Metadata Size in Bytes : %u\n",
>> >> >> geo->metadata_size_in_bytes); + ?pr_info("ECC Chunk Size in Bytes:
>> >> >> %u\n",
>> >> >> geo->ecc_chunk_size_in_bytes); + ? pr_info("ECC Chunk Count ? ? ? ?:
>> >> >> %u\n", geo->ecc_chunk_count); + ? ?pr_info("Payload Size in Bytes ?:
>> >> >> %u\n", geo->payload_size_in_bytes); + ? ? ?pr_info("Auxiliary Size in
>> >> >> Bytes: %u\n", geo->auxiliary_size_in_bytes); + ? ?pr_info("Auxiliary
>> >> >> Status Offset: %u\n", geo->auxiliary_status_offset); +
>> >> >> ?pr_info("Block Mark Byte Offset : %u\n",
>> >> >> geo->block_mark_byte_offset); + ? ? ? pr_info("Block Mark Bit Offset
>> >> >> ?: %u\n", geo->block_mark_bit_offset); +}
>> >> >
>> >> > We don't need this.
>> >>
>> >> I just use it for debug.
>> >> Why do not need it? :)
>> >> I think it's useful to debug.
>> >
>> > I want to use it, not debug it. I don't want to have it in dmesg.
>> > pr_info() is really unsuitable. Remove it, use pr_debug(), #define it in
>> > MXS_NAND_VERBOSE_DEBUG, which will be undefined at the begining of the
>> > file by default (probably the best approach). Someone who wants to debug
>> > this thing will just enable it.
>> >
>> >> >> +
>> >> >> +int start_dma_without_bch_irq(struct gpmi_nand_data *this,
>> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ?struct dma_async_tx_descriptor *desc)
>> >> >> +{
>> >> >> + ?struct completion *dma_c =&this->dma_done;
>> >> >> + ?int err;
>> >
>> > [...]
>> >
>> >> >> +
>> >> >> + ?if ((mil->current_chip< ?0)&& ?(chip>= 0))
>> >
>> > btw. is the indent here OK?
>>
>> I checked with the script ./script/checkpatch.
>> there is no error.
>>
>> It's ok.
>>
>> >> >> + ? ? ? ? ?gpmi_begin(this);
>> >> >> + ?else if ((mil->current_chip>= 0)&& ?(chip< ?0))
>> >> >> + ? ? ? ? ?gpmi_end(this);
>> >> >> + ?else
>> >> >> + ? ? ? ? ?;
>> >> >
>> >> > Do you need this else branch at all?
>> >>
>> >> It needs a warning here.
>> >>
>> >> >> +
>> >> >> + ?mil->current_chip = chip;
>> >> >> +}
>> >> >> +
>> >> >> +static void gpmi_read_buf(struct mtd_info *mtd, uint8_t *buf, int
>> >> >> len) +{
>> >> >> + ?struct nand_chip *nand = mtd->priv;
>> >> >> + ?struct gpmi_nand_data *this = nand->priv;
>> >> >> + ?struct mil *mil =&this->mil;
>> >> >> +
>> >> >> + ?logio(GPMI_DEBUG_READ);
>> >> >> + ?/* save the info in mil{} for future */
>> >> >> + ?mil->upper_buf ?= buf;
>> >> >> + ?mil->upper_len ?= len;
>> >> >> +
>> >> >> + ?gpmi_read_data(this);
>> >> >> +}
>> >> >> +
>> >> >> +static void gpmi_write_buf(struct mtd_info *mtd, const uint8_t *buf,
>> >> >> int len) +{
>> >> >> + ?struct nand_chip *nand = mtd->priv;
>> >> >> + ?struct gpmi_nand_data *this = nand->priv;
>> >> >> + ?struct mil *mil =&this->mil;
>> >> >> +
>> >> >> + ?logio(GPMI_DEBUG_WRITE);
>> >> >> + ?/* save the info in mil{} for future */
>> >> >> + ?mil->upper_buf ?= (uint8_t *)buf;
>> >> >> + ?mil->upper_len ?= len;
>> >> >> +
>> >> >> + ?gpmi_send_data(this);
>> >> >> +}
>> >> >> +
>> >> >> +static uint8_t gpmi_read_byte(struct mtd_info *mtd)
>> >> >> +{
>> >> >> + ?struct nand_chip *nand = mtd->priv;
>> >> >> + ?struct gpmi_nand_data *this = nand->priv;
>> >> >> + ?struct mil *mil =&this->mil;
>> >> >> + ?uint8_t *buf = mil->data_buffer_dma;
>> >> >> +
>> >> >> + ?gpmi_read_buf(mtd, buf, 1);
>> >> >> + ?return buf[0];
>> >> >> +}
>> >> >> +
>> >> >>
>> >> >> +static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
>> >> >> +{
>> >> >> + ?struct nand_chip *nand = mtd->priv;
>> >> >> + ?struct gpmi_nand_data *this = nand->priv;
>> >> >> + ?int block, ret = 0;
>> >> >> +
>> >> >> + ?/* Get block number */
>> >> >> + ?block = (int)(ofs>> ?nand->bbt_erase_shift);
>> >> >> + ?if (nand->bbt)
>> >> >> + ? ? ? ? ?nand->bbt[block>> ?2] |= 0x01<< ?((block& ?0x03)<< ?1);
>> >> >> +
>> >> >> + ?/* Do we have a flash based bad block table ? */
>> >> >> + ?if (nand->options& ?NAND_USE_FLASH_BBT)
>> >> >> + ? ? ? ? ?ret = nand_update_bbt(mtd, ofs);
>> >> >
>> >> > if (stuff)
>> >> >
>> >> > ? ? return nand_update_bbt();
>> >>
>> >> I can not return it here, I need to update the ecc_stats too.
>> >
>> > You're right.
>> >
>> >> > stuff from else branch
>> >> > .
>> >> > .
>> >> > .
>> >> >
>> >> > Besides, please don't declare variables in the middle of code.
>> >>
>> >> why?
>> >> it's no harm to declare the variables in the {}.
>> >
>> > And to find out what kind of variable it is, you can't just jump at the
>> > begining of the function, you need to navigate through the code ...
>> > that's bad and additional work for other people.
>>
>> thanks, got it.
>>
>> >> >> + ?else {
>> >> >> + ? ? ? ? ?struct mil *mil =&this->mil;
>> >> >> + ? ? ? ? ?uint8_t *block_mark;
>> >> >> + ? ? ? ? ?int column, page, status, chipnr;
>> >> >> +
>> >> >> + ? ? ? ? ?chipnr = (int)(ofs>> ?nand->chip_shift);
>> >> >> + ? ? ? ? ?nand->select_chip(mtd, chipnr);
>> >> >> +
>> >> >> + ? ? ? ? ?column = this->swap_block_mark ? mtd->writesize : 0;
>> >> >> +
>> >> >> + ? ? ? ? ?/* Write the block mark. */
>> >> >> + ? ? ? ? ?block_mark = mil->data_buffer_dma;
>> >> >> + ? ? ? ? ?block_mark[0] = 0; /* bad block marker */
>> >> >> +
>> >> >> + ? ? ? ? ?/* Shift to get page */
>> >> >> + ? ? ? ? ?page = (int)(ofs>> ?nand->page_shift);
>> >> >> +
>> >> >> + ? ? ? ? ?nand->cmdfunc(mtd, NAND_CMD_SEQIN, column, page);
>> >> >> + ? ? ? ? ?nand->write_buf(mtd, block_mark, 1);
>> >> >> + ? ? ? ? ?nand->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
>> >> >> +
>> >> >> + ? ? ? ? ?status = nand->waitfunc(mtd, nand);
>> >> >> + ? ? ? ? ?if (status& ?NAND_STATUS_FAIL)
>> >> >> + ? ? ? ? ? ? ? ? ?ret = -EIO;
>> >> >> +
>> >> >> + ? ? ? ? ?nand->select_chip(mtd, -1);
>> >> >> + ?}
>> >> >> + ?if (!ret)
>> >> >> + ? ? ? ? ?mtd->ecc_stats.badblocks++;
>> >> >> +
>> >> >> + ?return ret;
>> >> >> +}
>> >
>> > [...]
>> >
>> >> >> addr_t auxiliary);
>> >> >> +
>> >> >> +/* ONFI or TOGGLE nand */
>> >> >> +bool is_ddr_nand(struct gpmi_nand_data *);
>> >> >> +
>> >> >> +/* for log */
>> >> >> +extern int gpmi_debug;
>> >> >
>> >> > Why this extern ?
>> >>
>> >> this header can be included by gpmi-nand.c and gpmi-lib.c.
>> >
>> > This is a peculiar one ... can't you -- for example -- hide this into
>> > driver data?
>>
>> It's a parameter of the driver.
>> I use it to show different log.
>> I think it can not be hide into driver data :(
>
> You can set up a variable in the driver data (the internal state of the driver)
> according to this parameter, no problem.
>
it will be a little complicated. I prefer to remove it from the header file.


thanks
Huang Shijie
>>
>> thanks
>>
>> Huang Shijie
>
