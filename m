From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Apr 2012 10:26:48 +0100
Subject: [PATCH V3 2/2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
In-Reply-To: <27dea103ccf6da5b7376c837d9a95dc7a9ed3be3.1335246446.git.viresh.kumar@st.com>
References: <31b0b89e21e6a234cb904761a1d0e5106405da82.1335246446.git.viresh.kumar@st.com>
 <27dea103ccf6da5b7376c837d9a95dc7a9ed3be3.1335246446.git.viresh.kumar@st.com>
Message-ID: <4F9671D8.4080308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/12 06:50, Viresh Kumar wrote:
> This patch adds Device tree probing support for ARM Mpcore watchdog. Its binding
> were already documented in Documentation/devicetree/bindings/arm/twd.txt.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> V2->V3:
> - Nothing. Just resend it.

I'm sorry, but I really have to ask: What is the point of adding DT
support to this driver when it is obvious that it is already broken?

As mentioned yesterday, interrupt request doesn't use the right API,
which makes it very unlikely that the probe function will succeed.

Furthermore, I cannot see anything in this driver that ensures the
userspace ioctl() will end-up kicking the watchdog on the right CPU.

So if you really care about this driver, please have a look at the above
issues. Otherwise this is only pointless churn.

Thanks,

	M.

>  drivers/watchdog/mpcore_wdt.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
> index 13197c7..3690af3 100644
> --- a/drivers/watchdog/mpcore_wdt.c
> +++ b/drivers/watchdog/mpcore_wdt.c
> @@ -27,6 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/reboot.h>
> @@ -424,6 +425,16 @@ static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mpcore_wdt_suspend,
>  /* work with hotplug and coldplug */
>  MODULE_ALIAS("platform:mpcore_wdt");
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id mpcore_wdt_id_table[] = {
> +	{ .compatible = "arm,cortex-a9-twd-wdt" },
> +	{ .compatible = "arm,cortex-a5-twd-wdt" },
> +	{ .compatible = "arm,arm11mp-twd-wdt" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mpcore_wdt_id_table);
> +#endif
> +
>  static struct platform_driver mpcore_wdt_driver = {
>  	.probe		= mpcore_wdt_probe,
>  	.remove		= __devexit_p(mpcore_wdt_remove),
> @@ -432,6 +443,7 @@ static struct platform_driver mpcore_wdt_driver = {
>  		.owner	= THIS_MODULE,
>  		.name	= "mpcore_wdt",
>  		.pm	= &mpcore_wdt_dev_pm_ops,
> +		.of_match_table = of_match_ptr(mpcore_wdt_id_table),
>  	},
>  };
>  


-- 
Jazz is not dead. It just smells funny...
