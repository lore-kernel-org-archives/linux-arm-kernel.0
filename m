From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 17 Jun 2010 09:33:51 +1000
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <20100616211645.GC30005@fluff.org.uk>
References: <19473.61547.684572.647641@ipc1.ka-ro>
	<201006111718.47426.jeremy.kerr@canonical.com>
	<19474.172.742782.972629@ipc1.ka-ro>
	<20100611095839.GC10894@pengutronix.de>
	<19474.2817.333749.485028@ipc1.ka-ro>
	<1276319643.1962.181.camel@pasglop>
	<19477.52889.982995.407051@ipc1.ka-ro>
	<1276507378.2552.39.camel@pasglop>
	<19477.63136.664249.167207@ipc1.ka-ro>
	<20100614094310.GE12159@pengutronix.de>
	<20100616211645.GC30005@fluff.org.uk>
Message-ID: <1276731231.2552.645.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-16 at 22:16 +0100, Ben Dooks wrote:
> > I think you can find different examples that make both possiblities
> bad.
> > All in all I think that a sleeping clock implementation is
> preferable as
> > it improves (general) latencies.
> 
> It may be that we need to do a bit of work on some of the drivers to
> ensure that they don't fully re-set their clocks until they are able
> to sleep. 

With the move of the interrupt disable we did upstream not long ago,
most drivers now can sleep at any stage of resume. sysdev's can't so
those are the main issue, but then, I don't like sysdevs :-)

I must say that on powermac I avoid some of these problems by, in
addition to the normal suspend/resume process, having some platform code
that (almost) blindly saves & restores a bunch of ASIC regs on late
suspend/early resume. It ends up being faster and simpler than going
through convolutions of suspend/resume callbacks left and right that
need to happen in the right order.

Cheers,
Ben.
