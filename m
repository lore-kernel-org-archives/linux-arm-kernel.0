From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 5 Feb 2016 08:35:18 +0100
Subject: [PATCH v2 05/51] mtd: add mtd_ooblayout_xxx() helper functions
In-Reply-To: <1454580434-32078-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
 <1454580434-32078-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160205083518.7b54e9a7@bbrezillon>
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

[...]

> +
> +/**
> + * mtd_ooblayout_count_bytes - count the number of bytes in a OOB category
> + * @mtd: mtd info structure
> + * @iter: category iterator
> + *
> + * Count the number of bytes in a given category.
> + *
> + * Returns a positive value on success, a negative error code otherwise.
> + */
> +static int mtd_ooblayout_count_bytes(struct mtd_info *mtd,
> +				int (*iter)(struct mtd_info *,
> +					    int section,
> +					    struct mtd_oob_region *oobregion))
> +{
> +	struct mtd_oob_region oobregion = { };
> +	int section = 0, ret, nbytes = 0;
> +
> +	while (1) {
> +		ret = iter(mtd, section, &oobregion);

				^ section++

Oops, will fix that in next version.

> +		if (ret) {
> +			if (ret == -ERANGE)
> +				ret = nbytes;
> +			break;
> +		}
> +
> +		nbytes += oobregion.length;
> +	}
> +
> +	return ret;
> +}


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
