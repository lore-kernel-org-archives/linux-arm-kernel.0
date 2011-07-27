From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jul 2011 10:19:35 +0200
Subject: [PATCH v3 4/6] ARM: mxs: make ehci-mxc more flexible to be used
	on	different platforms
In-Reply-To: <1311744574-3610-5-git-send-email-tony.lin@freescale.com>
References: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
	<1311744574-3610-5-git-send-email-tony.lin@freescale.com>
Message-ID: <4E2FCA17.7010606@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2011 07:29 AM, Tony Lin wrote:
> change ehci_irq to mxc_ehci_irq to give chance do some platform specific
> actions in irq handler for different platforms.
> add void pointer in the last of mxc_usbh_platform_data structure so that
> additional information could be added to that field if needed.
> 
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/hardware.h |    2 ++
>  arch/arm/mach-mxs/include/mach/mxs.h      |   12 +++++++++++-
>  drivers/usb/host/Kconfig                  |    2 +-
>  drivers/usb/host/ehci-mxc.c               |   15 ++++++++++++++-
>  include/linux/fsl_devices.h               |    2 ++
>  5 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
> index 53e89a0..affa72b 100644
> --- a/arch/arm/mach-mxs/include/mach/hardware.h
> +++ b/arch/arm/mach-mxs/include/mach/hardware.h
> @@ -26,4 +26,6 @@
>  #define IOMEM(addr)	((void __force __iomem *)(addr))
>  #endif
>  
> +#include "mxs.h"
> +
>  #endif /* __MACH_MXS_HARDWARE_H__ */
> diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
> index 35a89dd..0661e90 100644
> --- a/arch/arm/mach-mxs/include/mach/mxs.h
> +++ b/arch/arm/mach-mxs/include/mach/mxs.h
> @@ -35,7 +35,17 @@
>  		machine_is_mx28evk() ||					\
>  		machine_is_tx28() ||					\
>  		0)
> -
> +#define cpu_is_mx1()		0
> +#define cpu_is_mx21()		0
> +#define cpu_is_mx25()		0
> +#define cpu_is_mx27()		0
> +#define cpu_is_mx31()		0
> +#define cpu_is_mx35()		0
> +#define cpu_is_mx50()		0
> +#define cpu_is_mx51()		0
> +#define cpu_is_mx53()		0
> +#define cpu_is_mx3()		(cpu_is_mx31() || cpu_is_mx35())
> +#define cpu_is_mx2()		(cpu_is_mx21() || cpu_is_mx27())
>  /*
>   * IO addresses common to MXS-based
>   */
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index ab085f1..6a5905b 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -139,7 +139,7 @@ config USB_EHCI_FSL
>  
>  config USB_EHCI_MXC
>  	bool "Support for Freescale on-chip EHCI USB controller"
> -	depends on USB_EHCI_HCD && ARCH_MXC
> +	depends on USB_EHCI_HCD && (ARCH_MXC || ARCH_MXS)
>  	select USB_EHCI_ROOT_HUB_TT
>  	---help---
>  	  Variation of ARC USB block used in some Freescale chips.
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index cbf60a6..c93f9ae 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -64,6 +64,19 @@ static int ehci_mxc_setup(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> +static irqreturn_t mxc_ehci_irq(struct usb_hcd *hcd)
> +{
> +	struct mxc_usbh_platform_data *pdata;
> +
> +	pdata = hcd->self.controller->platform_data;
> +	if (pdata->plt_irq_handler == NULL)
> +		goto out;
> +	pdata->plt_irq_handler(pdata);
> +
> +out:
> +	return ehci_irq(hcd);

Writing it this way, the code would be shorter more readable:
{
	struct mxc_usbh_platform_data *pdata = hcd->self.controller->platform_data;

	if (pdata->plt_irq_handler)
		pdata->plt_irq_handler(pdata);

	return ehci_irq(hcd);
}
> +}
> +
>  static const struct hc_driver ehci_mxc_hc_driver = {
>  	.description = hcd_name,
>  	.product_desc = "Freescale On-Chip EHCI Host Controller",
> @@ -72,7 +85,7 @@ static const struct hc_driver ehci_mxc_hc_driver = {
>  	/*
>  	 * generic hardware linkage
>  	 */
> -	.irq = ehci_irq,
> +	.irq = mxc_ehci_irq,
>  	.flags = HCD_USB2 | HCD_MEMORY,
>  
>  	/*
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index cb19260..cf441e8 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -120,6 +120,8 @@ struct mxc_usbh_platform_data {
>  
>  	unsigned int		portsc;
>  	struct otg_transceiver	*otg;
> +	void (*plt_irq_handler)(struct mxc_usbh_platform_data *pdata);
> +	void		*ppriv;

In linux we don't prefix pointers with "p", so void *priv is referred.

>  };
>  
>  struct spi_device;

cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110727/0f634249/attachment.sig>
