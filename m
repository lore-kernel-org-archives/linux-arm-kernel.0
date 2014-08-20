From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Aug 2014 12:04:49 +0200
Subject: [PATCH v3 2/4] pwm: rockchip: Allow polarity invert on rk3288
In-Reply-To: <1408464476-28316-3-git-send-email-dianders@chromium.org>
References: <1408464476-28316-1-git-send-email-dianders@chromium.org>
 <1408464476-28316-3-git-send-email-dianders@chromium.org>
Message-ID: <20140820100447.GG15414@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 09:07:54AM -0700, Doug Anderson wrote:
> The rk3288 has the ability to invert the polarity of the PWM.  Let's
> enable that ability.
> 
> To do this we increase the number of pwm_cells to 3 to allow using the
> PWM_POLARITY_INVERTED flag.  Since the PWM driver on rk3288 is very
> new, I thought this was OK.

I don't see any files in arch/arm/boot/dts using either of the
rockchip,vop-pwm or rockchip,rk3288-pwm compatible strings, so there's
no reason to consider this stable ABI yet. As far as I'm concerned the
last sentence can just as well be dropped.

Besides, patches have been posted to support #pwm-cells = <2> and
#pwm-cells = <3> at the same time which should give you backwards-
compatibility for free.

A couple more comments inline.

> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
[...]
> +int rockchip_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      enum pwm_polarity polarity)

This should be static.

> +{
> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> +
> +	if (!pc->data->has_invert)
> +		return -ENOSYS;
> +
> +	/*
> +	 * No action needed here because pwm->polarity will be set by the core
> +	 * and the core will only change polarity when the PWM is not enabled.
> +	 * We'll handle things in set_enable().
> +	 */
> +
> +	return 0;
> +}

An alternative here would be to provide a separate pwm_ops with
.set_polarity = NULL for the versions of the IP block that don't support
polarity inversion yet, but this works for me too.

> @@ -173,6 +201,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
>  		.ctrl = 0x0c,
>  	},
>  	.prescaler = 1,
> +	.has_invert = true,
>  	.set_enable = rockchip_pwm_set_enable_v2,
>  };
>  
> @@ -184,6 +213,7 @@ static const struct rockchip_pwm_data pwm_data_vop = {
>  		.ctrl = 0x00,
>  	},
>  	.prescaler = 1,
> +	.has_invert = true,
>  	.set_enable = rockchip_pwm_set_enable_v2,
>  };

Can you please add a '.has_invert = false,' line to pwm_data_v1? I know
it's not strictly necessary but I like it when things are explicitly
stated.

>  
> @@ -230,6 +260,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  	pc->chip.ops = &rockchip_pwm_ops;
>  	pc->chip.base = -1;
>  	pc->chip.npwm = 1;
> +	if (pc->data->has_invert) {

There should be a blank line between the above two.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/ee85c7ef/attachment.sig>
