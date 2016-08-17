From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 17 Aug 2016 11:48:43 +0200
Subject: [PATCH v2 1/4] clocksource: timer-atmel-pit: enable mck
In-Reply-To: <1470663233-15118-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1470663233-15118-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <57B432FB.90607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2016 03:33 PM, Alexandre Belloni wrote:
> mck is needed to get the PIT working. Explicitly prepare_enable it instead
> of assuming it is enabled.
> 
> This solves an issue where the system is freezing when the ETM/ETB drivers
> are enabled.
> 
> Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/clocksource/timer-atmel-pit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
> index 1ffac0cb0cb7..db839fc99a8e 100644
> --- a/drivers/clocksource/timer-atmel-pit.c
> +++ b/drivers/clocksource/timer-atmel-pit.c
> @@ -261,6 +261,9 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
>  		return PTR_ERR(data->mck);
>  	}
>  
> +	if (clk_prepare_enable(data->mck))
> +		panic(pr_fmt("Unable to enable mck\n"));
> +

Replace the panic by a proper error handling please.

Thanks !

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
