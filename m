From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 23 Jul 2010 13:18:16 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <20100722171404.e25e593a.ospite@studenti.unina.it>
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
	<20100703221022.27df1a2e.ospite@studenti.unina.it>
	<87r5jkxh1y.fsf@free.fr>
	<20100705104043.c72d4a5b.ospite@studenti.unina.it>
	<87zkxyv3jv.fsf@free.fr>
	<20100722171404.e25e593a.ospite@studenti.unina.it>
Message-ID: <20100723131816.a5a5e9a7.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jul 2010 17:14:04 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> On Sun, 11 Jul 2010 10:13:56 +0200
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> 
[...]
> > Well, the UDC is responding to each request from the USB host by stalling the
> > USB endpoint (and not by stalling the full kernel). This shows that at least
> > kernel interrupts are still alive and working.
> > 
> > > I noted that (either with or without this patch) a quite similar phone
> > > works, it's Motorola A1200 and has a different bootloader.
> > > Maybe comparing some registers can help here?
> > 
> > I'm still not fully convinced the pxa27x_udc is blocking the kernel. As the
> > interrupt is working properly, and the interrupt handler relies on a spinlock,
> > the spinlock is correcly released after each interrupt, and the driver should
> > work normally.
> > Now, the interrupt "storm" could block the kernel. That would rather be an host
> > issue. Did you try to connect your phone to another computer ?
> >
> > I would ask for a last test : on the first line of function pxa_udc_probe(),
> > insert "return 0;". If kernel still stalls, the pxa27x-udc is not involved.
> >
> 
> By inserting that "return 0;" the kernel goes on and I can complete
> booting.
> 
> BTW, I added some dumb debug calls to see the driver functions sequence
> on both a780 and a1200 and it turns out that on A1200 I don't have this
> IRQ that makes the driver(?) crazy on a780, does this new info give any
> new element to you to find out the root cause? The two phones have
> slight different hardware tho.
> 
> Here are the two calling sequences:
> http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/udc_a780.txt
> http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/udc_a1200.txt
>

After that I tried deferring request_irq until the gadget driver has
been registered, and it seems to work I don't get the Oops anymore,
I see this as a quickfix I don't know if I like it as it does not look
correct to me, but it could be another element toward a proper solution.

See the inlined patch:

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index 85b0d89..f083c5e 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1791,6 +1791,7 @@ static void udc_enable(struct pxa_udc *udc)
 	udc->enabled = 1;
 }
 
+static irqreturn_t pxa_udc_irq(int irq, void *_dev);
 /**
  * usb_gadget_register_driver - Register gadget driver
  * @driver: gadget driver
@@ -1847,6 +1848,16 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	if (should_enable_udc(udc))
 		udc_enable(udc);
+
+	/* irq setup after old hardware state is cleaned up */
+	retval = request_irq(udc->irq, pxa_udc_irq,
+			IRQF_SHARED, driver_name, udc);
+	if (retval != 0) {
+		dev_err(udc->dev, "%s: can't get irq %i, err %d\n",
+			driver_name, IRQ_USB, retval);
+		goto transceiver_fail;
+	}
+
 	return 0;
 
 transceiver_fail:
@@ -2507,15 +2518,6 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 	udc_init_data(udc);
 	pxa_eps_setup(udc);
 
-	/* irq setup after old hardware state is cleaned up */
-	retval = request_irq(udc->irq, pxa_udc_irq,
-			IRQF_SHARED, driver_name, udc);
-	if (retval != 0) {
-		dev_err(udc->dev, "%s: can't get irq %i, err %d\n",
-			driver_name, IRQ_USB, retval);
-		goto err_irq;
-	}
-
 	pxa_init_debugfs(udc);
 	return 0;
 err_irq:

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100723/9bef7365/attachment.sig>
