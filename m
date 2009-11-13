From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Fri, 13 Nov 2009 10:58:23 +0000
Subject: [PATCH 10/10] regulator: refresh 88pm8607 driver with updated api
In-Reply-To: <771cded00911130106t64b72ffdn1911dc2940cee7e2@mail.gmail.com>
References: <771cded00911130106t64b72ffdn1911dc2940cee7e2@mail.gmail.com>
Message-ID: <1258109903.3586.9.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-11-13 at 04:06 -0500, Haojian Zhuang wrote:
> >From 8fb032bd84d98409e78700bd1427d9506a44c602 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 9 Nov 2009 12:48:23 -0500
> Subject: [PATCH] regulator: refresh 88pm8607 driver with updated api
> 
> Since i2c API of mfd 88pm860x driver is changed, refresh 88pm8607 driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/regulator/88pm8607.c |   34 ++++++++++++++++++----------------
>  drivers/regulator/Kconfig    |    2 +-
>  2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
> index 0471955..aad829f 100644
> --- a/drivers/regulator/88pm8607.c
> +++ b/drivers/regulator/88pm8607.c
> @@ -14,11 +14,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
> -#include <linux/mfd/88pm8607.h>
> +#include <linux/mfd/88pm860x.h>
> 
>  struct pm8607_regulator_info {
>  	struct regulator_desc	desc;
> -	struct pm8607_chip	*chip;
> +	struct pm860x_chip	*chip;	/* real chip device */
>  	struct regulator_dev	*regulator;
> 
>  	int	min_uV;
> @@ -428,7 +428,7 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
>  			      int min_uV, int max_uV)
>  {
>  	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
> -	struct pm8607_chip *chip = info->chip;
> +	struct pm860x_chip *chip = info->chip;
>  	uint8_t val, mask;
>  	int ret;
> 
> @@ -443,13 +443,15 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
>  	val = (uint8_t)(ret << info->vol_shift);
>  	mask = ((1 << info->vol_nbits) - 1)  << info->vol_shift;
> 
> -	ret = pm8607_set_bits(chip, info->vol_reg, mask, val);
> +	ret = pm860x_set_bits(chip->parent, DESC_8607, info->vol_reg,
> +			      mask, val);
>  	if (ret)
>  		return ret;
>  	switch (info->desc.id) {
>  	case PM8607_ID_BUCK1:
>  	case PM8607_ID_BUCK3:
> -		ret = pm8607_set_bits(chip, info->update_reg,
> +		ret = pm860x_set_bits(chip->parent, DESC_8607,
> +				      info->update_reg,
>  				      1 << info->update_bit,
>  				      1 << info->update_bit);


Would it not be better if the chip struct contained the chip type. This
would save you having to pass in this extra DESC_8607 parameter and imho
looks neater.


Liam
