From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 19 Nov 2010 18:59:19 +0200
Subject: [Patch v1] AM35xx: Craneboard: Add USB EHCI support
In-Reply-To: <1290182862-21837-1-git-send-email-srinath@mistralsolutions.com>
References: <[PATCH] AM35xx-Craneboard-Add-USB-EHCI-support>
	<1290182862-21837-1-git-send-email-srinath@mistralsolutions.com>
Message-ID: <4CE6ACE7.9010203@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Srinath,

On 11/19/10 18:07, srinath at mistralsolutions.com wrote:
> From: Srinath <srinath@mistralsolutions.com>
>
> AM3517/05 Craneboard has one EHCI interface on board using port1.
>
> GPIO35 is used as power enable.
> GPIO38 is used as port1 PHY reset.
>
> Signed-off-by: Srinath <srinath@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-am3517crane.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
> index 13ead33..0e1a806 100644
> --- a/arch/arm/mach-omap2/board-am3517crane.c
> +++ b/arch/arm/mach-omap2/board-am3517crane.c
> @@ -28,8 +28,10 @@
>  
>  #include <plat/board.h>
>  #include <plat/common.h>
> +#include <plat/usb.h>
>  
>  #include "mux.h"
> +#include "control.h"
>  
>  /* Board initialization */
>  static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
> @@ -53,10 +55,29 @@ static void __init am3517_crane_init_irq(void)
>  	omap_gpio_init();
>  }
>  
> +static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
> +	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> +	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> +
> +	.phy_reset  = true,
> +	.reset_gpio_port[0]  = 38,
> +	.reset_gpio_port[1]  = -EINVAL,
> +	.reset_gpio_port[2]  = -EINVAL
> +};
> +
>  static void __init am3517_crane_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap_serial_init();
> +
> +	/* Configure GPIO for EHCI port */
> +	omap_mux_init_gpio(35, OMAP_PIN_OUTPUT);
> +	gpio_request(35, "usb_ehci_enable");

gpio_request() can fail, you should check this
and you should not use this gpio if the request fails.
Also, may be the regulators framework is more appropriate
for power enable line, but I'm not sure...

> +	gpio_direction_output(35, 1);
> +	gpio_set_value(35, 1);
> +	omap_mux_init_gpio(38, OMAP_PIN_OUTPUT);

Shouldn't the omap_mux_init_gpio() be called before you request the gpio?

> +	usb_ehci_init(&ehci_pdata);
>  }
>  
>  MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")

-- 
Regards,
Igor.
