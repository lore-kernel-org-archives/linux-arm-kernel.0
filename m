From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 21 Jul 2011 08:04:36 +0200
Subject: [PATCH 4/7] mx28: add usb host phy functions
In-Reply-To: <1311160106-4898-5-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-5-git-send-email-tony.lin@freescale.com>
Message-ID: <20007.49524.161986.250404@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Tony Lin writes:
> add usb phy register definitions and functions
> usb host driver will use these functions to initialize
> usb phy and change phy working mode
> 
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
>  arch/arm/mach-mxs/Kconfig            |    1 +
>  arch/arm/mach-mxs/Makefile           |    1 +
>  arch/arm/mach-mxs/regs-usbphy-mx28.h |  323 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/usb_h1.c           |  230 ++++++++++++++++++++++++
>  4 files changed, 555 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 4cd0231..1c4264f 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -49,6 +49,7 @@ config MACH_MX28EVK
>  	select MXS_HAVE_PLATFORM_MXS_MMC
>  	select MXS_HAVE_PLATFORM_MXSFB
>  	select MXS_OCOTP
> +	select USB_ARCH_HAS_EHCI
>  	help
>  	  Include support for MX28EVK platform. This includes specific
>  	  configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> index 6c38262..48fc2f5 100644
> --- a/arch/arm/mach-mxs/Makefile
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -12,5 +12,6 @@ obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
>  obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
>  obj-$(CONFIG_MODULE_TX28) += module-tx28.o
>  obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
> +obj-$(CONFIG_USB_EHCI_MXC)   += usb_h1.o
>  
>  obj-y += devices/
> diff --git a/arch/arm/mach-mxs/regs-usbphy-mx28.h b/arch/arm/mach-mxs/regs-usbphy-mx28.h
> new file mode 100644
> index 0000000..a367927
> --- /dev/null
> +++ b/arch/arm/mach-mxs/regs-usbphy-mx28.h
> @@ -0,0 +1,323 @@
> +/*
> + * Freescale USBPHY Register Definitions
> + *
> + * Copyright 2008-2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + *
> + * This file is created by xml file. Don't Edit it.
> + *
> + * Xml Revision: 1.52
> + * Template revision: 26195
> + */
> +
> +#ifndef __ARCH_ARM___USBPHY_H
> +#define __ARCH_ARM___USBPHY_H
> +
> +
> +#define HW_USBPHY_PWD	(0x00000000)
> +#define HW_USBPHY_PWD_SET	(0x00000004)
> +#define HW_USBPHY_PWD_CLR	(0x00000008)
> +#define HW_USBPHY_PWD_TOG	(0x0000000c)
> +
You should educate your file generator to omit those silly parens.

> diff --git a/arch/arm/mach-mxs/usb_h1.c b/arch/arm/mach-mxs/usb_h1.c
> new file mode 100644
> index 0000000..9ca5236
> --- /dev/null
> +++ b/arch/arm/mach-mxs/usb_h1.c
> @@ -0,0 +1,230 @@
> +/*
> + * Copyright (C) 2009-2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/gpio.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/irqs.h>
> +#include <mach/mx28.h>
> +#include "regs-usbphy-mx28.h"
> +
> +/* EHCI registers: */
> +#define UOG_USBCMD		(0x140)/* USB command register */
> +#define UOG_PORTSC1		(0x184)/* port status and control */
> +/* x_PORTSCx */
> +#define PORTSC_PTS_MASK		(3 << 30)/* parallel xcvr mask */
> +#define PORTSC_PTS_UTMI		(0 << 30)/* UTMI/UTMI+ */
> +#define PORTSC_PTW		(1 << 28)/* UTMI width */
> +/* USBCMD */
> +#define UCMD_RUN_STOP           (1 << 0)/* controller run/stop */
> +#define UCMD_RESET		(1 << 1)/* controller reset */
> +
A space between the value and the comment would be nice.

