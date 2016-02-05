From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 5 Feb 2016 10:27:10 +0100
Subject: [PATCH v2 05/51] mtd: add mtd_ooblayout_xxx() helper functions
In-Reply-To: <1454580434-32078-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
 <1454580434-32078-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160205102710.39fa4244@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  4 Feb 2016 11:06:28 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> In order to make the ecclayout definition completely dynamic we need to
> rework the way the OOB layout are defined and iterated.
> 
> Create a few mtd_ooblayout_xxx() helpers to ease OOB bytes manipulation
> and hide ecclayout internals to their users.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/mtdcore.c   | 401 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/mtd.h |  33 ++++
>  2 files changed, 434 insertions(+)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 3096251..14e46ca 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -997,6 +997,407 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(mtd_read_oob);
>  
> +/**
> + * mtd_ooblayout_ecc - Get the OOB region definition of a specific ECC section
> + * @mtd: MTD device structure
> + * @section: ECC section. Depending on the layout you may have all the ECC
> + *	     bytes stored in a single contiguous section, or one section
> + *	     per ECC chunk (and sometime several sections for a single ECC
> + *	     ECC chunk)
> + * @oobecc: OOB region struct filled with the appropriate ECC position
> + *	    information
> + *
> + * This functions return ECC section information in the OOB area. I you want
> + * to get all the ECC bytes information, then you should call
> + * mtd_ooblayout_ecc(mtd, section++, oobecc) until it returns -ERANGE.
> + *
> + * Returns zero on success, a negative error code otherwise.
> + */
> +int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
> +		      struct mtd_oob_region *oobecc)
> +{
> +	int eccbyte = 0, cursection = 0, length = 0, eccpos = 0;
> +
> +	memset(oobecc, 0, sizeof(*oobecc));
> +
> +	if (!mtd || section < 0)
> +		return -EINVAL;
> +
> +	if (!mtd->ecclayout)
> +		return -ENOTSUPP;
> +
> +	if (mtd->ecclayout->eccbytes < 1)
> +		return -ERANGE;
> +
> +	/*
> +	 * This logic allows us to reuse the ->ecclayout information and
> +	 * expose them as ECC regions (as done for the OOB free regions).
> +	 *
> +	 * TODO: this should be dropped as soon as we get rid of the
> +	 * ->ecclayout field.
> +	 */
> +	for (eccbyte = 0; eccbyte < mtd->ecclayout->eccbytes; eccbyte++) {
> +		eccpos = mtd->ecclayout->eccpos[eccbyte];
> +
> +		if (eccbyte < mtd->ecclayout->eccbytes - 1) {
> +			int neccpos = mtd->ecclayout->eccpos[eccbyte + 1];
> +
> +			if (eccpos + 1 == neccpos) {
> +				length++;
> +				continue;
> +			}
> +		}
> +
> +		if (section == cursection)
> +			break;
> +
> +		length = 0;
> +		cursection++;
> +	}
> +
> +	if (cursection != section)

Should be
	if (cursection != section ||
	    eccbyte >= mtd->ecclayout->eccbytes)

Will fix that too.

> +		return -ERANGE;
> +
> +	oobecc->length = length + 1;
> +	oobecc->offset = eccpos - length;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtd_ooblayout_ecc);


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
