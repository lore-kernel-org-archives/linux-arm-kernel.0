From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 26 Oct 2011 12:28:50 +0200
Subject: [PATCH] regulator: Use regmap_read/write(), regmap_update_bits
	functions directly
In-Reply-To: <1319617556-29021-1-git-send-email-jhbird.choi@samsung.com>
References: <1319617556-29021-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <20111026102849.GA3132@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2011 at 05:25:56PM +0900, jhbird.choi at samsung.com wrote:
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

You should always copy maintainers on patches - in this case you've
dropped Liam (added and not cut any text as a result).

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> ---
>  drivers/regulator/tps65023-regulator.c |   74 +++++++++++--------------------
>  1 files changed, 26 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
> index 701a590..39f57b9 100644
> --- a/drivers/regulator/tps65023-regulator.c
> +++ b/drivers/regulator/tps65023-regulator.c
> @@ -129,48 +129,22 @@ struct tps_pmic {
>  	struct regmap *regmap;
>  };
>  
> -static int tps_65023_set_bits(struct tps_pmic *tps, u8 reg, u8 mask)
> -{
> -	return regmap_update_bits(tps->regmap, reg, mask, mask);
> -}
> -
> -static int tps_65023_clear_bits(struct tps_pmic *tps, u8 reg, u8 mask)
> -{
> -	return regmap_update_bits(tps->regmap, reg, mask, 0);
> -}
> -
> -static int tps_65023_reg_read(struct tps_pmic *tps, u8 reg)
> -{
> -	unsigned int val;
> -	int ret;
> -
> -	ret = regmap_read(tps->regmap, reg, &val);
> -
> -	if (ret != 0)
> -		return ret;
> -	else
> -		return val;
> -}
> -
> -static int tps_65023_reg_write(struct tps_pmic *tps, u8 reg, u8 val)
> -{
> -	return regmap_write(tps->regmap, reg, val);
> -}
>  
>  static int tps65023_dcdc_is_enabled(struct regulator_dev *dev)
>  {
>  	struct tps_pmic *tps = rdev_get_drvdata(dev);
>  	int data, dcdc = rdev_get_id(dev);
> +	int ret;
>  	u8 shift;
>  
>  	if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
>  		return -EINVAL;
>  
>  	shift = TPS65023_NUM_REGULATOR - dcdc;
> -	data = tps_65023_reg_read(tps, TPS65023_REG_REG_CTRL);
> +	ret = regmap_read(tps->regmap, TPS65023_REG_REG_CTRL, &data);
>  
> -	if (data < 0)
> -		return data;
> +	if (ret != 0)
> +		return ret;
>  	else
>  		return (data & 1<<shift) ? 1 : 0;
>  }
> @@ -179,16 +153,17 @@ static int tps65023_ldo_is_enabled(struct regulator_dev *dev)
>  {
>  	struct tps_pmic *tps = rdev_get_drvdata(dev);
>  	int data, ldo = rdev_get_id(dev);
> +	int ret;
>  	u8 shift;
>  
>  	if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
>  		return -EINVAL;
>  
>  	shift = (ldo == TPS65023_LDO_1 ? 1 : 2);
> -	data = tps_65023_reg_read(tps, TPS65023_REG_REG_CTRL);
> +	ret = regmap_read(tps->regmap, TPS65023_REG_REG_CTRL, &data);
>  
> -	if (data < 0)
> -		return data;
> +	if (ret != 0)
> +		return ret;
>  	else
>  		return (data & 1<<shift) ? 1 : 0;
>  }
> @@ -203,7 +178,7 @@ static int tps65023_dcdc_enable(struct regulator_dev *dev)
>  		return -EINVAL;
>  
>  	shift = TPS65023_NUM_REGULATOR - dcdc;
> -	return tps_65023_set_bits(tps, TPS65023_REG_REG_CTRL, 1 << shift);
> +	return regmap_update_bits(tps->regmap, TPS65023_REG_REG_CTRL, 1 << shift, 1 << shift);
>  }
>  
>  static int tps65023_dcdc_disable(struct regulator_dev *dev)
> @@ -216,7 +191,7 @@ static int tps65023_dcdc_disable(struct regulator_dev *dev)
>  		return -EINVAL;
>  
>  	shift = TPS65023_NUM_REGULATOR - dcdc;
> -	return tps_65023_clear_bits(tps, TPS65023_REG_REG_CTRL, 1 << shift);
> +	return regmap_update_bits(tps->regmap, TPS65023_REG_REG_CTRL, 1 << shift, 0);
>  }
>  
>  static int tps65023_ldo_enable(struct regulator_dev *dev)
> @@ -229,7 +204,7 @@ static int tps65023_ldo_enable(struct regulator_dev *dev)
>  		return -EINVAL;
>  
>  	shift = (ldo == TPS65023_LDO_1 ? 1 : 2);
> -	return tps_65023_set_bits(tps, TPS65023_REG_REG_CTRL, 1 << shift);
> +	return regmap_update_bits(tps->regmap, TPS65023_REG_REG_CTRL, 1 << shift, 1 << shift);
>  }
>  
>  static int tps65023_ldo_disable(struct regulator_dev *dev)
> @@ -242,21 +217,22 @@ static int tps65023_ldo_disable(struct regulator_dev *dev)
>  		return -EINVAL;
>  
>  	shift = (ldo == TPS65023_LDO_1 ? 1 : 2);
> -	return tps_65023_clear_bits(tps, TPS65023_REG_REG_CTRL, 1 << shift);
> +	return regmap_update_bits(tps->regmap, TPS65023_REG_REG_CTRL, 1 << shift, 0);
>  }
>  
>  static int tps65023_dcdc_get_voltage(struct regulator_dev *dev)
>  {
>  	struct tps_pmic *tps = rdev_get_drvdata(dev);
> +	int ret;
>  	int data, dcdc = rdev_get_id(dev);
>  
>  	if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
>  		return -EINVAL;
>  
>  	if (dcdc == TPS65023_DCDC_1) {
> -		data = tps_65023_reg_read(tps, TPS65023_REG_DEF_CORE);
> -		if (data < 0)
> -			return data;
> +		ret = regmap_read(tps->regmap, TPS65023_REG_DEF_CORE, &data);
> +		if (ret != 0)
> +			return ret;
>  		data &= (tps->info[dcdc]->table_len - 1);
>  		return tps->info[dcdc]->table[data] * 1000;
>  	} else
> @@ -296,20 +272,21 @@ static int tps65023_dcdc_set_voltage(struct regulator_dev *dev,
>  	if (vsel == tps->info[dcdc]->table_len)
>  		return -EINVAL;
>  	else
> -		return tps_65023_reg_write(tps, TPS65023_REG_DEF_CORE, vsel);
> +		return regmap_write(tps->regmap, TPS65023_REG_DEF_CORE, vsel);
>  }
>  
>  static int tps65023_ldo_get_voltage(struct regulator_dev *dev)
>  {
>  	struct tps_pmic *tps = rdev_get_drvdata(dev);
>  	int data, ldo = rdev_get_id(dev);
> +	int ret;
>  
>  	if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
>  		return -EINVAL;
>  
> -	data = tps_65023_reg_read(tps, TPS65023_REG_LDO_CTRL);
> -	if (data < 0)
> -		return data;
> +	ret = regmap_read(tps->regmap, TPS65023_REG_LDO_CTRL, &data);
> +	if (ret != 0)
> +		return ret;
>  
>  	data >>= (TPS65023_LDO_CTRL_LDOx_SHIFT(ldo - TPS65023_LDO_1));
>  	data &= (tps->info[ldo]->table_len - 1);
> @@ -321,6 +298,7 @@ static int tps65023_ldo_set_voltage(struct regulator_dev *dev,
>  {
>  	struct tps_pmic *tps = rdev_get_drvdata(dev);
>  	int data, vsel, ldo = rdev_get_id(dev);
> +	int ret;
>  
>  	if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
>  		return -EINVAL;
> @@ -344,13 +322,13 @@ static int tps65023_ldo_set_voltage(struct regulator_dev *dev,
>  
>  	*selector = vsel;
>  
> -	data = tps_65023_reg_read(tps, TPS65023_REG_LDO_CTRL);
> -	if (data < 0)
> -		return data;
> +	ret = regmap_read(tps->regmap, TPS65023_REG_LDO_CTRL, &data);
> +	if (ret != 0)
> +		return ret;
>  
>  	data &= TPS65023_LDO_CTRL_LDOx_MASK(ldo - TPS65023_LDO_1);
>  	data |= (vsel << (TPS65023_LDO_CTRL_LDOx_SHIFT(ldo - TPS65023_LDO_1)));
> -	return tps_65023_reg_write(tps, TPS65023_REG_LDO_CTRL, data);
> +	return regmap_write(tps->regmap, TPS65023_REG_LDO_CTRL, data);
>  }
>  
>  static int tps65023_dcdc_list_voltage(struct regulator_dev *dev,
> -- 
> 1.7.1
> 
