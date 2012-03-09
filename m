From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 09 Mar 2012 13:32:45 +1100
Subject: [PATCH 1/1] of: add dma-mask binding
In-Reply-To: <20120309005923.2E04F3E0901@localhost>
References: <1331119575-6638-1-git-send-email-plagnioj@jcrosoft.com>
 <4F5793E9.9010100@gmail.com> <20120307173437.GC17087@game.jcrosoft.org>
 <20120309005923.2E04F3E0901@localhost>
Message-ID: <1331260365.3105.46.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-08 at 17:59 -0700, Grant Likely wrote:

> > > This would need some documentation. There is already "dma-ranges"
> > > defined for OF which nay do what's needed.
> > what is dma-ranges I see no doc about it
> > but I don't think it could be used for the dma mask
> 
> As Rob says, it's documented in ePAPR.

dma-ranges is generally defined for bridges to indicate the dma window
to system memory, it's not been by actual devices so far. It provides
the opposite of "ranges", ie a translation from children to parent
address space.

So it's not quite the same thing.

Now the fact that we are limited to power-of-2 masks is a Linux
implementation detail. We might want to make the device-tree a bit more
flexible and use something like dma-limit instead. However hardware
limits tend to be in term of number of bits anyways so it's not a big
issue.

I don't see a need to keep a "ranges" type of semantic. If we ever do
that we can do a new binding for it or add a dma-base...

> We could merely add an empty dma_mask u64 to the containing struct
> platform_device and then assign the pointer to dev.dma_mask if it is
> needed.  That would eliminate the malloc.

Agreed.

>   Or we could by default
> use dev->dev.dma_mask = &dev->dev.coherent_dma_mask;  Drivers or
> notifier code could override whatever we setup here as the default.
> 
> dma-ranges really is the property that should be used for this, but
> dma-ranges can describe a different set of permutations than dma_mask.

I don't think so. As I said, dma-ranges is about a bridge/bus exposing
DMA windows & translations. It has nothing to do with the device
intrinsic DMA'ing capabilities.
 
Cheers,
Ben.
