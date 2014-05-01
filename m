From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 01 May 2014 14:16:05 +0100
Subject: [RFC PATCH 2/3] of: mtd: add NAND randomizer mode retrieval
In-Reply-To: <1398906592-24677-3-git-send-email-b.brezillon.dev@gmail.com>
References: <1398906592-24677-1-git-send-email-b.brezillon.dev@gmail.com>
 <1398906592-24677-3-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140501131605.9CB7CC409DA@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  1 May 2014 03:09:51 +0200, Boris BREZILLON <b.brezillon.dev@gmail.com> wrote:
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> ---

No commit message? Immediate NAK. Please, make sure you write a
description for each and every patch. This is not optional. Future
readers want to know what this patch solves and any other information
you can provide without having to read the diff.

>  drivers/of/of_mtd.c    | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/of_mtd.h |  6 ++++++

Don't forget to update Documentation/devicetree/bindings/mtd/nand.txt

g.

>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/of/of_mtd.c b/drivers/of/of_mtd.c
> index a862c08..f941a5e 100644
> --- a/drivers/of/of_mtd.c
> +++ b/drivers/of/of_mtd.c
> @@ -84,6 +84,41 @@ int of_get_nand_ecc_strength(struct device_node *np)
>  EXPORT_SYMBOL_GPL(of_get_nand_ecc_strength);
>  
>  /**
> + * It maps 'enum nand_rnd_modes_t' found in include/linux/mtd/nand.h
> + * into the device tree binding of 'nand-rnd', so that MTD
> + * device driver can get nand rnd from device tree.
> + */
> +static const char * const nand_rnd_modes[] = {
> +	[NAND_RND_NONE]		= "none",
> +	[NAND_RND_SOFT]		= "soft",
> +	[NAND_RND_HW]		= "hw",
> +};
> +
> +/**
> + * of_get_nand_rnd_mode - Get nand randomizer mode for given device_node
> + * @np:	Pointer to the given device_node
> + *
> + * The function gets randomizer mode string from property 'nand-rnd-mode',
> + * and return its index in nand_rnd_modes table, or errno in error case.
> + */
> +int of_get_nand_rnd_mode(struct device_node *np)
> +{
> +	const char *pm;
> +	int err, i;
> +
> +	err = of_property_read_string(np, "nand-rnd-mode", &pm);
> +	if (err < 0)
> +		return err;
> +
> +	for (i = 0; i < ARRAY_SIZE(nand_rnd_modes); i++)
> +		if (!strcasecmp(pm, nand_rnd_modes[i]))
> +			return i;
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(of_get_nand_rnd_mode);
> +
> +/**
>   * of_get_nand_bus_width - Get nand bus witdh for given device_node
>   * @np:	Pointer to the given device_node
>   *
> diff --git a/include/linux/of_mtd.h b/include/linux/of_mtd.h
> index d0145fb..2f43362 100644
> --- a/include/linux/of_mtd.h
> +++ b/include/linux/of_mtd.h
> @@ -15,6 +15,7 @@
>  int of_get_nand_ecc_mode(struct device_node *np);
>  int of_get_nand_ecc_step_size(struct device_node *np);
>  int of_get_nand_ecc_strength(struct device_node *np);
> +int of_get_nand_rnd_mode(struct device_node *np);
>  int of_get_nand_bus_width(struct device_node *np);
>  bool of_get_nand_on_flash_bbt(struct device_node *np);
>  int of_get_nand_onfi_timing_mode(struct device_node *np);
> @@ -36,6 +37,11 @@ static inline int of_get_nand_ecc_strength(struct device_node *np)
>  	return -ENOSYS;
>  }
>  
> +static inline int of_get_nand_rnd_mode(struct device_node *np)
> +{
> +	return -ENOSYS;
> +}
> +
>  static inline int of_get_nand_bus_width(struct device_node *np)
>  {
>  	return -ENOSYS;
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
