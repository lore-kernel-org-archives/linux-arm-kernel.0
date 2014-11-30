From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 30 Nov 2014 22:07:09 +0100
Subject: [PATCH v2 2/3] usb: phy: add lubbock phy driver
In-Reply-To: <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Sun, 30 Nov 2014 01:02:04 +0300")
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
 <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
Message-ID: <874mtg1jpe.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Extract lubbock-specific code from pxa25x_udc driver. As a bonus, phy
> driver determines connector/VBUS status by reading CPLD register. Also
> it uses a work to call into udc stack, instead of pinging vbus session
> right from irq handler.
This comment is not accurate anymore, right ? The work call, etc ...

Moreover, I have this compile error:
drivers/built-in.o: In function `lubbock_vbus_remove':
/home/rj/mio_linux/kernel/drivers/usb/phy/phy-lubbock.c:200: undefined reference to `usb_remove_phy'
drivers/built-in.o: In function `lubbock_vbus_probe':
/home/rj/mio_linux/kernel/drivers/usb/phy/phy-lubbock.c:186: undefined reference to `usb_add_phy'
Makefile:922: recipe for target 'vmlinux' failed

A select in Kconfig is missing, right ?
And then :
genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 294
lubbock-vbus lubbock-vbus: can't request irq 294, err: -22
lubbock-vbus: probe of lubbock-vbus failed with error -22

> +static int is_vbus_powered(void)
> +{
> +	return !(LUB_MISC_RD && BIT(9));
That BIT(9) is a bit ugly. Moreover the "&&" is certainly wrong.
A define somewhere would be fine.

> +}
> +
> +static void lubbock_vbus_handle(struct lubbock_vbus_data *lubbock_vbus)
I have not reviewed that one thoroughly ...
> +
> +/* VBUS change IRQ handler */
> +static irqreturn_t lubbock_vbus_irq(int irq, void *data)
> +{
> +	struct platform_device *pdev = data;
> +	struct lubbock_vbus_data *lubbock_vbus = platform_get_drvdata(pdev);
> +	struct usb_otg *otg = lubbock_vbus->phy.otg;
> +
> +	dev_dbg(&pdev->dev, "VBUS %s (gadget: %s)\n",
> +		is_vbus_powered() ? "supplied" : "inactive",
> +		otg->gadget ? otg->gadget->name : "none");
> +
> +	switch (irq) {
> +	case LUBBOCK_USB_IRQ:
> +		disable_irq(LUBBOCK_USB_IRQ);
> +		enable_irq(LUBBOCK_USB_DISC_IRQ);
> +		break;
> +	case LUBBOCK_USB_DISC_IRQ:
> +		disable_irq(LUBBOCK_USB_DISC_IRQ);
> +		enable_irq(LUBBOCK_USB_IRQ);
> +		break;
> +	default:
> +		return IRQ_NONE;
> +	}
> +
> +	/*
> +	 * No need to use workqueue here - we are in a threded handler,
> +	 * so we can sleep.
> +	 */
What if a new interrupt occurs in here, and preempts this thread.

> +	if (otg->gadget)
> +		lubbock_vbus_handle(lubbock_vbus);
I think the enable_irq() call should be here. I can't have an ordering problem
at this point, right ?

> +	err = devm_request_threaded_irq(&pdev->dev, LUBBOCK_USB_DISC_IRQ,
> +			NULL, lubbock_vbus_irq, 0, "vbus disconnect", pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "can't request irq %i, err: %d\n",
> +			LUBBOCK_USB_DISC_IRQ, err);
> +		return err;
> +	}
> +
> +	err = devm_request_threaded_irq(&pdev->dev, LUBBOCK_USB_IRQ,
> +			NULL, lubbock_vbus_irq, 0, "vbus connect", pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "can't request irq %i, err: %d\n",
> +			LUBBOCK_USB_IRQ, err);
> +		return err;
> +	}
Here you have both interrupts enabled, this will mean one interrupt at least
will fire. And of course the other one will be enabled a second time, hence
imbalance.

If you want to have an initial status of disconnected gadget, just enable ti
connect interrupt at probing.

Cheers.

-- 
Robert
