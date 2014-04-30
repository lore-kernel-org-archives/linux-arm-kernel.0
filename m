From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 30 Apr 2014 11:14:58 -0700
Subject: [PATCH v3 3/9] of: mtd: add NAND timing mode retrieval support
In-Reply-To: <1394647664-8258-4-git-send-email-b.brezillon.dev@gmail.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
 <1394647664-8258-4-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140430181458.GD2497@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 07:07:38PM +0100, Boris BREZILLON wrote:
> Add a function to retrieve NAND timing mode (ONFI timing mode) from a given
> DT node.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> ---
>  drivers/of/of_mtd.c    |   19 +++++++++++++++++++
>  include/linux/of_mtd.h |    8 ++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/of/of_mtd.c b/drivers/of/of_mtd.c
> index b7361ed..8bdaa0b 100644
> --- a/drivers/of/of_mtd.c
> +++ b/drivers/of/of_mtd.c
> @@ -117,3 +117,22 @@ bool of_get_nand_on_flash_bbt(struct device_node *np)
>  	return of_property_read_bool(np, "nand-on-flash-bbt");
>  }
>  EXPORT_SYMBOL_GPL(of_get_nand_on_flash_bbt);
> +
> +/**
> + * of_get_nand_timings - Get nand timings for the given device_node
> + * @np:	Pointer to the given device_node
> + *
> + * return 0 on success errno other wise
> + */
> +int of_get_nand_onfi_timing_mode(struct device_node *np)
> +{
> +	int err;
> +	u32 mode;
> +
> +	err = of_property_read_u32(np, "onfi,nand-timing-mode", &mode);
> +	if (err)
> +		return err;
> +
> +	return mode;

To fit the style of the rest of this file (and to save some lines) this
might as well be:

	return ret ? ret : mode;

> +}
> +EXPORT_SYMBOL_GPL(of_get_nand_onfi_timing_mode);
> diff --git a/include/linux/of_mtd.h b/include/linux/of_mtd.h
> index e266caa..c8310ae 100644
> --- a/include/linux/of_mtd.h
> +++ b/include/linux/of_mtd.h
> @@ -9,6 +9,8 @@
>  #ifndef __LINUX_OF_MTD_H
>  #define __LINUX_OF_MTD_H
>  
> +#include <linux/mtd/nand.h>
> +

What's this header used for here? I think you can drop it.

>  #ifdef CONFIG_OF_MTD
>  
>  #include <linux/of.h>
> @@ -17,6 +19,7 @@ int of_get_nand_ecc_step_size(struct device_node *np);
>  int of_get_nand_ecc_strength(struct device_node *np);
>  int of_get_nand_bus_width(struct device_node *np);
>  bool of_get_nand_on_flash_bbt(struct device_node *np);
> +int of_get_nand_onfi_timing_mode(struct device_node *np);
>  
>  #else /* CONFIG_OF_MTD */
>  
> @@ -45,6 +48,11 @@ static inline bool of_get_nand_on_flash_bbt(struct device_node *np)
>  	return false;
>  }
>  
> +static inline int of_get_nand_onfi_timing_mode(struct device_node *np)
> +{
> +	return -ENOSYS;
> +}
> +
>  #endif /* CONFIG_OF_MTD */
>  
>  #endif /* __LINUX_OF_MTD_H */

Brian
