From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 22 Dec 2012 22:05:32 +0800
Subject: [PATCH v2 01/20] mmc: mvsdio: use slot-gpio infrastructure for
 write protect gpio
In-Reply-To: <1356101359-6054-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1356101359-6054-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121222140529.GA12120@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 03:49:00PM +0100, Thomas Petazzoni wrote:
> @@ -831,8 +809,7 @@ out:
>  			free_irq(gpio_to_irq(host->gpio_card_detect), host);
>  			gpio_free(host->gpio_card_detect);
>  		}
> -		if (host->gpio_write_protect)
> -			gpio_free(host->gpio_write_protect);
> +		mmc_gpio_free_ro(mmc);

I posted a series[1] to save the call from error path and .remove().

Shawn

PS. What's the merge path for these mmc patches?  I do not even see
linux-mmc and Chris Ball on the Cc list.

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/18197

>  		if (host->base)
>  			iounmap(host->base);
>  	}
> @@ -861,8 +838,7 @@ static int __exit mvsd_remove(struct platform_device *pdev)
>  		}
>  		mmc_remove_host(mmc);
>  		free_irq(host->irq, host);
> -		if (host->gpio_write_protect)
> -			gpio_free(host->gpio_write_protect);
> +		mmc_gpio_free_ro(mmc);
>  		del_timer_sync(&host->timer);
>  		mvsd_power_down(host);
>  		iounmap(host->base);
