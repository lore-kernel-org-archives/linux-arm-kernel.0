From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Aug 2014 16:29:21 +0100
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140802151144.GK3952@lukather>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <20140731132223.GK30282@n2100.arm.linux.org.uk>
 <20140731164152.GF3952@lukather>
 <20140801145325.GR30282@n2100.arm.linux.org.uk>
 <20140802151144.GK3952@lukather>
Message-ID: <20140802152921.GC30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 05:11:44PM +0200, Maxime Ripard wrote:
> On Fri, Aug 01, 2014 at 03:53:26PM +0100, Russell King - ARM Linux wrote:
> > > > >   - That might just be my experience, but judging from previous
> > > > >     commits, DMA_PRIVATE is completely obscure, and we just set it
> > > > >     because it was making it work, without knowing what it was
> > > > >     supposed to do.
> > > > 
> > > > DMA_PRIVATE means that the channel is unavailable for async-tx operations
> > > > - in other words, it's slave-only.  Setting it before registration results
> > > > in the private-use count being incremented, disabling the DMA_PRIVATE
> > > > manipulation in the channel request/release APIs (requested channels are
> > > > unavailable for async-tx operations, which is why that flag is also set
> > > > there.)
> > > > 
> > > > To put it another way, if a DMA engine driver only provides slave DMA
> > > > support, it must set DMA_PRIVATE to mark the channel unavailable for
> > > > async-tx operations.  If a DMA engine drivers channels can also be used
> > > > for async-tx operations, then it should leave the flag clear.
> > > 
> > > What about channels that can be both used for slave operations and
> > > async-tx (like memcpy) ?
> > 
> > Then you don't set DMA_PRIVATE when the DMA engine driver registers with
> > the core.  That then allows the DMA engine core to manage the flag,
> > setting it when the channel is allocated for slave usage.
> 
> Then I guess we currently have a bug related to this.
> 
> During the development of the A31 driver that recently got merged,
> during two subsequent channel allocation, the second would fail if
> DMA_PRIVATE wasn't set.
> 
> I think it was on in dmaengine_get, but I'll have to get back to you
> on that whenever I'm back from my holydays.

I think you mean dma_chan_get().  dmaengine_get() is used to obtain
references to the async_tx memcpy/crypto channels, and should not be used
by a driver making use of the slave capabilities.

There two systems are slightly competitive between each other.  Slave
stuff generally want to get hold of specific channels, whereas the
async_tx stuff can generally do with any channel which provides the
appropriate capabilities, and can switch between channels if it needs
to perform a series of operations only supported by separate channels.

> You can also add vchan scheduling or descriptor allocations. The atmel
> guys seem to have hit a performance issue with dma_pool_alloc, so they
> re-developped a descriptor allocation mechanism in their driver. I
> don't have much more details on this, but if that was to be true, that
> would definitely be something that should be in the framework.

It is entirely legal for a dmaengine driver to maintain its own list of
"free" transaction descriptors (that's actually what many async-tx
drivers do) and is partly why there's the alloc_chan_resources and
free_chan_resources callbacks.

However, they tend to be fairly large structures, and don't always
match what the hardware wants, so using them to describe the individual
scatterlist elements of a transaction is not always a good idea.

> vchan mapping to physical channels also seem to be quite common in the
> drivers. That would be a nice addition too.

It's intentionally not in the vchan interface because that mapping is
device specific.

For example, there are some DMA engine implementations where certain
physical DMA channels should not be used because they have slightly
different properties (for example, they can lock the CPU off the bus
if they're permanently transferring data, such as in a memcpy or
device-to-memory transfer where the device always has data available.)

In any case, I'm not interested in seeing vchan turning into another
"layer" - it must remain a library.  Layers are bad news. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
