From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 19 Aug 2014 09:18:58 +0200
Subject: [PATCH 2/4] pwm: rockchip: Allow polarity invert on rk3288
In-Reply-To: <1408381749-14156-3-git-send-email-dianders@chromium.org>
References: <1408381749-14156-1-git-send-email-dianders@chromium.org>
 <1408381749-14156-3-git-send-email-dianders@chromium.org>
Message-ID: <20140819071857.GD12859@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:09:07AM -0700, Doug Anderson wrote:
[...]
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
>  #define PWM_LP_DISABLE		(0 << 8)
>  
> @@ -32,6 +34,7 @@ struct rockchip_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	const struct rockchip_pwm_data *data;
> +	enum pwm_polarity polarity;

Why do you need this field? struct pwm_device already has a copy of it.

> @@ -74,10 +78,14 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
>  {
>  	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>  	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
> -			  PWM_CONTINUOUS | PWM_DUTY_POSITIVE |
> -			  PWM_INACTIVE_NEGATIVE;
> +			  PWM_CONTINUOUS;
>  	u32 val;
>  
> +	if (pc->polarity == PWM_POLARITY_INVERSED)
> +		enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> +	else
> +		enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;

I have a feeling you're going to answer the above question with: "Because
it's needed here". If so, my reply would be: "Then this function should
take a struct pwm_device instead of struct pwm_chip."

> @@ -173,6 +195,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
>  		.ctrl = 0x0c,
>  	},
>  	.prescaler = 1,
> +	.has_invert = 1,

Since has_invert is a boolean, the proper value here would be "true".

> @@ -228,6 +252,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  	pc->data = id->data;
>  	pc->chip.dev = &pdev->dev;
>  	pc->chip.ops = &rockchip_pwm_ops;
> +	if (pc->data->has_invert) {
> +		pc->chip.of_xlate = of_pwm_xlate_with_flags;
> +		pc->chip.of_pwm_n_cells = 3;
> +	}
>  	pc->chip.base = -1;
>  	pc->chip.npwm = 1;

I suggest to rewrite the above as follows for readability:

 	pc->data = id->data;
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &rockchip_pwm_ops;
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
+
+	if (pc->data->has_invert) {
+		pc->chip.of_xlate = of_pwm_xlate_with_flags;
+		pc->chip.of_pwm_n_cells = 3;
+	}

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140819/51892853/attachment.sig>
