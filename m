From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 21 May 2011 08:11:04 +1000
Subject: [PATCH 8/9] dma IPU: rework irq handling
In-Reply-To: <alpine.LFD.2.02.1105201823050.3078@ionos>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-10-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1105201507250.3078@ionos>
	<20110520133022.GE10403@pengutronix.de>
	<alpine.LFD.2.02.1105201823050.3078@ionos>
Message-ID: <1305929464.7481.185.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > One for the framebuffer and another one for the camera...
> > 
> > BTW often enough it's the same for the gpio interrupts. I have plenty of
> > boards ending up with a single gpio interrupt out of 160 used for a
> > external network controller.
> 
> We could actually be more clever about that by doing:
> 
>    irq_prealloc_irqs(from, cnt, setup_callback);
> 
> Which would return you the base nr of a linear range and at
> request_irq() time we would detect the missing irq descriptor,
> allocate it and call the setup_callback, which would fill in chip,
> handler, data etc. That would make the few lines of init code for the
> descriptor non __init, but we could avoid allocating 159 irq
> descriptors for nothing.
> 
> The demux interrupt could still call generic_handle_irq() as we have a
> sanity in place there now and a return value to let the demux irq know
> that shite happened.

Well, if you use the remapper we use on power, then you can allocate
descriptors and interrupt numbers even on demand :-) But I see some
interest I suppose in keeping a linear range of irq numbers, makes
diagnosing easier for example...

Cheers,
Ben.
