From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Apr 2014 07:58:22 +0900
Subject: [PATCHv2 02/11] ARM: shmobile: Armadillo 800 EVA: initialize all
 struct pwm_lookup members
In-Reply-To: <1397512793-10325-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1397512793-10325-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140414225822.GG22518@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 11:59:44PM +0200, Alexandre Belloni wrote:
> Initializing all the struct pwm_lookup members allows to get rid of the struct
> tpu_pwm_platform_data as the polarity initialization will be taken care of by
> the PWM core.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


This looks good to me.
Please let me know when the driver code has been merged and
I'll take this patch. Likewise for the other shmobile patch in this series.

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 2858f380beae..1bf61dad9a35 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -31,7 +31,7 @@
>  #include <linux/gpio_keys.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/pinctrl/machine.h>
> -#include <linux/platform_data/pwm-renesas-tpu.h>
> +#include <linux/pwm.h>
>  #include <linux/pwm_backlight.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/gpio-regulator.h>
> @@ -399,24 +399,22 @@ static struct resource pwm_resources[] = {
>  	},
>  };
>  
> -static struct tpu_pwm_platform_data pwm_device_data = {
> -	.channels[2] = {
> -		.polarity = PWM_POLARITY_INVERSED,
> -	}
> -};
> -
>  static struct platform_device pwm_device = {
>  	.name = "renesas-tpu-pwm",
>  	.id = -1,
> -	.dev = {
> -		.platform_data = &pwm_device_data,
> -	},
>  	.num_resources = ARRAY_SIZE(pwm_resources),
>  	.resource = pwm_resources,
>  };
>  
>  static struct pwm_lookup pwm_lookup[] = {
> -	PWM_LOOKUP("renesas-tpu-pwm", 2, "pwm-backlight.0", NULL),
> +	{
> +		.provider = "renesas-tpu-pwm",
> +		.index = 2,
> +		.dev_id = "pwm-backlight.0",
> +		.con_id = NULL,
> +		.period = 33333,
> +		.polarity = PWM_POLARITY_INVERSED,
> +	},
>  };
>  
>  /* LCDC and backlight */
> -- 
> 1.8.3.2
> 
