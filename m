From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 23 Jun 2014 09:45:21 +0000
Subject: [PATCH 1/5] regulator: act8865: fix parsing of platform data
In-Reply-To: <1403451105-31929-2-git-send-email-b.galvani@gmail.com>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
 <1403451105-31929-2-git-send-email-b.galvani@gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A2436419D1B5CA4@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Beniamino Galvani [mailto:b.galvani at gmail.com]
> Sent: Sunday, June 22, 2014 11:32 PM
> To: Liam Girdwood; Mark Brown
> Cc: Yang, Wenyou; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell;
> Kumar Gala; Heiko Stuebner; devicetree at vger.kernel.org; linux-
> doc at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Beniamino Galvani
> Subject: [PATCH 1/5] regulator: act8865: fix parsing of platform data
> 
> The driver loops through all available regulators (ACT8865_REG_NUM) and
> accesses pdata->regulators[i].platform_data without checking the actual
> value of num_regulators in platform data, potentially causing a invalid
> memory access.
> 
> Fix this and look up the regulator init_data by id in platform data.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/regulator/act8865-regulator.c |   29 +++++++++++++++++++++----
> ----
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/act8865-regulator.c
> b/drivers/regulator/act8865-regulator.c
> index b92d7dd..fe2c038 100644
> --- a/drivers/regulator/act8865-regulator.c
> +++ b/drivers/regulator/act8865-regulator.c
> @@ -252,6 +252,22 @@ static inline int act8865_pdata_from_dt(struct
> device *dev,  }  #endif
> 
> +static struct regulator_init_data
> +*act8865_get_init_data(int id, struct act8865_platform_data *pdata) {
> +	int i;
> +
> +	if (!pdata)
> +		return NULL;
> +
> +	for (i = 0; i < pdata->num_regulators; i++) {
> +		if (pdata->regulators[i].id == id)
> +			return pdata->regulators[i].platform_data;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int act8865_pmic_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *i2c_id)  { @@ -261,7
> +277,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
>  	struct regulator_config config = { };
>  	struct act8865 *act8865;
>  	struct device_node *of_node[ACT8865_REG_NUM];
> -	int i, id;
> +	int i;
>  	int ret = -EINVAL;
>  	int error;
> 
> @@ -299,20 +315,17 @@ static int act8865_pmic_probe(struct i2c_client
> *client,
> 
>  	/* Finally register devices */
>  	for (i = 0; i < ACT8865_REG_NUM; i++) {
> -
> -		id = pdata->regulators[i].id;
> +		const struct regulator_desc *desc = &act8865_reg[i];
> 
>  		config.dev = dev;
> -		config.init_data = pdata->regulators[i].platform_data;
> +		config.init_data = act8865_get_init_data(desc->id, pdata);
>  		config.of_node = of_node[i];
>  		config.driver_data = act8865;
>  		config.regmap = act8865->regmap;
> 
> -		rdev = devm_regulator_register(&client->dev,
> &act8865_reg[i],
> -					       &config);
> +		rdev = devm_regulator_register(&client->dev, desc, &config);
>  		if (IS_ERR(rdev)) {
> -			dev_err(dev, "failed to register %s\n",
> -				act8865_reg[id].name);
> +			dev_err(dev, "failed to register %s\n", desc->name);
>  			return PTR_ERR(rdev);
>  		}
>  	}
> --
> 1.7.10.4


Tested on at91-sama5d3_xplained with ACT8865

Tested-by Wenyou.Yang <wenyou.yang@atmel.com>

Best Regards,
Wenyou Yang
