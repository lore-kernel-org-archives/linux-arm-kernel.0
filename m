From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 11:15:41 -0700
Subject: [PATCH 2/3] i2c/at91: add support for system PM
In-Reply-To: <1413776535-10123-3-git-send-email-wenyou.yang@atmel.com> (Wenyou
 Yang's message of "Mon, 20 Oct 2014 11:42:13 +0800")
References: <1413776535-10123-1-git-send-email-wenyou.yang@atmel.com>
 <1413776535-10123-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <7h8ukafvzm.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wenyou Yang <wenyou.yang@atmel.com> writes:

Add a changelog here describing what you're doing, and why.

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  drivers/i2c/busses/i2c-at91.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 03b9f48..8f408f8 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -845,6 +845,35 @@ static int at91_twi_remove(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
> +static int at91_twi_suspend(struct device *dev)
> +{
> +	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_suspended(dev))
> +		clk_disable_unprepare(twi_dev->clk);

I would just call at91_twi_runtime_suspend() here.

Then, if you need to add additional steps, you only have to add them in
once place.  This also makes it obvious that ->suspend and
->runtime_suspend are doing the exact same thing.

NOTE: you'll need to wrap the runtime_suspend|resume functions in just
CONFIG_PM instead of CONFIG_PM_RUNTIME for this to work.

Kevin
