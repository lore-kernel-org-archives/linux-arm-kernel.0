From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Apr 2017 12:31:24 +0100
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <1491952371.7236.22.camel@kernel.crashing.org>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
Message-ID: <20170412113124.GZ17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 09:12:51AM +1000, Benjamin Herrenschmidt wrote:
> This is a problem to be solved by the bridge itself. If ARM has a
> mapping attribute to make stores non-posted, keep this an ARM specific
> attribute at this stage I'd say.

So what you seem to be saying is to place drivers not in drivers/pci/host
but in arch/arm, and a duplicate copy in arch/arm64.

No.  We're way past that by popular concensus.  We're not going back to
doing what we did in the 2000s.  Drivers go in the drivers subtree,
period.  That means we require architecture interfaces that provide
access to architecture specific details that may not be suitable for
all architectures to support.

In the case of something brand new, then I agree with you that the
default implementation should fail if it's not supportable on all
architectures.  However, when we have existing drivers using an
interface that doesn't provide the semantics they already require,
then it makes no sense to effectively break these drivers on a range
of existing architectures.

The question really is - what's the best way to solve the problem with
existing drivers without breaking them.  I suspect that, sadly, the
only realistic way forward here is via the litter-drivers-with-ifdefs
approach since you don't like providing a default implementation that
is compatible with what these drivers are already doing.

Drivers, such as:

drivers/pci/host/pci-mvebu.c
drivers/pci/host/pci-versatile.c
drivers/pci/host/pci-xgene.c

to name a few.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
