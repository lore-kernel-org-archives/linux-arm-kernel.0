From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Aug 2014 19:53:00 +0100
Subject: PL310 cache initialization/fixup for BCM63138
In-Reply-To: <53EBB141.7050206@gmail.com>
References: <53EBA9CF.4030902@gmail.com>
 <20140813182435.GM30401@n2100.arm.linux.org.uk> <53EBB141.7050206@gmail.com>
Message-ID: <20140813185259.GO30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 11:41:05AM -0700, Florian Fainelli wrote:
> On 08/13/2014 11:24 AM, Russell King - ARM Linux wrote:
> > The correct answer is to research how to specify cache attributes in DT,
> > and create an appropriate set of properties described by that, and have
> > the l2x0 OF init code parse those, and create the appropriate aux control
> > register values from those.
> > 
> > I forget exactly what they are, but I do know that there is a standardised
> > set of DT properties to describe the geometry of caches - I came across
> > them about six months back when I worked on the L2 code.
> 
> Alright, I will take a stab at using the ePAPR cache properties.
> 
> How about PL310 specific properties such as instruction prefetc and
> non-secure access, would boolean properties work for these?

We always enable non-secure access.  If we're running in secure mode,
enabling non-secure access will be accepted by the hardware, and as
we run in secure mode, has no effect.  If we're running in non-secure
mode, then we need to ask the firmware to enable non-secure access
to things like the unlock registers, and eventually the interrupt
registers anyway.

So it makes no sense for that to be a property.

For instruction prefetch, does it make sense for it to be in DT at
all - is there a reason not to enable it as a matter of course?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
