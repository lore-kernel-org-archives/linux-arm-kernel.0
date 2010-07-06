From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 7 Jul 2010 00:56:36 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <87r5jgw86x.fsf@free.fr>
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
	<20100703221022.27df1a2e.ospite@studenti.unina.it>
	<87r5jkxh1y.fsf@free.fr>
	<20100705104043.c72d4a5b.ospite@studenti.unina.it>
	<87r5jgw86x.fsf@free.fr>
Message-ID: <20100707005636.c9ec7d6f.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Jul 2010 00:34:46 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
> 
> >> Now, would you test the patch attached in this mail to see if :
> >>  - it fixes your Oops
> >>  - the UDC is usable after you attach a gadget driver to pxa27x_udc
> >>
> >
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
> > <7>[   12.545381] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
> > <7>[   12.554164] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
> > <7>[   12.562987] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
> > <7>[   12.571818] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8
> > <7>[   12.580628] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
> > <7>[   12.589416] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
> > <7>[   12.598241] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
> > <7>[   12.607076] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8
> > <7>[   12.615890] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
> > <7>[   12.624681] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
> > <7>[   12.633513] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
> > <7>[   12.642354] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8
> That sequence prooves the patch works.
> The patch purpose is to stall the control endpoint as long as no gadget driver
> regitered itself and prevent the Oops.
>

but it looks like it is stalling the whole kernel, as I said before:
 The Oops does not occurr anymore but UDC does not work yet, with DEBUG
 disabled I see kernel stops here, no more messages _at_all_ after that:
 <6>[    7.196467] pxa27x_udc: version 2008-04-18
 <6>[    7.201653] pxa27x-udc pxa27x-udc: USB reset

> What should be happening is that you didn't inserted one of the modules :
>  - g_ether
>  - or g_zero
>  - or g_storage
> 
> Or, if you did, there is a sequence that somehow prevents the correct hook up
> between the pxa27_udc and g_ether for instance. If you want to be convinced, add
> a printk() at the beginning of usb_gadget_register_driver() in pxa27x_udc.c, and
> you shall see that it is never called in your case.
>

The weird thing is that the same kernel binary works on one machine
(A1200) and doesn't on the other (A780), so a linking problem is to
exclude.

I am talking about linking because right now I have both:
CONFIG_USB_GADGET_PXA27X=y
CONFIG_USB_ETH=y

I'll try building them as modules and using the loading order you
suggest below.

> That's pretty wierd, because as soon as g_ether is inserted, and because
> pxa27x_udc was inserted before, the gadget layer calls the register function of
> pxa27x_udc, which should link the gadget and the gadget driver.
>

I am sure I am missing something here, if pxa27x_udc stalls, and prevent
my kernel doing anything else at all, how can g_ether ever be loaded?

> > I noted that (either with or without this patch) a quite similar phone
> > works, it's Motorola A1200 and has a different bootloader.
> > Maybe comparing some registers can help here?
> Mmmm. I would rather bet on modules order if I had to. Or some wierd sequence.
> 
> Do you have the possibility, in your boot sequence, in one of the init scripts,
> to add :
> modprobe pxa27x_udc
> modprobe g_ether
>
> And see what comes out of it ?
>

I'll try that btw, to see if there's some difference.
 
> I'm afraid I'm a bit at a loss to investigate further, as I can't reproduce the
> test case myself ... All I can think of is modules ordering ATM.
>

I understand. You've been always very helpful btw, I am sure if you
happen to have some "enlightenment" you'll get back to this :)

Thanks again,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100707/9bdb462e/attachment-0001.sig>
