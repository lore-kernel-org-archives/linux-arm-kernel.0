From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 May 2014 10:39:53 -0500
Subject: [PATCH v3 06/20] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <1399335255-589-7-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140506153953.GF25849@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 06, 2014 at 02:14:01AM +0200, Gregory CLEMENT wrote:
> For the Armada 38x SoCs which come with an xhci controller, specific
> initialization must be done during probe related to the MBus windows
> configuration. This patch adds the support of this quirk.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/usb/host/Kconfig      |  7 +++++
>  drivers/usb/host/Makefile     |  1 +
>  drivers/usb/host/xhci-mvebu.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-mvebu.h | 21 +++++++++++++
>  drivers/usb/host/xhci-plat.c  |  6 ++++
>  5 files changed, 106 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-mvebu.c
>  create mode 100644 drivers/usb/host/xhci-mvebu.h
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 3d9e54062d62..e70943fac4a1 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -29,6 +29,13 @@ if USB_XHCI_HCD
>  config USB_XHCI_PLATFORM
>  	tristate
>  
> +config USB_XHCI_MVEBU
> +	tristate "xHCI support for Marvell Armada 38x"
> +	select USB_XHCI_PLATFORM
> +	---help---
> +	  Say 'Y' to enable the support for the xHCI host controller
> +	  found in Marvell Armada 38x ARM SOCs.
> +
>  endif # USB_XHCI_HCD
>  
>  config USB_EHCI_HCD
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 7530468c9a4f..7a8db7f7dc01 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -19,6 +19,7 @@ xhci-hcd-$(CONFIG_PCI)	+= xhci-pci.o
>  
>  ifneq ($(CONFIG_USB_XHCI_PLATFORM), )
>  	xhci-hcd-y		+= xhci-plat.o
> +	xhci-hcd-$(CONFIG_USB_XHCI_MVEBU)	+= xhci-mvebu.o

hmm, this has the potential of resulting in:

	xhci-hcd-m += xhci-mvebu.o

I guess it's best to turn this into:

ifneq ($(CONFIG_USB_XHCI_PLATFORM), )
	xhci-hcd-y += xhci-mvebu.o
endif

no ? Other than this comment:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/e9db2c71/attachment.sig>
