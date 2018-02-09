From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Feb 2018 14:48:49 -0800
Subject: [PATCH 6/7] watchdog: meson: allow setting timeout in devicetree
In-Reply-To: <20180209192724.1227-7-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-7-marcus.folkesson@gmail.com>
Message-ID: <20180209224849.GH19627@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 08:27:23PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also
> let us to set timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenetr Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 4 ++++
>  drivers/watchdog/meson_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> index 8a6d84cb36c9..7588cc3971bf 100644
> --- a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> @@ -9,9 +9,13 @@ Required properties:
>  	"amlogic,meson8m2-wdt" and "amlogic,meson8b-wdt" on Meson8m2 SoCs
>  - reg : Specifies base physical address and size of the registers.
>  
> +Optional properties:
> +- timeout-sec: contains the watchdog timeout in seconds.
> +
>  Example:
>  
>  wdt: watchdog at c1109900 {
>  	compatible = "amlogic,meson6-wdt";
>  	reg = <0xc1109900 0x8>;
> +	timeout-sec = <10>;
>  };
> diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
> index 304274c67735..cd0275a6cdac 100644
> --- a/drivers/watchdog/meson_wdt.c
> +++ b/drivers/watchdog/meson_wdt.c
> @@ -36,7 +36,7 @@
>  #define MESON_SEC_TO_TC(s, c)	((s) * (c))
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -static unsigned int timeout = MESON_WDT_TIMEOUT;
> +static unsigned int timeout;
>  
>  struct meson_wdt_data {
>  	unsigned int enable;
> -- 
> 2.15.1
> 
