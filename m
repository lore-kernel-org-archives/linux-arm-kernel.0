From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Dec 2013 10:56:55 +0100
Subject: [PATCH 1/2] pinctrl: at91: fix clk_unprepare and clk_disable order
In-Reply-To: <1387132252-2584-2-git-send-email-b.brezillon@overkiz.com>
References: <1387132252-2584-1-git-send-email-b.brezillon@overkiz.com>
 <1387132252-2584-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52AECE67.6050507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/2013 19:30, Boris BREZILLON :
> clk_unprepare shall be called before clk_disable.
> Fix the issue by replacing the clk_unprepare and clk_disable calls by a
> single clk_disable_unprepare call.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
>  drivers/pinctrl/pinctrl-at91.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index a7549c4..82f6301 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1339,13 +1339,11 @@ void at91_pinctrl_gpio_suspend(void)
>  		__raw_writel(backups[i], pio + PIO_IDR);
>  		__raw_writel(wakeups[i], pio + PIO_IER);
>  
> -		if (!wakeups[i]) {
> -			clk_unprepare(gpio_chips[i]->clock);
> -			clk_disable(gpio_chips[i]->clock);
> -		} else {
> +		if (!wakeups[i])
> +			clk_disable_unprepare(gpio_chips[i]->clock);
> +		else
>  			printk(KERN_DEBUG "GPIO-%c may wake for %08x\n",
>  			       'A'+i, wakeups[i]);
> -		}
>  	}
>  }
>  
> 


-- 
Nicolas Ferre
