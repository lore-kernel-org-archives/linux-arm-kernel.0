From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Aug 2013 17:28:48 +0100
Subject: [PATCH v2 1/3] ARM: Introduce atomic MMIO clear/set
In-Reply-To: <20130821142203.GA2459@localhost>
References: <1377017307-23201-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377017307-23201-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130821122424.GB1653@mudshark.cambridge.arm.com>
 <20130821142203.GA2459@localhost>
Message-ID: <20130821162848.GF1653@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 03:22:04PM +0100, Ezequiel Garcia wrote:
> On Wed, Aug 21, 2013 at 01:24:24PM +0100, Will Deacon wrote:
> > On Tue, Aug 20, 2013 at 05:48:25PM +0100, Ezequiel Garcia wrote:
> > > diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> > > index dcd5b4d..b2a53a3 100644
> > > --- a/arch/arm/kernel/io.c
> > > +++ b/arch/arm/kernel/io.c
> > > @@ -1,6 +1,19 @@
> > >  #include <linux/export.h>
> > >  #include <linux/types.h>
> > >  #include <linux/io.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +static DEFINE_SPINLOCK(__io_lock);
> > > +
> > > +void atomic_io_clear_set(u32 clear, u32 set, void __iomem *reg)
> > 
> > First off, what exactly is this function supposed to guarantee? Do you simply
> > require thread-safe device access, or do you also require completion of the
> > the device writes?
> > 
> 
> Indeed, thread-safe device access would be enough, unless I'm missing
> something.

Great!

> > > +	spin_lock(&__io_lock);
> > 
> > Is this function likely to be used in irq context? If so, better disable
> > IRQs here.
> > 
> 
> No, I don't think this API is aimed particularly at irq-context.
> 
> That said, it's a generic API that can be used anywhere, yet users are expected
> to be aware of the performance impact (or at least I hope that).
> 
> And speaking about performance, I appreciate any performance tunings,
> but I guess we can all agree this API is not meant for hot-paths.

Well, device accesses in interrupt handlers are very common, so if you need
to co-exist with other users of the device, you could decide to use this
API. I think it's a good idea to use the _irqsave variant here.

> > > +	/* ensure the write get done before unlocking */
> > > +	__iowmb();
> > 
> > And then, despite my previous suggestion, you can drop this line too.
> > 
> 
> Ok... I'm not sure I understand why using relaxed variants allows us to drop this.
> 
> Maybe you can (try) to enlighten me?

Sure. Firstly, an __iowmb() is only required for ensuring *endpoint* ordering
between normal, cacheable memory and device memory. i.e. you write a normal
cacheable buffer, then you poke a device to go and read it. That is why
there is this barrier in writel, before the actual device write: it ensures
that the buffer is visible to the device before it sees the control write.

My original, rushed reading of your patch lead me to think that this was all
about endpoint ordering and you were trying to guarantee some sort of
immediacy of the device write by using a spinlock, but now I see that's not
the case. Given that the device is never going to go and read the spinlock
value, you can drop the __iowmb() regardless.

> > Now, the only downside with this approach is that you need explicit barriers
> > in the driver if you want to enforce ordering with respect to normal,
> > cacheable buffers to be consumed/populated by the device.
> > 
> > What do you think? An alternative would be just to relax the readl and rely
> > on the dsb preceeding the writel, then add atomic_io_clear_set_relaxed
> > to implement what I described above, but it depends on how you envisage
> > this helper being used.
> > 
> 
> Mmm.. it's not easy to foresee, for we have only a scarce bunch of planned
> usage for the API. I guess any simple shared-register access would want
> to use this, typically just to enable/disable something in some 'control'
> register.

Right, but if that control register causes the device to go off and read a
normal, cacheable buffer then the driver would need explicit barriers if we
exclusively use relaxed accessors here. The more I think about it, the more
I like the idea of having two versions:

atomic_io_clear_set
	spin_lock
	writel(readl_relaxed(...)
	spin_unlock

atomic_io_clear_set_relaxed
	spin_lock
	writel_relaxed(readl_relaxed(...))
	spin_unlock

That way, the two versions match the semantics of the simpler I/O accessors
from which they are built and drivers can use the relaxed variant as an
optimisation.

Hope that helps, and sorry for the confusion.

Will
