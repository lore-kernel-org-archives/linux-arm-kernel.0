From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Nov 2015 11:24:41 -0800
Subject: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
In-Reply-To: <1447133399-25658-2-git-send-email-vigneshr@ti.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
Message-ID: <20151111192441.GG12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to my other comments:

On Tue, Nov 10, 2015 at 10:59:55AM +0530, Vignesh R wrote:
> In addition to providing direct access to SPI bus, some spi controller
> hardwares (like ti-qspi) provide special memory mapped port
> to accesses SPI flash devices in order to increase read performance.
> This means the controller can automatically send the SPI signals
> required to read data from the SPI flash device.
> For this, spi controller needs to know flash specific information like
> read command to use, dummy bytes and address width. Once these settings
> are populated in hardware registers, any read accesses to flash's memory
> map region(SoC specific) through memcpy (or mem-to mem DMA copy) will be
> handled by controller hardware. The hardware will automatically generate
> SPI signals required to read data from flash and present it to CPU/DMA.
> 
> Introduce spi_mtd_mmap_read() interface to support memory mapped read
> over SPI flash devices. SPI master drivers can implement this callback to
> support memory mapped read interfaces. m25p80 flash driver and other
> flash drivers can call this to request memory mapped read. The interface
> should only be used MTD flashes and cannot be used with other SPI devices.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
...
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cce80e6dc7d1..2f2c431b8917 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -361,6 +361,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
>   * @handle_err: the subsystem calls the driver to handle an error that occurs
>   *		in the generic implementation of transfer_one_message().
>   * @unprepare_message: undo any work done by prepare_message().
> + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory.
> + *                     Flash drivers (like m25p80) can request memory
> + *                     mapped read via this method. This interface
> + *                     should only be used by mtd flashes and cannot be
> + *                     used by other spi devices.
>   * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
>   *	number. Any individual value may be -ENOENT for CS lines that
>   *	are not GPIOs (driven by the SPI controller itself).
> @@ -507,6 +512,11 @@ struct spi_master {
>  			       struct spi_message *message);
>  	int (*unprepare_message)(struct spi_master *master,
>  				 struct spi_message *message);
> +	int (*spi_mtd_mmap_read)(struct  spi_device *spi,
> +				 loff_t from, size_t len,
> +				 size_t *retlen, u_char *buf,
> +				 u8 read_opcode, u8 addr_width,
> +				 u8 dummy_bytes);

This is seeming to be a longer and longer list of arguments. I know MTD
has a bad habit of long argument lists (which then cause a ton of
unnecessary churn when things need changed in the API), but perhaps we
can limit the damage to the SPI layer. Perhaps this deserves a struct to
encapsulate all the flash read arguments? Like:

struct spi_flash_read_message {
	loff_t from;
	size_t len;
	size_t *retlen;
	void *buf;
	u8 read_opcode;
	u8 addr_width;
	u8 dummy_bits;
	// additional fields to describe rx_nbits for opcode/addr/data
};

struct spi_master {
	...
	int (*spi_flash_read)(struct spi_device *spi,
			      struct spi_flash_message *msg);
};

>  
>  	/*
>  	 * These hooks are for drivers that use a generic implementation

...

Brian
