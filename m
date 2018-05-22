From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 22 May 2018 13:54:57 -0700
Subject: [PATCH 3/5] watchdog: sp805: set WDOG_HW_RUNNING when appropriate
In-Reply-To: <1527014840-21236-4-git-send-email-ray.jui@broadcom.com>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-4-git-send-email-ray.jui@broadcom.com>
Message-ID: <20180522205457.GA16363@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 11:47:18AM -0700, Ray Jui wrote:
> If the watchdog hardware is already enabled during the boot process,
> when the Linux watchdog driver loads, it should reset the watchdog and
> tell the watchdog framework. As a result, ping can be generated from
> the watchdog framework, until the userspace watchdog daemon takes over
> control
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/watchdog/sp805_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 1484609..408ffbe 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -42,6 +42,7 @@
>  	/* control register masks */
>  	#define	INT_ENABLE	(1 << 0)
>  	#define	RESET_ENABLE	(1 << 1)
> +	#define	ENABLE_MASK	(INT_ENABLE | RESET_ENABLE)
>  #define WDTINTCLR		0x00C
>  #define WDTRIS			0x010
>  #define WDTMIS			0x014
> @@ -74,6 +75,18 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout,
>  		"Set to 1 to keep watchdog running after device release");
>  
> +/* returns true if wdt is running; otherwise returns false */
> +static bool wdt_is_running(struct watchdog_device *wdd)
> +{
> +	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	if ((readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK) ==
> +	    ENABLE_MASK)
> +		return true;
> +	else
> +		return false;

	return !!(readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK));

> +}
> +
>  /* This routine finds load value that will reset system in required timout */
>  static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>  {
> @@ -239,6 +252,15 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  	watchdog_init_timeout(&wdt->wdd, 0, &adev->dev);
>  	wdt_setload(&wdt->wdd, wdt->wdd.timeout);
>  
> +	/*
> +	 * If HW is already running, enable/reset the wdt and set the running
> +	 * bit to tell the wdt subsystem
> +	 */
> +	if (wdt_is_running(&wdt->wdd)) {
> +		wdt_enable(&wdt->wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +
>  	ret = watchdog_register_device(&wdt->wdd);
>  	if (ret) {
>  		dev_err(&adev->dev, "watchdog_register_device() failed: %d\n",
> -- 
> 2.1.4
> 
