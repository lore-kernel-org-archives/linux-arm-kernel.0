From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Dec 2013 14:07:59 +0100
Subject: [PATCH V2 2/4] mtd: spi-nor: add the basic data structures
In-Reply-To: <1386318764-15882-3-git-send-email-b32955@freescale.com>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <1386318764-15882-3-git-send-email-b32955@freescale.com>
Message-ID: <201312101407.59958.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 06, 2013 at 09:32:42 AM, Huang Shijie wrote:
> The spi_nor{} is cloned from the m25p{}.
> The spi_nor{} can be used by both the m25p80 and spi-nor controller.
> 
> We also add the spi_nor_xfer_cfg{} which can be used by the two
> fundamental primitives: read_xfer/write_xfer.
> 
>  1) the hooks for spi_nor{}:
>     @read_xfer/write_xfer: We can use these two hooks to code all
>              the following hooks if the driver tries to implement them
>              by itself.
> 
>     @read_reg: used to read the registers, such as read status register,
>              read configure register.
>     @write_reg: used to write the registers, such as write enable,
>              erase sector.
>     @read_id: read out the ID info.
>     @wait_till_ready: wait till the NOR becomes ready.
>     @read: read out the data from the NOR.
>     @write: write data to the NOR.
>     @erase: erase a sector of the NOR.
> 
>  2) Add a new field sst_write_second for the SST NOR write.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  include/linux/mtd/spi-nor.h |   74
> +++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 74
> insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index ab2ea1e..b3e08c2 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -50,4 +50,78 @@
>  /* Configuration Register bits. */
>  #define CR_QUAD_EN_SPAN		0x2     /* Spansion Quad I/O */
> 
> +
> +enum read_mode {
> +	SPI_NOR_NORMAL = 0,
> +	SPI_NOR_FAST,
> +	SPI_NOR_QUAD,
> +};
> +
> +/*
> + * struct spi_nor_xfer_cfg - Structure for defining a Serial Flash
> transfer + * @wren:		command for "Write Enable", or 0x00 for not 
required
> + * @cmd:		command for operation
> + * @cmd_pins:		number of pins to send @cmd (1, 2, 4)
> + * @addr:		address for operation
> + * @addr_pins:		number of pins to send @addr (1, 2, 4)
> + * @addr_width: 	number of address bytes (3,4, or 0 for address not
> required) + * @mode:		mode data
> + * @mode_pins:		number of pins to send @mode (1, 2, 4)
> + * @mode_cycles:	number of mode cycles (0 for mode not required)
> + * @dummy_cycles:	number of dummy cycles (0 for dummy not required)
> + */
> +struct spi_nor_xfer_cfg {
> +	u8		wren;
> +	u8		cmd;
> +	u8		cmd_pins;
> +	u32		addr;
> +	u8		addr_pins;
> +	u8		addr_width;
> +	u8		mode;
> +	u8		mode_pins;
> +	u8		mode_cycles;
> +	u8		dummy_cycles;
> +};
> +
> +#define	SPI_NOR_MAX_CMD_SIZE	8
> +struct spi_nor {
> +	struct mtd_info		*mtd;
> +	struct mutex		lock;
> +
> +	/* pointer to a spi device */
> +	struct device		*dev;
> +	u32			page_size;
> +	u8			addr_width;
> +	u8			erase_opcode;
> +	u8			read_opcode;
> +	u8			read_dummy;
> +	u8			program_opcode;
> +	enum read_mode		flash_read;
> +	bool			sst_write_second;
> +	struct spi_nor_xfer_cfg	cfg;
> +
> +	/* for write_reg */
> +	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> +
> +	/* the two fundamental primitives */
> +	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> +			 u8 *buf, size_t len);
> +	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> +			  u8 *buf, size_t len);
> +
> +	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
> +	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
> +			int write_enable);

Does the vybrid really support accelerated SPI NOR register IO or does it 
emulate it with read/write or read_xfer/write_xfer accessors ? If the later, 
just drop this stuff for now.

> +	const struct spi_device_id *(*read_id)(struct spi_nor *nor);
> +	int (*wait_till_ready)(struct spi_nor *nor);
> +
> +	/* write */
> +	void (*write)(struct spi_nor *nor, loff_t to,
> +			size_t len, size_t *retlen, const u_char *buf);
> +	/* read */
> +	int (*read)(struct spi_nor *nor, loff_t from,
> +			size_t len, size_t *retlen, u_char *buf);
> +	/* erase */
> +	int (*erase)(struct spi_nor *nor, loff_t offs);

How do you specify what to erase (sub-sector, sector, whole chip) here ?

> +};
>  #endif
