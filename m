From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 2 Aug 2014 17:11:44 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140801145325.GR30282@n2100.arm.linux.org.uk>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <20140731132223.GK30282@n2100.arm.linux.org.uk>
 <20140731164152.GF3952@lukather>
 <20140801145325.GR30282@n2100.arm.linux.org.uk>
Message-ID: <20140802151144.GK3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 03:53:26PM +0100, Russell King - ARM Linux wrote:
> > > >   - That might just be my experience, but judging from previous
> > > >     commits, DMA_PRIVATE is completely obscure, and we just set it
> > > >     because it was making it work, without knowing what it was
> > > >     supposed to do.
> > > 
> > > DMA_PRIVATE means that the channel is unavailable for async-tx operations
> > > - in other words, it's slave-only.  Setting it before registration results
> > > in the private-use count being incremented, disabling the DMA_PRIVATE
> > > manipulation in the channel request/release APIs (requested channels are
> > > unavailable for async-tx operations, which is why that flag is also set
> > > there.)
> > > 
> > > To put it another way, if a DMA engine driver only provides slave DMA
> > > support, it must set DMA_PRIVATE to mark the channel unavailable for
> > > async-tx operations.  If a DMA engine drivers channels can also be used
> > > for async-tx operations, then it should leave the flag clear.
> > 
> > What about channels that can be both used for slave operations and
> > async-tx (like memcpy) ?
> 
> Then you don't set DMA_PRIVATE when the DMA engine driver registers with
> the core.  That then allows the DMA engine core to manage the flag,
> setting it when the channel is allocated for slave usage.

Then I guess we currently have a bug related to this.

During the development of the A31 driver that recently got merged,
during two subsequent channel allocation, the second would fail if
DMA_PRIVATE wasn't set.

I think it was on in dmaengine_get, but I'll have to get back to you
on that whenever I'm back from my holydays.

> One important point here is that async_tx does not have the idea of
> channel allocation - a channel which is registered into the DMA engine
> core without DMA_PRIVATE set is a candidate for use by the async_tx
> API.
> 
> > Hence why we should document as much as possible then, to spread the
> > knowledge and avoid it being lost when someone disappears or isn't
> > available anymore.
> > 
> > (And hopefully reduce the number of "errors" that might be done by
> > submitters, hence reducing the number of review iterations, lessening
> > the maintainers load)
> 
> The bigger issue in the longer run is being able to maintain and improve
> the DMA engine implementations and API.  One of the blockers to that is
> properly understanding all the async_tx API stuff, something which even
> I have been unable to do despite knowing a fair amount about DMA engine
> itself.
> 
> Where I fall down is the exact meaning of the ACK stuff, how the chaining
> is supposed to work, how the dependency between two DMA channels are
> handled.
> 
> This is why I was unable to resolve DMA engine's multiple mapping of the
> same DMA buffers, which has caused problems for ARM.
> 
> I've discussed this point in the past with Dan, making the point that
> each DMA engine driver should not be that concerned about things like
> descriptor list management, cookies, dependent transfers, but we seem
> to be ultimately doomed to re-implementing much of that infrastructure
> in every single DMA engine driver that comes along.

You can also add vchan scheduling or descriptor allocations. The atmel
guys seem to have hit a performance issue with dma_pool_alloc, so they
re-developped a descriptor allocation mechanism in their driver. I
don't have much more details on this, but if that was to be true, that
would definitely be something that should be in the framework.

vchan mapping to physical channels also seem to be quite common in the
drivers. That would be a nice addition too.

> Each DMA engine driver which gets accepted into mainline makes this
> problem worse - it's another driver which does something slightly
> differently that if we were to ever clean this stuff up, would need
> to be fixed.  This remains my biggest concern with the DMA engine
> code today, and I'm one of the few people who have put effort into
> trying to sort that out.

Yep. It's one of mine too, I'm willing to help if possible.

> > > Drivers should have no reason what so ever to be touching the cookie
> > > directly anymore.
> > 
> > Ok, thanks a lot for this!
> 
> I notice that drivers/dma/sirf-dma.c directly touches it and the
> completed cookie as well:
> 
> drivers/dma/sirf-dma.c: dma_cookie_t last_cookie = 0;
> drivers/dma/sirf-dma.c:                         last_cookie = desc->cookie;
> drivers/dma/sirf-dma.c:                 schan->chan.completed_cookie = last_cookie;
> 
> That's something which should be fixed.  I haven't looked too hard
> because it's not something I want to get involved with again right
> now.

By quickly looking at the code, it looks like dead code. I guess it
could just be removed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140802/60d2d676/attachment-0001.sig>
