From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [PATCH] ARM: SAMSUNG: Consolidate common function to set SDHCI
	plat data
In-Reply-To: <1313077093-25157-1-git-send-email-banajit.g@samsung.com>
References: <1313077093-25157-1-git-send-email-banajit.g@samsung.com>
Message-ID: <000201cc5e30$39de1a80$ad9a4f80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banajit Goswami wrote:
> 
> Moves similar functions to set SDHCI platform data for all Samsung
> boards to a common location, thereby saves a few lines.
> 
> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-hsmmc.c          |   19 +------------------
>  arch/arm/plat-samsung/dev-hsmmc1.c         |   19 +------------------
>  arch/arm/plat-samsung/dev-hsmmc2.c         |   19 +------------------
>  arch/arm/plat-samsung/dev-hsmmc3.c         |   19 +------------------
>  arch/arm/plat-samsung/include/plat/sdhci.h |    7 +++++++
>  arch/arm/plat-samsung/platformdata.c       |   22
> ++++++++++++++++++++++
>  6 files changed, 33 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-hsmmc.c
b/arch/arm/plat-samsung/dev-
> hsmmc.c
> index db7a65c..06825c4 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc.c
> @@ -58,22 +58,5 @@ struct platform_device s3c_device_hsmmc0 = {
> 
>  void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
>  {
> -	struct s3c_sdhci_platdata *set = &s3c_hsmmc0_def_platdata;
> -
> -	set->cd_type = pd->cd_type;
> -	set->ext_cd_init = pd->ext_cd_init;
> -	set->ext_cd_cleanup = pd->ext_cd_cleanup;
> -	set->ext_cd_gpio = pd->ext_cd_gpio;
> -	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
> -
> -	if (pd->max_width)
> -		set->max_width = pd->max_width;
> -	if (pd->cfg_gpio)
> -		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
> -	if (pd->host_caps)
> -		set->host_caps |= pd->host_caps;
> -	if (pd->clk_type)
> -		set->clk_type = pd->clk_type;
> +	s3c_sdhci_set_platdata(pd, &s3c_hsmmc0_def_platdata);
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c
b/arch/arm/plat-samsung/dev-
> hsmmc1.c
> index 2497321..4524ef4 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc1.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc1.c
> @@ -58,22 +58,5 @@ struct platform_device s3c_device_hsmmc1 = {
> 
>  void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
>  {
> -	struct s3c_sdhci_platdata *set = &s3c_hsmmc1_def_platdata;
> -
> -	set->cd_type = pd->cd_type;
> -	set->ext_cd_init = pd->ext_cd_init;
> -	set->ext_cd_cleanup = pd->ext_cd_cleanup;
> -	set->ext_cd_gpio = pd->ext_cd_gpio;
> -	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
> -
> -	if (pd->max_width)
> -		set->max_width = pd->max_width;
> -	if (pd->cfg_gpio)
> -		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
> -	if (pd->host_caps)
> -		set->host_caps |= pd->host_caps;
> -	if (pd->clk_type)
> -		set->clk_type = pd->clk_type;
> +	s3c_sdhci_set_platdata(pd, &s3c_hsmmc1_def_platdata);
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c
b/arch/arm/plat-samsung/dev-
> hsmmc2.c
> index f60aedb..9cede96 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc2.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc2.c
> @@ -59,22 +59,5 @@ struct platform_device s3c_device_hsmmc2 = {
> 
>  void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
>  {
> -	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;
> -
> -	set->cd_type = pd->cd_type;
> -	set->ext_cd_init = pd->ext_cd_init;
> -	set->ext_cd_cleanup = pd->ext_cd_cleanup;
> -	set->ext_cd_gpio = pd->ext_cd_gpio;
> -	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
> -
> -	if (pd->max_width)
> -		set->max_width = pd->max_width;
> -	if (pd->cfg_gpio)
> -		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
> -	if (pd->host_caps)
> -		set->host_caps |= pd->host_caps;
> -	if (pd->clk_type)
> -		set->clk_type = pd->clk_type;
> +	s3c_sdhci_set_platdata(pd, &s3c_hsmmc2_def_platdata);
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c
b/arch/arm/plat-samsung/dev-
> hsmmc3.c
> index ede776f..0358ef4 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc3.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc3.c
> @@ -62,22 +62,5 @@ struct platform_device s3c_device_hsmmc3 = {
> 
>  void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
>  {
> -	struct s3c_sdhci_platdata *set = &s3c_hsmmc3_def_platdata;
> -
> -	set->cd_type = pd->cd_type;
> -	set->ext_cd_init = pd->ext_cd_init;
> -	set->ext_cd_cleanup = pd->ext_cd_cleanup;
> -	set->ext_cd_gpio = pd->ext_cd_gpio;
> -	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
> -
> -	if (pd->max_width)
> -		set->max_width = pd->max_width;
> -	if (pd->cfg_gpio)
> -		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
> -	if (pd->host_caps)
> -		set->host_caps |= pd->host_caps;
> -	if (pd->clk_type)
> -		set->clk_type = pd->clk_type;
> +	s3c_sdhci_set_platdata(pd, &s3c_hsmmc3_def_platdata);
>  }
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 058e096..20dc81c 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -86,6 +86,13 @@ struct s3c_sdhci_platdata {
>  			    struct mmc_card *card);
>  };
> 
> +/* s3c_sdhci_set_platdata() - common helper for setting SDHCI platform
data
> + * @pd: The default platform data for this device.
> + * @set: Pointer to the platform data to fill in.
> + */
> +extern void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata *pd,
> +				struct s3c_sdhci_platdata *set);
> +
>  /**
>   * s3c_sdhci0_set_platdata - Set platform data for S3C SDHCI device.
>   * @pd: Platform data to register to device.
> diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-
> samsung/platformdata.c
> index 7cf2e1e..27bec0a 100644
> --- a/arch/arm/plat-samsung/platformdata.c
> +++ b/arch/arm/plat-samsung/platformdata.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_device.h>
> 
>  #include <plat/devs.h>
> +#include <plat/sdhci.h>
> 
>  void __init *s3c_set_platdata(void *pd, size_t pdsize,
>  			      struct platform_device *pdev)
> @@ -35,3 +36,24 @@ void __init *s3c_set_platdata(void *pd, size_t pdsize,
>  	pdev->dev.platform_data = npd;
>  	return npd;
>  }
> +
> +void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata *pd,
> +			struct s3c_sdhci_platdata *set)
> +{
> +	set->cd_type = pd->cd_type;
> +	set->ext_cd_init = pd->ext_cd_init;
> +	set->ext_cd_cleanup = pd->ext_cd_cleanup;
> +	set->ext_cd_gpio = pd->ext_cd_gpio;
> +	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
> +
> +	if (pd->max_width)
> +		set->max_width = pd->max_width;
> +	if (pd->cfg_gpio)
> +		set->cfg_gpio = pd->cfg_gpio;
> +	if (pd->cfg_card)
> +		set->cfg_card = pd->cfg_card;
> +	if (pd->host_caps)
> +		set->host_caps |= pd->host_caps;
> +	if (pd->clk_type)
> +		set->clk_type = pd->clk_type;
> +}
> --
> 1.7.2.3

Banajit, OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
