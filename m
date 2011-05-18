From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 23:47:15 +0100
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <1305740214.1526.2.camel@konomi>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110518152935.GJ5913@n2100.arm.linux.org.uk>
	<1305740214.1526.2.camel@konomi>
Message-ID: <20110518224715.GD21384@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 07:36:54PM +0200, Marek Vasut wrote:
> > On Wed, May 18, 2011 at 05:18:38PM +0200, Pavel Herrmann wrote:
> > > spi_sync call uses its spi_message parameter to keep completion
> > > information, having this structure static is not thread-safe,
> > > potentially causing one thread having pointers to memory on or above
> > > other threads stack. use per-call spi_message on stack to fix this
> > 
> > I assume this has not been tested with DMA debugging enabled.
> > 
> > The DMA API does not like mapping memory from the stack, which is what
> > you're potentially doing with this:
> 
> Yikes, good catch, but kmallocing this and kfreeing it again is not
> something I'd like to see either.

You could use a semaphore to protect against other threads.

However, this driver just gives us yet more problems, as it overlaps
the DMA'd data with the DMA metadata (spi message/spi transfer
structures.)  And yes we do get bug reports on that too...

I think its about time driver and subsystem authors got a clue about
DMA incoherent architectures, and these things called 'cache lines'
which have a direct impact on whether code is buggy or not.  Sharing
cache lines between DMA buffers and other data is Really Bad News for
data integrity - even sharing a cache line between two DMA buffers
can be a problem.
