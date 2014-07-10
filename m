From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 10 Jul 2014 14:23:11 -0400 (EDT)
Subject: [PATCH 1/3] usb: host: st-hcd: Add USB HCD support for STi SoCs
In-Reply-To: <1405005486-26355-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1407101154070.1492-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jul 2014, Peter Griffin wrote:

> This driver adds support for the USB HCD present in STi
> SoC's from STMicroelectronics. It has been tested on the
> stih416-b2020 board.

This driver file, along with the Kconfig changes, belongs in the
arch/platform-specific source directory.  Not in drivers/usb/host/.  
It is, after all, a platform driver that registers two platform
devices.

> +++ b/drivers/usb/host/Kconfig
> @@ -753,6 +753,23 @@ config USB_HCD_SSB
>  
>  	  If unsure, say N.
>  
> +config USB_HCD_ST
> +	tristate "STMicroelectronics STi family HCD support"

Why does this need to be tristate?  Why not always build it into the 
kernel?  Or at least make it boolean rather than tristate.

> +	depends on ARCH_STI
> +	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> +	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
> +	select MFD_SYSCON
> +	select GENERIC_PHY
> +	help
> +	  Enable support for the EHCI and OCHI host controller on ST

s/OCHI/OHCI/

> + 	  consumer electronics SoCs.
> +
> + 	  It converts the ST driver into two platform device drivers

It converts the ST driver?  That doesn't sound right at all.  You could 
eliminate this paragraph completely and nobody would miss it.

> + 	  for EHCI and OHCI and provides bus configuration, clock and power
> + 	  management for the combined hardware block.

Alan Stern
