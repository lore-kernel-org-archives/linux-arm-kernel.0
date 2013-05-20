From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 20 May 2013 11:26:02 +0800
Subject: [PATCH 1/5] usb: add Atmel USBA UDC DT support
In-Reply-To: <1368801730-31383-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130517141443.GB16804@game.jcrosoft.org>
 <1368801730-31383-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <519997CA.8010503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On 5/17/2013 22:42, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Allow to compile the driver all the time if AT91 enabled.
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-usb at vger.kernel.org
> ---
>   .../devicetree/bindings/usb/atmel-usb.txt          |   82 ++++++++
>   drivers/usb/gadget/Kconfig                         |    2 +-
>   drivers/usb/gadget/atmel_usba_udc.c                |  214 +++++++++++++++-----
>   drivers/usb/gadget/atmel_usba_udc.h                |    1 +
>   4 files changed, 244 insertions(+), 55 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> index 60bd215..878556b2 100644
> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> @@ -47,3 +47,85 @@ usb1: gadget at fffa4000 {
>   	interrupts = <10 4>;
>   	atmel,vbus-gpio = <&pioC 5 0>;
>   };
> +
> +Atmel High-Speed USB device controller
> +
> +Required properties:
> + - compatible: Should be "atmel,at91sam9rl-udc"
> + - reg: Address and length of the register set for the device
> + - interrupts: Should contain macb interrupt

s/macb/udphs

> + - ep childnode: To specifiy the number of endpoints and their properties.

s/specifiy/specify

> +
> +Optional properties:
> + - atmel,vbus-gpio: If present, specifies a gpio that needs to be
> +   activated for the bus to be powered.
> +
> +Required child node properties:
> + - name: Name of the endpoint.
> + - reg: Num of the endpoint.
> + - atmel,fifo-size: Size of the fifo.
> + - atmel,nb-banks: Number of banks.
> + - atmel,can-dma: Boolean to specify if the endpoint support DMA.
> + - atmel,can-isoc: Boolean to specify if the endpoint support ISOC.
> +
> +usb2: gadget at fff78000 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "atmel,at91sam9rl-udc";
> +	reg = <0x00600000 0x80000
> +	       0xfff78000 0x400>;
> +	interrupts = <27 4>;

s/interrupts = <27 4>/interrupts = <27 IRQ_TYPE_LEVEL_HIGH 0>;

> +	atmel,vbus-gpio = <&pioB 19 0>;
> +
> +	ep0 {
> +		reg = <0>;
> +		atmel,fifo-size = <64>;
> +		atmel,nb-banks = <1>;
> +	};
> +
> +	ep1 {
> +		reg = <1>;
> +		atmel,fifo-size = <1024>;
> +		atmel,nb-banks = <2>;
> +		atmel,can-dma;
> +		atmel,can-isoc;
> +	};
> +
> +	ep2 {
> +		reg = <2>;
> +		atmel,fifo-size = <1024>;
> +		atmel,nb-banks = <2>;
> +		atmel,can-dma;
> +		atmel,can-isoc;
> +	};
> +
> +	ep3 {
> +		reg = <3>;
> +		atmel,fifo-size = <1024>;
> +		atmel,nb-banks = <3>;
> +		atmel,can-dma;
> +	};
> +
> +	ep4 {
> +		reg = <4>;
> +		atmel,fifo-size = <1024>;
> +		atmel,nb-banks = <3>;
> +		atmel,can-dma;
> +	};
> +
> +	ep5 {
> +		reg = <5>;
> +		atmel,fifo-size = <1024>;
> +		atmel,nb-banks = <3>;
> +		atmel,can-dma;
> +		atmel,can-isoc;
> +	};
> +
> +	ep6 {
> +		reg = <6>;
> +		atmel,fifo-size = <1024>;
> +		atmel,nb-banks = <3>;
> +		atmel,can-dma;
> +		atmel,can-isoc;
> +	};
> +};
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 83300d9..5e47d50 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -156,7 +156,7 @@ config USB_LPC32XX
>
>   config USB_ATMEL_USBA
>   	tristate "Atmel USBA"
> -	depends on AVR32 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
> +	depends on AVR32 || ARCH_AT91
>   	help
>   	  USBA is the integrated high-speed USB Device controller on
>   	  the AT32AP700x, some AT91SAM9 and AT91CAP9 processors from Atmel.
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f2a970f..b3084b9 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -22,6 +22,8 @@
>   #include <linux/usb/atmel_usba_udc.h>
>   #include <linux/delay.h>
>   #include <linux/platform_data/atmel.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>
>   #include <asm/gpio.h>
>
> @@ -1835,9 +1837,143 @@ static int atmel_usba_stop(struct usb_gadget *gadget,
>   	return 0;
>   }
>
> -static int __init usba_udc_probe(struct platform_device *pdev)
> +#ifdef CONFIG_OF
> +static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
> +						    struct usba_udc *udc)
> +{
> +	u32 val;
> +	const char *name;
> +	enum of_gpio_flags flags;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *pp;
> +	int i, ret;
> +	struct usba_ep *eps, *ep;
> +
> +	udc->num_ep = 0;
> +
> +	udc->vbus_pin = of_get_named_gpio_flags(np, "atmel,vbus-gpio", 0,
> +						&flags);
> +	udc->vbus_pin_inverted = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
> +
> +	pp = NULL;
> +	while ((pp = of_get_next_child(np, pp)))
> +		udc->num_ep++;
> +
> +	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * udc->num_ep,
> +			   GFP_KERNEL);

