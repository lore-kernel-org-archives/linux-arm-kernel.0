From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Feb 2018 14:43:48 -0800
Subject: [PATCH 5/7] watchdog: mtk: allow setting timeout in devicetree
In-Reply-To: <20180209192724.1227-6-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-6-marcus.folkesson@gmail.com>
Message-ID: <20180209224348.GG19627@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 08:27:22PM +0100, Marcus Folkesson wrote:
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
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
>  drivers/watchdog/mtk_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 5b38a30e608c..859dee167b91 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -11,9 +11,13 @@ Required properties:
>  
>  - reg : Specifies base physical address and size of the registers.
>  
> +Optional properties:
> +- timeout-sec: contains the watchdog timeout in seconds.
> +
>  Example:
>  
>  wdt: watchdog at 10000000 {
>  	compatible = "mediatek,mt6589-wdt";
>  	reg = <0x10000000 0x18>;
> +	timeout-sec = <10>;
>  };
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 7ed417a765c7..fcdc10ec28a3 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -57,7 +57,7 @@
>  #define DRV_VERSION		"1.0"
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -static unsigned int timeout = WDT_MAX_TIMEOUT;
> +static unsigned int timeout;
>  
>  struct mtk_wdt_dev {
>  	struct watchdog_device wdt_dev;
> -- 
> 2.15.1
> 
