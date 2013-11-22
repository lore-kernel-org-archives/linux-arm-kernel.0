From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 22 Nov 2013 15:22:32 +0100
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <1385055795-24002-1-git-send-email-fabio.estevam@freescale.com>
References: <1385055795-24002-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20131122142231.GA1741@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 03:43:15PM -0200, Fabio Estevam wrote:
> Commit 22ceeee1 (pwm-backlight: Add power supply support) caused breakage on 
> boards that do not define the backlight regulator on their dts files.
> 
> Instead of making the backlight regulator mandatory, treat it as optional 
> instead, so that we do not have breakage.
> 
> This avoids the need for adding a dummy regulator on every dts file that uses 
> the pwm-backlight.

That was actually part of an earlier version of this patch. It was
rejected on the grounds that regulators really aren't optional. They are
there, but in most cases just not described in DT (most likely because
they aren't controllable and always on).

But even so, the regulator core now has functionality to return a dummy
regulator if none is specified in DT, specifically so that users don't
have to special case the handling of "optional" regulators. That should
be enough to keep all boards working even if no power-supply property
was given in the DTS. As a matter of fact it's a constellation that I
explicitly tested and found to work well.

Cc'ing Mark Brown, perhaps he can help figure out what's causing this.

Thierry

> 
> Tested on a mx6qsabresd.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  .../devicetree/bindings/video/backlight/pwm-backlight.txt |  2 +-
>  drivers/video/backlight/pwm_bl.c                          | 15 +++++++--------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> index 764db86..ed3dc3c 100644
> --- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> @@ -10,13 +10,13 @@ Required properties:
>        last value in the array represents a 100% duty cycle (brightest).
>    - default-brightness-level: the default brightness level (index into the
>        array defined by the "brightness-levels" property)
> -  - power-supply: regulator for supply voltage
>  
>  Optional properties:
>    - pwm-names: a list of names for the PWM devices specified in the
>                 "pwms" property (see PWM binding[0])
>    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>                    and disables the backlight (see GPIO binding[1])
> +  - power-supply: regulator for supply voltage
>  
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb80d68..fb3008c 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -50,9 +50,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>  	if (pb->enabled)
>  		return;
>  
> -	err = regulator_enable(pb->power_supply);
> -	if (err < 0)
> -		dev_err(pb->dev, "failed to enable power supply\n");
> +	if (!IS_ERR(pb->power_supply)) {
> +		err = regulator_enable(pb->power_supply);
> +		if (err < 0)
> +			dev_err(pb->dev, "failed to enable power supply\n");
> +	}
>  
>  	if (gpio_is_valid(pb->enable_gpio)) {
>  		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
> @@ -80,7 +82,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  			gpio_set_value(pb->enable_gpio, 0);
>  	}
>  
> -	regulator_disable(pb->power_supply);
> +	if (!IS_ERR(pb->power_supply))
> +		regulator_disable(pb->power_supply);
>  	pb->enabled = false;
>  }
>  
> @@ -283,10 +286,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	}
>  
>  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
> -	if (IS_ERR(pb->power_supply)) {
> -		ret = PTR_ERR(pb->power_supply);
> -		goto err_gpio;
> -	}
>  
>  	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
> -- 
> 1.8.1.2
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/b1a2ee3c/attachment.sig>