Using devm_kzalloc will cause issue when build as modules, and load and 
unload this driver, the second time unload, it will come out following 
segment fault, log as following. Using kzalloc will fix it.

---8>---
Unable to handle kernel NULL pointer dereference at virtual address 00000054
pgd = c7bac000
[00000054] *pgd=27b6f831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] ARM
Modules linked in: atmel_usba_udc(-) [last unloaded: atmel_usba_udc]
CPU: 0 PID: 519 Comm: rmmod Not tainted 3.10.0-rc1+ #13
task: c796d580 ti: c7b68000 task.ti: c7b68000
PC is at kfree+0x4c/0xb4
LR is at free_module+0xe4/0x168
pc : [<c007470c>]    lr : [<c0045884>]    psr: 40000093
sp : c7b69f10  ip : 00000010  fp : 00000000
r10: 00000000  r9 : c7b68000  r8 : c0009484
r7 : 00000000  r6 : c7ba0c00  r5 : a0000013  r4 : bf009240
r3 : c061d400  r2 : 00000000  r1 : 00007ba0  r0 : c7ba0c00
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 27bac000  DAC: 00000015
Process rmmod (pid: 519, stack limit = 0xc7b681b8)
Stack: (0xc7b69f10 to 0xc7b6a000)
9f00:                                     0000000f bf009240 000000a8 
bf009288
9f20: c7afe6a8 c0045884 bf009240 00000000 00000013 becbfbd0 c0009484 
c0045c10
9f40: 00000000 656d7461 73755f6c 755f6162 b6006364 b6f1c000 c796d580 
b6f1c000
9f60: b6f1c000 c7afb140 00000000 becbf984 00005401 00000001 c7b68000 
00000000
9f80: bf009240 00000880 c7b69f8c 00000000 becbf9bc b6f0a380 00000880 
becbfbd0
9fa0: 00000081 c0009320 b6f0a380 00000880 becbfbd0 00000880 0000000e 
00000000
9fc0: b6f0a380 00000880 becbfbd0 00000081 0000009c 0000ce8c 0000b7f0 
00000000
9fe0: b6ebda20 becbfbc0 00019750 b6ebda2c a0000010 becbfbd0 00000000 
00000000
[<c007470c>] (kfree+0x4c/0xb4) from [<c0045884>] (free_module+0xe4/0x168)
[<c0045884>] (free_module+0xe4/0x168) from [<c0045c10>] 
(SyS_delete_module+0x1d8/0x210)
[<c0045c10>] (SyS_delete_module+0x1d8/0x210) from [<c0009320>] 
(ret_fast_syscall+0x0/0x2c)
Code: e7922281 e3120902 1593301c e593701c (e5974054)
---[ end trace cb98ff9cd16ea901 ]---
Segmentation fault
---<8---

