From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 11 Feb 2018 09:33:56 -0800
Subject: [v2, 7/7] watchdog: coh901327: make use of timeout-secs provided
 in devicetree
In-Reply-To: <20180210091911.3644-7-marcus.folkesson@gmail.com>
References: <20180210091911.3644-7-marcus.folkesson@gmail.com>
Message-ID: <20180211173356.GA18292@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 10:19:11AM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> v2:
> 	- Set .timeout in coh901327_wdt structure declaration.
> 	- Set .min_timeout to 1 instead of 0. I could not find a datasheet
> 	  for coh901327, so I'm not sure if 0 is valid. However, 0 seems
> 		  wrong to me and most driver has 1 as min value. If it should
> 		  be 0, please let me know and I have to set another initial
> 		  value for margin.

Makes sense to me.

> 
>  drivers/watchdog/coh901327_wdt.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 4410337f4f7f..5d8eb9a30879 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -67,7 +67,9 @@
>  #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
>  
>  /* Default timeout in seconds = 1 minute */
> -static unsigned int margin = 60;
> +#define U300_WDOG_DEFAULT_TIMEOUT					60
> +
> +static unsigned int margin;

I just realized that 'margin' instead of the actual timeout is used
at the end of the probe function to display the selected timeout.
This will have to change as well (and I'll have to go back to the
other patches to make sure that this doesn't happen there as well).

Guenter

>  static int irq;
>  static void __iomem *virtbase;
>  static struct device *parent;
> @@ -235,8 +237,9 @@ static struct watchdog_device coh901327_wdt = {
>  	 * timeout register is max
>  	 * 0x7FFF = 327670ms ~= 327s.
>  	 */
> -	.min_timeout = 0,
> +	.min_timeout = 1,
>  	.max_timeout = 327,
> +	.timeout = U300_WDOG_DEFAULT_TIMEOUT,
>  };
>  
>  static int __exit coh901327_remove(struct platform_device *pdev)
> @@ -315,9 +318,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
>  		goto out_no_irq;
>  	}
>  
> -	ret = watchdog_init_timeout(&coh901327_wdt, margin, dev);
> -	if (ret < 0)
> -		coh901327_wdt.timeout = 60;
> +	watchdog_init_timeout(&coh901327_wdt, margin, dev);
>  
>  	coh901327_wdt.parent = dev;
>  	ret = watchdog_register_device(&coh901327_wdt);
