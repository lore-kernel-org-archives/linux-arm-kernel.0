From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Feb 2018 14:52:00 -0800
Subject: [PATCH 7/7] watchdog: coh901327: make use of timeout-secs
 provided in devicetree
In-Reply-To: <20180209192724.1227-8-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-8-marcus.folkesson@gmail.com>
Message-ID: <20180209225200.GI19627@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 08:27:24PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/watchdog/coh901327_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 4410337f4f7f..437f865e5c6b 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -67,7 +67,7 @@
>  #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
>  
>  /* Default timeout in seconds = 1 minute */
> -static unsigned int margin = 60;
> +static unsigned int margin;
>  static int irq;
>  static void __iomem *virtbase;
>  static struct device *parent;

I would suggest to initialize .timeout in 'static struct watchdog_device
coh901327_wdt', and drop the error check when calling watchdog_init_timeout().

Guenter
