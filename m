From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 29 Nov 2012 15:53:26 +0200
Subject: [PATCH v3 2/7] usb: chipidea: add otg file
In-Reply-To: <1353921068-15673-3-git-send-email-peter.chen@freescale.com>
References: <1353921068-15673-1-git-send-email-peter.chen@freescale.com>
 <1353921068-15673-3-git-send-email-peter.chen@freescale.com>
Message-ID: <87mwy0ms6h.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index d738603..8702871 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -129,6 +129,7 @@ struct hw_bank {
>   * @vbus_active: is VBUS active
>   * @transceiver: pointer to USB PHY, if any
>   * @hcd: pointer to usb_hcd for ehci host driver
> + * @otg: for otg support
>   */
>  struct ci13xxx {
>  	struct device			*dev;
> @@ -164,6 +165,7 @@ struct ci13xxx {
>  	bool				global_phy;
>  	struct usb_phy			*transceiver;
>  	struct usb_hcd			*hcd;
> +	struct usb_otg      otg;

Can you indent the "otg" so that it's aligned with the rest?

>  };
>  
>  static inline struct ci_role_driver *ci_role(struct ci13xxx *ci)
> diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
> new file mode 100644
> index 0000000..7dea3b3
> --- /dev/null
> +++ b/drivers/usb/chipidea/otg.c
> @@ -0,0 +1,60 @@
> +/*
> + * otg.c - ChipIdea USB IP core OTG driver
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *
> + * Author: Peter Chen
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>

Most of these look unnecessary.

> +#include <linux/usb/gadget.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/chipidea.h>
> +
> +#include "ci.h"
> +#include "udc.h"
> +#include "bits.h"
> +#include "host.h"
> +#include "debug.h"

And these.

> +
> +static int ci_otg_set_peripheral(struct usb_otg *otg,
> +		struct usb_gadget *periph)
> +{
> +	otg->gadget = periph;
> +
> +	return 0;
> +}
> +
> +static int ci_otg_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	otg->host = host;
> +
> +	return 0;
> +}
> +
> +/**
> + * ci_hdrc_otg_init - initialize device related bits
> + * ci: the controller
> + *
> + * This function create otg struct, if the device can switch between
> + * device and host.
> + */
> +int ci_hdrc_otg_init(struct ci13xxx *ci)
> +{
> +	/* Useless at current */
> +	ci->otg.set_peripheral = ci_otg_set_peripheral;
> +	ci->otg.set_host = ci_otg_set_host;
> +	if (!IS_ERR_OR_NULL(ci->transceiver))
> +		ci->transceiver->otg = &ci->otg;
> +
> +	return 0;
> +}
> diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h
> new file mode 100644
> index 0000000..b4c6b3e
> --- /dev/null
> +++ b/drivers/usb/chipidea/otg.h
> @@ -0,0 +1,6 @@
> +#ifndef __DRIVERS_USB_CHIPIDEA_OTG_H
> +#define __DRIVERS_USB_CHIPIDEA_OTG_H
> +
> +int ci_hdrc_otg_init(struct ci13xxx *ci);

Can you put it to ci.h instead?

Thanks,
--
Alex
