From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 5 Jun 2017 09:24:06 +0100
Subject: [PATCH v3 2/6] mfd: hi6421-pmic: add support for HiSilicon
 Hi6421v530
In-Reply-To: <20170602105156.11351-3-guodong.xu@linaro.org>
References: <20170602105156.11351-1-guodong.xu@linaro.org>
 <20170602105156.11351-3-guodong.xu@linaro.org>
Message-ID: <20170605082406.nbeu3qhfyxsjoqq3@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Jun 2017, Guodong Xu wrote:

> Add support for HiSilicon Hi6421v530 PMIC. Hi6421v530 communicates with
> main SoC via memory-mapped I/O.
> 
> Hi6421v530 and Hi6421 are PMIC chips from the same vendor, HiSilicon,
> but at different revisions. They share the same memory-mapped I/O
> design. They differ in integrated devices, such as regulator details,
> LDO voltage points.
> 
> Also, changed license to a shorter form, and arranged all #include in
> alphabetical order.
> 
> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  drivers/mfd/hi6421-pmic-core.c  | 85 +++++++++++++++++++++++++----------------
>  include/linux/mfd/hi6421-pmic.h |  5 +++
>  2 files changed, 58 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
> index 3fd703f..b914541 100644
> --- a/drivers/mfd/hi6421-pmic-core.c
> +++ b/drivers/mfd/hi6421-pmic-core.c
> @@ -1,40 +1,35 @@
>  /*
> - * Device driver for Hi6421 IC
> + * Device driver for Hi6421 PMIC
>   *
>   * Copyright (c) <2011-2014> HiSilicon Technologies Co., Ltd.
>   *              http://www.hisilicon.com
> - * Copyright (c) <2013-2014> Linaro Ltd.
> + * Copyright (c) <2013-2017> Linaro Ltd.
>   *              http://www.linaro.org
>   *
>   * Author: Guodong Xu <guodong.xu@linaro.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Nice change, but this should be a separate patch.

>   */
>  
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/mfd/core.h>
> +#include <linux/mfd/hi6421-pmic.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/mfd/hi6421-pmic.h>
>  
>  static const struct mfd_cell hi6421_devs[] = {
>  	{ .name = "hi6421-regulator", },
>  };
>  
> +static const struct mfd_cell hi6421v530_devs[] = {
> +	{ .name = "hi6421v530-regulator", },
> +};
> +
>  static const struct regmap_config hi6421_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
> @@ -42,12 +37,30 @@ static const struct regmap_config hi6421_regmap_config = {
>  	.max_register = HI6421_REG_TO_BUS_ADDR(HI6421_REG_MAX),
>  };
>  
> +static const struct of_device_id of_hi6421_pmic_match[] = {
> +	{ .compatible = "hisilicon,hi6421-pmic",
> +					.data = (void *)HI6421 },
> +	{ .compatible = "hisilicon,hi6421v530-pmic",
> +					.data = (void *)HI6421_V530 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_hi6421_pmic_match);

This formatting is odd.  If both attributes won't fit on a single
line, please place them on completely separate lines.  This includes
the braces.  Something like this:

	{
		.compatible = "hisilicon,hi6421-pmic",
		.data = (void *)HI6421
	}, {
		.compatible = "hisilicon,hi6421v530-pmic",
		.data = (void *)HI6421_V530 },
	{ },

>  static int hi6421_pmic_probe(struct platform_device *pdev)
>  {
>  	struct hi6421_pmic *pmic;
>  	struct resource *res;
>  	void __iomem *base;
> -	int ret;
> +	const struct of_device_id *id;
> +	unsigned long type;
> +	const struct mfd_cell *subdevs = NULL;
> +	int n_subdevs, ret;

Better to reorganise this a little.  I tend to have the complex data
types at the top running down to simple 'int' types at the bottom.

> +	id = of_match_device(of_hi6421_pmic_match, &pdev->dev);
> +	if (id)
> +		type = (unsigned long)id->data;
> +	else
> +		return -EINVAL;

Place "!id" in the if statement, then you can drop the else.

>  	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
>  	if (!pmic)
> @@ -61,41 +74,49 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
>  	pmic->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
>  						 &hi6421_regmap_config);
>  	if (IS_ERR(pmic->regmap)) {
> -		dev_err(&pdev->dev,
> -			"regmap init failed: %ld\n", PTR_ERR(pmic->regmap));
> +		dev_err(&pdev->dev, "Failed to initialise Regmap: %ld\n",
> +							PTR_ERR(pmic->regmap));

Separate patch.

>  		return PTR_ERR(pmic->regmap);
>  	}
>  
> -	/* set over-current protection debounce 8ms */
> -	regmap_update_bits(pmic->regmap, HI6421_OCP_DEB_CTRL_REG,
> +	platform_set_drvdata(pdev, pmic);
> +
> +	switch (type) {
> +	case HI6421:
> +		/* set over-current protection debounce 8ms */
> +		regmap_update_bits(pmic->regmap, HI6421_OCP_DEB_CTRL_REG,
>  				(HI6421_OCP_DEB_SEL_MASK
>  				 | HI6421_OCP_EN_DEBOUNCE_MASK
>  				 | HI6421_OCP_AUTO_STOP_MASK),
>  				(HI6421_OCP_DEB_SEL_8MS
>  				 | HI6421_OCP_EN_DEBOUNCE_ENABLE));
>  
> -	platform_set_drvdata(pdev, pmic);
> +		subdevs = hi6421_devs;
> +		n_subdevs = ARRAY_SIZE(hi6421_devs);
> +		break;
> +	case HI6421_V530:
> +		subdevs = hi6421v530_devs;
> +		n_subdevs = ARRAY_SIZE(hi6421v530_devs);
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Unknown device type %ld\n", type);
> +		return -EINVAL;
> +	}
>  
> -	ret = devm_mfd_add_devices(&pdev->dev, 0, hi6421_devs,
> -				   ARRAY_SIZE(hi6421_devs), NULL, 0, NULL);
> +	ret = devm_mfd_add_devices(&pdev->dev, 0, subdevs,

Use the proper defines, not '0'.

> +				   n_subdevs, NULL, 0, NULL);
>  	if (ret) {
> -		dev_err(&pdev->dev, "add mfd devices failed: %d\n", ret);
> +		dev_err(&pdev->dev, "Failed to add child devices: %d\n", ret);

This needs to be grouped with the other error message change above.

>  		return ret;
>  	}
>  
>  	return 0;
>  }
>  
> -static const struct of_device_id of_hi6421_pmic_match_tbl[] = {
> -	{ .compatible = "hisilicon,hi6421-pmic", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, of_hi6421_pmic_match_tbl);
> -
>  static struct platform_driver hi6421_pmic_driver = {
>  	.driver = {
> -		.name	= "hi6421_pmic",
> -		.of_match_table = of_hi6421_pmic_match_tbl,
> +		.name = "hi6421_pmic",
> +		.of_match_table = of_hi6421_pmic_match,
>  	},
>  	.probe	= hi6421_pmic_probe,
>  };
> diff --git a/include/linux/mfd/hi6421-pmic.h b/include/linux/mfd/hi6421-pmic.h
> index 587273e..2457438 100644
> --- a/include/linux/mfd/hi6421-pmic.h
> +++ b/include/linux/mfd/hi6421-pmic.h
> @@ -38,4 +38,9 @@ struct hi6421_pmic {
>  	struct regmap		*regmap;
>  };
>  
> +enum hi6421_type {
> +	HI6421      = 1,
> +	HI6421_V530 = 2,

Why 1 and 2?

> +};
> +
>  #endif		/* __HI6421_PMIC_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
