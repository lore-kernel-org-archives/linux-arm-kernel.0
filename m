From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 30 Oct 2014 12:42:10 +0100
Subject: [RFT v3 05/14] regulator: max77802: Don't ignore return value
 of current opmode
In-Reply-To: <1414668053-31370-6-git-send-email-k.kozlowski@samsung.com>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54522412.1070808@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/30/2014 12:20 PM, Krzysztof Kozlowski wrote:
> The return value of regmap_read() of current opmode for regulator was
> silently ignored and whatever happened to be in 'val' variable was used
> as new opmode. This could lead to using bogus opmode.
> 
> Don't ignore what regmap_read() returns. If it fails just fall back to
> normal opmode.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/regulator/max77802.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/max77802.c b/drivers/regulator/max77802.c
> index b9958d927297..60daca2028e9 100644
> --- a/drivers/regulator/max77802.c
> +++ b/drivers/regulator/max77802.c
> @@ -606,7 +606,13 @@ static int max77802_pmic_probe(struct platform_device *pdev)
>  		config.of_node = pdata->regulators[i].of_node;
>  
>  		ret = regmap_read(iodev->regmap, regulators[i].enable_reg, &val);
> -		val = val >> shift & MAX77802_OPMODE_MASK;
> +		if (ret < 0) {
> +			dev_warn(&pdev->dev,
> +				"cannot read current mode for %d\n", i);
> +			val = MAX77802_OPMODE_NORMAL;
> +		} else {
> +			val = val >> shift & MAX77802_OPMODE_MASK;
> +		}
>  
>  		/*
>  		 * If the regulator is disabled and the system warm rebooted,
> 

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
