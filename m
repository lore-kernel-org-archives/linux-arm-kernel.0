From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Feb 2018 14:40:25 -0800
Subject: [PATCH 3/7] watchdog: sirfsoc: allow setting timeout in devicetree
In-Reply-To: <20180209192724.1227-4-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-4-marcus.folkesson@gmail.com>
Message-ID: <20180209224025.GD19627@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 08:27:20PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also
> let us to set timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt | 4 ++++
>  drivers/watchdog/sirfsoc_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> index 9cbc76c89b2b..0dce5e3100b4 100644
> --- a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> @@ -5,10 +5,14 @@ Required properties:
>  - reg: Address range of tick timer/WDT register set
>  - interrupts: interrupt number to the cpu
>  
> +Optional properties:
> +- timeout-sec : Contains the watchdog timeout in seconds
> +
>  Example:
>  
>  timer at b0020000 {
>  	compatible = "sirf,prima2-tick";
>  	reg = <0xb0020000 0x1000>;
>  	interrupts = <0>;
> +	timeout-sec = <30>;
>  };
> diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
> index 4eea351e09b0..ac0c9d2c4aee 100644
> --- a/drivers/watchdog/sirfsoc_wdt.c
> +++ b/drivers/watchdog/sirfsoc_wdt.c
> @@ -29,7 +29,7 @@
>  #define SIRFSOC_WDT_MAX_TIMEOUT		(10 * 60)	/* 10 mins */
>  #define SIRFSOC_WDT_DEFAULT_TIMEOUT	30		/* 30 secs */
>  
> -static unsigned int timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
> +static unsigned int timeout;
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  module_param(timeout, uint, 0);
> -- 
> 2.15.1
> 
