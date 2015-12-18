From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 17 Dec 2015 17:55:44 -0800
Subject: [PATCH linux-next 1/5] mtd: spi-nor: properly detect the memory
 when it boots in Quad or Dual mode
In-Reply-To: <813edd1addf9a09b9f01031d3cb279c8cdfe97bb.1449494420.git.cyrille.pitchen@atmel.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <813edd1addf9a09b9f01031d3cb279c8cdfe97bb.1449494420.git.cyrille.pitchen@atmel.com>
Message-ID: <20151218015544.GG10460@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

On Mon, Dec 07, 2015 at 03:09:10PM +0100, Cyrille Pitchen wrote:
> The quad (or dual) mode of a spi-nor memory may be enabled at boot time by
> non-volatile bits in some setting register. Also such a mode may have
> already been enabled at early stage by some boot loader.
> 
> Hence, we should not guess the spi-nor memory is always configured for the
> regular SPI 1-1-1 protocol.
> 
> Micron and Macronix memories, once their Quad (or dual for Micron) mode
> enabled, no longer process the regular JEDEC Read ID (0x9f) command but
> instead reply to a new command: JEDEC Read ID Multiple I/O (0xaf).
> Besides, in Quad mode both memory manufacturers expect ALL commands to
> use the SPI 4-4-4 protocol. For Micron memories, enabling their Dual mode
> implies to use the SPI 2-2-2 protocol for ALL commands.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 52 +++++++++++++++++++++++++++++++++++++++----
>  include/linux/mtd/spi-nor.h   | 23 +++++++++++++++++--
>  2 files changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 3b2460efc019..bf17736750c1 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -73,6 +73,11 @@ struct flash_info {
>  
>  #define JEDEC_MFR(info)	((info)->id[0])
>  
> +struct read_id_config {
> +	enum read_mode		mode;
> +	enum spi_protocol	proto;
> +};
> +
>  static const struct flash_info *spi_nor_match_id(const char *name);
>  
>  /*
> @@ -867,11 +872,16 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ },
>  };
>  
> -static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> +static const struct flash_info *spi_nor_read_id(struct spi_nor *nor,
> +						enum read_mode mode)

It's unclear what you're trying to do with the 'read_mode' enum now.
(Admittedly it may not be clear in the current code either, given the
confusion we already have over Micron support.)

Would you care to document it better?

>  {
> -	int			tmp;
> +	int			i, tmp;
>  	u8			id[SPI_NOR_MAX_ID_LEN];
>  	const struct flash_info	*info;
> +	static const struct read_id_config configs[] = {
> +		{SPI_NOR_QUAD, SPI_PROTO_4_4_4},
> +		{SPI_NOR_DUAL, SPI_PROTO_2_2_2}
> +	};
>  
>  	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>  	if (tmp < 0) {
> @@ -879,6 +889,34 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>  		return ERR_PTR(tmp);
>  	}
>  
> +	/* Special case for Micron/Macronix qspi nor. */
> +	if ((id[0] == 0xff && id[1] == 0xff && id[2] == 0xff) ||
> +	    (id[0] == 0x00 && id[1] == 0x00 && id[2] == 0x00))
> +		for (i = 0; i < ARRAY_SIZE(configs); ++i) {
> +			if (configs[i].mode != mode)
> +				continue;
> +
> +			/* Set this protocol for all commands. */
> +			nor->reg_proto = configs[i].proto;
> +			nor->read_proto = configs[i].proto;
> +			nor->write_proto = configs[i].proto;
> +			nor->erase_proto = configs[i].proto;

Are these all fully independent? Do we really need 4 fields for this?

> +
> +			/*
> +			 * Multiple I/O Read ID only returns the Manufacturer ID
> +			 * (1 byte) and the Device ID (2 bytes). So we reset the
> +			 * remaining bytes.
> +			 */
> +			memset(id, 0, sizeof(id));
> +			tmp = nor->read_reg(nor, SPINOR_OP_MIO_RDID, id, 3);
> +			if (tmp < 0) {
> +				dev_dbg(nor->dev,
> +					"error %d reading JEDEC ID Multi I/O\n",
> +					tmp);
> +				return ERR_PTR(tmp);
> +			}
> +		}
> +
>  	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
>  		info = &spi_nor_ids[tmp];
>  		if (info->id_len) {
> @@ -1178,11 +1216,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  	if (ret)
>  		return ret;
>  
> +	/* Reset SPI protocol for all commands */
> +	nor->erase_proto = SPI_PROTO_1_1_1;
> +	nor->read_proto = SPI_PROTO_1_1_1;
> +	nor->write_proto = SPI_PROTO_1_1_1;
> +	nor->reg_proto = SPI_PROTO_1_1_1;
> +
>  	if (name)
>  		info = spi_nor_match_id(name);
>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info)
> -		info = spi_nor_read_id(nor);
> +		info = spi_nor_read_id(nor, mode);
>  	if (IS_ERR_OR_NULL(info))
>  		return -ENOENT;
>  
> @@ -1193,7 +1237,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  	if (name && info->id_len) {
>  		const struct flash_info *jinfo;
>  
> -		jinfo = spi_nor_read_id(nor);
> +		jinfo = spi_nor_read_id(nor, mode);
>  		if (IS_ERR(jinfo)) {
>  			return PTR_ERR(jinfo);
>  		} else if (jinfo != info) {
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index fac3f6f53981..c91986a99caf 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -75,8 +75,9 @@
>  #define SPINOR_OP_BRWR		0x17	/* Bank register write */
>  
>  /* Used for Micron flashes only. */
> -#define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
> -#define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
> +#define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
> +#define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
> +#define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
>  
>  /* Status Register bits. */
>  #define SR_WIP			BIT(0)	/* Write in progress */
> @@ -105,6 +106,16 @@ enum read_mode {
>  	SPI_NOR_QUAD,
>  };
>  
> +enum spi_protocol {
> +	SPI_PROTO_1_1_1,	/* SPI */
> +	SPI_PROTO_1_1_2,	/* Dual Output */
> +	SPI_PROTO_1_1_4,	/* Quad Output */
> +	SPI_PROTO_1_2_2,	/* Dual IO */
> +	SPI_PROTO_1_4_4,	/* Quad IO */
> +	SPI_PROTO_2_2_2,	/* Dual Command */
> +	SPI_PROTO_4_4_4,	/* Quad Command */

Would it help at all to make this enum into something more like a
bitfield? So in some cases, rather than a bit switch block, we can just
extract the "number of lines" from the integer value? e.g.:

#define SNOR_PROTO(command, addr, data) \
	(((command) << 0) | \
	 ((addr) << 4) | \
	 ((data) << 8)) // or some other kind of macro magic

enum spi_nor_protocol {
	SNOR_PROTO_1_1_1		= SNOR_PROTO(1, 1, 1),
	SNOR_PROTO_1_1_2		= SNOR_PROTO(1, 1, 2),
	...
};

static inline int spi_nor_io_lines_command(enum spi_nor_protocol proto)
{
	return proto & 0xf;
}

(Similar for addr and data phases. Also, my naming might suck. Feel free
to improve!)

I don't think we should stomp on the SPI namespace with the
"SPI_PROTO_*" definitions. That's why I chose SNOR_PROTO_ and spi_nor_
prefixes.

Brian

> +};
> +
>  #define SPI_NOR_MAX_CMD_SIZE	8
>  enum spi_nor_ops {
>  	SPI_NOR_OPS_READ = 0,
> @@ -132,6 +143,10 @@ enum spi_nor_option_flags {
>   * @flash_read:		the mode of the read
>   * @sst_write_second:	used by the SST write operation
>   * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
> + * @erase_proto:	the SPI protocol used by erase operations
> + * @read_proto:		the SPI protocol used by read operations
> + * @write_proto:	the SPI protocol used by write operations
> + * @reg_proto		the SPI protocol used by read_reg/write_reg operations
>   * @cmd_buf:		used by the write_reg
>   * @prepare:		[OPTIONAL] do some preparations for the
>   *			read/write/erase/lock/unlock operations
> @@ -160,6 +175,10 @@ struct spi_nor {
>  	u8			read_opcode;
>  	u8			read_dummy;
>  	u8			program_opcode;
> +	enum spi_protocol	erase_proto;
> +	enum spi_protocol	read_proto;
> +	enum spi_protocol	write_proto;
> +	enum spi_protocol	reg_proto;
>  	enum read_mode		flash_read;
>  	bool			sst_write_second;
>  	u32			flags;
> -- 
> 1.8.2.2
> 
