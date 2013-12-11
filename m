From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Dec 2013 18:09:02 -0800
Subject: [PATCH v3 26/36] mtd: st_spi_fsm: Add the ability to read from
 a Serial Flash device
In-Reply-To: <1385727565-25794-27-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-27-git-send-email-lee.jones@linaro.org>
Message-ID: <20131211020902.GL27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:19:15PM +0000, Lee Jones wrote:
> When a read is issued by userspace the MFD framework calls back into
> the driver to conduct the actual command issue and data extraction.
> Here we provide the routines which do exactly that.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 110 +++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/devices/st_spi_fsm.h |   3 ++
>  2 files changed, 113 insertions(+)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index ad277f1..c76510e 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -538,6 +538,114 @@ static int stfsm_n25q_config(struct stfsm *fsm)
>  	return 0;
>  }
>  
> +static int stfsm_read(struct stfsm *fsm, uint8_t *const buf,

Did you really mean uint8_t *const buf? This means that buf will always
hold the same address (which is fine). But we don't often enshrine that
in the function definition.

> +		      const uint32_t size, const uint32_t offset)

Similar. Is it really important to mark size and offset const?

I won't argue, if you think this is deserving, but I don't want to
encourage this practice everywhere, since it doesn't buy us much.
(Declaring a pointer argument as, e.g., 'const int *var' is useful in an
API, because it helps a developer understand externally that the routine
will not (in the absence of unsafe casts) modify the buffer contents.
But declaring 'int *const var' is less helpful, as it is only useful for
local reasoning.)

> +{

...

> +}
> +
> +/*
> + * Read an address range from the flash chip. The address range
> + * may be any size provided it is within the physical boundaries.
> + */
> +static int stfsm_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
> +			  size_t *retlen, u_char *buf)
> +{
> +	struct stfsm *fsm = dev_get_drvdata(mtd->dev.parent);
> +	uint32_t bytes;
> +
> +	dev_dbg(fsm->dev, "%s from 0x%08x, len %zd\n",
> +		__func__, (u32)from, len);
> +
> +	/* Initialise read length */
> +	if (retlen)
> +		*retlen = 0;

You're repeating the common code in mtd_read(). Kill this
initialization.

> +
> +	if (!len) {
> +		dev_warn(fsm->dev, "Zero byte read requested\n");
> +		return 0;
> +	}

Similar. You're duplicating the checks in mtd_read().

> +
> +	if (from + len > mtd->size) {
> +		dev_err(fsm->dev, "Can't read past end of chip\n");
> +		return -EINVAL;
> +	}

Ditto.

> +
> +	mutex_lock(&fsm->lock);
> +
> +	while (len > 0) {
> +		bytes = min(len, (size_t)FLASH_PAGESIZE);
> +
> +		stfsm_read(fsm, buf, bytes, from);
> +
> +		buf += bytes;
> +		from += bytes;
> +		len -= bytes;
> +
> +		if (retlen)
> +			*retlen += bytes;
> +	}
> +
> +	mutex_unlock(&fsm->lock);
> +
> +	return 0;
> +}
> +
>  static void stfsm_read_jedec(struct stfsm *fsm, uint8_t *const jedec)
>  {
>  	const struct stfsm_seq *seq = &stfsm_seq_read_jedec;
> diff --git a/drivers/mtd/devices/st_spi_fsm.h b/drivers/mtd/devices/st_spi_fsm.h
> index b5ce07d..e168296 100644
> --- a/drivers/mtd/devices/st_spi_fsm.h
> +++ b/drivers/mtd/devices/st_spi_fsm.h
> @@ -229,6 +229,9 @@
>  #define FLASH_CMD_READ4_1_1_4	0x6c
>  #define FLASH_CMD_READ4_1_4_4	0xec
>  
> +#define FLASH_PAGESIZE		256			/* In Bytes    */
> +#define FLASH_PAGESIZE_32	FLASH_PAGESIZE / 4	/* In uint32_t */

checkpatch.pl warns that you need parentheses around FLASH_PAGESIZE / 4.

Brian
