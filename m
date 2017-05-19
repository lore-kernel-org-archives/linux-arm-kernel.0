From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 15:02:40 +0100
Subject: [RFC PATCH] arm64: neon: Remove support for nested or hardirq
 kernel-mode NEON
In-Reply-To: <20170519133424.GC22800@leverpostej>
References: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
 <20170519124952.GB22800@leverpostej>
 <20170519131321.GD3559@e103592.cambridge.arm.com>
 <20170519133424.GC22800@leverpostej>
Message-ID: <20170519140239.GF3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 02:34:25PM +0100, Mark Rutland wrote:
> On Fri, May 19, 2017 at 02:13:21PM +0100, Dave Martin wrote:
> > On Fri, May 19, 2017 at 01:49:53PM +0100, Mark Rutland wrote:
> > > Hi,
> > > 
> > > On Fri, May 19, 2017 at 12:26:39PM +0100, Dave Martin wrote:
> > > > +static bool __maybe_unused kernel_neon_allowed(void)
> > > > +{
> > > > +	/*
> > > > +	 * The per_cpu_ptr() is racy if called with preemption enabled.
> > > > +	 * This is not a bug:  per_cpu(kernel_neon_busy) is only set
> > > > +	 * when preemption is disabled, so we cannot migrate to another
> > > > +	 * CPU while it is set, nor can we migrate to a CPU where it is set.
> > > > +	 * So, if we find it clear on some CPU then we're guaranteed to find it
> > > > +	 * clear on any CPU we could migrate to.
> > > > +	 *
> > > > +	 * If we are in between kernel_neon_begin()...kernel_neon_end(), the
> > > > +	 * flag will be set, but preemption is also disabled, so we can't
> > > > +	 * migrate to another CPU and spuriously see it become false.
> > > > +	 */
> > > > +	return !(in_irq() || in_nmi()) &&
> > > > +		!local_read(this_cpu_ptr(&kernel_neon_busy));
> > > > +}
> > > 
> > > I think it would be better to use the this_cpu ops for this, rather than
> > > manually messing with the pointer.
> > 
> > I had thought that the properties of local_t were important here, but
> > this_cpu ops seem equally appropriate.
> > 
> > > Here, we can use raw_cpu_read(kernel_neon_busy), given the comment
> > > above.
> > 
> > What's the difference?  The raw_ variants aren't documented.  Do these
> > not bother about atomicity between the address calculation and the read?
> 
> Yup.
> 
> Comparing raw_cpu_{x}, __this_cpu_{x}, and this_cpu_{x}:
> 
> * raw_cpu_{x} don't have any preemption checks, and don't disable
>   preemption internally. Due to this, the address gen and operation can
>   occur on different CPUs.

Ah, I see.  This is not fantastically intuitive...

> * __this_cpu_{x} have lockdep annotations to check that preemption is
>   disabled, but otherwise behave the same as raw_cpu_{x}. i.e. they
>   don't try to disable preemption internally.
> 
> * this_cpu_{x} ensure that preemption is disabled around the address gen
>   and operation.
> 
> Since preemption may be possible, but we believe this is fine, we have
> to use the raw form. We'll want to keep the commment explaining why.

Absolutely.  Those seem natural fits then.

Cheers
---Dave
