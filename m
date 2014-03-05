From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Mar 2014 19:20:05 +0000
Subject: [PATCH] Revert "irqchip: irq-dove: Add PMU interrupt controller."
In-Reply-To: <alpine.DEB.2.02.1403051445020.18573@ionos.tec.linutronix.de>
References: <20140304030838.GA1872@titan.lakedaemon.net>
 <1393911160-7688-1-git-send-email-jason@lakedaemon.net>
 <20140305004139.GT21483@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1403051445020.18573@ionos.tec.linutronix.de>
Message-ID: <20140305192005.GX21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 03:42:34PM +0100, Thomas Gleixner wrote:
> On Wed, 5 Mar 2014, Russell King - ARM Linux wrote:
> > This results in the RTC alarm test receiving exactly one interrupt for
> > each alarm expiry, as it should do.  Thoughts?
> 
> You are worried about clearing an interrupt which is transitory and
> not kept active at the device level until you handled it for real,
> right?

Yep.  Let's take the code:

	ldr	r0, [r1]		; read the interrupt cause register
	and	r0, r0, r2		; clear interrupts we've serviced
	str	r0, [r1]		; write it back

The problem here is if a transitory interrupt is received between the
load and store, the write can clear it back to zero.  There's nothing
which can be done to get around that - which is why I'd prefer to do
this as infrequently as necessary.

> Is the datasheet for this stuff public available?

Thankfully, it is, but like many such things, it'll leave you with /lots/
of questions.  In the case of this register, the documentation only goes
as far as describing the bits, but doesn't really describe their behaviour.
Much of that can only come via experimentation with the hardware. :(

> I don't think it matters in which order you process multiple pending
> interrupts.

Me neither - I'm just going to use fls() for no other reason that it
produces more efficient code.  My comments on that were to see whether
I'd missed anything, and to stave off any review comments about why
it's changed :)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