> +#define HOSTPHY_CONNECT_STATE	(1 << 3)
> +
> +static struct clk *usb_clk;
> +static struct clk *usb_phy_clk;
> +static int internal_phy_clk_already_on;
> +
> +/* The dmamask must be set for EHCI to work */
> +static u64 ehci_dmamask = ~(u32) 0;
> +static int instance_id = ~(u32) 0;
> +
> +static int fsl_platform_get_usb_conn_status(void)
> +{
> +	u32 status;
> +
> +	status = __raw_readl(MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR) + \
> +			HW_USBPHY_STATUS);
> +	return ((status & HOSTPHY_CONNECT_STATE) == 0);
> +}
> +
> +/* enable/disable high-speed disconnect detector of phy ctrl */
> +static void fsl_platform_set_usb_phy_dis(int enable)
> +{
> +	if (enable)
> +		__raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> +		MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR) + HW_USBPHY_CTRL_SET);
> +	else
> +		__raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> +		MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR) + HW_USBPHY_CTRL_CLR);
> +}
> +
> +static int usb_phy_enable(struct mxc_usbh_platform_data *pdata)
> +{
> +	u32 tmp;
> +	void __iomem *phy_reg = MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR);
> +	void __iomem *usb_reg = MX28_IO_ADDRESS(MX28_USBCTRL1_BASE_ADDR);
> +	void __iomem *usbcmd, *phy_ctrl, *portsc;
> +	/* Reset USB IP */
> +	usbcmd = usb_reg + UOG_USBCMD;
> +	tmp = __raw_readl(usbcmd); /* usb command */
> +	tmp &= ~UCMD_RUN_STOP;
> +	__raw_writel(tmp, usbcmd);
> +	while (__raw_readl(usbcmd) & UCMD_RUN_STOP)
> +		;
>
This loop (and the subsequent similar ones) should be bounded in case
the condition never becomes true.
Otherwise the return type could be changed to void, since the return
value is always zero and not even checked by the caller.

> +	tmp |= UCMD_RESET;
> +	__raw_writel(tmp, usbcmd);
> +	while (__raw_readl(usbcmd) & UCMD_RESET)
> +		;
> +	mdelay(10);
> +	/* Reset USBPHY module */
> +	phy_ctrl = phy_reg + HW_USBPHY_CTRL;
> +	tmp = __raw_readl(phy_ctrl);
> +	tmp |= BM_USBPHY_CTRL_SFTRST;
> +	__raw_writel(tmp, phy_ctrl);
> +	udelay(10);
> +	/* Remove CLKGATE and SFTRST */
> +	tmp = __raw_readl(phy_ctrl);
> +	tmp &= ~(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL_SFTRST);
> +	__raw_writel(tmp, phy_ctrl);
> +	udelay(10);
> +	/* set UTMI xcvr */
> +	/* Workaround an IC issue for ehci driver:
> +	 * when turn off root hub port power, EHCI set
> +	 * PORTSC reserved bits to be 0, but PTW with 0
> +	 * means 8 bits tranceiver width, here change
> +	 * it back to be 16 bits and do PHY diable and
> +	 * then enable.
> +	 */
> +	portsc = usb_reg + UOG_PORTSC1;
> +	tmp = __raw_readl(portsc);
> +	tmp &=  ~PORTSC_PTS_MASK;
> +	tmp |= (PORTSC_PTS_UTMI | PORTSC_PTW);
> +	__raw_writel(tmp, portsc);
> +	/* Power up the PHY */
> +	__raw_writel(0, phy_reg + HW_USBPHY_PWD);
> +	return 0;
> +}
> +
> +static int fsl_usb_host_init(struct platform_device *pdev)
> +{
> +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> +	void __iomem *phy_reg = MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR);
> +	u32 tmp;
> +
> +	usb_phy_enable(pdata);
> +	/* enable FS/LS device */
> +	tmp = __raw_readl(phy_reg + HW_USBPHY_CTRL);
> +	tmp |= (BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3);
> +	__raw_writel(tmp, phy_reg + HW_USBPHY_CTRL);
> +
> +	return 0;
> +}
> +
> +static void usbh1_internal_phy_clock_gate(bool on)
> +{
> +	u32 tmp;
> +	void __iomem *phy_reg = MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR);
> +
> +	if (on) {
> +		internal_phy_clk_already_on += 1;
> +		if (internal_phy_clk_already_on == 1) {
> +			tmp = BM_USBPHY_CTRL_SFTRST | BM_USBPHY_CTRL_CLKGATE;
> +			__raw_writel(tmp, phy_reg + HW_USBPHY_CTRL_CLR);
> +		}
> +	} else {
> +		internal_phy_clk_already_on -= 1;
> +		if (internal_phy_clk_already_on == 0) {
> +			tmp = BM_USBPHY_CTRL_CLKGATE;
> +			__raw_writel(tmp, phy_reg + HW_USBPHY_CTRL_SET);
> +		}
> +	}
> +	if (internal_phy_clk_already_on < 0)
> +		printk(KERN_ERR "please check phy clock ON/OFF sequence\n");
>
A WARN_ON() would be appropriate here.

