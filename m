From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2012 11:03:06 -0700
Subject: [PATCH 2/2] ARM: OMAP2+: Enable pinctrl dummy states
In-Reply-To: <1347385599-27558-3-git-send-email-mporter@ti.com>
References: <1347385599-27558-1-git-send-email-mporter@ti.com>
 <1347385599-27558-3-git-send-email-mporter@ti.com>
Message-ID: <20120911180306.GI23092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@ti.com> [120911 10:46]:
> Enable pinctrl dummy states for all OMAP platforms. This allows
> drivers to be converted to pinctrl while still running on
> platforms that do not provide pinctrl data.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c00c689..577cd04 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/omap4-keypad.h>
>  
>  #include <mach/hardware.h>
> @@ -631,6 +632,9 @@ static inline void omap_init_vout(void) {}
>  
>  static int __init omap2_init_devices(void)
>  {
> +	/* Enable dummy states for those platforms without pinctrl support */
> +	pinctrl_provide_dummies();
> +
>  	/*
>  	 * please keep these calls, and their implementations above,
>  	 * in alphabetical order so they're easier to sort through.

Hmm I think this may need to be board specific. And may need to
be board specific and depend on unpopulated device tree?

For board-generic.c we always want to see the warnings. And some boards
insist on doing all the muxing only in the bootloader.

Regards,

Tony
