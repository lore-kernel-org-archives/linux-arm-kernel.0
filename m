From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Oct 2012 18:45:55 +0300
Subject: [PATCH] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
In-Reply-To: <1350488622-6057-1-git-send-email-balbi@ti.com>
References: <20121016230040.GP15569@atomide.com>
 <1350488622-6057-1-git-send-email-balbi@ti.com>
Message-ID: <20121017154555.GM11394@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 17, 2012 at 06:43:41PM +0300, Felipe Balbi wrote:
> In order to make single zImage work for ARM architecture,
> we need to make sure we don't depend on private headers.
> 
> Move USB platform_data to <linux/platform_data/omap-usb.h>
> and keep only internal functions in <plat/usb.h>.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/usb-host.c                     |   1 +
>  arch/arm/mach-omap2/usb-musb.c                     |   1 +
>  arch/arm/mach-omap2/usb-tusb6010.c                 |   1 +
>  arch/arm/plat-omap/include/plat/usb.h              | 126 +--------------------
>  drivers/mfd/omap-usb-host.c                        |   2 +-
>  drivers/usb/musb/am35x.c                           |   3 +-
>  drivers/usb/musb/musb_dsps.c                       |   3 +-
>  drivers/usb/musb/omap2430.h                        |   2 +-
>  .../linux/platform_data/usb-omap.h                 |  80 +++++--------
>  9 files changed, 36 insertions(+), 183 deletions(-)
>  copy arch/arm/plat-omap/include/plat/usb.h => include/linux/platform_data/usb-omap.h (69%)
> 
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index 3c43449..e0c2cad 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/platform_data/usb-omap.h>
>  
>  #include <asm/io.h>
>  
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 51da21c..4fcd3a6 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -23,6 +23,7 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> +#include <linux/platform_data/usb-omap.h>
>  #include <linux/usb/musb.h>
>  
>  #include <plat/usb.h>
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
> index 805bea6..5e24289 100644
> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ b/arch/arm/mach-omap2/usb-tusb6010.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
>  #include <linux/export.h>
> +#include <linux/platform_data/usb-omap.h>
>  
>  #include <linux/usb/musb.h>
>  
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 87ee140..550e40e 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -3,86 +3,15 @@
>  #ifndef	__ASM_ARCH_OMAP_USB_H
>  #define	__ASM_ARCH_OMAP_USB_H
>  
> -#include <linux/io.h>
>  #include <linux/platform_device.h>
> -#include <linux/usb/musb.h>
> -
> -#define OMAP3_HS_USB_PORTS	3
> -
> -enum usbhs_omap_port_mode {
> -	OMAP_USBHS_PORT_MODE_UNUSED,
> -	OMAP_EHCI_PORT_MODE_PHY,
> -	OMAP_EHCI_PORT_MODE_TLL,
> -	OMAP_EHCI_PORT_MODE_HSIC,
> -	OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0,
> -	OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM,
> -	OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
> -	OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM,
> -	OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0,
> -	OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM,
> -	OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0,
> -	OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM,
> -	OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0,
> -	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
> -};
> -
> -struct usbhs_omap_board_data {
> -	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> -
> -	/* have to be valid if phy_reset is true and portx is in phy mode */
> -	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
> -
> -	/* Set this to true for ES2.x silicon */
> -	unsigned			es2_compatibility:1;
> -
> -	unsigned			phy_reset:1;
> -
> -	/*
> -	 * Regulators for USB PHYs.
> -	 * Each PHY can have a separate regulator.
> -	 */
> -	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
> -};
> +#include <linux/platform_data/usb-omap.h>
>  
>  #ifdef CONFIG_ARCH_OMAP2PLUS
>  
> -struct ehci_hcd_omap_platform_data {
> -	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> -	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
> -	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
> -	unsigned			phy_reset:1;
> -};
> -
> -struct ohci_hcd_omap_platform_data {
> -	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> -	unsigned			es2_compatibility:1;
> -};
> -
> -struct usbhs_omap_platform_data {
> -	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
> -
> -	struct ehci_hcd_omap_platform_data	*ehci_data;
> -	struct ohci_hcd_omap_platform_data	*ohci_data;
> -};
>  
>  struct usbtll_omap_platform_data {
>  	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
>  };

looks like should be moved too... I'll respin the patch.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121017/c35f9a6e/attachment-0001.sig>
