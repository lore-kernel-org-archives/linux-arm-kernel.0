From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Feb 2018 14:39:04 -0800
Subject: [PATCH 2/7] watchdog: sunxi: allow setting timeout in devicetree
In-Reply-To: <20180209192724.1227-3-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-3-marcus.folkesson@gmail.com>
Message-ID: <20180209223904.GC19627@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 08:27:19PM +0100, Marcus Folkesson wrote:
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
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 4 ++++
>  drivers/watchdog/sunxi_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> index 62dd5baad70e..49900e72f6b1 100644
> --- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> @@ -6,9 +6,13 @@ Required properties:
>                 "allwinner,sun6i-a31-wdt"
>  - reg : Specifies base physical address and size of the registers.
>  
> +Optional properties:
> +- timeout-sec : Contains the watchdog timeout in seconds
> +
>  Example:
>  
>  wdt: watchdog at 1c20c90 {
>  	compatible = "allwinner,sun4i-a10-wdt";
>  	reg = <0x01c20c90 0x10>;
> +	timeout-sec = <10>;
>  };
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index 9728fa32c357..55f166bec0ca 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -39,7 +39,7 @@
>  #define DRV_VERSION		"1.0"
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -static unsigned int timeout = WDT_MAX_TIMEOUT;
> +static unsigned int timeout;
>  
>  /*
>   * This structure stores the register offsets for different variants
> -- 
> 2.15.1
> 
