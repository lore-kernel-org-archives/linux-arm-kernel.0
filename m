From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 12:43:57 -0600
Subject: [PATCH 09/10] pwm-backlight: Use an optional power supply
In-Reply-To: <1379972467-11243-10-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-10-git-send-email-treding@nvidia.com>
Message-ID: <524B17ED.1080806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 03:41 PM, Thierry Reding wrote:
> Many backlights require a power supply to work properly. This commit
> uses a power-supply regulator, if available, to power up and power down
> the panel.

I think that all backlights require a power supply, albeit the supply
may not be SW-controllable. Hence, shouldn't the regulator be mandatory
in the binding, yet the driver be defensively coded such that if one
isn't specified, the driver continues to work?

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c

> @@ -253,6 +264,16 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	pb->power_supply = devm_regulator_get_optional(&pdev->dev, "power");

... so I think that should be devm_regulator_get(), since the regulator
isn't really optional.

> +	if (IS_ERR(pb->power_supply)) {
> +		if (PTR_ERR(pb->power_supply) != -ENODEV) {
> +			ret = PTR_ERR(pb->power_supply);
> +			goto err_gpio;
> +		}
> +
> +		pb->power_supply = NULL;

If devm_regulator_get_optional() returns an error value or a valid
value, then I don't think that this driver should transmute error values
into NULL; NULL might be a perfectly valid regulator value. Related, I
think the if (pb->power_supply) tests should be replaced with if
(!IS_ERR(pb->power_supply)) instead.
