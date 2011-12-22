From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 22 Dec 2011 07:53:00 +0100
Subject: [PATCH] usb: gadget: Fix build error due to selection of
 USB_FSL_MPH_DR_OF by ARCH_MXC
In-Reply-To: <1324492640-25481-1-git-send-email-fabio.estevam@freescale.com>
References: <1324492640-25481-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20210.54220.176541.407719@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam writes:
> USB_FSL_MPH_DR_OF is a PowerPC driver and should not be selected by ARCH_MXC.
> 
> Doing a 'make mx3_defconfig' and selecting i.MX6 we get:
> 
> CC [M]  drivers/usb/host/fsl-mph-dr-of.o
> drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
> drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
> 
> Fix this error by not allowing USB_FSL_MPH_DR_OF to be selected by ARCH_MXC.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/usb/gadget/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 23a4473..0148676 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -159,7 +159,7 @@ config USB_FSL_USB2
>  	tristate "Freescale Highspeed USB DR Peripheral Controller"
>  	depends on FSL_SOC || ARCH_MXC
>  	select USB_GADGET_DUALSPEED
> -	select USB_FSL_MPH_DR_OF if OF
> +	select USB_FSL_MPH_DR_OF if OF && !ARCH_MXC
>
You could probably use 'FSL_SOC' instead of '!ARCH_MXC', like it is
done for the USB host controller:
|config USB_EHCI_FSL
|	bool "Support for Freescale on-chip EHCI USB controller"
|	depends on USB_EHCI_HCD && FSL_SOC
|	select USB_EHCI_ROOT_HUB_TT
|	select USB_FSL_MPH_DR_OF if OF
|	---help---
|	  Variation of ARC USB block used in some Freescale chips.
|
|config USB_EHCI_MXC
|	bool "Support for Freescale on-chip EHCI USB controller"
|	depends on USB_EHCI_HCD && ARCH_MXC
|	select USB_EHCI_ROOT_HUB_TT
|	---help---
|	  Variation of ARC USB block used in some Freescale chips.

Otherwise you would have the same trouble again, if e.g. ARCH_MXS
should be added to the dependency list of USB_FSL_USB2.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
