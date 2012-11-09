From: balbi@ti.com (Felipe Balbi)
Date: Fri, 9 Nov 2012 16:30:34 +0200
Subject: [PATCHv2] ARM: OMAP4: USB: power down MUSB PHY during boot
In-Reply-To: <1352471435-9560-1-git-send-email-t-kristo@ti.com>
References: <1352471435-9560-1-git-send-email-t-kristo@ti.com>
Message-ID: <20121109143033.GB10718@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Fri, Nov 09, 2012 at 04:30:35PM +0200, Tero Kristo wrote:
> Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
> PHY functions for OMAP4, but this causes a problem with core retention
> as the MUSB module remains enabled if omap-usb2 phy driver is not used.
> This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.
> 
> Fixed by adding a minimal function back that disables the USB PHY during
> boot.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>

looks good to me. I would still suggest adding a REVISIT or FIXME note
stating that this should be moved to SCM driver eventually ;-)

Other than that:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |   32 +++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index d992db8..9b56e5e 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -33,6 +33,38 @@
>  #include "soc.h"
>  #include "control.h"
>  
> +#define CONTROL_DEV_CONF		0x300
> +#define PHY_PD				0x1
> +
> +/**
> + * omap4430_phy_power_down: disable MUSB PHY during early init
> + *
> + * OMAP4 MUSB PHY module is enabled by default on reset, but this will
> + * prevent core retention if not disabled by SW. USB driver will
> + * later on enable this, once and if the driver needs it.
> + */
> +static int __init omap4430_phy_power_down(void)
> +{
> +	void __iomem *ctrl_base;
> +
> +	if (!cpu_is_omap44xx())
> +		return 0;
> +
> +	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
> +	if (!ctrl_base) {
> +		pr_err("control module ioremap failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Power down the phy */
> +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> +
> +	iounmap(ctrl_base);
> +
> +	return 0;
> +}
> +early_initcall(omap4430_phy_power_down);
> +
>  void am35x_musb_reset(void)
>  {
>  	u32	regval;
> -- 
> 1.7.4.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/5604756b/attachment.sig>
