From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 4 Feb 2010 17:26:29 +0100
Subject: [PATCH 4/8] i.MX35: Add USB control register access support
In-Reply-To: <1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100204162629.GV6130@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 04:03:41PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Daniel Mack <daniel@caiaq.de>
> ---
>  arch/arm/plat-mxc/ehci.c                  |   55 +++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mxc_ehci.h |    4 ++
>  2 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
> index 816a9cc..94b0036 100644
> --- a/arch/arm/plat-mxc/ehci.c
> +++ b/arch/arm/plat-mxc/ehci.c
> @@ -38,6 +38,18 @@
>  #define MX31_H1_PM_BIT		(1 << 8)
>  #define MX31_H1_DT_BIT		(1 << 4)
>  
> +#define MX35_OTG_SIC_SHIFT	29
> +#define MX35_OTG_SIC_MASK	(0x3 << MX35_OTG_SIC_SHIFT)
> +#define MX35_OTG_PM_BIT		(1 << 24)
> +
> +#define MX35_H1_SIC_SHIFT	21
> +#define MX35_H1_SIC_MASK	(0x3 << MX35_H1_SIC_SHIFT)
> +#define MX35_H1_PM_BIT		(1 << 8)
> +#define MX35_OTG_IPPUE_UP_BIT	(1 << 7)
> +#define MX35_OTG_IPPUE_DOWN_BIT	(1 << 6)
> +#define MX35_H1_TLL_BIT		(1 << 5)
> +#define MX35_OTG_USBTE_BIT	(1 << 4)
> +
>  int mxc_set_usbcontrol(int port, unsigned int flags)
>  {
>  	unsigned int v;
> @@ -85,6 +97,49 @@ int mxc_set_usbcontrol(int port, unsigned int flags)
>  				     USBCTRL_OTGBASE_OFFSET));
>  		return 0;
>  	}
> +
> +	if (cpu_is_mx35()) {
> +		v = readl(MX35_IO_ADDRESS(MX35_OTG_BASE_ADDR +
> +				     USBCTRL_OTGBASE_OFFSET));
> +
> +		switch (port) {
> +		case 0:	/* OTG port */
> +			v &= ~(MX35_OTG_SIC_MASK | MX35_OTG_PM_BIT);
> +			v |= (flags & MXC_EHCI_INTERFACE_MASK)
> +					<< MX35_OTG_SIC_SHIFT;
> +			if (!(flags & MXC_EHCI_POWER_PINS_ENABLED))
> +				v |= MX35_OTG_PM_BIT;
> +
> +			break;
> +		case 1: /* H1 port */
> +			v &= ~(MX35_H1_SIC_MASK | MX35_H1_PM_BIT | MX35_H1_TLL_BIT |
> +				MX35_OTG_USBTE_BIT | MXC_EHCI_IPPUE_DOWN | MXC_EHCI_IPPUE_UP);

Gna, of course the MX35_OTG_USBTE_BIT / MX35_OTG_IPPUE_UP_BIT bits
should be cleared here, not the generic defines.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
