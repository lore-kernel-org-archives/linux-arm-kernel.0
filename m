From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 May 2013 17:44:15 +0200
Subject: [PATCH 1/5] usb: add Atmel USBA UDC DT support
In-Reply-To: <20130520101237.GA9937@game.jcrosoft.org>
References: <20130517141443.GB16804@game.jcrosoft.org>
 <1368801730-31383-1-git-send-email-plagnioj@jcrosoft.com>
 <519997CA.8010503@atmel.com>
 <20130520101237.GA9937@game.jcrosoft.org>
Message-ID: <20130520154415.GB9937@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:12 Mon 20 May     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > >
> > >-static int __init usba_udc_probe(struct platform_device *pdev)
> > >+#ifdef CONFIG_OF
> > >+static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
> > >+						    struct usba_udc *udc)
> > >+{
> > >+	u32 val;
> > >+	const char *name;
> > >+	enum of_gpio_flags flags;
> > >+	struct device_node *np = pdev->dev.of_node;
> > >+	struct device_node *pp;
> > >+	int i, ret;
> > >+	struct usba_ep *eps, *ep;
> > >+
> > >+	udc->num_ep = 0;
> > >+
> > >+	udc->vbus_pin = of_get_named_gpio_flags(np, "atmel,vbus-gpio", 0,
> > >+						&flags);
> > >+	udc->vbus_pin_inverted = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
> > >+
> > >+	pp = NULL;
> > >+	while ((pp = of_get_next_child(np, pp)))
> > >+		udc->num_ep++;
> > >+
> > >+	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * udc->num_ep,
> > >+			   GFP_KERNEL);
> > 
> > Using devm_kzalloc will cause issue when build as modules, and load
> > and unload this driver, the second time unload, it will come out
> > following segment fault, log as following. Using kzalloc will fix
> > it.
> 
> no devm_kzalloc is the right one to use
> 
> if there is a this not in the drivers and kzalloc is not the solution
> we need to find the real reason as devm_xxx are used everywhere by now

The issue come from that the current driver have some hack that forbiden
multi-instance

I'll drop that

so yes devm_kzalloc is the right alloc to use
