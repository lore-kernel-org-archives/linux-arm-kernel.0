From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 1 Oct 2012 14:45:46 +0200
Subject: [PATCH v6 3/5] watchdog: at91sam9_wdt: add device tree support
In-Reply-To: <1349094281-28889-4-git-send-email-fabio.porcedda@gmail.com>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
 <1349094281-28889-4-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <20121001124546.GE11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 02:24:39PM +0200, Fabio Porcedda wrote:
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> new file mode 100644
> index 0000000..65c1755
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -0,0 +1,19 @@
> +* Atmel Watchdog Timers
> +
> +** at91sam9-wdt
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9260-wdt".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +Optional properties:
> +- timeout: contains the watchdog timeout in seconds.
> +
> +Example:
> +
> +	watchdog at fffffd40 {
> +		compatible = "atmel,at91sam9260-wdt";
> +		reg = <0xfffffd40 0x10>;
> +		timeout = <10>;
> +	};
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 05e1be8..c9e6bfa 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -32,6 +32,7 @@
>  #include <linux/timer.h>
>  #include <linux/bitops.h>
>  #include <linux/uaccess.h>
> +#include <linux/of.h>
>  
>  #include "at91sam9_wdt.h"
>  
> @@ -254,6 +255,14 @@ static struct miscdevice at91wdt_miscdev = {
>  	.fops		= &at91wdt_fops,
>  };
>  
> +static inline void __init at91wdt_probe_dt(struct device_node *node)
> +{
> +	if (!node)
> +		return;
> +
> +	of_property_read_u32(node, "timeout", &heartbeat);
> +}
> +

In patch #1 you add a function to do this, and then you don't make use
of it here ?

Or am i missing something?

   Thanks
	Andrew