> +}
> +static int fsl_usb_host_init_ext(struct platform_device *pdev)
> +{
>
blank line before new function prototype.

> +	usb_clk = clk_get(NULL, "usb1");
> +	clk_enable(usb_clk);
> +	clk_put(usb_clk);
> +	usb_phy_clk = clk_get(NULL, "usb1_phy");
> +	clk_enable(usb_phy_clk);
> +	clk_put(usb_phy_clk);
> +
clk_get() may fail!
	  if (IS_ERR(usb_clk))
	  ...
	  if (IS_ERR(usb_phy_clk))
	  ...

> +	usbh1_internal_phy_clock_gate(true);
> +	return fsl_usb_host_init(pdev);
> +}
> +
> +static int fsl_usb_host_uninit_ext(struct platform_device *pdev)
> +{
> +	usbh1_internal_phy_clock_gate(false);
> +	clk_disable(usb_phy_clk);
> +	clk_disable(usb_clk);
>
The clocks have already been released by clk_put() in the
fsl_usb_host_init_ext() function. Thus they must not be used any more!
You probably should move the clk_put() from the init function to
here.

> +	return 0;
> +}
> +
> +static struct mxc_usbh_platform_data usbh1_config = {
> +	.init = fsl_usb_host_init_ext,
> +	.exit = fsl_usb_host_uninit_ext,
> +	.portsc = MXC_EHCI_MODE_ULPI,
> +	.otg = NULL,
> +	.plt_get_usb_connect_status = fsl_platform_get_usb_conn_status,
> +	.plt_usb_disconnect_detect = fsl_platform_set_usb_phy_dis,
> +};
> +
> +/* The resources for kinds of usb devices */
> +static struct resource usbh1_resources[] = {
> +	[0] = {
unnecessary index.

> +	       .start = (u32) (MX28_USBCTRL1_BASE_ADDR),
> +	       .end = (u32) (MX28_USBCTRL1_BASE_ADDR + 0x1ff),
>
pointless and wrong cast. Silly parens around MX28_USBCTRL1_BASE_ADDR.

> +	       .flags = IORESOURCE_MEM,
> +	       },
> +	[1] = {
> +	       .start = MX28_INT_USB1,
> +	       .flags = IORESOURCE_IRQ,
'.end =' missing.

> +	       },
>
strange indentation of the whole block.

> +};
> +
> +static int __init usbh1_init(void)
> +{
> +	struct platform_device *pdev;
> +	int rc;
> +
> +	if (!cpu_is_mx28())
> +		return 0;
> +
> +	pdev = platform_device_register_simple("mxc-ehci",
> +		instance_id, usbh1_resources, ARRAY_SIZE(usbh1_resources));
> +	if (IS_ERR(pdev)) {
> +		pr_debug("can't register Host, %ld\n",
> +			 PTR_ERR(pdev));
> +		return -EFAULT;
>
You have already an error code returned by
platform_device_register_simple(). So use it:
	return PTR_ERR(pdev);

> +	}
> +
> +	pdev->dev.coherent_dma_mask = 0xffffffff;
> +	pdev->dev.dma_mask = &ehci_dmamask;
> +
> +	rc = platform_device_add_data(pdev, &usbh1_config,
> +				      sizeof(struct mxc_usbh_platform_data));
> +	if (rc) {
> +		platform_device_unregister(pdev);
> +		return -EFAULT;
>
ditto.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
