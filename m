From: ospite@studenti.unina.it (Antonio Ospite)
Date: Thu, 22 Jul 2010 17:14:04 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <87zkxyv3jv.fsf@free.fr>
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
	<20100703221022.27df1a2e.ospite@studenti.unina.it>
	<87r5jkxh1y.fsf@free.fr>
	<20100705104043.c72d4a5b.ospite@studenti.unina.it>
	<87zkxyv3jv.fsf@free.fr>
Message-ID: <20100722171404.e25e593a.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Jul 2010 10:13:56 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
> 
> > The Oops does not occurr anymore but UDC does not work yet, with DEBUG
> > disabled I see kernel stops here, no more messages _at_all_ after that:
> > <6>[    7.196467] pxa27x_udc: version 2008-04-18
> > <6>[    7.201653] pxa27x-udc pxa27x-udc: USB reset
> >
> > And on the host side I get:
> > [ 6512.104045] usb 4-2: new full speed USB device using ohci_hcd and address 50
> > [ 6512.512030] usb 4-2: device not accepting address 50, error -62
> > [ 6512.512063] hub 4-0:1.0: unable to enumerate USB device on port 2
> >
> > If I enable debug back I can see some messages repeated over
> > and over:
> >
[...]
> 
> Well, the UDC is responding to each request from the USB host by stalling the
> USB endpoint (and not by stalling the full kernel). This shows that at least
> kernel interrupts are still alive and working.
> 
> > I noted that (either with or without this patch) a quite similar phone
> > works, it's Motorola A1200 and has a different bootloader.
> > Maybe comparing some registers can help here?
> 
> I'm still not fully convinced the pxa27x_udc is blocking the kernel. As the
> interrupt is working properly, and the interrupt handler relies on a spinlock,
> the spinlock is correcly released after each interrupt, and the driver should
> work normally.
> Now, the interrupt "storm" could block the kernel. That would rather be an host
> issue. Did you try to connect your phone to another computer ?
>
> I would ask for a last test : on the first line of function pxa_udc_probe(),
> insert "return 0;". If kernel still stalls, the pxa27x-udc is not involved.
>

By inserting that "return 0;" the kernel goes on and I can complete
booting.

BTW, I added some dumb debug calls to see the driver functions sequence
on both a780 and a1200 and it turns out that on A1200 I don't have this
IRQ that makes the driver(?) crazy on a780, does this new info give any
new element to you to find out the root cause? The two phones have
slight different hardware tho.

Here are the two calling sequences:
http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/udc_a780.txt
http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/udc_a1200.txt

And the changes to obtain them:
http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/udc_fcall_printk.patch

Thanks a lot,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100722/00ed3d24/attachment.sig>
