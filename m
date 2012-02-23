From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 14:14:19 +0000
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <201202231335.04923.arnd@arndb.de>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <201202231233.05622.arnd@arndb.de>
 <20120223125044.GW22562@n2100.arm.linux.org.uk>
 <201202231335.04923.arnd@arndb.de>
Message-ID: <20120223141419.GY22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 01:35:04PM +0000, Arnd Bergmann wrote:
> Since devices that can bei either PCI or not are relatively rare, I'd
> rather put them in the same category as those that can either use
> PCI I/O space or some form of memory space and require that the
> drivers use the "I don't care what you are, just do what I want"
> accessors in the ioread/iowrite family that are already going through
> an indirect function call on most architectures.

It's not a case of whether they themselves are PCI or not.  It's a case
that manufacturers are starting to take existing ARM IP and sticking a
PCI bridge in front of them.

That's why there's someone looking at a set of PCI drivers which create
AMBA primecell devices to allow the existing primecell drivers to bind
to these peripherals.

What that means is that in theory, you could have an AMBA primecell
peripheral behind a PCI device on an IXP4xx platform with its weird
windows, and that would necessitate the AMBA primecell drivers to use the
special PCI space accessors.

I would not be surprised if some of these PPC freescale peripheral IPs
using their private in_xxx() accessors end up in the same situation.
That seems to be the direction the hardware folk are going.

So, I think it's a big mistake to distinguish bus types by their
accessors.  Or put it another way, it's a big mistake to have bus
specific accessors.

Consider the AMBA primecell behind a PCI device, and if AMBA had its own
bus specific accessors.  Should we litter the drivers with ifdefs to
select between the PCI accessors or the AMBA accessors?  Or something
equally horrible?
