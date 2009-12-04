From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Fri, 04 Dec 2009 13:08:15 +0000
Subject: Query about pxa27x_udc.c
Message-ID: <4B1909BF.9050704@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just had the following pop up in a compile of linux-next


drivers/usb/gadget/pxa27x_udc.c: In function 'pxa_udc_irq':
drivers/usb/gadget/pxa27x_udc.c:2232: warning: array subscript is above array bounds
drivers/usb/gadget/pxa27x_udc.c:2232: warning: array subscript is above array bounds
drivers/usb/gadget/pxa27x_udc.c:2233: warning: array subscript is above array bounds

I'm not sure what the lines in question are actually doing (and at least
at first glance they can never access anything in the array).


	for (i = 16; udcisr1 != 0 && i < 24; udcisr1 >>= 2, i++) {
		udc_writel(udc, UDCISR1, UDCISR_INT(i - 16, UDCISR_INT_MASK));
		if (!(udcisr1 & UDCISR_INT_MASK))
			continue;

		ep = &udc->pxa_ep[i];
		ep->stats.irqs++;
		handle_ep(ep);
	}

Where the warning is about the call to &udc->pxa_ep[i]

Seeing as that appears to only ever contain 15 elements this doesn't look good.
I haven't waded through everything that happens to this structure so I guess it might
be doing something less than obvious.

Jonathan
