From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 14 Mar 2017 06:48:21 -0700
Subject: [PATCH v3 2/3] watchdog: s3c2410: Simplify getting driver data
In-Reply-To: <20170313190726.2988-3-krzk@kernel.org>
References: <20170313190726.2988-1-krzk@kernel.org>
 <20170313190726.2988-3-krzk@kernel.org>
Message-ID: <70c9cc8f-e527-ef4b-d003-1ef8f1bffdda@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2017 12:07 PM, Krzysztof Kozlowski wrote:
> Simplify the flow in helper function for getting the driver data by
> using of_device_get_match_data() and only one if() branch.
>
> The code should be equivalent.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 52b66bcdd1ef..0532dc93e600 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -37,6 +37,7 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
> @@ -510,14 +511,16 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>  static inline const struct s3c2410_wdt_variant *
>  s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>  {
> -	if (pdev->dev.of_node) {
> -		const struct of_device_id *match;
> -		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
> -		return (struct s3c2410_wdt_variant *)match->data;
> -	} else {
> -		return (struct s3c2410_wdt_variant *)
> -			platform_get_device_id(pdev)->driver_data;
> +	const struct s3c2410_wdt_variant *variant;
> +
> +	variant = of_device_get_match_data(&pdev->dev);
> +	if (!variant) {
> +		/* Device matched by platform_device_id */
> +		variant = (struct s3c2410_wdt_variant *)
> +			   platform_get_device_id(pdev)->driver_data;
>  	}
> +
> +	return variant;
>  }
>
>  static int s3c2410wdt_probe(struct platform_device *pdev)
>
