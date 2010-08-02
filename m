From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Mon, 02 Aug 2010 16:25:34 +0200
Subject: [PATCH] usb gadget: don't save bind callback in struct
	usb_gadget_driver
In-Reply-To: <1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <op.vgs04dub7p4s8u@pikus>
	<1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <op.vgtecwcq7p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some random thoughts, one bug and mostly just minor comments:

> @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
>  }
> /* Called by gadget driver to register itself */
> -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct udc		*dev = udc;
>  	int			retval;
>  	u32 tmp;
>-	if (!driver || !driver->bind || !driver->setup
> +	if (!driver || bind || !driver->setup


** BUG: Should read "!bind".


> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> @@ -1612,7 +1613,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
>  	DBG("bound to %s\n", driver->driver.name);
>  	return 0;
>  }
> -EXPORT_SYMBOL (usb_gadget_register_driver);
> +EXPORT_SYMBOL (usb_gadget_probe_driver);

How about also correcting space before "("?

> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1789,7 +1789,8 @@ out:
>  	return IRQ_HANDLED;
>  }
>-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct usba_udc *udc = &the_udc;
>  	unsigned long flags;

There was no checking here?  How about adding?

> diff --git a/drivers/usb/gadget/ci13xxx_udc.c b/drivers/usb/gadget/ci13xxx_udc.c
> @@ -2340,12 +2340,13 @@ static const struct usb_ep_ops usb_ep_ops = {
>  static const struct usb_gadget_ops usb_gadget_ops;
> /**
> - * usb_gadget_register_driver: register a gadget driver
> + * usb_gadget_probe_driver: register a gadget driver
>   *
> - * Check usb_gadget_register_driver() at "usb_gadget.h" for details
> - * Interrupts are enabled here
> + * Check usb_gadget_probe_driver() at "usb_gadget.h" for details.
> + * Interrupts are enabled here.
>   */

usb_gadget.h is the old name.  How about correcting it as well?

> diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
> @@ -3583,7 +3582,7 @@ static int __init fsg_init(void)
>  	if ((rc = fsg_alloc()) != 0)
>  		return rc;
>  	fsg = the_fsg;
> -	if ((rc = usb_gadget_register_driver(&fsg_driver)) != 0)
> +	if ((rc = usb_gadget_probe_driver(&fsg_driver, fsg_bind)) != 0)

I'm tempted to propose:

+ rc = usb_gadget_probe_driver(&fsg_driver, fsg_bind);
+ if (rc != 0)

which is more compatible with coding style but it probably would be inconsistent
with the rest of the code.

> diff --git a/drivers/usb/gadget/langwell_udc.c b/drivers/usb/gadget/langwell_udc.c
> @@ -1807,7 +1807,8 @@ static DEVICE_ATTR(langwell_udc, S_IRUGO, show_langwell_udc, NULL);
>   * the driver might get unbound.
>   */
>-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct langwell_udc	*dev = the_controller;
>  	unsigned long		flags;

Again, function has no checking, how about adding?

> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> @@ -1698,7 +1698,8 @@ void musb_gadget_cleanup(struct musb *musb)
>   * @param driver the gadget driver
>   * @return <0 if error, 0 if everything is fine
>   */

I've just noticed that it misses @param bind in the comment.  Would be great to update it
and all other occurrences.

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> @@ -798,17 +797,18 @@ struct usb_gadget_driver {
>   */
> /**
> - * usb_gadget_register_driver - register a gadget driver
> - * @driver:the driver being registered
> + * usb_gadget_probe_driver - probe a gadget driver
> + * @driver: the driver being registered

+ * @bind: the driver's bind callback.

>   * Context: can sleep
>   *
>   * Call this in your gadget driver's module initialization function,
>   * to tell the underlying usb controller driver about your driver.
> - * The driver's bind() function will be called to bind it to a
> - * gadget before this registration call returns.  It's expected that
> - * the bind() functions will be in init sections.
> + * The bind() function will be called to bind it to a gadget before this
> + * registration call returns.  It's expected that the bind() function will

Maybe "the @bind function" in those two places?

So for what it's worth, I haven't noticed any other obvious problems.

I think it still does not fix all the section mismatch warnings -- would have to look
closer at composite gadgets -- so I think still parts of my patch is legit.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
