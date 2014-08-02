From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 2 Aug 2014 16:49:25 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140801171306.GF8181@intel.com>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <20140731115628.GQ8181@intel.com> <20140731162330.GE3952@lukather>
 <20140801171306.GF8181@intel.com>
Message-ID: <20140802144925.GJ3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 10:43:06PM +0530, Vinod Koul wrote:
> On Thu, Jul 31, 2014 at 06:23:30PM +0200, Maxime Ripard wrote:
> > On Thu, Jul 31, 2014 at 05:26:28PM +0530, Vinod Koul wrote:
> > 
> > Also, feel free to add anything that you feel like you keep saying
> > during the review. If mistakes keep coming, it's probably worth
> > documenting what you expect.
> I think the common issues seen would be:
> - prpeare calls in atomic context and usuage of GFP_NOWAIT for memory
>   allocations

I think we have that part covered already.

> - residue callculation, though situation is much better now but still lots
>   of driver do it worng and folks do get it wrong

What mistake in often made regarding the residue calculation?

> > > > Because, for the moment, we're pretty much left in the dark with
> > > > different drivers doing the same thing in completetely different ways,
> > > > with basically no way to tell if it's either the framework that
> > > > requires such behaviour, or if the author was just feeling creative.
> > > > 
> > > > There's numerous examples for this at the moment:
> > > >   - The GFP flags, with different drivers using either GFP_ATOMIC,
> > > >     GFP_NOWAIT or GFP_KERNEL in the same functions
> > > >   - Having to set device_slave_caps or not?
> > > >   - Some drivers use dma_run_depedencies, some other don't
> > > >   - That might just be my experience, but judging from previous
> > > >     commits, DMA_PRIVATE is completely obscure, and we just set it
> > > >     because it was making it work, without knowing what it was
> > > >     supposed to do.
> > > >   - etc.
> > > 
> > > Thanks for highlighting we should definitely add these in Documentation
> > 
> > It's quite clear in the case of the GFP flags now, Lars-Peter and you
> > cleared up device_slave_caps, but I still could use some help with
> > DMA_PRIVATE.
> > 
> > > > And basically, we have no way to tell at the moment which one is
> > > > right and which one needs fixing.
> > > > 
> > > > The corollary being that it cripples the whole community ability to
> > > > maintain the framework and make it evolve.
> > > > 
> > > > > > +  * device_slave_caps
> > > > > > +    - Isn't that redundant with the cap_mask already?
> > > > > > +    - Only a few drivers seem to implement it
> > > > > For audio to know what your channel can do rather than hardcoding it
> > > > 
> > > > Ah, yes, I see it now. It's not related to the caps mask at all.
> > > > 
> > > > Just out of curiosity, wouldn't it be better to move this to the
> > > > framework, and have these informations provided through the struct
> > > > dma_device? Or would it have some non-trivial side-effects?
> > > Well the problem is ability to have this queried uniformly from all drivers
> > > across subsystems. If we can do this that would be nice.
> > 
> > I can work on some premelinary work to do just that, and see if it
> > works for you then.
> Sure sounds excellent to me

Another extra questions arose during starting this.

In the case of the call to device_control, especially in the
DMA_SLAVE_CONFIG case, but that also applies to pause/resume, are the
changes supposed to be immediates or can they happen later?

I actually have in mind the case where we would use a vchan, that
might or might not be actually mapped to a physical channel at the
moment where the DMA_SLAVE_CONFIG call is made. In the case where it's
not mapped and not transfering anything, it's pretty trivial, to
handle, but in the case where it's actually mapped to a physical
channel, should we push the new configuration to the physical channel
right away, or can it wait until the transfer ends ?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140802/9af6e753/attachment.sig>
