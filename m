From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Tue, 07 Oct 2014 10:46:27 +0200
Subject: [PATCH 2/5] regulator: Set ena_gpio_valid in regulator drivers
In-Reply-To: <1412626635-7404-3-git-send-email-mpa@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-3-git-send-email-mpa@pengutronix.de>
Message-ID: <5433A863.1040206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.10.2014 22:17, Markus Pargmann wrote:
> This patch sets the new field ena_gpio_valid for all drivers which set a
> valid ena_gpio.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---

(... looking only on s2m/s5m drivers)

> diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
> index b16c53a8272f..4d78477b9f57 100644
> --- a/drivers/regulator/s2mps11.c
> +++ b/drivers/regulator/s2mps11.c
> @@ -986,6 +986,7 @@ common_reg:
>   			config.of_node = rdata[i].of_node;
>   		}
>   		config.ena_gpio = s2mps11->ext_control_gpio[i];
> +		config.ena_gpio_valid = true;

This way you'll mark all regulators as GPIO enabled. This is won't 
produce an error (ena_gpio is initialized to -EINVAL by default) but I 
think it is misuse of the idea "ena_gpio_valid".

Instead maybe:
+		if (gpio_is_valid(s2mps11->ext_control_gpio[i]))
+			config.ena_gpio_valid = true;
?

>
>   		regulator = devm_regulator_register(&pdev->dev,
>   						&regulators[i], &config);
> diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
> index 0ab5cbeeb797..d258e6613831 100644
> --- a/drivers/regulator/s5m8767.c
> +++ b/drivers/regulator/s5m8767.c
> @@ -466,6 +466,7 @@ static void s5m8767_regulator_config_ext_control(struct s5m8767_info *s5m8767,
>   	}
>
>   	config->ena_gpio = rdata->ext_control_gpio;
> +	config->ena_gpio_valid = true;
>   	config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
>   }

This looks fine.

Best regards,
Krzysztof
