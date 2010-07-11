From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 11 Jul 2010 10:13:56 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
	<20100703221022.27df1a2e.ospite@studenti.unina.it>
	<87r5jkxh1y.fsf@free.fr>
	<20100705104043.c72d4a5b.ospite@studenti.unina.it>
Message-ID: <87zkxyv3jv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> The Oops does not occurr anymore but UDC does not work yet, with DEBUG
> disabled I see kernel stops here, no more messages _at_all_ after that:
> <6>[    7.196467] pxa27x_udc: version 2008-04-18
> <6>[    7.201653] pxa27x-udc pxa27x-udc: USB reset
>
> And on the host side I get:
> [ 6512.104045] usb 4-2: new full speed USB device using ohci_hcd and address 50
> [ 6512.512030] usb 4-2: device not accepting address 50, error -62
> [ 6512.512063] hub 4-0:1.0: unable to enumerate USB device on port 2
>
> If I enable debug back I can see some messages repeated over
> and over:
>
> <7>[   12.545381] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
> <7>[   12.554164] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
> <7>[   12.562987] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
> <7>[   12.571818] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8
> <7>[   12.580628] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
> <7>[   12.589416] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
> <7>[   12.598241] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
> <7>[   12.607076] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8
> <7>[   12.615890] pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: protocol STALL, udccsr0=0c1 err 1
> <7>[   12.624681] pxa27x-udc pxa27x-udc: ep0:set_ep0state: state=SETUP_STAGE->STALL, udccsr0=0x0c1, udcbcr=8
> <7>[   12.633513] pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=STALL, req=(null), udccsr0=0x0c1, udcbcr=8, irq_msk=1
> <7>[   12.642354] pxa27x-udc pxa27x-udc: ep0:set_ep0state:
> state=STALL->SETUP_STAGE, udccsr0=0x0c1, udcbcr=8

Well, the UDC is responding to each request from the USB host by stalling the
USB endpoint (and not by stalling the full kernel). This shows that at least
kernel interrupts are still alive and working.

> I noted that (either with or without this patch) a quite similar phone
> works, it's Motorola A1200 and has a different bootloader.
> Maybe comparing some registers can help here?

I'm still not fully convinced the pxa27x_udc is blocking the kernel. As the
interrupt is working properly, and the interrupt handler relies on a spinlock,
the spinlock is correcly released after each interrupt, and the driver should
work normally.
Now, the interrupt "storm" could block the kernel. That would rather be an host
issue. Did you try to connect your phone to another computer ?

I would ask for a last test : on the first line of function pxa_udc_probe(),
insert "return 0;". If kernel still stalls, the pxa27x-udc is not involved.

Cheers.

--
Robert
