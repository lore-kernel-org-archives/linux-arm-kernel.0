From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Oct 2014 16:53:33 +0200
Subject: [PATCH v2 2/4] regulator: Set ena_gpio_initialized in regulator
 drivers
In-Reply-To: <1412776028-15655-3-git-send-email-mpa@pengutronix.de>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
 <1412776028-15655-3-git-send-email-mpa@pengutronix.de>
Message-ID: <1412780013.31093.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-10-08 at 15:47 +0200, Markus Pargmann wrote:
> This patch sets ena_gpio_initialized for all drivers which set a
> ena_gpio from parsed DT properties. Drivers using pdata may get zero
> initialized pdata and therefore copy a 0 into the regulator_config
> ena_gpio field.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

(... rewind to s2m/s5m... I think Mark asked for splitting this per
driver)

> diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
> index adab82d5279f..49b9e1ddc87e 100644
> --- a/drivers/regulator/s2mps11.c
> +++ b/drivers/regulator/s2mps11.c
> @@ -897,6 +897,7 @@ common_reg:
>  			config.of_node = rdata[i].of_node;
>  		}
>  		config.ena_gpio = s2mps11->ext_control_gpio[i];
> +		config.ena_gpio_initialized = true;
>  
>  		regulator = devm_regulator_register(&pdev->dev,
>  						&regulators[i], &config);

Looks good.

> diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
> index 0ab5cbeeb797..7f176cdb7e37 100644
> --- a/drivers/regulator/s5m8767.c
> +++ b/drivers/regulator/s5m8767.c
> @@ -466,6 +466,7 @@ static void s5m8767_regulator_config_ext_control(struct s5m8767_info *s5m8767,
>  	}
>  
>  	config->ena_gpio = rdata->ext_control_gpio;
> +	config->ena_gpio_initialized = true;
>  	config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
>  }

It will work fine but a little messy. The 'config' is re-used in loop
for next regulators, so:
1. regulator X with GPIO=-ENODEV, ena_gpio_initialized=false
2. regulator X+1 with real GPIO, ena_gpio_initialized=true
3. regulator X+2 with GPIO=-ENODEV, ena_gpio_initialized=true


Instead do this in probe around line 950:
 config.ena_gpio = -EINVAL;
 config.ena_gpio_flags = 0;
+config->ena_gpio_initialized = true;
 if (gpio_is_valid(pdata->regulators[i].ext_control_gpio))
 	s5m8767_regulator_config_ext_control(s5m8767,
 			&pdata->regulators[i], &config);


Best regards,
Krzysztof
