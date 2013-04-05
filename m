From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Apr 2013 09:43:56 +0900
Subject: [PATCH 5/8] rcar-phy: correct base address
In-Reply-To: <201304050305.15517.sergei.shtylyov@cogentembedded.com>
References: <201304050305.15517.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130405004356.GP29203@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 03:05:14AM +0400, Sergei Shtylyov wrote:
> The memory region that is used by the driver overlaps EHCI and OHCI register
> regions for absolutely no reason now  -- fix it by adding offset of 0x800 to
> the base address, changing the register #define's accordingly. This has extra
> positive effect that we now can use devm_ioremap_resource().
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

As per my comment regarding patch 4, I wonder if this
could be split into a driver patch and an SoC patch.

> 
> ---
>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
>  drivers/usb/phy/rcar-phy.c             |   28 ++++++++++------------------
>  2 files changed, 11 insertions(+), 19 deletions(-)
> 
> Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -401,7 +401,7 @@ static struct platform_device sata_devic
>  /* USB PHY */
>  static struct resource usb_phy_resources[] = {
>  	[0] = {
> -		.start		= 0xffe70000,
> +		.start		= 0xffe70800,
>  		.end		= 0xffe70900 - 1,
>  		.flags		= IORESOURCE_MEM,
>  	},
> Index: renesas/drivers/usb/phy/rcar-phy.c
> ===================================================================
> --- renesas.orig/drivers/usb/phy/rcar-phy.c
> +++ renesas/drivers/usb/phy/rcar-phy.c
> @@ -16,13 +16,13 @@
>  #include <linux/spinlock.h>
>  #include <linux/module.h>
>  
> -/* USBH common register */
> -#define USBPCTRL0	0x0800
> -#define USBPCTRL1	0x0804
> -#define USBST		0x0808
> -#define USBEH0		0x080C
> -#define USBOH0		0x081C
> -#define USBCTL0		0x0858
> +/* REGS block */
> +#define USBPCTRL0	0x00
> +#define USBPCTRL1	0x04
> +#define USBST		0x08
> +#define USBEH0		0x0C
> +#define USBOH0		0x1C
> +#define USBCTL0		0x58
>  
>  /* USBPCTRL1 */
>  #define PHY_RST		(1 << 2)
> @@ -139,17 +139,9 @@ static int rcar_usb_phy_probe(struct pla
>  		return -EINVAL;
>  	}
>  
> -	/*
> -	 * CAUTION
> -	 *
> -	 * Because this phy address is also mapped under OHCI/EHCI address area,
> -	 * this driver can't use devm_request_and_ioremap(dev, res) here
> -	 */
> -	reg0 = devm_ioremap_nocache(dev, res0->start, resource_size(res0));
> -	if (!reg0) {
> -		dev_err(dev, "ioremap error\n");
> -		return -ENOMEM;
> -	}
> +	reg0 = devm_ioremap_resource(dev, res0);
> +	if (IS_ERR(reg0))
> +		return PTR_ERR(reg0);
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv) {
> 
