From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Nov 2009 09:39:28 +0100
Subject: [PATCH] MXC: Add support for ULPI Viewports
In-Reply-To: <20091030141635.GQ29442@buzzloop.caiaq.de>
References: <20091030141635.GQ29442@buzzloop.caiaq.de>
Message-ID: <20091105083928.GN30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2009 at 03:16:35PM +0100, Daniel Mack wrote:
> Hi Sascha,
> 
> Below is a rebased version of the patch that adds ULPI viewports for
> MX31 controllers. There was also a bug in the condition check for
> ULPIVW_SS - && was used instead of &, a hertiage from the Freescale BSP,
> which was copy'n pasted over and over again.
> 
> Daniel
> 
> 
> From c523e69a3a3689e8108ff608cf2d8c919665baec Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Thu, 25 Jun 2009 13:27:40 +0200
> Subject: [PATCH] MXC: Add support for ULPI Viewports
> 
> The ARC USB OTG Core has support for accessing ULPI tranceivers
> through so called ULPI viewports. Export a set of function for use with
> the USB OTG framework.

Ok, added to mxc-master.

Sascha

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: linux-usb at vger.kernel.org
> ---
>  arch/arm/plat-mxc/Kconfig             |    3 +
>  arch/arm/plat-mxc/Makefile            |    1 +
>  arch/arm/plat-mxc/include/mach/ulpi.h |    7 ++
>  arch/arm/plat-mxc/ulpi.c              |  111 +++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/ulpi.h
>  create mode 100644 arch/arm/plat-mxc/ulpi.c
> 
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index ca5c7c2..e8e92cb 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -69,6 +69,9 @@ config MXC_PWM
>  	help
>  	  Enable support for the i.MX PWM controller(s).
>  
> +config MXC_ULPI
> +	bool
> +
>  config ARCH_HAS_RNGA
>  	bool
>  	depends on ARCH_MXC
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index e3212c8..545412f 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_ARCH_MX1) += iomux-mx1-mx2.o dma-mx1-mx2.o
>  obj-$(CONFIG_ARCH_MX2) += iomux-mx1-mx2.o dma-mx1-mx2.o
>  obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
>  obj-$(CONFIG_MXC_PWM)  += pwm.o
> +obj-$(CONFIG_MXC_ULPI) += ulpi.o
> diff --git a/arch/arm/plat-mxc/include/mach/ulpi.h b/arch/arm/plat-mxc/include/mach/ulpi.h
> new file mode 100644
> index 0000000..96b6ab4
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/ulpi.h
> @@ -0,0 +1,7 @@
> +#ifndef __MACH_ULPI_H
> +#define __MACH_ULPI_H
> +
> +extern struct otg_io_access_ops mxc_ulpi_access_ops;
> +
> +#endif /* __MACH_ULPI_H */
> +
> diff --git a/arch/arm/plat-mxc/ulpi.c b/arch/arm/plat-mxc/ulpi.c
> new file mode 100644
> index 0000000..b6977b9
> --- /dev/null
> +++ b/arch/arm/plat-mxc/ulpi.c
> @@ -0,0 +1,111 @@
> +/*
> + * Copyright 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA  02110-1301, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/usb/otg.h>
> +
> +#include <mach/ulpi.h>
> +
> +/* ULPIVIEW register bits */
> +#define ULPIVW_WU		(1 << 31)	/* Wakeup */
> +#define ULPIVW_RUN		(1 << 30)	/* read/write run */
> +#define ULPIVW_WRITE		(1 << 29)	/* 0 = read  1 = write */
> +#define ULPIVW_SS		(1 << 27)	/* SyncState */
> +#define ULPIVW_PORT_MASK	0x07	/* Port field */
> +#define ULPIVW_PORT_SHIFT	24
> +#define ULPIVW_ADDR_MASK	0xff	/* data address field */
> +#define ULPIVW_ADDR_SHIFT	16
> +#define ULPIVW_RDATA_MASK	0xff	/* read data field */
> +#define ULPIVW_RDATA_SHIFT	8
> +#define ULPIVW_WDATA_MASK	0xff	/* write data field */
> +#define ULPIVW_WDATA_SHIFT	0
> +
> +static int ulpi_poll(void __iomem *view, u32 bit)
> +{
> +	uint32_t data;
> +	int timeout = 10000;
> +
> +	data = __raw_readl(view);
> +	while (data & bit) {
> +		if (!timeout--) {
> +			printk(KERN_WARNING
> +				"timeout polling for ULPI device\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		udelay(10);
> +		data = __raw_readl(view);
> +	}
> +
> +	return (data >> ULPIVW_RDATA_SHIFT) & ULPIVW_RDATA_MASK;
> +}
> +
> +static int ulpi_read(struct otg_transceiver *otg, u32 reg)
> +{
> +	int ret;
> +	void __iomem *view = otg->io_priv;
> +
> +	/* make sure interface is running */
> +	if (!(__raw_readl(view) & ULPIVW_SS)) {
> +		__raw_writel(ULPIVW_WU, view);
> +
> +		/* wait for wakeup */
> +		ret = ulpi_poll(view, ULPIVW_WU);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* read the register */
> +	__raw_writel((ULPIVW_RUN | (reg << ULPIVW_ADDR_SHIFT)), view);
> +
> +	/* wait for completion */
> +	return ulpi_poll(view, ULPIVW_RUN);
> +}
> +
> +static int ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
> +{
> +	int ret;
> +	void __iomem *view = otg->io_priv;
> +
> +	/* make sure the interface is running */
> +	if (!(__raw_readl(view) & ULPIVW_SS)) {
> +		__raw_writel(ULPIVW_WU, view);
> +		/* wait for wakeup */
> +		ret = ulpi_poll(view, ULPIVW_WU);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	__raw_writel((ULPIVW_RUN | ULPIVW_WRITE |
> +		      (reg << ULPIVW_ADDR_SHIFT) |
> +		      ((val & ULPIVW_WDATA_MASK) << ULPIVW_WDATA_SHIFT)), view);
> +
> +	/* wait for completion */
> +	ret = ulpi_poll(view, ULPIVW_RUN);
> +
> +	return (ret < 0) ? ret : 0;
> +}
> +
> +struct otg_io_access_ops mxc_ulpi_access_ops = {
> +	.read	= ulpi_read,
> +	.write	= ulpi_write,
> +};
> +
> -- 
> 1.6.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
