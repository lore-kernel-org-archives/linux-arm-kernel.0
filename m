From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 03 Jul 2013 04:30:50 +0200
Subject: [PATCH v4 2/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <20130702012227.GA24086@verge.net.au>
References: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
 <1870016.uXUUSHgrj5@avalon> <20130702012227.GA24086@verge.net.au>
Message-ID: <2350201.0bf2NXOx7A@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tuesday 02 July 2013 10:22:28 Simon Horman wrote:
> On Mon, Jul 01, 2013 at 03:29:21PM +0200, Laurent Pinchart wrote:
> > On Monday 01 July 2013 16:20:33 Simon Horman wrote:
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > 
> > > ---
> > > 
> > > This patch has a build-time dependency on "sh_eth: add support for gpio
> > > reset". This patch has a run-time dependency on "sh_eth: add support for
> > > r8a7790 SoC".
> > > 
> > > v4
> > > * Annotate ether_platdata as __initdata
> > > 
> > > v3
> > > * Rebase
> > > 
> > > v2
> > > * As suggested by Laurent Pinchart
> > >   - Do not manipilate sh_eth reset GPIO directly,
> > >     rather, do so through newly proposed support for this in
> > >     the sh_eth driver.
> > > * A suggested by Sergei Shtylyov
> > >   - Move DTS portion into a separate patch
> > > 
> > > ---
> > > 
> > >  arch/arm/mach-shmobile/board-lager.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-lager.c
> > > b/arch/arm/mach-shmobile/board-lager.c index 0b4a1f9..7d5db20 100644
> > > --- a/arch/arm/mach-shmobile/board-lager.c
> > > +++ b/arch/arm/mach-shmobile/board-lager.c
> > > @@ -71,6 +71,17 @@ static __initdata struct gpio_keys_platform_data
> > > lager_keys_pdata = { .nbuttons	= ARRAY_SIZE(gpio_buttons),
> > >  };
> > > 
> > > +/* Ether */
> > > +static struct sh_eth_plat_data ether_platdata __initdata = {
> > > +	.phy			= 0x1,
> > > +	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
> > > +	.register_type		= SH_ETH_REG_FAST_RCAR,
> > > +	.phy_interface		= PHY_INTERFACE_MODE_RMII,
> > > +	.ether_link_active_low	= 1,
> > > +	.needs_gpio_reset	= 1,
> > > +	.reset_gpio		= RCAR_GP_PIN(5, 31),
> > > +};
> > > +
> > > 
> > >  static const struct pinctrl_map lager_pinctrl_map[] = {
> > >  	/* SCIF0 (CN19: DEBUG SERIAL0) */
> > >  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
> > > @@ -78,6 +89,17 @@ static const struct pinctrl_map lager_pinctrl_map[] =
> > > {
> > >  	/* SCIF1 (CN20: DEBUG SERIAL1) */
> > >  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
> > >  				  "scif1_data", "scif1"),
> > > +	/* Ether */
> > > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> > > +				  "eth_link", "eth"),
> > > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> > > +				  "eth_magic", "eth"),
> > 
> > That pin isn't used on Lager, you can drop it.
> 
> Thanks, I will drop that.
> 
> > By the way, the latest R8A7790 datasheet errata renamed the eth_magic pin
> > to eth_wol. What would you think about renaming it to eth_wol in
> > drivers/pinctrl/sh-pfc/pfc-r8a7790.c ?
> 
> I do not have a strong opinion but changing it sounds entirely reasonable to
> me.

The errata renamed the pin, but the latest datasheet, supposed to include the 
errata, still uses eth_magic. Let's not bother then (even though wol would be 
much more descriptive than magic).

> > > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> > > +				  "eth_mdio", "eth"),
> > > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> > > +				  "eth_rmii", "eth"),
> > > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> > > +				  "intc_irq0", "intc"),
> > >  };
> > >  
> > >  static void __init lager_add_standard_devices(void)
> > > @@ -89,6 +111,8 @@ static void __init lager_add_standard_devices(void)
> > >  	r8a7790_pinmux_init();
> > >  	r8a7790_add_standard_devices();
> > > +	r8a7790_add_ether_device(&ether_platdata);
> > > +
> > >  	platform_device_register_data(&platform_bus, "leds-gpio", -1,
> > >  				      &lager_leds_pdata,
> > >  				      sizeof(lager_leds_pdata));

-- 
Regards,

Laurent Pinchart
