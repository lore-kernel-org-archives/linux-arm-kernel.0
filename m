From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 20 Mar 2013 10:00:18 +0900
Subject: [PATCH 4/4] leds: renesas: fix devm_gpio_request_one() flags
 parameter
In-Reply-To: <1363716452-18870-5-git-send-email-simon.guinot@sequanux.org>
References: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
 <1363716452-18870-5-git-send-email-simon.guinot@sequanux.org>
Message-ID: <009201ce2506$4a755cc0$df601640$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 20, 2013 3:08 AM, Simon Guinot wrote:
> 
> This patch fixes a regression introduced by commit b0053aaa23
> ("leds: renesas: use gpio_request_one").
> 
> gpio_request_one is called with a wrong flag value: The brightness is
> used to configure the direction (bit 0) instead of the value (bit 1).
> 
> This patch fixes the issue by using the dedicated macros
> GPIOF_OUT_INIT_{LOW,HIGH} to configure the initial GPIO value.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>

Hi Simon Guinot,

The same patch was already merged to Bryan's git.
Thus, this patch is not necessary.
(http://www.spinics.net/lists/linux-leds/msg00757.html)

Best regards,
Jingoo Han


> ---
>  drivers/leds/leds-renesas-tpu.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-renesas-tpu.c b/drivers/leds/leds-renesas-tpu.c
> index d3c2b7e..79cca23 100644
> --- a/drivers/leds/leds-renesas-tpu.c
> +++ b/drivers/leds/leds-renesas-tpu.c
> @@ -205,7 +205,8 @@ static void r_tpu_set_pin(struct r_tpu_priv *p, enum r_tpu_pin new_state,
>  		gpio_free(cfg->pin_gpio_fn);
> 
>  	if (new_state == R_TPU_PIN_GPIO)
> -		gpio_request_one(cfg->pin_gpio, GPIOF_DIR_OUT | !!brightness,
> +		gpio_request_one(cfg->pin_gpio, brightness ?
> +				GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
>  				cfg->name);
> 
>  	if (new_state == R_TPU_PIN_GPIO_FN)
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