> +	if (!eps)
> +		return ERR_PTR(-ENOMEM);
> +
> +	udc->gadget.ep0 = &eps[0].ep;
> +
> +	INIT_LIST_HEAD(&eps[0].ep.ep_list);
> +
> +	pp = NULL;
> +	i = 0;
> +	while ((pp = of_get_next_child(np, pp))) {
> +		ep = &eps[i];
> +
> +		ret = of_property_read_u32(pp, "reg", &val);
> +		if (ret) {
> +			dev_err(&pdev->dev, "of_probe: reg error(%d)\n", ret);
> +			goto err;
> +		}
> +		ep->index = val;
> +
> +		ret = of_property_read_u32(pp, "atmel,fifo-size", &val);
> +		if (ret) {
> +			dev_err(&pdev->dev, "of_probe: fifo-size error(%d)\n", ret);
> +			goto err;
> +		}
> +		ep->fifo_size = val;
> +
> +		ret = of_property_read_u32(pp, "atmel,nb-banks", &val);
> +		if (ret) {
> +			dev_err(&pdev->dev, "of_probe: nb-banks error(%d)\n", ret);
> +			goto err;
> +		}
> +		ep->nr_banks = val;
> +
> +		ep->can_dma = of_property_read_bool(pp, "atmel,can-dma");
> +		ep->can_isoc = of_property_read_bool(pp, "atmel,can-isoc");
> +
> +		ret = of_property_read_string(pp, "name", &name);
> +		ep->ep.name = name;
> +
> +		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
> +		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
> +		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
> +		ep->ep.ops = &usba_ep_ops;
> +		ep->ep.maxpacket = ep->fifo_size;
> +		ep->udc = udc;
> +		INIT_LIST_HEAD(&ep->queue);
> +
> +		if (i)
> +			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
> +
> +		i++;
> +	}
> +
> +	return eps;
> +err:
> +	return ERR_PTR(ret);
> +}
> +#else
> +static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
> +						    struct usba_udc *udc)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +#endif
> +
> +static struct usba_ep * usba_udc_pdata(struct platform_device *pdev,
> +						 struct usba_udc *udc)
>   {
>   	struct usba_platform_data *pdata = pdev->dev.platform_data;
> +	struct usba_ep *eps;
> +	int i;
> +
> +	if (!pdata)
> +		return ERR_PTR(-ENXIO);
> +
> +	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * pdata->num_ep,
> +			   GFP_KERNEL);
> +	if (!eps)
> +		return ERR_PTR(-ENOMEM);
> +
> +	udc->gadget.ep0 = &eps[0].ep;
> +
> +	udc->vbus_pin = pdata->vbus_pin;
> +	udc->vbus_pin_inverted = pdata->vbus_pin_inverted;
> +	udc->num_ep = pdata->num_ep;
> +
> +	INIT_LIST_HEAD(&eps[0].ep.ep_list);
> +
> +	for (i = 0; i < pdata->num_ep; i++) {
> +		struct usba_ep *ep = &eps[i];
> +
> +		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
> +		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
> +		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
> +		ep->ep.ops = &usba_ep_ops;
> +		ep->ep.name = pdata->ep[i].name;
> +		ep->fifo_size = ep->ep.maxpacket = pdata->ep[i].fifo_size;
> +		ep->udc = udc;
> +		INIT_LIST_HEAD(&ep->queue);
> +		ep->nr_banks = pdata->ep[i].nr_banks;
> +		ep->index = pdata->ep[i].index;
> +		ep->can_dma = pdata->ep[i].can_dma;
> +		ep->can_isoc = pdata->ep[i].can_isoc;
> +
> +		if (i)
> +			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
> +	}
> +
> +	return eps;
> +}
> +
> +static int __init usba_udc_probe(struct platform_device *pdev)
> +{
>   	struct resource *regs, *fifo;
>   	struct clk *pclk, *hclk;
>   	struct usba_udc *udc = &the_udc;
> @@ -1845,7 +1981,7 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>
>   	regs = platform_get_resource(pdev, IORESOURCE_MEM, CTRL_IOMEM_ID);
>   	fifo = platform_get_resource(pdev, IORESOURCE_MEM, FIFO_IOMEM_ID);
> -	if (!regs || !fifo || !pdata)
> +	if (!regs || !fifo)
>   		return -ENXIO;
>
>   	irq = platform_get_irq(pdev, 0);
> @@ -1891,46 +2027,14 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>   	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
>   	clk_disable(pclk);
>
> -	usba_ep = kzalloc(sizeof(struct usba_ep) * pdata->num_ep,
> -			  GFP_KERNEL);
> -	if (!usba_ep)
> -		goto err_alloc_ep;
> -
> -	the_udc.gadget.ep0 = &usba_ep[0].ep;
> -
> -	INIT_LIST_HEAD(&usba_ep[0].ep.ep_list);
> -	usba_ep[0].ep_regs = udc->regs + USBA_EPT_BASE(0);
> -	usba_ep[0].dma_regs = udc->regs + USBA_DMA_BASE(0);
> -	usba_ep[0].fifo = udc->fifo + USBA_FIFO_BASE(0);
> -	usba_ep[0].ep.ops = &usba_ep_ops;
> -	usba_ep[0].ep.name = pdata->ep[0].name;
> -	usba_ep[0].ep.maxpacket = pdata->ep[0].fifo_size;
> -	usba_ep[0].udc = &the_udc;
> -	INIT_LIST_HEAD(&usba_ep[0].queue);
> -	usba_ep[0].fifo_size = pdata->ep[0].fifo_size;
> -	usba_ep[0].nr_banks = pdata->ep[0].nr_banks;
> -	usba_ep[0].index = pdata->ep[0].index;
> -	usba_ep[0].can_dma = pdata->ep[0].can_dma;
> -	usba_ep[0].can_isoc = pdata->ep[0].can_isoc;
> -
> -	for (i = 1; i < pdata->num_ep; i++) {
> -		struct usba_ep *ep = &usba_ep[i];
> -
> -		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
> -		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
> -		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
> -		ep->ep.ops = &usba_ep_ops;
> -		ep->ep.name = pdata->ep[i].name;
> -		ep->ep.maxpacket = pdata->ep[i].fifo_size;
> -		ep->udc = &the_udc;
> -		INIT_LIST_HEAD(&ep->queue);
> -		ep->fifo_size = pdata->ep[i].fifo_size;
> -		ep->nr_banks = pdata->ep[i].nr_banks;
> -		ep->index = pdata->ep[i].index;
> -		ep->can_dma = pdata->ep[i].can_dma;
> -		ep->can_isoc = pdata->ep[i].can_isoc;
> +	if (pdev->dev.of_node)
> +		usba_ep = atmel_udc_of_init(pdev, udc);
> +	else
> +		usba_ep = usba_udc_pdata(pdev, udc);
>
> -		list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
> +	if (IS_ERR(usba_ep)) {
> +		ret = PTR_ERR(usba_ep);
> +		goto err_alloc_ep;
>   	}
>
>   	ret = request_irq(irq, usba_udc_irq, 0, "atmel_usba_udc", udc);
> @@ -1941,16 +2045,12 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>   	}
>   	udc->irq = irq;
>
> -	if (gpio_is_valid(pdata->vbus_pin)) {
> -		if (!gpio_request(pdata->vbus_pin, "atmel_usba_udc")) {
> -			udc->vbus_pin = pdata->vbus_pin;
> -			udc->vbus_pin_inverted = pdata->vbus_pin_inverted;
> -
> +	if (gpio_is_valid(udc->vbus_pin)) {
> +		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
>   			ret = request_irq(gpio_to_irq(udc->vbus_pin),
>   					usba_vbus_irq, 0,
>   					"atmel_usba_udc", udc);
>   			if (ret) {
> -				gpio_free(udc->vbus_pin);
>   				udc->vbus_pin = -ENODEV;
>   				dev_warn(&udc->pdev->dev,
>   					 "failed to request vbus irq; "
> @@ -1969,16 +2069,14 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>   		goto err_add_udc;
>
>   	usba_init_debugfs(udc);
> -	for (i = 1; i < pdata->num_ep; i++)
> +	for (i = 1; i < udc->num_ep; i++)
>   		usba_ep_init_debugfs(udc, &usba_ep[i]);
>
>   	return 0;
>
>   err_add_udc:
> -	if (gpio_is_valid(pdata->vbus_pin)) {
> +	if (gpio_is_valid(udc->vbus_pin))
>   		free_irq(gpio_to_irq(udc->vbus_pin), udc);
> -		gpio_free(udc->vbus_pin);
> -	}
>
>   	free_irq(irq, udc);
>   err_request_irq:
> @@ -2001,19 +2099,17 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
>   {
>   	struct usba_udc *udc;
>   	int i;
> -	struct usba_platform_data *pdata = pdev->dev.platform_data;
>
>   	udc = platform_get_drvdata(pdev);
>
>   	usb_del_gadget_udc(&udc->gadget);
>
> -	for (i = 1; i < pdata->num_ep; i++)
> +	for (i = 1; i < udc->num_ep; i++)
>   		usba_ep_cleanup_debugfs(&usba_ep[i]);
>   	usba_cleanup_debugfs(udc);
>
>   	if (gpio_is_valid(udc->vbus_pin)) {
>   		free_irq(gpio_to_irq(udc->vbus_pin), udc);
> -		gpio_free(udc->vbus_pin);
>   	}
>
>   	free_irq(udc->irq, udc);
> @@ -2026,11 +2122,21 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id atmel_udc_dt_ids[] = {
> +	{ .compatible = "atmel,at91sam9rl-udc" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, atmel_udc_dt_ids);
> +#endif
> +
>   static struct platform_driver udc_driver = {
>   	.remove		= __exit_p(usba_udc_remove),
>   	.driver		= {
>   		.name		= "atmel_usba_udc",
>   		.owner		= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(atmel_udc_dt_ids),
>   	},
>   };
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
> index d65a618..6999a26 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/atmel_usba_udc.h
> @@ -317,6 +317,7 @@ struct usba_udc {
>   	int irq;
>   	int vbus_pin;
>   	int vbus_pin_inverted;
> +	int num_ep;
>   	struct clk *pclk;
>   	struct clk *hclk;
>
>

Best Regards,
Bo Shen
