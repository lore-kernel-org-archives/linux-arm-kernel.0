From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 21 Oct 2010 23:36:53 +0100
Subject: [PATCH 3/4] USB: Gadget: Add Samsung S3C24XX USB
	High-Speed	controller driver
In-Reply-To: <1286928627-22824-4-git-send-email-sbkim73@samsung.com>
References: <1286928627-22824-1-git-send-email-sbkim73@samsung.com>
	<1286928627-22824-4-git-send-email-sbkim73@samsung.com>
Message-ID: <4CC0C085.6020404@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/10 01:10, Sangbeom Kim wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The Samsung's S3C2416, S3C2443 and S3C2450 includes a USB High-Speed
> device controller module. This driver enables support for USB high-speed
> gadget functionality for the Samsung S3C24xx SoC's that include this
> controller.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  drivers/usb/gadget/Kconfig        |   17 +
>  drivers/usb/gadget/Makefile       |    1 +
>  drivers/usb/gadget/gadget_chips.h |    7 +
>  drivers/usb/gadget/s3c-hsudc.c    | 1329 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 1354 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/gadget/s3c-hsudc.c
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index cd27f9b..235d4db 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -348,6 +348,23 @@ config USB_S3C2410_DEBUG
>  	boolean "S3C2410 udc debug messages"
>  	depends on USB_GADGET_S3C2410
>  
> +config USB_GADGET_S3C_HSUDC
> +	boolean "S3C2416, S3C2443 and S3C2450 USB Device Controller"
> +	depends on ARCH_S3C2410
> +	select USB_GADGET_DUALSPEED
> +	help
> +	  Samsung's S3C2416, S3C2443 and S3C2450 is an ARM9 based SoC
> +	  integrated with dual speed USB 2.0 device controller. It has
> +	  8 endpoints, as well as endpoint zero.
> +
> +	  This driver has been tested on S3C2416 and S3C2450 processors.
> +
> +config USB_S3C_HSUDC
> +	tristate
> +	depends on USB_GADGET_S3C_HSUDC
> +	default USB_GADGET
> +	select USB_GADGET_SELECTED
> +
>  #
>  # Controllers available in both integrated and discrete versions
>  #
> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
> index 27283df..76e3d67 100644
> --- a/drivers/usb/gadget/Makefile
> +++ b/drivers/usb/gadget/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_USB_R8A66597)	+= r8a66597-udc.o
>  obj-$(CONFIG_USB_FSL_QE)	+= fsl_qe_udc.o
>  obj-$(CONFIG_USB_CI13XXX)	+= ci13xxx_udc.o
>  obj-$(CONFIG_USB_S3C_HSOTG)	+= s3c-hsotg.o
> +obj-$(CONFIG_USB_S3C_HSUDC)	+= s3c-hsudc.o
>  obj-$(CONFIG_USB_LANGWELL)	+= langwell_udc.o
>  
>  #
> diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
> index e511fec..0b27f6f 100644
> --- a/drivers/usb/gadget/gadget_chips.h
> +++ b/drivers/usb/gadget/gadget_chips.h
> @@ -142,6 +142,11 @@
>  #define gadget_is_s3c_hsotg(g)    0
>  #endif
>  
> +#ifdef CONFIG_USB_S3C_HSUDC
> +#define gadget_is_s3c_hsudc(g) (!strcmp("s3c-hsudc", (g)->name))
> +#else
> +#define gadget_is_s3c_hsudc(g) 0
> +#endif
>  
>  /**
>   * usb_gadget_controller_number - support bcdDevice id convention
> @@ -200,6 +205,8 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
>  		return 0x25;
>  	else if (gadget_is_s3c_hsotg(gadget))
>  		return 0x26;
> +	else if (gadget_is_s3c_hsudc(gadget))
> +		return 0x27;
>  	return -ENOENT;
>  }
>  
> diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
> new file mode 100644
> index 0000000..ebc4a10
> --- /dev/null
> +++ b/drivers/usb/gadget/s3c-hsudc.c
> @@ -0,0 +1,1329 @@
> +/* linux/drivers/usb/gadget/s3c-hsudc.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S3C24XX USB 2.0 High-speed USB controller gadget driver
> + *
> + * The S3C24XX USB 2.0 high-speed USB controller supports upto 9 endpoints.
> + * Each endpoint can be configured as either in or out endpoint. Endpoints
> + * can be configured for Bulk or Interrupt transfer mode.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +
> +#include <mach/regs-s3c2443-clock.h>

hmm, do you really need to include the clock
registers? surely the clk_ api should be doing
the work for you.

> +#include <plat/udc.h>
> +
> +#define S3C_HSUDC_REG(x)	(x)
> +
> +/* Non-Indexed Registers */
> +#define S3C_IR				S3C_HSUDC_REG(0x00) /* Index Register */
> +#define S3C_EIR				S3C_HSUDC_REG(0x04) /* EP Intr Status */
> +#	define S3C_EIR_EP0		(1<<0)
> +#define S3C_EIER			S3C_HSUDC_REG(0x08) /* EP Intr Enable */
> +#define S3C_FAR				S3C_HSUDC_REG(0x0c) /* Gadget Address */
> +#define S3C_FNR				S3C_HSUDC_REG(0x10) /* Frame Number */
> +#define S3C_EDR				S3C_HSUDC_REG(0x14) /* EP Direction */
> +#define S3C_TR				S3C_HSUDC_REG(0x18) /* Test Register */
> +#define S3C_SSR				S3C_HSUDC_REG(0x1c) /* System Status */
> +#	define S3C_SSR_DTZIEN_EN	(0xff8f)
> +#	define S3C_SSR_ERR		(0xff80)
> +#	define S3C_SSR_VBUSON		(1 << 8)
> +#	define S3C_SSR_HSP		(1 << 4)
> +#	define S3C_SSR_SDE		(1 << 3)
> +#	define S3C_SSR_RESUME		(1 << 2)
> +#	define S3C_SSR_SUSPEND		(1 << 1)
> +#	define S3C_SSR_RESET		(1 << 0)
> +#define S3C_SCR				S3C_HSUDC_REG(0x20) /* System Control */
> +#	define S3C_SCR_DTZIEN_EN	(1 << 14)
> +#	define S3C_SCR_RRD_EN		(1 << 5)
> +#	define S3C_SCR_SUS_EN		(1 << 1)
> +#	define S3C_SCR_RST_EN		(1 << 0)
> +#define S3C_EP0SR			S3C_HSUDC_REG(0x24) /* EP0 Status */
> +#	define S3C_EP0SR_EP0_LWO	(1 << 6)
> +#	define S3C_EP0SR_STALL		(1 << 4)
> +#	define S3C_EP0SR_TX_SUCCESS	(1 << 1)
> +#	define S3C_EP0SR_RX_SUCCESS	(1 << 0)
> +#define S3C_EP0CR			S3C_HSUDC_REG(0x28) /* EP0 Control */
> +#define S3C_BR(_x)			S3C_HSUDC_REG(0x60 + (_x * 4))
> +
> +/* Indexed Registers */
> +#define S3C_ESR				S3C_HSUDC_REG(0x2c) /* EPn Status */
> +#	define S3C_ESR_FLUSH		(1 << 6)
> +#	define S3C_ESR_STALL		(1 << 5)
> +#	define S3C_ESR_LWO		(1 << 4)
> +#	define S3C_ESR_PSIF_ONE		(1 << 2)
> +#	define S3C_ESR_PSIF_TWO		(2 << 2)
> +#	define S3C_ESR_TX_SUCCESS	(1 << 1)
> +#	define S3C_ESR_RX_SUCCESS	(1 << 0)
> +#define S3C_ECR				S3C_HSUDC_REG(0x30) /* EPn Control */
> +#	define S3C_ECR_DUEN		(1 << 7)
> +#	define S3C_ECR_FLUSH		(1 << 6)
> +#	define S3C_ECR_STALL		(1 << 1)
> +#	define S3C_ECR_IEMS		(1 << 0)
> +#define S3C_BRCR			S3C_HSUDC_REG(0x34) /* Read Count */
> +#define S3C_BWCR			S3C_HSUDC_REG(0x38) /* Write Count */
> +#define S3C_MPR				S3C_HSUDC_REG(0x3c) /* Max Pkt Size */

