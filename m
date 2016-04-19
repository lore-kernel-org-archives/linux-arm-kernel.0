From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Apr 2016 16:37:54 +0200
Subject: [PATCH] pinctrl: at91-pio4: fix pull-up/down logic
In-Reply-To: <1461074628-20224-1-git-send-email-ludovic.desroches@atmel.com>
References: <1461074628-20224-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160419143754.GB29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/2016 at 16:03:45 +0200, Ludovic Desroches wrote :
> The default configuration of a pin is often with a value in the
> pull-up/down field at chip reset. So, even if the internal logic of the
> controller prevents writing a configuration with pull-up and pull-down at
> the same time, we must ensure explicitly this condition before writing the
> register.
> 
> This was leading to a pull-down condition not taken into account for
> instance.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
> Cc: stable at vger.kernel.org #v4.4 and later
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/pinctrl/pinctrl-at91-pio4.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 629b6fe..75093d7 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -722,9 +722,11 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
>  			break;
>  		case PIN_CONFIG_BIAS_PULL_UP:
>  			conf |= ATMEL_PIO_PUEN_MASK;
> +			conf &= (~ATMEL_PIO_PDEN_MASK);
>  			break;
>  		case PIN_CONFIG_BIAS_PULL_DOWN:
>  			conf |= ATMEL_PIO_PDEN_MASK;
> +			conf &= (~ATMEL_PIO_PUEN_MASK);
>  			break;
>  		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
>  			if (arg == 0)
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
