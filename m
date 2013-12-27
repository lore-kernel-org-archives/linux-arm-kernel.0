From: horms@verge.net.au (Simon Horman)
Date: Fri, 27 Dec 2013 11:12:27 +0900
Subject: [PATCH 1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ
In-Reply-To: <201312200228.00555.sergei.shtylyov@cogentembedded.com>
References: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
 <201312200228.00555.sergei.shtylyov@cogentembedded.com>
Message-ID: <20131227021227.GC9184@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 02:28:00AM +0300, Sergei Shtylyov wrote:
> Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> trigger type to be low-level as per the Micrel PHY driver's setup.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Sergei,

does this depend on changes that have been queued up in net or net-next
since v3.13-rc1? If so are they present in v3.13-rc5? If not please
repost when an rc release with the required dependencies is available.

> 
> ---
>  arch/arm/mach-shmobile/board-koelsch.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c
> @@ -23,6 +23,7 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
>  #include <linux/phy.h>
> @@ -92,6 +93,7 @@ static void __init koelsch_add_du_device
>  /* Ether */
>  static const struct sh_eth_plat_data ether_pdata __initconst = {
>  	.phy			= 0x1,
> +	.phy_irq		= irq_pin(0),
>  	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
>  	.phy_interface		= PHY_INTERFACE_MODE_RMII,
>  	.ether_link_active_low	= 1,
> @@ -215,6 +217,8 @@ static void __init koelsch_init(void)
>  {
>  	koelsch_add_standard_devices();
>  
> +	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
> +
>  	if (IS_ENABLED(CONFIG_PHYLIB))
>  		phy_register_fixup_for_id("r8a7791-ether-ff:01",
>  					  koelsch_ksz8041_fixup);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
