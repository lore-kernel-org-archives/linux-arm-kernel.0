From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 20:59:59 -0600
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F67F2AF.3020404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 09:56 AM, Thierry Reding wrote:
> This commit adds very basic support for device tree probing. Currently,
> only a PWM and a list of distinct brightness levels can be specified.
> Enabling or disabling backlight power via GPIOs is not yet supported.
> 
> A pointer to the exit() callback is stored in the driver data to keep it
> around until the driver is unloaded.

> +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight

> +pwm-backlight bindings
> +
> +Required properties:
> +  - compatible: "pwm-backlight"
> +  - pwm: OF device-tree PWM specification
> +  - num-brightness-levels: number of distinct brightness levels
> +  - brightness-levels: array of distinct brightness levels

I assume the values in this array are 0 (darkest/off) to 255 (max
brightness)? The doc should probably specify this.

> +  - default-brightness-level: the default brightness level

Likewise, this is an index into the default-brightness-level? Again,
it'd be best to explicitly state this.

...
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;


> +static int pwm_backlight_parse_dt(struct device *dev,
> +				  struct platform_pwm_backlight_data *data)
...
> +		ret = of_property_read_u32(node, "default-brightness-level",
> +					   &value);
> +		if (ret < 0)
> +			goto free;

Range-check that against max_brightness?

>  static int pwm_backlight_probe(struct platform_device *pdev)
...
> -	pb->pwm = pwm_request(data->pwm_id, "backlight");
> -	if (IS_ERR(pb->pwm)) {
> -		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
> -		ret = PTR_ERR(pb->pwm);
> -		goto err_alloc;
> -	} else
> -		dev_dbg(&pdev->dev, "got pwm for backlight\n");
> +	if (!pb->pwm) {
> +		pb->pwm = pwm_request(data->pwm_id, "backlight");
> +		if (IS_ERR(pb->pwm)) {
> +			dev_err(&pdev->dev, "unable to request PWM for backlight\n");
> +			ret = PTR_ERR(pb->pwm);
> +			goto err_alloc;
> +		} else
> +			dev_dbg(&pdev->dev, "got pwm for backlight\n");
> +	}

Hmmm. It'd be more consistent if pwm_backlight_parse_dt() called
something like of_pwm_get() instead of of_pwm_request(), so that this
code could always call pwm_request() on the PWM and hence operate the
same irrespective of DT vs non-DT. GPIOs work that way at least.
