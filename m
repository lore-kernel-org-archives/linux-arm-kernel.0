From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 13 Apr 2010 19:30:41 +0200
Subject: [PATCH 2.6.34-rc4 4/8] mx5: Add USB OTG port registration
In-Reply-To: <1271175030-3635-4-git-send-email-Dinh.Nguyen@freescale.com>
References: <1271175030-3635-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271175030-3635-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1271175030-3635-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1271175030-3635-4-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100413173041.GP30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 13, 2010 at 11:10:27AM -0500, Dinh.Nguyen at freescale.com wrote:
> This patch adds the device platform registration for enabling USB
> host functionality on the OTG port on Freescale MX51 Babbage HW. This
> file makes platform specific calls to initialize the USB HW.
> 
> This patch applies to 2.6.34-rc4.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/mach-mx5/Makefile             |    2 +-
>  arch/arm/mach-mx5/board-mx51_babbage.c |    4 ++
>  arch/arm/mach-mx5/usb_dr.c             |   57 ++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/usb_dr.c
> 
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index bf23f86..3fca1f1 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Object file lists.
> -obj-y   := cpu.o mm.o clock-mx51.o devices.o
> +obj-y   := cpu.o mm.o clock-mx51.o devices.o usb_dr.o
>  
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
>  
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index afbe400..4e196d7 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -27,6 +27,8 @@
>  
>  #include "devices.h"
>  
> +extern void __init mx5_usb_dr_init(void);
> +
>  static struct platform_device *devices[] __initdata = {
>  	&mxc_fec_device,
>  };
> @@ -78,6 +80,8 @@ static void __init mxc_board_init(void)
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  
>  	mxc_register_gpios();
> +
> +	mx5_usb_dr_init();
>  }
>  
>  static void __init mx51_babbage_timer_init(void)
> diff --git a/arch/arm/mach-mx5/usb_dr.c b/arch/arm/mach-mx5/usb_dr.c
> new file mode 100644
> index 0000000..52273ea
> --- /dev/null
> +++ b/arch/arm/mach-mx5/usb_dr.c
> @@ -0,0 +1,57 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <mach/mxc_ehci.h>
> +#include <mach/common.h>
> +#include "devices.h"
> +
> +extern int usbotg_init(struct platform_device *pdev);
> +extern int usbotg_uninit(struct platform_device *pdev);
> +
> +static int usbotg_init_ext(struct platform_device *pdev);
> +static int usbotg_uninit_ext(struct platform_device *pdev);
> +
> +/*
> + * platform data structs
> + * 	- Which one to use is determined by CONFIG options in usb.h
> + * 	- operating_mode plugged at run time
> + */
> +static struct mxc_usbh_platform_data dr_utmi_config = {
> +	.init	= usbotg_init_ext,
> +	.exit	= usbotg_uninit_ext,
> +	.portsc	= MXC_EHCI_UTMI_16BIT,
> +	.flags	= MXC_EHCI_INTERNAL_PHY,
> +};

This is also board specific, and nothing you should assume for all
boards. Other implementations may do this differntly, which is why
this belongs to board code.

> +/* Notes: configure USB clock*/
> +static int usbotg_init_ext(struct platform_device *pdev)
> +{
> +	return usbotg_init(pdev);
> +}
> +
> +static int usbotg_uninit_ext(struct platform_device *pdev)
> +{
> +	return usbotg_uninit(pdev);
> +}
> +
> +void __init mx5_usb_dr_init(void)
> +{
> +	mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
> +}

What's the reason for having the _ext variants that are just wrapers?
