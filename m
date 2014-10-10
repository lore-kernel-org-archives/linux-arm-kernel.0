From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 9 Oct 2014 21:51:26 -0700
Subject: [PATCH v2 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <1412043295.9388.82.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043295.9388.82.camel@decadent.org.uk>
Message-ID: <20141010045126.GB22169@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 03:14:55AM +0100, Ben Hutchings wrote:
> m25p80's device ID table is now spi_nor_ids, defined in spi-nor.  The
> MODULE_DEVICE_TABLE() macro doesn't work with extern definitions, but
> its use was also removed at the same time.  Now if m25p80 is built as
> a module it doesn't get the necessary aliases to be loaded
> automatically.
> 
> A clean solution to this will involve defining the list of device
> IDs in spi-nor.h and removing struct spi_device_id from the spi-nor
> API, but this is quite a large change.
> 
> As a quick fix suitable for stable, copy the device IDs back into
> m25p80.
> 
> Fixes: 03e296f613af ("mtd: m25p80: use the SPI nor framework")
> Cc: stable <stable@vger.kernel.org> # 3.16.x: 32f1b7c8352f: mtd: move support for struct flash_platform_data into m25p80
> Cc: stable <stable@vger.kernel.org> # 3.16.x
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Can I get any acks/tested-by's? I'll try to test this out when I get
back to the office, but I'd like to be able to send this in the 3.18
cycle still.

As for the rest of the series, well we still have a few things to agree
on...

> ---
>  drivers/mtd/devices/m25p80.c  | 59 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/mtd/spi-nor/spi-nor.c |  5 ++--
>  include/linux/mtd/spi-nor.h   |  3 +--
>  3 files changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index dcda628..204bec1 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -239,8 +239,11 @@ static int m25p_probe(struct spi_device *spi)
>  		id = spi_nor_match_id(data->type);
>  
>  	/* If we didn't get name from platform, simply use "modalias". */
> -	if (!id)
> -		id = spi_get_device_id(spi);
> +	if (!id) {
> +		id = spi_nor_match_id(spi_get_device_id(spi)->name);
> +		if (WARN_ON(!id))
> +			return -ENODEV;
> +	}
>  
>  	ret = spi_nor_scan(nor, id, mode);
>  	if (ret)
> @@ -263,12 +266,62 @@ static int m25p_remove(struct spi_device *spi)
>  }
>  
> 
> +/*
> + * XXX This needs to be kept in sync with spi_nor_ids.  We can't share
> + * it with spi-nor, because if this is built as a module then modpost
> + * won't be able to read it and add appropriate aliases.
> + */
> +static const struct spi_device_id m25p_ids[] = {
> +	{"at25fs010"},	{"at25fs040"},	{"at25df041a"},	{"at25df321a"},
> +	{"at25df641"},	{"at26f004"},	{"at26df081a"},	{"at26df161a"},
> +	{"at26df321"},	{"at45db081d"},
> +	{"en25f32"},	{"en25p32"},	{"en25q32b"},	{"en25p64"},
> +	{"en25q64"},	{"en25qh128"},	{"en25qh256"},
> +	{"f25l32pa"},
> +	{"mr25h256"},	{"mr25h10"},
> +	{"gd25q32"},	{"gd25q64"},
> +	{"160s33b"},	{"320s33b"},	{"640s33b"},
> +	{"mx25l2005a"},	{"mx25l4005a"},	{"mx25l8005"},	{"mx25l1606e"},
> +	{"mx25l3205d"},	{"mx25l3255e"},	{"mx25l6405d"},	{"mx25l12805d"},
> +	{"mx25l12855e"},{"mx25l25635e"},{"mx25l25655e"},{"mx66l51235l"},
> +	{"mx66l1g55g"},
> +	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q256a"},
> +	{"n25q512a"},	{"n25q512ax3"},	{"n25q00"},
> +	{"pm25lv512"},	{"pm25lv010"},	{"pm25lq032"},
> +	{"s25sl032p"},	{"s25sl064p"},	{"s25fl256s0"},	{"s25fl256s1"},
> +	{"s25fl512s"},	{"s70fl01gs"},	{"s25sl12800"},	{"s25sl12801"},
> +	{"s25fl129p0"},	{"s25fl129p1"},	{"s25sl004a"},	{"s25sl008a"},
> +	{"s25sl016a"},	{"s25sl032a"},	{"s25sl064a"},	{"s25fl008k"},
> +	{"s25fl016k"},	{"s25fl064k"},
> +	{"sst25vf040b"},{"sst25vf080b"},{"sst25vf016b"},{"sst25vf032b"},
> +	{"sst25vf064c"},{"sst25wf512"},	{"sst25wf010"},	{"sst25wf020"},
> +	{"sst25wf040"},
> +	{"m25p05"},	{"m25p10"},	{"m25p20"},	{"m25p40"},
> +	{"m25p80"},	{"m25p16"},	{"m25p32"},	{"m25p64"},
> +	{"m25p128"},	{"n25q032"},
> +	{"m25p05-nonjedec"},	{"m25p10-nonjedec"},	{"m25p20-nonjedec"},
> +	{"m25p40-nonjedec"},	{"m25p80-nonjedec"},	{"m25p16-nonjedec"},
> +	{"m25p32-nonjedec"},	{"m25p64-nonjedec"},	{"m25p128-nonjedec"},
> +	{"m45pe10"},	{"m45pe80"},	{"m45pe16"},
> +	{"m25pe20"},	{"m25pe80"},	{"m25pe16"},
> +	{"m25px16"},	{"m25px32"},	{"m25px32-s0"},	{"m25px32-s1"},
> +	{"m25px64"},
> +	{"w25x10"},	{"w25x20"},	{"w25x40"},	{"w25x80"},
> +	{"w25x16"},	{"w25x32"},	{"w25q32"},	{"w25q32dw"},
> +	{"w25x64"},	{"w25q64"},	{"w25q128"},	{"w25q80"},
> +	{"w25q80bl"},	{"w25q128"},	{"w25q256"},	{"cat25c11"},
> +	{"cat25c03"},	{"cat25c09"},	{"cat25c17"},	{"cat25128"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, m25p_ids);
> +
> +
>  static struct spi_driver m25p80_driver = {
>  	.driver = {
>  		.name	= "m25p80",
>  		.owner	= THIS_MODULE,
>  	},
> -	.id_table	= spi_nor_ids,
> +	.id_table	= m25p_ids,
>  	.probe	= m25p_probe,
>  	.remove	= m25p_remove,
>  
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index ae16aa2..53783ed 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -473,7 +473,7 @@ struct flash_info {
>   * more nor chips.  This current list focusses on newer chips, which
>   * have been converging on command sets which including JEDEC ID.
>   */
> -const struct spi_device_id spi_nor_ids[] = {
> +static const struct spi_device_id spi_nor_ids[] = {
>  	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
>  	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
>  	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
> @@ -637,7 +637,6 @@ const struct spi_device_id spi_nor_ids[] = {
>  	{ "cat25128", CAT25_INFO(2048, 8, 64, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
>  	{ },
>  };
> -EXPORT_SYMBOL_GPL(spi_nor_ids);
>  
>  static const struct spi_device_id *spi_nor_read_id(struct spi_nor *nor)
>  {
> @@ -1113,7 +1112,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  }
>  EXPORT_SYMBOL_GPL(spi_nor_scan);
>  
> -const struct spi_device_id *spi_nor_match_id(char *name)
> +const struct spi_device_id *spi_nor_match_id(const char *name)
>  {
>  	const struct spi_device_id *id = spi_nor_ids;
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 9e6294f..5ec84cc 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -201,7 +201,6 @@ struct spi_nor {
>   */
>  int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  			enum read_mode mode);
> -extern const struct spi_device_id spi_nor_ids[];
>  
>  /**
>   * spi_nor_match_id() - find the spi_device_id by the name
> @@ -213,6 +212,6 @@ extern const struct spi_device_id spi_nor_ids[];
>   * Return: returns the right spi_device_id pointer on success,
>   *         and returns NULL on failure.
>   */
> -const struct spi_device_id *spi_nor_match_id(char *name);
> +const struct spi_device_id *spi_nor_match_id(const char *name);
>  
>  #endif
> 
> 

Brian
