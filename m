From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 Jun 2016 08:52:50 +0200
Subject: [PATCH V2 35/63] clocksource/drivers/time-lpc32xx: Convert init
 function to return error
In-Reply-To: <1466112442-31105-36-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-36-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160617065250.GU26048@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

$Subject ~= s/lpc32xx/efm32/

On Thu, Jun 16, 2016 at 11:26:54PM +0200, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
> 
>   - panic, thus leading to a kernel crash while another timer may work and
>        make the system boot up correctly
> 
>   or
> 
>   - print an error and let the caller unaware if the state of the system

These are both wrong for efm32. It doesn't panic and doesn't print an
error message (obviously the "let the caller unaware" part is true).

> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.

Apart from the comment below the error handling is already fine in this
driver.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/time-efm32.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
> index b06e4c2..b71ffc6 100644
> --- a/drivers/clocksource/time-efm32.c
> +++ b/drivers/clocksource/time-efm32.c
> @@ -233,7 +233,11 @@ static int __init efm32_clockevent_init(struct device_node *np)
>  					DIV_ROUND_CLOSEST(rate, 1024),
>  					0xf, 0xffff);
>  
> -	setup_irq(irq, &efm32_clock_event_irq);
> +	ret = setup_irq(irq, &efm32_clock_event_irq);
> +	if (ret) {
> +		pr_err("Failed setup irq");
> +		goto err_get_irq;

I would prefer to introduce another label "err_setup_irq" at the same
place as err_get_irq and use it here.

> +	}
>  
>  	return 0;
>  

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
