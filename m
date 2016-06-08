From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 15:26:51 -0500
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160608202651.GA23604@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 12:15:10PM +0800, Wenyou Yang wrote:
> In order to the save power consumption, as a workaround, suspend
> forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
> Interrupt Configuration Register in the SFRs while OHCI USB suspend.
> 
> This suspend operation must be done before the USB clock is disabled,
> resume after the USB clock is enabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v3:
>  - Change the compatible description for more precise.
> 
> Changes in v2:
>  - Add compatible to support forcibly suspend the ports.
>  - Add soc/at91/at91_sfr.h to accommodate the defines.
>  - Add error checking for .sfr_regmap.
>  - Remove unnecessary regmap_read() statement.
> 
>  .../devicetree/bindings/usb/atmel-usb.txt          |  6 +-
>  drivers/usb/host/ohci-at91.c                       | 80 +++++++++++++++++++++-
>  include/soc/at91/at91_sfr.h                        | 29 ++++++++
>  3 files changed, 112 insertions(+), 3 deletions(-)
>  create mode 100644 include/soc/at91/at91_sfr.h
> 
> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> index 5883b73..888deaa 100644
> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> @@ -3,8 +3,10 @@ Atmel SOC USB controllers
>  OHCI
>  
>  Required properties:
> - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
> -   used in host mode.
> + - compatible: Should be one of the following
> +	       "atmel,at91rm9200-ohci" for USB controllers used in host mode.
> +	       "atmel,sama5d2-ohci" for USB controllers used in host mode
> +	       on SAMA5D2 which can force to suspend.

Guess I wasn't clear enough before. Drop "which can force to suspend".

>   - reg: Address and length of the register set for the device
>   - interrupts: Should contain ehci interrupt
>   - clocks: Should reference the peripheral, host and system clocks
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index d177372..54e8feb 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -21,8 +21,11 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <soc/at91/at91_sfr.h>
>  
>  #include "ohci.h"
>  
> @@ -45,12 +48,18 @@ struct at91_usbh_data {
>  	u8 overcurrent_changed[AT91_MAX_USBH_PORTS];
>  };
>  
> +struct ohci_at91_caps {
> +	bool suspend_ctrl;
> +};
> +
>  struct ohci_at91_priv {
>  	struct clk *iclk;
>  	struct clk *fclk;
>  	struct clk *hclk;
>  	bool clocked;
>  	bool wakeup;		/* Saved wake-up state for resume */
> +	const struct ohci_at91_caps *caps;
> +	struct regmap *sfr_regmap;
>  };
>  /* interface and function clocks; sometimes also an AHB clock */
>  
> @@ -132,6 +141,17 @@ static void at91_stop_hc(struct platform_device *pdev)
>  
>  /*-------------------------------------------------------------------------*/
>  
> +struct regmap *at91_dt_syscon_sfr(void)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
> +	if (IS_ERR(regmap))
> +		regmap = NULL;
> +
> +	return regmap;
> +}
> +
>  static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
>  
>  /* configure so an HC device and id are always provided */
> @@ -197,6 +217,17 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		goto err;
>  	}
>  
> +	ohci_at91->caps = (const struct ohci_at91_caps *)
> +			  of_device_get_match_data(&pdev->dev);
> +	if (!ohci_at91->caps)
> +		return -ENODEV;
> +
> +	if (ohci_at91->caps->suspend_ctrl) {
> +		ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
> +		if (!ohci_at91->sfr_regmap)
> +			dev_warn(dev, "failed to find sfr node\n");
> +	}
> +
>  	board = hcd->self.controller->platform_data;
>  	ohci = hcd_to_ohci(hcd);
>  	ohci->num_ports = board->ports;
> @@ -440,8 +471,17 @@ static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static const struct ohci_at91_caps at91rm9200_caps = {
> +	.suspend_ctrl = false,
> +};
> +
> +static const struct ohci_at91_caps sama5d2_caps = {
> +	.suspend_ctrl = true,
> +};
> +
>  static const struct of_device_id at91_ohci_dt_ids[] = {
> -	{ .compatible = "atmel,at91rm9200-ohci" },
> +	{ .compatible = "atmel,at91rm9200-ohci", .data = &at91rm9200_caps },
> +	{ .compatible = "atmel,sama5d2-ohci", .data = &sama5d2_caps },
>  	{ /* sentinel */ }
>  };
>  
> @@ -581,6 +621,38 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int ohci_at91_port_ctrl(struct regmap *regmap, bool enable)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	if (!regmap)
> +		return -EINVAL;
> +
> +	ret = regmap_read(regmap, SFR_OHCIICR, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (enable)
> +		regval &= ~SFR_OHCIICR_USB_SUSPEND;
> +	else
> +		regval |= SFR_OHCIICR_USB_SUSPEND;
> +
> +	regmap_write(regmap, SFR_OHCIICR, regval);
> +
> +	return 0;
> +}
> +
> +static int ohci_at91_port_suspend(struct regmap *regmap)
> +{
> +	return ohci_at91_port_ctrl(regmap, false);
> +}
> +
> +static int ohci_at91_port_resume(struct regmap *regmap)
> +{
> +	return ohci_at91_port_ctrl(regmap, true);
> +}
> +
>  static int __maybe_unused
>  ohci_hcd_at91_drv_suspend(struct device *dev)
>  {
> @@ -618,6 +690,9 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>  		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
>  		ohci->rh_state = OHCI_RH_HALTED;
>  
> +		if (ohci_at91->caps->suspend_ctrl)
> +			ohci_at91_port_suspend(ohci_at91->sfr_regmap);
> +
>  		/* flush the writes */
>  		(void) ohci_readl (ohci, &ohci->regs->control);
>  		at91_stop_clock(ohci_at91);
> @@ -637,6 +712,9 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>  
>  	at91_start_clock(ohci_at91);
>  
> +	if (ohci_at91->caps->suspend_ctrl)
> +		ohci_at91_port_resume(ohci_at91->sfr_regmap);
> +
>  	ohci_resume(hcd, false);
>  	return 0;
>  }
> diff --git a/include/soc/at91/at91_sfr.h b/include/soc/at91/at91_sfr.h
> new file mode 100644
> index 0000000..04a3a1e
> --- /dev/null
> +++ b/include/soc/at91/at91_sfr.h
> @@ -0,0 +1,29 @@
> +/*
> + * Header file for the Atmel DDR/SDR SDRAM Controller
> + *
> + * Copyright (C) 2016 Atmel Corporation
> + *
> + * Author: Wenyou Yang <wenyou.yang@atmel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#ifndef __AT91_SFR_H__
> +#define __AT91_SFR_H__
> +
> +#define SFR_DDRCFG		0x04	/* DDR Configuration Register */
> +/* 0x08 ~ 0x0c: Reserved */
> +#define SFR_OHCIICR		0x10	/* OHCI Interrupt Configuration Register */
> +#define SFR_OHCIISR		0x14	/* OHCI Interrupt Status Register */
> +
> +#define SFR_OHCIICR_SUSPEND_A	BIT(8)
> +#define SFR_OHCIICR_SUSPEND_B	BIT(9)
> +#define SFR_OHCIICR_SUSPEND_C	BIT(10)
> +
> +#define SFR_OHCIICR_USB_SUSPEND	(SFR_OHCIICR_SUSPEND_A | \
> +				 SFR_OHCIICR_SUSPEND_B | \
> +				 SFR_OHCIICR_SUSPEND_C)
> +
> +#endif
> -- 
> 2.7.4
> 
