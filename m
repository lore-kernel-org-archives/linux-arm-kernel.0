From: horms@verge.net.au (Simon Horman)
Date: Thu, 19 Sep 2013 14:20:30 -0700
Subject: [PATCH] ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup
In-Reply-To: <201309140429.23474.sergei.shtylyov@cogentembedded.com>
References: <201309140429.23474.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130919212030.GK2918@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 14, 2013 at 04:29:22AM +0400, Sergei Shtylyov wrote:
> Currently on the Lager board NFS timeouts/delays are seen when booting.  That
> turned out to happen because the SoC's ETH_LINK signal turns on and off after
> each packet.  It is connected to Micrel KSZ8041 PHY's LED0 signal. Ether LEDs
> on the Lager board are named LINK and ACTIVE which corresponds to non-default
> 01 setting of the PHY control register 1 bits 14-15. The 'sh_eth' driver resets
> the PHY when opening the network device, so we have to set the mentioned bits
> back to 01 from the default 00 value which causes bouncing of ETH_LINK.  That
> can be achieved using the PHY platform fixup mechanism if we also modify the
> driver to use it..
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the recent Linus' tree. Its effect on NFS issue depends
> on the 'sh_eth' driver patch I've posted earlier. 
> Simon, please update your 'master' and/or 'fixes' branches since currently it's
> impossible to apply fixes to your tree.

Now that rc-1 is out I plan to rebase my tree.
But as I am travelling this week it will have to wait until next week.

> 
>  arch/arm/mach-shmobile/board-lager.c |   27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> Index: linux/arch/arm/mach-shmobile/board-lager.c
> ===================================================================
> --- linux.orig/arch/arm/mach-shmobile/board-lager.c
> +++ linux/arch/arm/mach-shmobile/board-lager.c
> @@ -29,6 +29,7 @@
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/gpio-rcar.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/sh_eth.h>
> @@ -155,6 +156,30 @@ static void __init lager_add_standard_de
>  					  &ether_pdata, sizeof(ether_pdata));
>  }
>  
> +/*
> + * Ether LEDs on the Lager board are named LINK and ACTIVE which corresponds
> + * to non-default 01 setting of the Micrel KSZ8041 PHY control register 1 bits
> + * 14-15. We have to set them back to 01 from the default 00 value each time
> + * the PHY is reset. It's also important because the PHY's LED0 signal is
> + * connected to SoC's ETH_LINK signal and in the PHY's default mode it will
> + * bounce on and off after each packet, which we apparently want to avoid.
> + */
> +static int lager_ksz8041_fixup(struct phy_device *phydev)
> +{
> +	u16 phyctrl1 = phy_read(phydev, 0x1e);
> +
> +	phyctrl1 &= ~0xc000;
> +	phyctrl1 |= 0x4000;
> +	return phy_write(phydev, 0x1e, phyctrl1);
> +}
> +
> +static void __init lager_init(void)
> +{
> +	lager_add_standard_devices();
> +
> +	phy_register_fixup_for_id("r8a7790-ether-ff:01", lager_ksz8041_fixup);
> +}
> +
>  static const char *lager_boards_compat_dt[] __initdata = {
>  	"renesas,lager",
>  	NULL,
> @@ -163,6 +188,6 @@ static const char *lager_boards_compat_d
>  DT_MACHINE_START(LAGER_DT, "lager")
>  	.init_early	= r8a7790_init_delay,
>  	.init_time	= r8a7790_timer_init,
> -	.init_machine	= lager_add_standard_devices,
> +	.init_machine	= lager_init,
>  	.dt_compat	= lager_boards_compat_dt,
>  MACHINE_END
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
