From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Nov 2013 16:54:33 +0900
Subject: [PATCH] sh_eth: add R8A7791 support
In-Reply-To: <201311150211.36049.sergei.shtylyov@cogentembedded.com>
References: <201311150211.36049.sergei.shtylyov@cogentembedded.com>
Message-ID: <20131118075433.GA1506@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 02:11:35AM +0300, Sergei Shtylyov wrote:
> Add support for yet another ARM member of the R-Car family, R-Car M2, also known
> as R8A7791 -- it will share the code and data with previously added R8A7790.
> Since  the Ether devices in these SoCs are indistinguishable at least from the
> driver's point of view,  do not introduce  a new platform device ID but modify
> device name "r8a7790-ether" to "r8a779x-ether" throughout the files (and also
> 'r8a7790_data' to 'r8a779x_data' in the driver), just like the names used for
> R8A7778/9 SoCs.

I realise that this is the approach that has been taken previously by this
driver for some other SoCs but it is inconsistent with the approach that
has (recently) emerged for drivers for Renesas IP.

The problem with this approach is that although the hardware may appear to
be the same in the absence of some kind of version number for the IP we
can't be certain it is the same.  Some difference may come to light later
and then this system breaks down.

Sure, at that point we can create a more fine-grained compatibility string.
But the approach that has emerged is that in the absence of a clearly
documented version number for the hardware the SoC name is used as the
version number.

I am also not entirely happy with the approach taken by this patch for
two other reasons:

1) It removes rather than deprecating an existing compatibility string.
   Albeit one that may not actually be used in the wild.

2) It changes both drivers/net/ and arch/arm/mach-shmobile/ code.
   This kind of cross-subsystem change can lead to conflicts which
   make Linus grumpy: this has occurred recently with shmobile code
   though not in this driver.

That said, I did successfully test this patch in conjunction with
companion patches for the r8A7791 SoC and Koelsch board.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is atop of 'renesas-devel-v3.12-20131112' tag of Simon Horman's
> 'renesas.git' repo and I intend to push it thru this tree in order to satisfy
> runtime dependencies of the R8A7791/Koelsch Ether support patches to follow.
> Not posting this to netdev at vger.kernel.org since Dave has closed 'net-next.git'
> for now; Dave, I hope you'll ACK this patch...
> 
>  arch/arm/mach-shmobile/board-lager.c   |   12 ++++++------
>  arch/arm/mach-shmobile/clock-r8a7790.c |    2 +-
>  drivers/net/ethernet/renesas/Kconfig   |    2 +-
>  drivers/net/ethernet/renesas/sh_eth.c  |    6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> Index: renesas/arch/arm/mach-shmobile/board-lager.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/board-lager.c
> +++ renesas/arch/arm/mach-shmobile/board-lager.c
> @@ -186,13 +186,13 @@ static const struct pinctrl_map lager_pi
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.1", "pfc-r8a7790",
>  				  "mmc1_ctrl", "mmc1"),
>  	/* Ether */
> -	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a779x-ether", "pfc-r8a7790",
>  				  "eth_link", "eth"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a779x-ether", "pfc-r8a7790",
>  				  "eth_mdio", "eth"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a779x-ether", "pfc-r8a7790",
>  				  "eth_rmii", "eth"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a779x-ether", "pfc-r8a7790",
>  				  "intc_irq0", "intc"),
>  };
>  
> @@ -217,7 +217,7 @@ static void __init lager_add_standard_de
>  					  mmcif1_resources, ARRAY_SIZE(mmcif1_resources),
>  					  &mmcif1_pdata, sizeof(mmcif1_pdata));
>  
> -	platform_device_register_resndata(&platform_bus, "r8a7790-ether", -1,
> +	platform_device_register_resndata(&platform_bus, "r8a779x-ether", -1,
>  					  ether_resources,
>  					  ARRAY_SIZE(ether_resources),
>  					  &ether_pdata, sizeof(ether_pdata));
> @@ -246,7 +246,7 @@ static void __init lager_init(void)
>  {
>  	lager_add_standard_devices();
>  
> -	phy_register_fixup_for_id("r8a7790-ether-ff:01", lager_ksz8041_fixup);
> +	phy_register_fixup_for_id("r8a779x-ether-ff:01", lager_ksz8041_fixup);
>  }
>  
>  static const char * const lager_boards_compat_dt[] __initconst = {
> Index: renesas/arch/arm/mach-shmobile/clock-r8a7790.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ renesas/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -285,7 +285,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
>  	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
>  	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
> -	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
> +	CLKDEV_DEV_ID("r8a779x-ether", &mstp_clks[MSTP813]),
>  	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
>  	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
>  	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
> Index: renesas/drivers/net/ethernet/renesas/Kconfig
> ===================================================================
> --- renesas.orig/drivers/net/ethernet/renesas/Kconfig
> +++ renesas/drivers/net/ethernet/renesas/Kconfig
> @@ -13,4 +13,4 @@ config SH_ETH
>  	  Renesas SuperH Ethernet device driver.
>  	  This driver supporting CPUs are:
>  		- SH7619, SH7710, SH7712, SH7724, SH7734, SH7763, SH7757,
> -		  R8A7740, R8A777x and R8A7790.
> +		  R8A7740, R8A777x and R8A779x.
> Index: renesas/drivers/net/ethernet/renesas/sh_eth.c
> ===================================================================
> --- renesas.orig/drivers/net/ethernet/renesas/sh_eth.c
> +++ renesas/drivers/net/ethernet/renesas/sh_eth.c
> @@ -395,8 +395,8 @@ static struct sh_eth_cpu_data r8a777x_da
>  	.hw_swap	= 1,
>  };
>  
> -/* R8A7790 */
> -static struct sh_eth_cpu_data r8a7790_data = {
> +/* R8A7790/1 */
> +static struct sh_eth_cpu_data r8a779x_data = {
>  	.set_duplex	= sh_eth_set_duplex,
>  	.set_rate	= sh_eth_set_rate_r8a777x,
>  
> @@ -2807,7 +2807,7 @@ static struct platform_device_id sh_eth_
>  	{ "sh7763-gether", (kernel_ulong_t)&sh7763_data },
>  	{ "r8a7740-gether", (kernel_ulong_t)&r8a7740_data },
>  	{ "r8a777x-ether", (kernel_ulong_t)&r8a777x_data },
> -	{ "r8a7790-ether", (kernel_ulong_t)&r8a7790_data },
> +	{ "r8a779x-ether", (kernel_ulong_t)&r8a779x_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, sh_eth_id_table);
> 
