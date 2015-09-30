From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 30 Sep 2015 15:21:07 +0200
Subject: [PATCH v2 1/2] regulator: act8865: support output voltage by
 VSET2[] bits
In-Reply-To: <1443597950-27849-2-git-send-email-wenyou.yang@atmel.com>
References: <1443597950-27849-1-git-send-email-wenyou.yang@atmel.com>
 <1443597950-27849-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150930132107.GH31199@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

I see nothing wrong in it.

On Wed, Sep 30, 2015 at 03:25:49PM +0800, Wenyou Yang wrote:
> For the step-down DC/DC regulators, the output voltage is
> selectable by setting VSEL pin that when VSEL is low, output
> voltage is programmed by VSET1[] bits, and when VSEL is high,
> output voltage is programmed by VSET2[] bits.
> 
> The DT property "active-semi,vsel-high" is used to specify
> the VSEL pin at high on the board.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Minor comment below, it's only my point of view.

Anyway, Reviewed-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
> 
> Changes in v2:
>  - fix missed argument of macro "ACT88xx_REG" for act8865_alt_regulators
>    structure variable.
>  - set variable "voltage_select" initial value to avoid compile warning.
> 
>  drivers/regulator/act8865-regulator.c |   24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
> index 896db16..f8d4cd3 100644
> --- a/drivers/regulator/act8865-regulator.c
> +++ b/drivers/regulator/act8865-regulator.c
> @@ -261,6 +261,16 @@ static const struct regulator_desc act8865_regulators[] = {
>  	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
>  };
>  
> +static const struct regulator_desc act8865_alt_regulators[] = {
> +	ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET2, "vp1"),
> +	ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET2, "vp2"),
> +	ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET2, "vp3"),
> +	ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET, "inl45"),
> +	ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET, "inl45"),
> +	ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET, "inl67"),
> +	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
> +};
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id act8865_dt_ids[] = {
>  	{ .compatible = "active-semi,act8600", .data = (void *)ACT8600 },
> @@ -413,6 +423,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
>  	struct act8865 *act8865;
>  	unsigned long type;
>  	int off_reg, off_mask;
> +	int voltage_select = 0;

I think adding this variable is useless...

>  
>  	pdata = dev_get_platdata(dev);
>  
> @@ -424,6 +435,10 @@ static int act8865_pmic_probe(struct i2c_client *client,
>  			return -ENODEV;
>  
>  		type = (unsigned long) id->data;
> +
> +		voltage_select = !!of_get_property(dev->of_node,
> +						   "active-semi,vsel-high",
> +						   NULL);
>  	} else {
>  		type = i2c_id->driver_data;
>  	}
> @@ -442,8 +457,13 @@ static int act8865_pmic_probe(struct i2c_client *client,
>  		off_mask = ACT8846_OFF_SYSMASK;
>  		break;
>  	case ACT8865:
> -		regulators = act8865_regulators;
> -		num_regulators = ARRAY_SIZE(act8865_regulators);
> +		if (voltage_select) {

I would directly do

if (of_get_property(dev->of_node, "active-semi,vsel-high", NULL) {

> +			regulators = act8865_alt_regulators;
> +			num_regulators = ARRAY_SIZE(act8865_alt_regulators);
> +		} else {
> +			regulators = act8865_regulators;
> +			num_regulators = ARRAY_SIZE(act8865_regulators);
> +		}
>  		off_reg = ACT8865_SYS_CTRL;
>  		off_mask = ACT8865_MSTROFF;
>  		break;
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
