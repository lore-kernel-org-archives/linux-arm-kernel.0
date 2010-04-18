From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 18 Apr 2010 04:07:26 +0200
Subject: [PATCHv4 2.6.34-rc4 5/7] mxc: Add generic USB HW
	initialization for MX51
In-Reply-To: <1271445371-18501-5-git-send-email-Dinh.Nguyen@freescale.com>
References: <1271445371-18501-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-4-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-5-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100418020726.GB7882@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 02:16:09PM -0500, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> This patch adds USB HW initializiation code to /plat-mxc/ehci.c.
> 	-Stops and resets USB HW
> 	-Sets some specific PHY settings
> 	-Stop and restart the USB HW.
> Renames mxc_set_usbcontrol to mxc_initialize_usb_hw.
> 
> This patch applies to 2.6.34-rc4.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/plat-mxc/ehci.c                  |  128 ++++++++++++++++++++++++++++-
>  arch/arm/plat-mxc/include/mach/mxc_ehci.h |    2 +-
>  2 files changed, 127 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
> index cb0b638..35ff1c1 100644
> --- a/arch/arm/plat-mxc/ehci.c
> +++ b/arch/arm/plat-mxc/ehci.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
> + * Copyright (C) 2010 Freescale Semiconductor, Inc.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> @@ -18,6 +19,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/mxc_ehci.h>
> @@ -50,9 +52,14 @@
>  #define MX35_H1_TLL_BIT		(1 << 5)
>  #define MX35_H1_USBTE_BIT	(1 << 4)
>  
> -int mxc_set_usbcontrol(int port, unsigned int flags)
> +int mxc_intialize_usb_hw(int port, unsigned int flags)
>  {
>  	unsigned int v;
> +	void __iomem *usb_base;
> +	u32 usbotg_base;
> +	u32 usbother_base;
> +	int timeout;
> +	int ret = 0;
>  #ifdef CONFIG_ARCH_MX3
>  	if (cpu_is_mx31()) {
>  		v = readl(MX31_IO_ADDRESS(MX31_OTG_BASE_ADDR +
> @@ -186,9 +193,126 @@ int mxc_set_usbcontrol(int port, unsigned int flags)
>  		return 0;
>  	}
>  #endif /* CONFIG_MACH_MX27 */
> +#ifdef CONFIG_ARCH_MX51
> +	if (cpu_is_mx51()) {
> +		usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
> +
> +		switch (port) {
> +		case 0:	/* OTG port */
> +			usbotg_base = (u32)usb_base + USBOTG_OFFSET;
> +			break;
> +		case 1:	/* Host 1 port */
> +			usbotg_base = (u32)usb_base + USBH1_OFFSET;
> +			break;
> +		default:
> +			printk(KERN_ERR"%s no such port %d\n", __func__, port);
> +			ret = -ENOENT;
> +			goto error;
> +		}
> +		usbother_base = (u32)usb_base + USBOTHER_REGS_OFFSET;
> +
> +		/* Stop then Reset */
> +		v = __raw_readl(usbotg_base + USBCMD_OFFSET);
> +		v &= ~UCMD_RUN_STOP;
> +		__raw_writel(v, usbotg_base + USBCMD_OFFSET);
> +		timeout = 0x100000;
> +		while (--timeout && __raw_readl(usbotg_base + USBCMD_OFFSET) & UCMD_RUN_STOP)
> +			cpu_relax();
> +		if (!timeout) {
> +			printk(KERN_ERR "%s could not stop usb hardware\n", __func__);
> +			ret = -ETIMEDOUT;
> +			goto error;
> +		}
> +
> +		v = __raw_readl(usbotg_base + USBCMD_OFFSET);
> +		v |= UCMD_RESET;
> +		__raw_writel(v, usbotg_base + USBCMD_OFFSET);
> +		timeout = 0x100000;
> +		while (--timeout && __raw_readl(usbotg_base + USBCMD_OFFSET) & UCMD_RESET)
> +			cpu_relax();
> +		if (!timeout) {
> +			printk(KERN_ERR "%s could not reset usb hardware\n", __func__);
> +			ret = -ETIMEDOUT;
> +			goto error;
> +		}
> +
> +		switch (port) {
> +		case 0:	/*OTG port */
> +			v = __raw_readl(usbother_base + USB_PHY_CTR_FUNC_OFFSET);
> +			v |= USB_UTMI_PHYCTRL_OC_DIS; /* OC is not used */
> +			__raw_writel(v, usbother_base + USB_PHY_CTR_FUNC_OFFSET);
> +
> +			v = __raw_readl(usbother_base + USBCTRL_OFFSET);
> +			v &= ~(UCTRL_OPM | UCTRL_OWIE);/* OTG wakeup/power mask disable */
> +			__raw_writel(v, usbother_base + USBCTRL_OFFSET);
> +
> +			/* Set the PHY clock to 19.2MHz */
> +			v = __raw_readl(usbother_base + USB_PHY_CTR_FUNC2_OFFSET);
> +			v &= ~USB_UTMI_PHYCTRL2_PLLDIV_MASK;
> +			v |= 0x01;
> +			__raw_writel(v, usbother_base + USB_PHY_CTR_FUNC2_OFFSET);
> +			break;

The sense of this funtion is to make the interface configuration,
especially the receiver type configurable with the flags parameter to
this function. This all looks very specific to your board, flags is
completely unused.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
