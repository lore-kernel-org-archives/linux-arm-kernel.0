From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jul 2014 14:22:23 +0100
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140731074440.GY3952@lukather>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
Message-ID: <20140731132223.GK30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 09:44:40AM +0200, Maxime Ripard wrote:
> I didn't miss it. But I feel like it describes quite nicely the slave
> API, but doesn't help at all whenever you're writing a DMAengine driver.

There's actually two documents:

Documentation/crypto/async-tx-api.txt
Documentation/dmaengine.txt

The first is the original DMA engine API for use with offloading things
like memcpy, as well as the crypto API to hardware crypto DMA engines.

The second is documentation for the DMA slave API which modifies some
of the requirements of the first (like, the ability to call the slave
DMA prepare functions from within the callback, which are not permitted
in the async tx API.)

Both documents are relevant for writing a DMA engine driver.

> Because, for the moment, we're pretty much left in the dark with
> different drivers doing the same thing in completetely different ways,
> with basically no way to tell if it's either the framework that
> requires such behaviour, or if the author was just feeling creative.

DMA engine has lacked a lot of infrastructure for common patterns in
drivers; some of that is solved by my efforts with the virt_dma.c
support, and also various cleanups to existing drivers, but it's not
easy to fix this problem after drivers have been merged.

> There's numerous examples for this at the moment:
>   - The GFP flags, with different drivers using either GFP_ATOMIC,
>     GFP_NOWAIT or GFP_KERNEL in the same functions

The slave prepare APIs should be using GFP_ATOMIC to ensure safety.

>   - Having to set device_slave_caps or not?

device_slave_caps is a relatively new invention, so old drivers don't
implement it.  Newer drivers should, and there probably should be some
motivation for older drivers to add it.

>   - Some drivers use dma_run_depedencies, some other don't

Dependent operations are part of the async-tx API, and aren't really
applicable to the slave DMA API.  A driver implementing just the slave
DMA API need not concern itself with dependent operations, but a
driver implementing the async-tx APIs should do.

>   - That might just be my experience, but judging from previous
>     commits, DMA_PRIVATE is completely obscure, and we just set it
>     because it was making it work, without knowing what it was
>     supposed to do.

DMA_PRIVATE means that the channel is unavailable for async-tx operations
- in other words, it's slave-only.  Setting it before registration results
in the private-use count being incremented, disabling the DMA_PRIVATE
manipulation in the channel request/release APIs (requested channels are
unavailable for async-tx operations, which is why that flag is also set
there.)

To put it another way, if a DMA engine driver only provides slave DMA
support, it must set DMA_PRIVATE to mark the channel unavailable for
async-tx operations.  If a DMA engine drivers channels can also be used
for async-tx operations, then it should leave the flag clear.

> And basically, we have no way to tell at the moment which one is
> right and which one needs fixing.
> 
> The corollary being that it cripples the whole community ability to
> maintain the framework and make it evolve.

All respect to Vinod (who looks after the slave side of the DMA engine
implementations) and Dan, what it needs is someone who knows the *whole*
DMA engine picture to be in control of the subsystem, and who knows these
details - not must one bit of it.  Someone who has the time to put into
reviewing changes to it, and probably more importantly, has the time to
clean up the existing code.  Finding someone who fits that is a struggle.

Dan knows the whole picture (or used to when he was working on it at one
of his former employers) but I don't think Dan had the available time to
address various issues with it.

> > cookie is dma transaction representation which is monotonically incrementing
> > number.
> 
> Ok, and it identifies a unique dma_async_tx_descriptor, right?

You really should not be concerned with DMA cookies anymore since one
of my cleanups - I added a number of helper functions which hide the
manipulation of DMA cookies, and take away from driver writers the
semantics of how cookies themselves are operated upon.  virt-dma goes
a little further and provides descriptor lists and methods to look up
a descriptor given a cookie.

The only thing that a driver writer should concern themselves with is
making the appropriate cookie management calls at the relevant point in
the code - in other words, allocating a cookie at in the submit callback,
completing a cookie when a descriptor is complete, etc.

Drivers should have no reason what so ever to be touching the cookie
directly anymore.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
