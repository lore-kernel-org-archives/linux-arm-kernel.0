From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 18:17:33 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <20101215170636.GJ28971@pengutronix.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151758.42896.arnd@arndb.de>
	<20101215170636.GJ28971@pengutronix.de>
Message-ID: <201012151817.33671.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Uwe Kleine-K?nig wrote:
> > Then we should define a proper function for this with well-defined
> > behaviour. I would suggest defining a mxs_readl/mxs_writel here,
> > that is defined to have the same endianess as the mxs SOC, but
> > otherwise has the same properties as readl/writel.
> I don't get your point here.  What are the properties of readl/writel
> you want here?  The barrier?  __mem_pci?

Being a documented interface.

> For me __mxs_setl is a proper function with well-defined behaviour, no?
> (One thing I currently consider to argue is to make these .c file local
> because different IPs might have different offsets for SET, CLR and TOG
> or not support it at all, but other than that I'm happy with it.)

The problem is that __raw_* is defined as a pointer reference on
all architectures, nothing more. Depending on the architecture and
compiler, sometimes even on the I/O subsystem, it may or may not
do any of the following:

* work on mapped PCI addresses
* work on mapped non-PCI addresses
* work on addresses returned from ioport_map
* be synchronized with spinlocks
* cause an atomic access on the bus
* trap on I/O device exceptions
* cause writes to be posted/nonposted

It's just not something that can possibly be used correctly
in portable code. I do realize that on mxs, it does pretty
much what you need, but that doesn't make it an officially
supported interface. Just like you are supposed to use spinlock
instead of raw_spinlock unless you know exactly why you need it
and document it.

	Arnd
