From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 May 2014 11:05:40 +0100
Subject: [PATCH v3 1/6] mfd: axp20x: add AXP221 PMIC support
In-Reply-To: <1401183535-31003-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1401183535-31003-1-git-send-email-boris.brezillon@free-electrons.com>
 <1401183535-31003-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140527100540.GJ5875@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add support for the AXP221 PMIC device to the existing AXP20x driver.
> 
> The AXP221 defines a new set of registers, power supplies and regulators,
> but most of the API is similar to the AXP20x ones.
> The AXP20x irq chip definition is reused, though some interrupts are not
> available in the AXP221.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c       | 58 +++++++++++++++++++++++++++++++++++++++++++---

Quite a difference from 237 lines, eh?

>  include/linux/mfd/axp20x.h | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index dee6539..119a7ed 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c

[...]

> @@ -190,7 +233,12 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
>  	axp20x->dev = &i2c->dev;
>  	dev_set_drvdata(axp20x->dev, axp20x);
>  
> -	axp20x->regmap = devm_regmap_init_i2c(i2c, &axp20x_regmap_config);
> +	if (axp20x->variant == AXP221_ID)
> +		axp20x->regmap = devm_regmap_init_i2c(i2c,
> +						      &axp22x_regmap_config);
> +	else
> +		axp20x->regmap = devm_regmap_init_i2c(i2c,
> +						      &axp20x_regmap_config);

Better to put these into a variable and have one instance of
devm_regmap_init_i2c() where you pass said variable as the second
parameter.

>  	if (IS_ERR(axp20x->regmap)) {
>  		ret = PTR_ERR(axp20x->regmap);
>  		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
> @@ -206,8 +254,12 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> -	ret = mfd_add_devices(axp20x->dev, -1, axp20x_cells,
> -			      ARRAY_SIZE(axp20x_cells), NULL, 0, NULL);
> +	if (axp20x->variant == AXP221_ID)
> +		ret = mfd_add_devices(axp20x->dev, -1, axp22x_cells,
> +				      ARRAY_SIZE(axp22x_cells), NULL, 0, NULL);
> +	else
> +		ret = mfd_add_devices(axp20x->dev, -1, axp20x_cells,
> +				      ARRAY_SIZE(axp20x_cells), NULL, 0, NULL);

Same here.  New variables to carry the cell structure and its size.
As the if statement is the same at the one above, you can move this
all into the first one.

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
