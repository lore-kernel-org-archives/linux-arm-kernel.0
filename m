From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Jul 2014 09:44:40 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140730160607.GM8181@intel.com>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com>
Message-ID: <20140731074440.GY3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Wed, Jul 30, 2014 at 09:36:07PM +0530, Vinod Koul wrote:
> On Wed, Jul 30, 2014 at 06:03:13PM +0200, Maxime Ripard wrote:
> > The dmaengine is neither trivial nor properly documented at the moment, which
> > means a lot of trial and error development, which is not that good for such a
> > central piece of the system.
> > 
> > Attempt at making such a documentation.
> 
> Did you miss Documentation/dmaengine.txt, lots of this is already covered
> there. But yes i would be really glad to know what isnt, so that we can fix
> that.

I didn't miss it. But I feel like it describes quite nicely the slave
API, but doesn't help at all whenever you're writing a DMAengine driver.

The first lines of the existing document makes it quite clear too.

There's still a bit of duplication, but I don't feel it's such a big
deal.

What I'd like to do with the documentation I just sent is basically
have a clear idea whenever you step into dmaengine what you can/cannot
do, and have a reference document explaining what's expected by the
framework, and hopefully have unified drivers that follow this
pattern.

Because, for the moment, we're pretty much left in the dark with
different drivers doing the same thing in completetely different ways,
with basically no way to tell if it's either the framework that
requires such behaviour, or if the author was just feeling creative.

There's numerous examples for this at the moment:
  - The GFP flags, with different drivers using either GFP_ATOMIC,
    GFP_NOWAIT or GFP_KERNEL in the same functions
  - Having to set device_slave_caps or not?
  - Some drivers use dma_run_depedencies, some other don't
  - That might just be my experience, but judging from previous
    commits, DMA_PRIVATE is completely obscure, and we just set it
    because it was making it work, without knowing what it was
    supposed to do.
  - etc.

And basically, we have no way to tell at the moment which one is
right and which one needs fixing.

The corollary being that it cripples the whole community ability to
maintain the framework and make it evolve.

> > +  * device_slave_caps
> > +    - Isn't that redundant with the cap_mask already?
> > +    - Only a few drivers seem to implement it
> For audio to know what your channel can do rather than hardcoding it

Ah, yes, I see it now. It's not related to the caps mask at all.

Just out of curiosity, wouldn't it be better to move this to the
framework, and have these informations provided through the struct
dma_device? Or would it have some non-trivial side-effects?

> > +  * dma cookies?
> cookie is dma transaction representation which is monotonically incrementing
> number.

Ok, and it identifies a unique dma_async_tx_descriptor, right?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/8ef53175/attachment.sig>
