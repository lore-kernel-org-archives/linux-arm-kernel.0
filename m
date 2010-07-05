From: ospite@studenti.unina.it (Antonio Ospite)
Date: Mon, 5 Jul 2010 10:40:43 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <87r5jkxh1y.fsf@free.fr>
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
	<20100703221022.27df1a2e.ospite@studenti.unina.it>
	<87r5jkxh1y.fsf@free.fr>
Message-ID: <20100705104043.c72d4a5b.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 04 Jul 2010 01:48:57 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
> 
> > Done that as well this time. See
> > http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/
> > I replaced the old files with the new ones as per your instructions.
> 
> Nice.
> 
> Now, would you test the patch attached in this mail to see if :
>  - it fixes your Oops
>  - the UDC is usable after you attach a gadget driver to pxa27x_udc
>

The Oops does not occurr anymore but UDC does not work yet, with DEBUG
disabled I see kernel stops here, no more messages _at_all_ after that:
<6>[    7.196467] pxa27x_udc: version 2008-04-18
<6>[    7.201653] pxa27x-udc pxa27x-udc: USB reset

And on the host side I get:
[ 6512.104045] usb 4-2: new full speed USB device using ohci_hcd and address 50
[ 6512.512030] usb 4-2: device not accepting address 50, error -62
[ 6512.512063] hub 4-0:1.0: unable to enumerate USB device on port 2

If I enable debug back I can see some messages repeated over
and over:

<7>[   12.545381] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
<7>[   12.554164] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
<7>[   12.562987] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
<7>[   12.571818] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8
<7>[   12.580628] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
<7>[   12.589416] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
<7>[   12.598241] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
<7>[   12.607076] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8
<7>[   12.615890] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
<7>[   12.624681] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
<7>[   12.633513] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
<7>[   12.642354] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8

I noted that (either with or without this patch) a quite similar phone
works, it's Motorola A1200 and has a different bootloader.
Maybe comparing some registers can help here?

Regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100705/d8f776b2/attachment.sig>
