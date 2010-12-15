From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 15 Dec 2010 19:49:51 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <201012151817.33671.arnd@arndb.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151758.42896.arnd@arndb.de>
	<20101215170636.GJ28971@pengutronix.de>
	<201012151817.33671.arnd@arndb.de>
Message-ID: <20101215184951.GA1940@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Wed, Dec 15, 2010 at 06:17:33PM +0100, Arnd Bergmann wrote:
> On Wednesday 15 December 2010, Uwe Kleine-K?nig wrote:
> > > Then we should define a proper function for this with well-defined
> > > behaviour. I would suggest defining a mxs_readl/mxs_writel here,
> > > that is defined to have the same endianess as the mxs SOC, but
> > > otherwise has the same properties as readl/writel.
> > I don't get your point here.  What are the properties of readl/writel
> > you want here?  The barrier?  __mem_pci?
> 
> Being a documented interface.
> 
> > For me __mxs_setl is a proper function with well-defined behaviour, no?
> > (One thing I currently consider to argue is to make these .c file local
> > because different IPs might have different offsets for SET, CLR and TOG
> > or not support it at all, but other than that I'm happy with it.)
> 
> The problem is that __raw_* is defined as a pointer reference on
> all architectures, nothing more. Depending on the architecture and
> compiler, sometimes even on the I/O subsystem, it may or may not
> do any of the following:
> 
> * work on mapped PCI addresses
> * work on mapped non-PCI addresses
> * work on addresses returned from ioport_map
> * be synchronized with spinlocks
> * cause an atomic access on the bus
> * trap on I/O device exceptions
> * cause writes to be posted/nonposted
> 
> It's just not something that can possibly be used correctly
> in portable code.
Code that is defined in arch/arm/mach-mxs doesn't necessarily need to
run on (say) x86.  And if I configure an gpio IP on an embedded machine
I know this is not PCI.  And to throw in some statistics:

	ukl at octopus:~/gsrc/linux-2.6$ git grep -E '\<(read|write)l\>' arch/arm/mach-* | wc -l
	947
	ukl at octopus:~/gsrc/linux-2.6$ git grep -E '\<__raw_(read|write)l\>' arch/arm/mach-* | wc -l
	2276

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