hmm, the formatting is a bit non-standard.

> +
> +static inline void __orr32(void __iomem *ptr, u32 val)
> +{
> +	writel(readl(ptr) | val, ptr);
> +}
> +
> +static void s3c_hsudc_init_phy(void)
> +{
> +	u32 cfg;
> +
> +	cfg = __raw_readl(S3C2443_PWRCFG) | S3C2443_PWRCFG_USBPHY;
> +	__raw_writel(cfg, S3C2443_PWRCFG);
> +
> +	cfg = __raw_readl(S3C2443_URSTCON);
> +	cfg |= (S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
> +	__raw_writel(cfg, S3C2443_URSTCON);
> +	mdelay(1);
> +
> +	cfg = __raw_readl(S3C2443_URSTCON);
> +	cfg &= ~(S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
> +	__raw_writel(cfg, S3C2443_URSTCON);
> +
> +	cfg = __raw_readl(S3C2443_PHYCTRL);
> +	cfg &= ~(S3C2443_PHYCTRL_CLKSEL | S3C2443_PHYCTRL_DSPORT);
> +	cfg |= (S3C2443_PHYCTRL_EXTCLK | S3C2443_PHYCTRL_PLLSEL);
> +	__raw_writel(cfg, S3C2443_PHYCTRL);
> +
> +	cfg = __raw_readl(S3C2443_PHYPWR);
> +	cfg &= ~(S3C2443_PHYPWR_FSUSPEND | S3C2443_PHYPWR_PLL_PWRDN |
> +		S3C2443_PHYPWR_XO_ON | S3C2443_PHYPWR_PLL_REFCLK |
> +		S3C2443_PHYPWR_ANALOG_PD);
> +	cfg |= S3C2443_PHYPWR_COMMON_ON;
> +	__raw_writel(cfg, S3C2443_PHYPWR);
> +
> +	cfg = __raw_readl(S3C2443_UCLKCON);
> +	cfg |= (S3C2443_UCLKCON_DETECT_VBUS | S3C2443_UCLKCON_FUNC_CLKEN |
> +		S3C2443_UCLKCON_TCLKEN);
> +	__raw_writel(cfg, S3C2443_UCLKCON);
> +}
> +
> +static void s3c_hsudc_uninit_phy(void)
> +{
> +	u32 cfg;
> +
> +	cfg = __raw_readl(S3C2443_PWRCFG) & ~S3C2443_PWRCFG_USBPHY;
> +	__raw_writel(cfg, S3C2443_PWRCFG);
> +
> +	__raw_writel(S3C2443_PHYPWR_FSUSPEND, S3C2443_PHYPWR);
> +
> +	cfg = __raw_readl(S3C2443_UCLKCON) & ~S3C2443_UCLKCON_FUNC_CLKEN;
> +	__raw_writel(cfg, S3C2443_UCLKCON);
> +}

I suppose this has to be here.


> +/**
> + * s3c_hsudc_read_setup_pkt - Read the received setup packet from EP0 fifo.
> + * @hsudc: Device controller from which setup packet is to be read.
> + * @buf: The buffer into which the setup packet is read.
> + *
> + * The setup packet received in the EP0 fifo is read and stored into a
> + * given buffer address.
> + */
> +
> +static void s3c_hsudc_read_setup_pkt(struct s3c_hsudc *hsudc, u16 *buf)
> +{
> +	int count;
> +
> +	count = __raw_readl(hsudc->regs + S3C_BRCR);
> +	while (count--)
> +		*buf++ = (u16)__raw_readl(hsudc->regs + S3C_BR(0));

hmm, __raw_readl() shouldn't be being used for ioremaped addresses?

> +	__raw_writel(S3C_EP0SR_RX_SUCCESS, hsudc->regs + S3C_EP0SR);
> +}
> +
> +/**
> + * s3c_hsudc_write_fifo - Write next chunk of transfer data to EP fifo.
> + * @hsep: Endpoint to which the data is to be written.
> + * @hsreq: Transfer request from which the next chunk of data is written.
> + *
> + * Write the next chunk of data from a transfer request to the endpoint FIFO.
> + * If the transfer request completes, 1 is returned, otherwise 0 is returned.
> + */
> +static int s3c_hsudc_write_fifo(struct s3c_hsudc_ep *hsep,
> +				struct s3c_hsudc_req *hsreq)
> +{
> +	u16 *buf;
> +	u32 max = ep_maxpacket(hsep);
> +	u32 count, length;
> +	int is_last;

this could be a bool.

> +	u32 fifo = hsep->fifo;
> +
> +	buf = hsreq->req.buf + hsreq->req.actual;
> +	prefetch(buf);
> +
> +	length = hsreq->req.length - hsreq->req.actual;
> +	length = min(length, max);
> +	hsreq->req.actual += length;
> +
> +	__raw_writel(length, hsep->dev->regs + S3C_BWCR);
> +	for (count = 0; count < length; count += 2)
> +		__raw_writel(*buf++, fifo);
> +
> +	if (count != max) {
> +		is_last = 1;
> +	} else {
> +		if (hsreq->req.length != hsreq->req.actual || hsreq->req.zero)
> +			is_last = 0;
> +		else
> +			is_last = 1;
> +	}
> +
> +	if (is_last) {
> +		s3c_hsudc_complete_request(hsep, hsreq, 0);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * s3c_hsudc_read_fifo - Read the next chunk of data from EP fifo.
> + * @hsep: Endpoint from which the data is to be read.
> + * @hsreq: Transfer request to which the next chunk of data read is written.
> + *
> + * Read the next chunk of data from the endpoint FIFO and a write it to the
> + * transfer request buffer. If the transfer request completes, 1 is returned,
> + * otherwise 0 is returned.
> + */
> +static int s3c_hsudc_read_fifo(struct s3c_hsudc_ep *hsep,
> +				struct s3c_hsudc_req *hsreq)
> +{
> +	struct s3c_hsudc *hsudc = hsep->dev;
> +	u32 csr, offset;
> +	u16 *buf, word;
> +	u32 buflen, rcnt, rlen;
> +	u32 fifo = hsep->fifo;

if this is an ioaddr, it should be void __iomem *.

> +	u32 is_short = 0;
> +
> +	offset = (ep_index(hsep)) ? S3C_ESR : S3C_EP0SR;
> +	csr = __raw_readl(hsudc->regs + offset);
> +	if (!(csr & S3C_ESR_RX_SUCCESS))
> +		return -EINVAL;
> +
> +	buf = hsreq->req.buf + hsreq->req.actual;
> +	prefetchw(buf);
> +	buflen = hsreq->req.length - hsreq->req.actual;
> +
> +	rcnt = __raw_readl(hsudc->regs + S3C_BRCR);
> +	rlen = (csr & S3C_ESR_LWO) ? (rcnt * 2 - 1) : (rcnt * 2);
> +
> +	hsreq->req.actual += min(rlen, buflen);
> +	is_short = (rlen < hsep->ep.maxpacket);
> +
> +	while (rcnt-- != 0) {
> +		word = (u16)__raw_readl(fifo);
> +		if (buflen) {
> +			*buf++ = word;
> +			buflen--;
> +		} else {
> +			hsreq->req.status = -EOVERFLOW;
> +		}
> +	}
> +
> +	__raw_writel(S3C_ESR_RX_SUCCESS, hsudc->regs + offset);
> +
> +	if (is_short || hsreq->req.actual == hsreq->req.length) {
> +		s3c_hsudc_complete_request(hsep, hsreq, 0);
> +		return 1;
> +	}
> +
> +	return 0;
> +}

> +/**
> + * s3c_hsudc_ep_disable - Disable a endpoint.
> + * @_ep: The endpoint to be disabled.
> + * @desc: Endpoint descriptor.
> + *
> + * Disables a endpoint when called from the gadget driver.
> + */
> +static int s3c_hsudc_ep_disable(struct usb_ep *_ep)
> +{
> +	struct s3c_hsudc_ep *hsep = our_ep(_ep);
> +	struct s3c_hsudc *hsudc = hsep->dev;
> +	unsigned long flags;
> +
> +	hsep = container_of(_ep, struct s3c_hsudc_ep, ep);

hmm, you've got hsep assigned twice?

> +	if (!_ep || !hsep->desc)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&hsudc->lock, flags);
> +
> +	set_index(hsudc, hsep->bEndpointAddress);
> +	__clear_bit(ep_index(hsep), hsudc->regs + S3C_EIER);
> +
> +	s3c_hsudc_nuke_ep(hsep, -ESHUTDOWN);
> +
> +	hsep->desc = 0;
> +	hsep->stopped = 1;
> +
> +	spin_unlock_irqrestore(&hsudc->lock, flags);
> +	return 0;
> +}

> +	local_irq_disable();
> +
> +	disable_irq(hsudc->irq);
> +	local_irq_enable();

hmm, why are you disabling the irqs around this call?

> +	return 0;
