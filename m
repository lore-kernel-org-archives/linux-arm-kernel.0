From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Dec 2013 14:28:44 -0600
Subject: [PATCH v2 1/5] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <1386187811-9596-2-git-send-email-w-kwok2@ti.com>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
 <1386187811-9596-2-git-send-email-w-kwok2@ti.com>
Message-ID: <20131206202844.GG21086@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 04, 2013 at 03:10:07PM -0500, WingMan Kwok wrote:
> Add Keystone platform specific glue layer to support
> USB3 Host mode.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  drivers/usb/dwc3/Kconfig         |    7 ++
>  drivers/usb/dwc3/Makefile        |    1 +
>  drivers/usb/dwc3/dwc3-keystone.c |  210 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 218 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-keystone.c
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 70fc430..e2c730f 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -70,6 +70,13 @@ config USB_DWC3_PCI
>  	  One such PCIe-based platform is Synopsys' PCIe HAPS model of
>  	  this IP.
>  
> +config USB_DWC3_KEYSTONE
> +	tristate "Texas Instruments Keystone2 Platforms"
> +	default USB_DWC3
> +	help
> +	  Support of USB2/3 functionality in TI Keystone2 platforms.
> +	  Say 'Y' or 'M' here if you have one such device
> +
>  comment "Debugging features"
>  
>  config USB_DWC3_DEBUG
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index dd17601..10ac3e7 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -32,3 +32,4 @@ endif
>  obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
>  obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
>  obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
> +obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
> new file mode 100644
> index 0000000..d3c0dc5
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-keystone.c
> @@ -0,0 +1,210 @@
> +/**
> + * dwc3-keystone.c - Keystone Specific Glue layer
> + *
> + * Copyright (C) 2010-2013 Texas Instruments Incorporated - http://www.ti.com
> + *
> + * Author: WingMan Kwok <w-kwok2@ti.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +
> +/* USBSS register offsets */
> +#define USBSS_REVISION		0x0000
> +#define USBSS_SYSCONFIG		0x0010
> +#define USBSS_IRQ_EOI		0x0018
> +#define USBSS_IRQSTATUS_RAW_0	0x0020
> +#define USBSS_IRQSTATUS_0	0x0024
> +#define USBSS_IRQENABLE_SET_0	0x0028
> +#define USBSS_IRQENABLE_CLR_0	0x002c
> +
> +/* IRQ register bits */
> +#define USBSS_IRQ_EOI_LINE(n)	BIT(n)
> +#define USBSS_IRQ_EVENT_ST	BIT(0)
> +#define USBSS_IRQ_COREIRQ_EN	BIT(0)
> +#define USBSS_IRQ_COREIRQ_CLR	BIT(0)
> +
> +static u64 kdwc3_dma_mask;
> +
> +struct dwc3_keystone {
> +	spinlock_t			lock;
> +	struct device			*dev;
> +	struct clk			*clk;
> +	void __iomem			*usbss;
> +};
> +
> +static inline u32 kdwc3_readl(void __iomem *base, u32 offset)
> +{
> +	return readl(base + offset);
> +}
> +
> +static inline void kdwc3_writel(void __iomem *base, u32 offset, u32 value)
> +{
> +	writel(value, base + offset);
> +}
> +
> +static void kdwc3_enable_irqs(struct dwc3_keystone *kdwc)
> +{
> +	u32 val;
> +
> +	val = kdwc3_readl(kdwc->usbss, USBSS_IRQENABLE_SET_0);
> +	val = USBSS_IRQ_COREIRQ_EN;
> +	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_SET_0, val);
> +}
> +
> +static void kdwc3_disable_irqs(struct dwc3_keystone *kdwc)
> +{
> +	u32 val;
> +
> +	val = kdwc3_readl(kdwc->usbss, USBSS_IRQENABLE_SET_0);
> +	val &= ~USBSS_IRQ_COREIRQ_EN;
> +	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_SET_0, val);
> +}
> +
> +static irqreturn_t dwc3_keystone_interrupt(int irq, void *_kdwc)
> +{
> +	struct dwc3_keystone	*kdwc = _kdwc;
> +
> +	spin_lock(&kdwc->lock);

Isn't this lock unnecessary ? This handler will run with IRQs disabled
anyway.

> +	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_CLR_0, USBSS_IRQ_COREIRQ_CLR);
> +	kdwc3_writel(kdwc->usbss, USBSS_IRQSTATUS_0, USBSS_IRQ_EVENT_ST);
> +	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_SET_0, USBSS_IRQ_COREIRQ_EN);
> +	kdwc3_writel(kdwc->usbss, USBSS_IRQ_EOI, USBSS_IRQ_EOI_LINE(0));
> +	spin_unlock(&kdwc->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int kdwc3_probe(struct platform_device *pdev)
> +{
> +	struct device_node	*node = pdev->dev.of_node;
> +	struct device		*dev = &pdev->dev;

if you invert these lines, it'll look a little nicer:

	struct device		*dev = &pdev->dev;
	struct device_node	*node = dev->of_node;

everything else looks pretty good, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/69c07116/attachment.sig>
