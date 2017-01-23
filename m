From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 23 Jan 2017 08:37:09 +0100
Subject: [PATCH linux-next 1/1] usb: gadget: udc: atmel: Update endpoint
 allocation scheme
In-Reply-To: <1484926859-4732-2-git-send-email-cristian.birsan@microchip.com>
References: <1484926859-4732-1-git-send-email-cristian.birsan@microchip.com>
 <1484926859-4732-2-git-send-email-cristian.birsan@microchip.com>
Message-ID: <20170123073709.khl5oslglsnmw2xs@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cristian,

Minor comments about syntax otherwise
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

On Fri, Jan 20, 2017 at 05:40:59PM +0200, cristian.birsan at microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> Update atmel udc driver with a new enpoint allocation scheme. The data
> sheet requires that all endpoints are allocated in order.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  drivers/usb/gadget/udc/Kconfig          |  14 ++
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 236 +++++++++++++++++++++++++++-----
>  drivers/usb/gadget/udc/atmel_usba_udc.h |  10 +-
>  3 files changed, 227 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 658b8da..4b69f28 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -60,6 +60,20 @@ config USB_ATMEL_USBA
>  	  USBA is the integrated high-speed USB Device controller on
>  	  the AT32AP700x, some AT91SAM9 and AT91CAP9 processors from Atmel.
>  
> +	  The fifo_mode parameter is used to select endpoint allocation mode.
> +	  fifo_mode = 0 is used to let the driver autoconfigure the endpoints.
> +	  In this case 2 banks are allocated for isochronous endpoints and
> +	  only one bank is allocated for the rest of the endpoints.
> +
> +	  fifo_mode = 1 is a generic maximum fifo size (1024 bytes) configuration
> +	  allowing the usage of ep1 - ep6
> +
> +	  fifo_mode = 2 is a generic performance maximum fifo size (1024 bytes)
> +	  configuration allowing the usage of ep1 - ep3
> +
> +	  fifo_mode = 3 is a balanced performance configuration allowing the
> +	  the usage of ep1 - ep8
> +
>  config USB_BCM63XX_UDC
>  	tristate "Broadcom BCM63xx Peripheral Controller"
>  	depends on BCM63XX
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 12c7687..3417bb9 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -20,6 +20,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/ctype.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/atmel_usba_udc.h>
> @@ -318,6 +319,91 @@ static inline void usba_cleanup_debugfs(struct usba_udc *udc)
>  }
>  #endif
>  
> +static ushort fifo_mode;
> +
> +/* "modprobe ... fifo_mode=1" etc */
> +module_param(fifo_mode, ushort, 0x0);
> +MODULE_PARM_DESC(fifo_mode, "Endpoint configuration mode");
> +
> +/* mode 0 - uses autoconfig */
> +
> +/* mode 1 - fits in 8KB, generic max fifo configuration */
> +static struct usba_fifo_cfg mode_1_cfg[] = {
> +{ .hw_ep_num = 0, .fifo_size = 64,	.nr_banks = 1, },
> +{ .hw_ep_num = 1, .fifo_size = 1024,	.nr_banks = 2, },
> +{ .hw_ep_num = 2, .fifo_size = 1024,	.nr_banks = 1, },
> +{ .hw_ep_num = 3, .fifo_size = 1024,	.nr_banks = 1, },
> +{ .hw_ep_num = 4, .fifo_size = 1024,	.nr_banks = 1, },
> +{ .hw_ep_num = 5, .fifo_size = 1024,	.nr_banks = 1, },
> +{ .hw_ep_num = 6, .fifo_size = 1024,	.nr_banks = 1, },
> +};
> +
> +/* mode 2 - fits in 8KB, performance max fifo configuration */
> +static struct usba_fifo_cfg mode_2_cfg[] = {
> +{ .hw_ep_num = 0, .fifo_size = 64,	.nr_banks = 1, },
> +{ .hw_ep_num = 1, .fifo_size = 1024,	.nr_banks = 3, },
> +{ .hw_ep_num = 2, .fifo_size = 1024,	.nr_banks = 2, },
> +{ .hw_ep_num = 3, .fifo_size = 1024,	.nr_banks = 2, },
> +};
> +
> +/* mode 3 - fits in 8KB, mixed fifo configuration */
> +static struct usba_fifo_cfg mode_3_cfg[] = {
> +{ .hw_ep_num = 0, .fifo_size = 64,	.nr_banks = 1, },
> +{ .hw_ep_num = 1, .fifo_size = 1024,	.nr_banks = 2, },
> +{ .hw_ep_num = 2, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 3, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 4, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 5, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 6, .fifo_size = 512,	.nr_banks = 2, },
> +};
> +
> +/* mode 4 - fits in 8KB, custom fifo configuration */
> +static struct usba_fifo_cfg mode_4_cfg[] = {
> +{ .hw_ep_num = 0, .fifo_size = 64,	.nr_banks = 1, },
> +{ .hw_ep_num = 1, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 2, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 3, .fifo_size = 8,	.nr_banks = 2, },
> +{ .hw_ep_num = 4, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 5, .fifo_size = 512,	.nr_banks = 2, },
> +{ .hw_ep_num = 6, .fifo_size = 16,	.nr_banks = 2, },
> +{ .hw_ep_num = 7, .fifo_size = 8,	.nr_banks = 2, },
> +{ .hw_ep_num = 8, .fifo_size = 8,	.nr_banks = 2, },
> +};
> +/* Add additional configurations here */
> +
> +int usba_config_fifo_table(struct usba_udc *udc)
> +{
> +	int n;
> +
> +	switch (fifo_mode) {
> +	default:
> +		fifo_mode = 0;
> +	case 0:
> +		udc->fifo_cfg = NULL;
> +		n = 0;
> +		break;
> +	case 1:
> +		udc->fifo_cfg = mode_1_cfg;
> +		n = ARRAY_SIZE(mode_1_cfg);
> +		break;
> +	case 2:
> +		udc->fifo_cfg = mode_2_cfg;
> +		n = ARRAY_SIZE(mode_2_cfg);
> +		break;
> +	case 3:
> +		udc->fifo_cfg = mode_3_cfg;
> +		n = ARRAY_SIZE(mode_3_cfg);
> +		break;
> +	case 4:
> +		udc->fifo_cfg = mode_4_cfg;
> +		n = ARRAY_SIZE(mode_4_cfg);
> +		break;
> +	}
> +	DBG(DBG_HW, "Setup fifo_mode %d\n", fifo_mode);
> +
> +	return n;
> +}
> +
>  static inline u32 usba_int_enb_get(struct usba_udc *udc)
>  {
>  	return udc->int_enb_cache;
> @@ -543,24 +629,17 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
>  	ep->is_isoc = 0;
>  	ep->is_in = 0;
>  
> -	if (maxpacket <= 8)
> -		ept_cfg = USBA_BF(EPT_SIZE, USBA_EPT_SIZE_8);
> -	else
> -		/* LSB is bit 1, not 0 */
> -		ept_cfg = USBA_BF(EPT_SIZE, fls(maxpacket - 1) - 3);
> -
> -	DBG(DBG_HW, "%s: EPT_SIZE = %lu (maxpacket = %lu)\n",
> +	DBG(DBG_ERR, "%s: EPT_CFG = 0x%lx (maxpacket = %lu)\n",
>  			ep->ep.name, ept_cfg, maxpacket);
>  
>  	if (usb_endpoint_dir_in(desc)) {
>  		ep->is_in = 1;
> -		ept_cfg |= USBA_EPT_DIR_IN;
> +		ep->ept_cfg |= USBA_EPT_DIR_IN;
>  	}
>  
>  	switch (usb_endpoint_type(desc)) {
>  	case USB_ENDPOINT_XFER_CONTROL:
> -		ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_CONTROL);
> -		ept_cfg |= USBA_BF(BK_NUMBER, USBA_BK_NUMBER_ONE);
> +		ep->ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_CONTROL);
>  		break;
>  	case USB_ENDPOINT_XFER_ISOC:
>  		if (!ep->can_isoc) {
> @@ -578,24 +657,15 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
>  			return -EINVAL;
>  
>  		ep->is_isoc = 1;
> -		ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_ISO);
> +		ep->ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_ISO);
> +		ep->ept_cfg |= USBA_BF(NB_TRANS, nr_trans);
>  
> -		/*
> -		 * Do triple-buffering on high-bandwidth iso endpoints.
> -		 */
> -		if (nr_trans > 1 && ep->nr_banks == 3)
> -			ept_cfg |= USBA_BF(BK_NUMBER, USBA_BK_NUMBER_TRIPLE);
> -		else
> -			ept_cfg |= USBA_BF(BK_NUMBER, USBA_BK_NUMBER_DOUBLE);
> -		ept_cfg |= USBA_BF(NB_TRANS, nr_trans);
>  		break;
>  	case USB_ENDPOINT_XFER_BULK:
> -		ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_BULK);
> -		ept_cfg |= USBA_BF(BK_NUMBER, USBA_BK_NUMBER_DOUBLE);
> +		ep->ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_BULK);
>  		break;
>  	case USB_ENDPOINT_XFER_INT:
> -		ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_INT);
> -		ept_cfg |= USBA_BF(BK_NUMBER, USBA_BK_NUMBER_DOUBLE);
> +		ep->ept_cfg |= USBA_BF(EPT_TYPE, USBA_EPT_TYPE_INT);
>  		break;
>  	}
>  
> @@ -604,7 +674,7 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
>  	ep->ep.desc = desc;
>  	ep->ep.maxpacket = maxpacket;
>  
> -	usba_ep_writel(ep, CFG, ept_cfg);
> +	usba_ep_writel(ep, CFG, ep->ept_cfg);
>  	usba_ep_writel(ep, CTL_ENB, USBA_EPT_ENABLE);
>  
>  	if (ep->can_dma) {
> @@ -1006,12 +1076,81 @@ static int atmel_usba_start(struct usb_gadget *gadget,
>  		struct usb_gadget_driver *driver);
>  static int atmel_usba_stop(struct usb_gadget *gadget);
>  
> +static struct usb_ep *atmel_usba_match_ep(
> +	struct usb_gadget		*gadget,
> +	struct usb_endpoint_descriptor	*desc,
> +	struct usb_ss_ep_comp_descriptor *ep_comp
> +)

I don't feel confortable with the parameters aligned with the function
declaration, I would add an extra tab.

static struct usb_ep *atmel_usba_match_ep(
		struct usb_gadget               *gadget,
		struct usb_endpoint_descriptor  *desc,
		struct usb_ss_ep_comp_descriptor *ep_comp)

> +{
> +	struct usb_ep	*_ep;
> +	struct usba_ep *ep;
> +
> +	/* Look at endpoints until an unclaimed one looks usable */
> +	list_for_each_entry(_ep, &gadget->ep_list, ep_list) {
> +		if (usb_gadget_ep_match_desc(gadget, _ep, desc, ep_comp))
> +			goto found_ep;
> +	}
> +	/* Fail */
> +	return NULL;
> +
> +found_ep:
> +
> +	if (fifo_mode == 0) {
> +		/* Optimize hw fifo size based on ep type and other info */
> +		ep = to_usba_ep(_ep);
> +
> +		switch (usb_endpoint_type(desc)) {
> +
> +		case USB_ENDPOINT_XFER_CONTROL:
> +			break;
> +
> +		case USB_ENDPOINT_XFER_ISOC:
> +			ep->fifo_size = 1024;
> +			ep->nr_banks = 2;
> +			break;
> +
> +		case USB_ENDPOINT_XFER_BULK:
> +			ep->fifo_size = 512;
> +			ep->nr_banks = 1;
> +			break;
> +
> +		case USB_ENDPOINT_XFER_INT:
> +			if (desc->wMaxPacketSize == 0)
> +				ep->fifo_size =
> +				    roundup_pow_of_two(_ep->maxpacket_limit);
> +			else
> +				ep->fifo_size =
> +				    roundup_pow_of_two(le16_to_cpu(desc->wMaxPacketSize));
> +			ep->nr_banks = 1;
> +			break;
> +		}
> +
> +		/* It might be a little bit late to set this */
> +		usb_ep_set_maxpacket_limit(&ep->ep, ep->fifo_size);
> +
> +		/* Generate ept_cfg basd on FIFO size and number of banks */
> +		if (ep->fifo_size  <= 8)
> +			ep->ept_cfg = USBA_BF(EPT_SIZE, USBA_EPT_SIZE_8);
> +		else
> +			/* LSB is bit 1, not 0 */
> +			ep->ept_cfg =
> +				USBA_BF(EPT_SIZE, fls(ep->fifo_size - 1) - 3);
> +
> +		ep->ept_cfg |= USBA_BF(BK_NUMBER, ep->nr_banks);
> +
> +		ep->udc->configured_ep++;
> +	}
> +
> +return _ep;
> +}
> +
>  static const struct usb_gadget_ops usba_udc_ops = {
>  	.get_frame		= usba_udc_get_frame,
>  	.wakeup			= usba_udc_wakeup,
>  	.set_selfpowered	= usba_udc_set_selfpowered,
>  	.udc_start		= atmel_usba_start,
>  	.udc_stop		= atmel_usba_stop,
> +	.match_ep		= atmel_usba_match_ep,
>  };
>  
>  static struct usb_endpoint_descriptor usba_ep0_desc = {
> @@ -1678,7 +1817,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
>  	}
>  
>  	if (status & USBA_END_OF_RESET) {
> -		struct usba_ep *ep0;
> +		struct usba_ep *ep0, *ep;
> +		int i, n;
>  
>  		usba_writel(udc, INT_CLR, USBA_END_OF_RESET);
>  		generate_bias_pulse(udc);
> @@ -1717,6 +1857,16 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
>  		if (!(usba_ep_readl(ep0, CFG) & USBA_EPT_MAPPED))
>  			dev_dbg(&udc->pdev->dev,
>  				 "ODD: EP0 configuration is invalid!\n");
> +
> +		/* Preallocate other endpoints */
> +		n = fifo_mode ? udc->num_ep : udc->configured_ep;
> +		for (i = 1; i < n; i++) {
> +			ep = &udc->usba_ep[i];
> +			usba_ep_writel(ep, CFG, ep->ept_cfg);
> +			if (!(usba_ep_readl(ep, CFG) & USBA_EPT_MAPPED))
> +				dev_dbg(&udc->pdev->dev,
> +				 "ODD: EP%d configuration is invalid!\n", i);
> +		}
>  	}
>  
>  	spin_unlock(&udc->lock);
> @@ -1864,6 +2014,9 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
>  	if (gpio_is_valid(udc->vbus_pin))
>  		disable_irq(gpio_to_irq(udc->vbus_pin));
>  
> +	if (fifo_mode == 0)
> +		udc->configured_ep = 1;
> +
>  	usba_stop(udc);
>  
>  	udc->driver = NULL;
> @@ -1931,9 +2084,13 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  						&flags);
>  	udc->vbus_pin_inverted = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
>  
> -	pp = NULL;
> -	while ((pp = of_get_next_child(np, pp)))
> -		udc->num_ep++;
> +	if (fifo_mode == 0)	{

if (fifo_mode == 0) {

Regards

Ludovic

> +		pp = NULL;
> +		while ((pp = of_get_next_child(np, pp)))
> +			udc->num_ep++;
> +		udc->configured_ep = 1;
> +	} else
> +		udc->num_ep = usba_config_fifo_table(udc);
>  
>  	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * udc->num_ep,
>  			   GFP_KERNEL);
> @@ -1946,7 +2103,7 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  
>  	pp = NULL;
>  	i = 0;
> -	while ((pp = of_get_next_child(np, pp))) {
> +	while ((pp = of_get_next_child(np, pp)) && i < udc->num_ep) {
>  		ep = &eps[i];
>  
>  		ret = of_property_read_u32(pp, "reg", &val);
> @@ -1954,21 +2111,21 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  			dev_err(&pdev->dev, "of_probe: reg error(%d)\n", ret);
>  			goto err;
>  		}
> -		ep->index = val;
> +		ep->index = fifo_mode ? udc->fifo_cfg[i].hw_ep_num : val;
>  
>  		ret = of_property_read_u32(pp, "atmel,fifo-size", &val);
>  		if (ret) {
>  			dev_err(&pdev->dev, "of_probe: fifo-size error(%d)\n", ret);
>  			goto err;
>  		}
> -		ep->fifo_size = val;
> +		ep->fifo_size = fifo_mode ? udc->fifo_cfg[i].fifo_size : val;
>  
>  		ret = of_property_read_u32(pp, "atmel,nb-banks", &val);
>  		if (ret) {
>  			dev_err(&pdev->dev, "of_probe: nb-banks error(%d)\n", ret);
>  			goto err;
>  		}
> -		ep->nr_banks = val;
> +		ep->nr_banks = fifo_mode ? udc->fifo_cfg[i].nr_banks : val;
>  
>  		ep->can_dma = of_property_read_bool(pp, "atmel,can-dma");
>  		ep->can_isoc = of_property_read_bool(pp, "atmel,can-isoc");
> @@ -2000,6 +2157,21 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  		ep->ep.caps.dir_in = true;
>  		ep->ep.caps.dir_out = true;
>  
> +		if (fifo_mode != 0) {
> +			/*
> +			 * Generate ept_cfg based on FIFO size and
> +			 * banks number
> +			 */
> +			if (ep->fifo_size  <= 8)
> +				ep->ept_cfg = USBA_BF(EPT_SIZE, USBA_EPT_SIZE_8);
> +			else
> +				/* LSB is bit 1, not 0 */
> +				ep->ept_cfg =
> +				  USBA_BF(EPT_SIZE, fls(ep->fifo_size - 1) - 3);
> +
> +			ep->ept_cfg |= USBA_BF(BK_NUMBER, ep->nr_banks);
> +		}
> +
>  		if (i)
>  			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
>  
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
> index b03b2eb..9551b70 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
> @@ -275,6 +275,12 @@ struct usba_dma_desc {
>  	u32 ctrl;
>  };
>  
> +struct usba_fifo_cfg {
> +	u8			hw_ep_num;
> +	u16			fifo_size;
> +	u8			nr_banks;
> +};
> +
>  struct usba_ep {
>  	int					state;
>  	void __iomem				*ep_regs;
> @@ -293,7 +299,7 @@ struct usba_ep {
>  	unsigned int				can_isoc:1;
>  	unsigned int				is_isoc:1;
>  	unsigned int				is_in:1;
> -
> +	unsigned long				ept_cfg;
>  #ifdef CONFIG_USB_GADGET_DEBUG_FS
>  	u32					last_dma_status;
>  	struct dentry				*debugfs_dir;
> @@ -338,6 +344,8 @@ struct usba_udc {
>  	int vbus_pin;
>  	int vbus_pin_inverted;
>  	int num_ep;
> +	int configured_ep;
> +	struct usba_fifo_cfg *fifo_cfg;
>  	struct clk *pclk;
>  	struct clk *hclk;
>  	struct usba_ep *usba_ep;
> -- 
> 2.7.4
> 
