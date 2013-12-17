From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Dec 2013 14:05:55 +0100
Subject: [PATCH v3 2/7] mtd: spi-nor: add the basic data structures
In-Reply-To: <1387184330-14448-3-git-send-email-b32955@freescale.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-3-git-send-email-b32955@freescale.com>
Message-ID: <201312171405.55964.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 16, 2013 at 09:58:45 AM, Huang Shijie wrote:
> The spi_nor{} is cloned from the m25p{}.
> The spi_nor{} can be used by both the m25p80 and spi-nor controller.
> 
> We also add the spi_nor_xfer_cfg{} which can be used by the two
> fundamental primitives: read_xfer/write_xfer.
> 
>  1) the hooks for spi_nor{}:
>     @prepare/unpreare: used to do some work before or after the
>              read/write/erase/lock/unlock.
>     @read_xfer/write_xfer: We can use these two hooks to code all
>              the following hooks if the driver tries to implement them
>              by itself.
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
>  include/linux/mtd/spi-nor.h |  108
> +++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 108
> insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index ab2ea1e..83ca63d 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -50,4 +50,112 @@
>  /* Configuration Register bits. */
>  #define CR_QUAD_EN_SPAN		0x2     /* Spansion Quad I/O */
> 
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
> +enum spi_nor_ops {
> +	SPI_NOR_OPS_READ = 0,
> +	SPI_NOR_OPS_WRITE,
> +	SPI_NOR_OPS_ERASE,
> +	SPI_NOR_OPS_LOCK,
> +	SPI_NOR_OPS_UNLOCK,
> +};
> +
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

You do want to split the function pointers below and the device configuration 
above into separate structures.

> +	/* for write_reg */
> +	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> +
> +	/*
> +	 * Do some work before or after we run these operations:
> +	 *   read/write/erese/lock/unlock

Proper kernel-doc style comments for this structure would be nice.

> +	 */
> +	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
> +	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
> +
> +	/*
> +	 * The two fundamental primitives, you can use them to implement
> +	 * all the other hooks, except the prepare/unprepare.
> +	 */
> +	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> +			 u8 *buf, size_t len);
> +	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> +			  u8 *buf, size_t len);
> +
> +	/*
> +	 * The two hooks are used to read/write SPI NOR register, such as
> +	 * read status register, write status register.
> +         */

The format of the comment is messed up, please fix globally.

> +	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
> +	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
> +			int write_enable);
> +
> +	/*
> +	 * The hook for reading out the ID, the spi-nor controller drivers
> +         * can fill it with its own implementation if the default
> +	 * could not meet its requirement.
> +	 */
> +	const struct spi_device_id *(*read_id)(struct spi_nor *nor);
> +
> +	/*
> +	 * The hook for "Wait till ready", some spi-nor controller drivers
> +	 * may fill it with its own implementation.
> +	 */
> +	int (*wait_till_ready)(struct spi_nor *nor);
> +
> +	/* write */

write ... what ? I get it, but a proper documentation for new API would be 
_nice_ . Besides, I do not understand the parameters at all. Neither do I 
understand how to implement driver based on this API.

> +	void (*write)(struct spi_nor *nor, loff_t to,
> +			size_t len, size_t *retlen, const u_char *buf);
> +	/* read */
> +	int (*read)(struct spi_nor *nor, loff_t from,
> +			size_t len, size_t *retlen, u_char *buf);
> +	/* erase a sector(4K/64K, etc..) */

How do you select the erase size here (this is not documented, I dont understand 
it at all)?

> +	int (*erase)(struct spi_nor *nor, loff_t offs);
> +
> +	void *priv;
> +};
>  #endif
