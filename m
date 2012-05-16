From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 May 2012 11:36:16 +0300
Subject: [PATCH 6/8] CI13xxx: Add i.MX233/i.MX28 binding code
In-Reply-To: <1337070219-3630-7-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-7-git-send-email-marex@denx.de>
Message-ID: <20120516083613.GG17359@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 10:23:37AM +0200, Marek Vasut wrote:
> This codes connects the CI13xxx driver with the core found inside of
> the Freescale i.MX244/i.MX28 CPU.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Detlev Zundel <dzu@denx.de>
> CC: Dong Aisheng <b29396@freescale.com>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> Cc: linux-i2c at vger.kernel.org
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/usb/chipidea/Makefile      |    4 +
>  drivers/usb/chipidea/ci13xxx_mxs.c |  201 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+)
>  create mode 100644 drivers/usb/chipidea/ci13xxx_mxs.c
> 
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index cc34937..266d57d 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -12,3 +12,7 @@ endif
>  ifneq ($(CONFIG_ARCH_MSM),)
>  	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
>  endif
> +
> +ifneq ($(CONFIG_ARCH_MXS),)
> +	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_mxs.o
> +endif

NAK... let it compile everywhere.

> diff --git a/drivers/usb/chipidea/ci13xxx_mxs.c b/drivers/usb/chipidea/ci13xxx_mxs.c
> new file mode 100644
> index 0000000..fcca90b
> --- /dev/null
> +++ b/drivers/usb/chipidea/ci13xxx_mxs.c
> @@ -0,0 +1,201 @@
> +/*
> + * drivers/usb/chipidea/ci13xxx_mxs.c
> + *
> + * Freescale i.MX233/i.MX28 USB glue driver to CI13xxx core.
> + *
> + * Copyright (C) 2012 Marek Vasut <marex@denx.de>
> + * on behalf of DENX Software Engineering GmbH
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
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <linux/usb.h>
> +#include <linux/usb/chipidea.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/usb/ehci_def.h>
> +
> +#include <linux/usb/mxs-usb.h>
> +
> +#include "ci.h"
> +
> +static void ci13xxx_mxs_notify(struct ci13xxx *ci, unsigned event)
> +{
> +	uint32_t status;
> +	struct usb_phy *phy;
> +	struct mxs_ci13xxx_phy_notify notify;
> +
> +	phy = usb_get_transceiver();
> +	if (!phy)
> +		return;
> +
> +	if (event != CI13XXX_CONTROLLER_HOST_IRQ_EVENT)
> +		return;
> +
> +	status = hw_read(ci, OP_USBSTS, ~0);
> +
> +	notify.discon = status & STS_PCD;
> +
> +	usb_phy_notify(phy, &notify);
> +}
> +
> +static struct ci13xxx_udc_driver ci13xxx_mxs_udc_driver = {
> +	.name			= "ci13xxx_mxs",
> +	.flags			= /*CI13XXX_REGS_SHARED |*/
> +				  CI13XXX_REQUIRE_TRANSCEIVER |
> +				  CI13XXX_PULLUP_ON_VBUS |
> +				  CI13XXX_DISABLE_STREAMING,
> +	.capoffset		= 0x100,
> +	.notify_event		= ci13xxx_mxs_notify,
> +};
> +
> +struct ci13xxx_mxs_data {
> +	struct clk		*clk;
> +	struct platform_device	*pdev;
> +};
> +
> +static int __devinit ci13xxx_mxs_probe(struct platform_device *pdev)
> +{
> +	struct ci13xxx_mxs_data *data;
> +	int ret;
> +	struct usb_phy *phy;
> +
> +	phy = usb_get_transceiver();
> +	if (!phy)
> +		return -EPROBE_DEFER;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		dev_err(&pdev->dev, "Failed to allocate CI13xxx-MXS data!\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = usb_phy_init(phy);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to initialize PHY!\n");
> +		return -EINVAL;
> +	}
> +
> +	data->pdev = platform_device_alloc("ci_hdrc", -1);
> +	if (!data->pdev) {
> +		dev_err(&pdev->dev,
> +			"Failed to allocate ci_hdrc platform device!\n");
> +		ret = -ENOMEM;
> +		goto put_phy;
> +	}
> +
> +	/* Add DMA mask */
> +	data->pdev->dev.dma_mask = devm_kzalloc(&pdev->dev,
> +					sizeof(*data->pdev->dev.dma_mask),
> +					GFP_KERNEL);
> +	if (!data->pdev->dev.dma_mask) {
> +		ret = -ENOMEM;
> +		goto put_platform;
> +	}
> +
> +	*data->pdev->dev.dma_mask = DMA_BIT_MASK(32);
> +	data->pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);

why don't you just point to the parent's ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/22ab45e7/attachment.sig>
