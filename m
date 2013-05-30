From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 30 May 2013 14:51:13 +0200
Subject: [PATCH] ARM: imx: Remove mxc specific ulpi access ops
In-Reply-To: <1369917895-9562-1-git-send-email-mpa@pengutronix.de>
References: <1369917895-9562-1-git-send-email-mpa@pengutronix.de>
Message-ID: <51A74B41.5010909@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2013 02:44 PM, Markus Pargmann wrote:
> There are ulpi access ops implemented in drivers/usb/phy/phy-ulpi.c.
> mxc access ops implement the same access operations within mach-imx. This
> patch removes the mxc ulpi file and uses phy-ulpi instead for
> imx_otg_ulpi_create.
> 
> phy-ulpi successfully tested with i.MX27 Phytec phyCARD-S (pca100).
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/Kconfig       |   1 +
>  arch/arm/mach-imx/Makefile      |   1 -
>  arch/arm/mach-imx/mach-pca100.c |   4 +-
>  arch/arm/mach-imx/ulpi.c        | 118 ----------------------------------------
>  arch/arm/mach-imx/ulpi.h        |   9 ++-
>  5 files changed, 9 insertions(+), 124 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/ulpi.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index ba44328..ca59799 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -58,6 +58,7 @@ config MXC_USE_EPIT
>  
>  config MXC_ULPI
>  	bool
> +	select USB_ULPI_VIEWPORT
>  
>  config ARCH_HAS_RNGA
>  	bool
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 70ae7c4..dcb8291 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -23,7 +23,6 @@ obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
>  obj-$(CONFIG_MXC_TZIC) += tzic.o
>  obj-$(CONFIG_MXC_AVIC) += avic.o
>  
> -obj-$(CONFIG_MXC_ULPI) += ulpi.o
>  obj-$(CONFIG_MXC_USE_EPIT) += epit.o
>  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
>  
> diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
> index b8b15bb..19bb644 100644
> --- a/arch/arm/mach-imx/mach-pca100.c
> +++ b/arch/arm/mach-imx/mach-pca100.c
> @@ -398,8 +398,8 @@ static void __init pca100_init(void)
>  		imx27_add_fsl_usb2_udc(&otg_device_pdata);
>  	}
>  
> -	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
> -				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
> +	usbh2_pdata.otg = imx_otg_ulpi_create(
> +			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);

Why don't you keep otg_ulpi_create()?

http://lxr.free-electrons.com/source/include/linux/usb/ulpi.h#L185

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130530/7195f3ed/attachment.sig>
