From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 22 Jul 2018 12:32:31 +0200
Subject: [PATCH v4 34/35] mtd: rawnand: allocate model parameter
 dynamically
In-Reply-To: <20180720151527.16038-35-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-35-miquel.raynal@bootlin.com>
Message-ID: <20180722123231.1cde7180@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:26 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Thanks to the migration of all drivers to use nand_scan() and the
> related nand_controller_ops, we can now allocate data during the
> detection phase. Let's do it first for the NAND model parameter which
> is allocated in nand_detect().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/nand_base.c | 52 +++++++++++++++++++++++++++++++---------
>  include/linux/mtd/rawnand.h      |  2 +-
>  2 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index da99232702a4..8645f655e5b0 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5225,8 +5225,11 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  
>  	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
>  	sanitize_string(p->model, sizeof(p->model));
> -	strncpy(chip->parameters.model, p->model,
> -		sizeof(chip->parameters.model) - 1);
> +	chip->parameters.model = kstrdup(p->model, GFP_KERNEL);
> +	if (!chip->parameters.model) {
> +		ret = -ENOMEM;
> +		goto free_onfi_param_page;
> +	}
>  
>  	mtd->writesize = le32_to_cpu(p->byte_per_page);
>  
> @@ -5356,8 +5359,11 @@ static int nand_flash_detect_jedec(struct nand_chip *chip)
>  
>  	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
>  	sanitize_string(p->model, sizeof(p->model));
> -	strncpy(chip->parameters.model, p->model,
> -		sizeof(chip->parameters.model) - 1);
> +	chip->parameters.model = kstrdup(p->model, GFP_KERNEL);
> +	if (!chip->parameters.model) {
> +		ret = -ENOMEM;
> +		goto free_jedec_param_page;
> +	}
>  
>  	mtd->writesize = le32_to_cpu(p->byte_per_page);
>  
> @@ -5546,8 +5552,9 @@ static bool find_full_id_nand(struct nand_chip *chip,
>  		chip->onfi_timing_mode_default =
>  					type->onfi_timing_mode_default;
>  
> -		strncpy(chip->parameters.model, type->name,
> -			sizeof(chip->parameters.model) - 1);
> +		chip->parameters.model = kstrdup(type->name, GFP_KERNEL);
> +		if (!chip->parameters.model)
> +			return false;
>  
>  		return true;
>  	}
> @@ -5706,8 +5713,9 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>  	if (!type->name)
>  		return -ENODEV;
>  
> -	strncpy(chip->parameters.model, type->name,
> -		sizeof(chip->parameters.model) - 1);
> +	chip->parameters.model = kstrdup(type->name, GFP_KERNEL);
> +	if (!chip->parameters.model)
> +		return -ENOMEM;
>  
>  	chip->chipsize = (uint64_t)type->chipsize << 20;
>  
> @@ -5737,7 +5745,9 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>  			mtd->name);
>  		pr_warn("bus width %d instead of %d bits\n", busw ? 16 : 8,
>  			(chip->options & NAND_BUSWIDTH_16) ? 16 : 8);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +
> +		goto free_detect_allocation;
>  	}
>  
>  	nand_decode_bbm_options(chip);
> @@ -5774,6 +5784,11 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>  		(int)(chip->chipsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
>  		mtd->erasesize >> 10, mtd->writesize, mtd->oobsize);
>  	return 0;
> +
> +free_detect_allocation:
> +	kfree(chip->parameters.model);
> +
> +	return ret;
>  }
>  
>  static const char * const nand_ecc_modes[] = {
> @@ -6021,6 +6036,11 @@ static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
>  	return 0;
>  }
>  
> +static void nand_scan_ident_cleanup(struct nand_chip *chip)
> +{
> +	kfree(chip->parameters.model);
> +}
> +
>  static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
>  {
>  	struct nand_chip *chip = mtd_to_nand(mtd);
> @@ -6764,11 +6784,18 @@ int nand_scan_with_ids(struct mtd_info *mtd, int maxchips,
>  
>  	ret = nand_attach(chip);
>  	if (ret)
> -		return ret;
> +		goto cleanup_ident;
>  
>  	ret = nand_scan_tail(mtd);
>  	if (ret)
> -		nand_detach(chip);
> +		goto detach_chip;
> +
> +	return 0;
> +
> +detach_chip:
> +	nand_detach(chip);
> +cleanup_ident:
> +	nand_scan_ident_cleanup(chip);
>  
>  	return ret;
>  }
> @@ -6800,6 +6827,9 @@ void nand_cleanup(struct nand_chip *chip)
>  
>  	/* Free controller specific allocations after chip identification */
>  	nand_detach(chip);
> +
> +	/* Free identification phase allocations */
> +	nand_scan_ident_cleanup(chip);
>  }
>  
>  EXPORT_SYMBOL_GPL(nand_cleanup);
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index a928771a7ae4..5723d940a47d 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -482,7 +482,7 @@ struct onfi_params {
>   */
>  struct nand_parameters {
>  	/* Generic parameters */
> -	char model[100];
> +	const char *model;
>  	bool supports_set_get_features;
>  	DECLARE_BITMAP(set_feature_list, ONFI_FEATURE_NUMBER);
>  	DECLARE_BITMAP(get_feature_list, ONFI_FEATURE_NUMBER);
