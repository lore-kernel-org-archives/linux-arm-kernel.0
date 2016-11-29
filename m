From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 29 Nov 2016 19:06:16 +0100
Subject: [LINUX RFC v4 3/4] mtd: spi-nor: add stripe support
In-Reply-To: <1480235616-34038-1-git-send-email-nagasure@xilinx.com>
References: <1480235616-34038-1-git-send-email-nagasure@xilinx.com>
Message-ID: <68ca0f19-e534-3361-11f0-6566626380fe@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naga,

I have not finished to review the whole series yet but here some first
comments:

Le 27/11/2016 ? 09:33, Naga Sureshkumar Relli a ?crit :
> This patch adds stripe support and it is needed for GQSPI parallel
> configuration mode by:
> 
> - Adding required parameters like stripe and shift to spi_nor
>   structure.
> - Initializing all added parameters in spi_nor_scan()
> - Updating read_sr() and read_fsr() for getting status from both
>   flashes
> - Increasing page_size, sector_size, erase_size and toatal flash
>   size as and when required.
> - Dividing address by 2
> - Updating spi->master->flags for qspi driver to change CS
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> ---
> Changes for v4:
>  - rename isparallel to stripe
> Changes for v3:
>  - No change
> Changes for v2:
>  - Splitted to separate MTD layer changes from SPI core changes
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 130 ++++++++++++++++++++++++++++++++----------
>  include/linux/mtd/spi-nor.h   |   2 +
>  2 files changed, 103 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d0fc165..4252239 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/spi/flash.h>
>  #include <linux/mtd/spi-nor.h>
> +#include <linux/spi/spi.h>
>  
>  /* Define max times to check status register before we give up. */
>  
> @@ -89,15 +90,24 @@ static const struct flash_info *spi_nor_match_id(const char *name);
>  static int read_sr(struct spi_nor *nor)
>  {
>  	int ret;
> -	u8 val;
> +	u8 val[2];
>  
> -	ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val, 1);
> -	if (ret < 0) {
> -		pr_err("error %d reading SR\n", (int) ret);
> -		return ret;
> +	if (nor->stripe) {
> +		ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 2);
> +		if (ret < 0) {
> +			pr_err("error %d reading SR\n", (int) ret);
> +			return ret;
> +		}
> +		val[0] |= val[1];
Why '|' rather than '&' ?
I guess because of the 'Write In Progress/Busy' bit: when called by
spi_nor_sr_ready(), you want to be sure that this 'BUSY' bit is cleared on
both memories.

But what about when the Status Register is read for purpose other than
checking the state of the 'BUSY' bit?

What about SPI controllers supporting more than 2 memories in parallel?

This solution might fit the ZynqMP controller but doesn't look so generic.

> +	} else {
> +		ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 1);
> +		if (ret < 0) {
> +			pr_err("error %d reading SR\n", (int) ret);
> +			return ret;
> +		}
>  	}
>  
> -	return val;
> +	return val[0];
>  }
>  
>  /*
> @@ -108,15 +118,24 @@ static int read_sr(struct spi_nor *nor)
>  static int read_fsr(struct spi_nor *nor)
>  {
>  	int ret;
> -	u8 val;
> +	u8 val[2];
>  
> -	ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
> -	if (ret < 0) {
> -		pr_err("error %d reading FSR\n", ret);
> -		return ret;
> +	if (nor->stripe) {
> +		ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val[0], 2);
> +		if (ret < 0) {
> +			pr_err("error %d reading FSR\n", ret);
> +			return ret;
> +		}
> +		val[0] &= val[1];
Same comment here: why '&' rather than '|'?
Surely because of the the 'READY' bit which should be set for both memories.

> +	} else {
> +		ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val[0], 1);
> +		if (ret < 0) {
> +			pr_err("error %d reading FSR\n", ret);
> +			return ret;
> +		}
>  	}
>  
> -	return val;
> +	return val[0];
>  }
>  
>  /*
> @@ -290,9 +309,16 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor)
>   */
>  static int erase_chip(struct spi_nor *nor)
>  {
> +	u32 ret;
> +
>  	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
>  
> -	return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
> +	ret = nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +

	if (ret)
		return ret;
	else
		return ret;

This chunk should be removed, it doesn't ease the patch review ;)

>  }
>  
>  static int spi_nor_lock_and_prep(struct spi_nor *nor, enum spi_nor_ops ops)
> @@ -349,7 +375,7 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>  static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  {
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> -	u32 addr, len;
> +	u32 addr, len, offset;
>  	uint32_t rem;
>  	int ret;
>  
> @@ -399,9 +425,13 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	/* "sector"-at-a-time erase */
>  	} else {
>  		while (len) {
> +
>  			write_enable(nor);
> +			offset = addr;
> +			if (nor->stripe)
> +				offset /= 2;

I guess this should be /= 4 for controllers supporting 4 memories in parallel.
Shouldn't you use nor->shift and define shift as an unsigned int instead of a
bool?
offset >>= nor->shift;

Anyway, by tuning the address here in spi-nor.c rather than in the SPI
controller driver, you impose a model to support parallel memories that might
not be suited to other controllers.

>  
> -			ret = spi_nor_erase_sector(nor, addr);
> +			ret = spi_nor_erase_sector(nor, offset);
>  			if (ret)
>  				goto erase_err;
>  
> @@ -525,6 +555,8 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  	bool use_top;
>  	int ret;
>  
> +	ofs = ofs >> nor->shift;
> +
>  	status_old = read_sr(nor);
>  	if (status_old < 0)
>  		return status_old;
> @@ -610,6 +642,8 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  	bool use_top;
>  	int ret;
>  
> +	ofs = ofs >> nor->shift;
> +
>  	status_old = read_sr(nor);
>  	if (status_old < 0)
>  		return status_old;
> @@ -709,6 +743,8 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	if (ret)
>  		return ret;
>  
> +	ofs = ofs >> nor->shift;
> +
>  	ret = nor->flash_lock(nor, ofs, len);
>  
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
> @@ -724,6 +760,8 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	if (ret)
>  		return ret;
>  
> +	ofs = ofs >> nor->shift;
> +
>  	ret = nor->flash_unlock(nor, ofs, len);
>  
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
> @@ -1018,6 +1056,9 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>  	u8			id[SPI_NOR_MAX_ID_LEN];
>  	const struct flash_info	*info;
>  
> +	nor->spi->master->flags &= ~(SPI_MASTER_BOTH_CS |
> +					SPI_MASTER_DATA_STRIPE);
> +
>  	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>  	if (tmp < 0) {
>  		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
> @@ -1041,6 +1082,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  {
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>  	int ret;
> +	u32 offset = from;
>  
>  	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
>  
> @@ -1049,7 +1091,13 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  		return ret;
>  
>  	while (len) {
> -		ret = nor->read(nor, from, len, buf);
> +
> +		offset = from;
> +
> +		if (nor->stripe)
> +			offset /= 2;
> +
> +		ret = nor->read(nor, offset, len, buf);
>  		if (ret == 0) {
>  			/* We shouldn't see 0-length reads */
>  			ret = -EIO;
> @@ -1161,6 +1209,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>  	size_t page_offset, page_remain, i;
>  	ssize_t ret;
> +	u32 offset;
>  
>  	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
>  
> @@ -1178,9 +1227,13 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		/* the size of data remaining on the first page */
>  		page_remain = min_t(size_t,
>  				    nor->page_size - page_offset, len - i);
> +		offset = (to + i);
> +
> +		if (nor->stripe)
> +			offset /= 2;
>  
>  		write_enable(nor);
> -		ret = nor->write(nor, to + i, page_remain, buf + i);
> +		ret = nor->write(nor, (offset), page_remain, buf + i);
>  		if (ret < 0)
>  			goto write_err;
>  		written = ret;
> @@ -1302,22 +1355,22 @@ static int spi_nor_check(struct spi_nor *nor)
>  
>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  {
> -	const struct flash_info *info = NULL;
> +	struct flash_info *info = NULL;

You should not remove the const and should not try to modify members of *info.

>  	struct device *dev = nor->dev;
>  	struct mtd_info *mtd = &nor->mtd;
>  	struct device_node *np = spi_nor_get_flash_node(nor);
> -	int ret;
> -	int i;
> +	struct device_node *np_spi;
> +	int ret, i, xlnx_qspi_mode;
>  
>  	ret = spi_nor_check(nor);
>  	if (ret)
>  		return ret;
>  
>  	if (name)
> -		info = spi_nor_match_id(name);
> +		info = (struct flash_info *)spi_nor_match_id(name);
>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info)
> -		info = spi_nor_read_id(nor);
> +		info = (struct flash_info *)spi_nor_read_id(nor);
>  	if (IS_ERR_OR_NULL(info))
>  		return -ENOENT;
>
Both spi_nor_match_id() and spi_nor_read_id(), when they succeed, return a
pointer to an entry of the spi_nor_ids[] array, which is located in a
read-only memory area.

Since your patch doesn't remove the const attribute of the spi_nor_ids[],
I wonder whether it has been tested. I expect it not to work on most
architecture.

Anyway spi_nor_ids[] should remain const. Let's take the case of eXecution
In Place (XIP) from an external memory: if spi_nor_ids[] is const, it can be
read directly from this external (read-only) memory and we never need to copy
the array in RAM, so we save some KB of RAM.
This is just an example but I guess we can find other reasons to keep this
array const.
  
> @@ -1341,7 +1394,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  			 */
>  			dev_warn(dev, "found %s, expected %s\n",
>  				 jinfo->name, info->name);
> -			info = jinfo;
> +			info = (struct flash_info *)jinfo;
>  		}
>  	}
>  
> @@ -1370,6 +1423,27 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  	mtd->size = info->sector_size * info->n_sectors;
>  	mtd->_erase = spi_nor_erase;
>  	mtd->_read = spi_nor_read;
> +#ifdef CONFIG_OF
> +	np_spi = of_get_next_parent(np);
> +
> +	if (of_property_read_u32(np_spi, "xlnx,qspi-mode",
> +				&xlnx_qspi_mode) < 0) {
This really looks controller specific so should not be placed in the
generic spi-nor.c file.

> +		nor->shift = 0;
> +		nor->stripe = 0;
> +	} else if (xlnx_qspi_mode == 2) {
> +		nor->shift = 1;
> +		info->sector_size <<= nor->shift;
> +		info->page_size <<= nor->shift;
Just don't modify *info members! :)


> +		mtd->size <<= nor->shift;
> +		nor->stripe = 1;
> +		nor->spi->master->flags |= (SPI_MASTER_BOTH_CS |
> +						SPI_MASTER_DATA_STRIPE);
> +	}
> +#else
> +	/* Default to single */
> +	nor->shift = 0;
> +	nor->stripe = 0;
> +#endif
>  
>  	/* NOR protection support for STmicro/Micron chips and similar */
>  	if (JEDEC_MFR(info) == SNOR_MFR_MICRON ||
> @@ -1400,10 +1474,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  	/* prefer "small sector" erase if possible */
>  	if (info->flags & SECT_4K) {
>  		nor->erase_opcode = SPINOR_OP_BE_4K;
> -		mtd->erasesize = 4096;
> +		mtd->erasesize = 4096 << nor->shift;
>  	} else if (info->flags & SECT_4K_PMC) {
>  		nor->erase_opcode = SPINOR_OP_BE_4K_PMC;
> -		mtd->erasesize = 4096;
> +		mtd->erasesize = 4096 << nor->shift;
>  	} else
>  #endif
>  	{
> @@ -1508,16 +1582,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
>  			(long long)mtd->size >> 10);
>  
> -	dev_dbg(dev,
> -		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
> +	dev_dbg(dev, "mtd .name = %s, .size = 0x%llx (%lldMiB), "
>  		".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
>  		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
>  		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
>  
>  	if (mtd->numeraseregions)
>  		for (i = 0; i < mtd->numeraseregions; i++)
> -			dev_dbg(dev,
> -				"mtd.eraseregions[%d] = { .offset = 0x%llx, "
> +			dev_dbg(dev, "mtd.eraseregions[%d] = { .offset = 0x%llx, "
>  				".erasesize = 0x%.8x (%uKiB), "
>  				".numblocks = %d }\n",
>  				i, (long long)mtd->eraseregions[i].offset,
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 84f3ce5..673ec68 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -165,6 +165,8 @@ struct spi_nor {
>  	u8			read_dummy;
>  	u8			program_opcode;
>  	enum read_mode		flash_read;
> +	bool			shift;
> +	bool			stripe;
>  	bool			sst_write_second;
>  	u32			flags;
>  	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> 

Best regards,

Cyrille
