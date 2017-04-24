From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Apr 2017 12:50:09 +0100
Subject: [PATCH 2/7] regulator: arizona-micsupp: Move pdata into a
 separate structure
In-Reply-To: <1492512234-19210-4-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1492512234-19210-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1492512234-19210-4-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <20170424115009.ggzpw7odlsyg7per@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Apr 2017, Richard Fitzgerald wrote:

> In preparation for sharing this driver with Madera, move the pdata
> for the micsupp regulator out of struct arizona_pdata into a dedicated
> pdata struct for this driver. As a result the code in
> arizona_micsupp_of_get_pdata() can be made independent of struct arizona.
> 
> This patch also updates the definition of struct arizona_pdata and
> the use of this pdata in mach-crag6410-module.c
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  MAINTAINERS                               |  1 +
>  drivers/regulator/arizona-micsupp.c       | 21 +++++++++++----------

>  include/linux/mfd/arizona/pdata.h         |  3 ++-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  include/linux/regulator/arizona-micsupp.h | 21 +++++++++++++++++++++
>  4 files changed, 35 insertions(+), 11 deletions(-)
>  create mode 100644 include/linux/regulator/arizona-micsupp.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c35e0ce..6ed8ef1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13623,6 +13623,7 @@ F:	include/linux/mfd/arizona/
>  F:	include/linux/mfd/wm831x/
>  F:	include/linux/mfd/wm8350/
>  F:	include/linux/mfd/wm8400*
> +F:	include/linux/regulator/arizona*
>  F:	include/linux/wm97xx.h
>  F:	include/sound/wm????.h
>  F:	sound/soc/codecs/arizona.?
> diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
> index 5e38861..5f8b5a7 100644
> --- a/drivers/regulator/arizona-micsupp.c
> +++ b/drivers/regulator/arizona-micsupp.c
> @@ -30,6 +30,8 @@
>  #include <linux/mfd/arizona/pdata.h>
>  #include <linux/mfd/arizona/registers.h>
>  
> +#include <linux/regulator/arizona-micsupp.h>
> +
>  struct arizona_micsupp {
>  	struct regulator_dev *regulator;
>  	struct arizona *arizona;
> @@ -199,28 +201,26 @@ static int arizona_micsupp_set_bypass(struct regulator_dev *rdev, bool ena)
>  	.num_consumer_supplies = 1,
>  };
>  
> -static int arizona_micsupp_of_get_pdata(struct device *dev,
> -					struct arizona *arizona,
> +static int arizona_micsupp_of_get_pdata(struct arizona_micsupp_pdata *pdata,
>  					struct regulator_config *config,
>  					const struct regulator_desc *desc)
>  {
> -	struct arizona_pdata *pdata = &arizona->pdata;
>  	struct arizona_micsupp *micsupp = config->driver_data;
>  	struct device_node *np;
>  	struct regulator_init_data *init_data;
>  
> -	np = of_get_child_by_name(arizona->dev->of_node, "micvdd");
> +	np = of_get_child_by_name(config->dev->of_node, "micvdd");
>  
>  	if (np) {
>  		config->of_node = np;
>  
> -		init_data = of_get_regulator_init_data(dev, np, desc);
> +		init_data = of_get_regulator_init_data(config->dev, np, desc);
>  
>  		if (init_data) {
>  			init_data->consumer_supplies = &micsupp->supply;
>  			init_data->num_consumer_supplies = 1;
>  
> -			pdata->micvdd = init_data;
> +			pdata->init_data = init_data;
>  		}
>  	}
>  
> @@ -232,6 +232,7 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
>  	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
>  	const struct regulator_desc *desc;
>  	struct regulator_config config = { };
> +	struct arizona_micsupp_pdata *pdata = &arizona->pdata.micvdd;
>  	struct arizona_micsupp *micsupp;
>  	int ret;
>  
> @@ -269,15 +270,15 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
>  
>  	if (IS_ENABLED(CONFIG_OF)) {
>  		if (!dev_get_platdata(arizona->dev)) {
> -			ret = arizona_micsupp_of_get_pdata(&pdev->dev, arizona,
> -							   &config, desc);
> +			ret = arizona_micsupp_of_get_pdata(pdata, &config,
> +							   desc);
>  			if (ret < 0)
>  				return ret;
>  		}
>  	}
>  
> -	if (arizona->pdata.micvdd)
> -		config.init_data = arizona->pdata.micvdd;
> +	if (pdata->init_data)
> +		config.init_data = pdata->init_data;
>  	else
>  		config.init_data = &micsupp->init_data;
>  
> diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
> index 64faeef..43e875f 100644
> --- a/include/linux/mfd/arizona/pdata.h
> +++ b/include/linux/mfd/arizona/pdata.h
> @@ -12,6 +12,7 @@
>  #define _ARIZONA_PDATA_H
>  
>  #include <dt-bindings/mfd/arizona.h>
> +#include <linux/regulator/arizona-micsupp.h>
>  
>  #define ARIZONA_GPN_DIR_MASK                     0x8000  /* GPN_DIR */
>  #define ARIZONA_GPN_DIR_SHIFT                        15  /* GPN_DIR */
> @@ -79,7 +80,7 @@ struct arizona_pdata {
>  	int ldoena;     /** GPIO controlling LODENA, if any */
>  
>  	/** Regulator configuration for MICVDD */
> -	struct regulator_init_data *micvdd;
> +	struct arizona_micsupp_pdata micvdd;
>  
>  	/** Regulator configuration for LDO1 */
>  	struct regulator_init_data *ldo1;
> diff --git a/include/linux/regulator/arizona-micsupp.h b/include/linux/regulator/arizona-micsupp.h
> new file mode 100644
> index 0000000..6168426
> --- /dev/null
> +++ b/include/linux/regulator/arizona-micsupp.h
> @@ -0,0 +1,21 @@
> +/*
> + * Platform data for Arizona micsupp regulator
> + *
> + * Copyright 2017 Cirrus Logic
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef ARIZONA_MICSUPP_H
> +#define ARIZONA_MICSUPP_H
> +
> +struct regulator_init_data;
> +
> +struct arizona_micsupp_pdata {
> +	/** Regulator configuration for micsupp */
> +	const struct regulator_init_data *init_data;
> +};
> +
> +#endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
