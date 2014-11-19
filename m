From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 19 Nov 2014 15:49:21 +0000
Subject: [PATCH V4] arm64: percpu: Implement this_cpu operations
In-Reply-To: <20141117104010.GB18061@arm.com>
References: <20141114134644.GD27963@arm.com>
 <1415977413-17642-1-git-send-email-steve.capper@linaro.org>
 <20141117104010.GB18061@arm.com>
Message-ID: <20141119154920.GA25504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 10:40:11AM +0000, Will Deacon wrote:
> Hi Steve,

Hey Will,

[sorry for the late reply, was recovering from plague]

> 
> On Fri, Nov 14, 2014 at 03:03:33PM +0000, Steve Capper wrote:
> > The generic this_cpu operations disable interrupts to ensure that the
> > requested operation is protected from pre-emption. For arm64, this is
> > overkill and can hurt throughput and latency.
> > 
> > This patch provides arm64 specific implementations for the this_cpu
> > operations. Rather than disable interrupts, we use the exclusive
> > monitor or atomic operations as appropriate.
> > 
> > The following operations are implemented: add, add_return, and, or,
> > read, write, xchg. We also wire up a cmpxchg implementation from
> > cmpxchg.h.
> > 
> > Testing was performed using the percpu_test module and hackbench on a
> > Juno board running 3.18-rc4.
> 
> Looks good. I notice that this change drops the compiler barriers too,
> which we used to get via local_irq_{enable/disable}. I *think* that's fine
> (at least, I couldn't find a place that breaks due to that) but it would be
> nice to know that it was deliberate :)

Yes it was deliberate. :-)

My understanding of the this_cpu... set of accessors is that they are
there to solely protect the access with respect to pre-emption, not other
CPUs, thus we shouldn't need barriers?

> 
> > +static inline void __percpu_write(void *ptr, unsigned long val, int size)
> > +{
> > +	switch (size) {
> > +	case 1:
> > +		ACCESS_ONCE(*((u8 *)ptr)) = (u8) val;
> > +		break;
> > +	case 2:
> > +		ACCESS_ONCE(*((u16 *)ptr)) = (u16) val;
> > +		break;
> > +	case 4:
> > +		ACCESS_ONCE(*((u32 *)ptr)) = (u32) val;
> > +		break;
> > +	case 8:
> > +		ACCESS_ONCE(*((u64 *)ptr)) = (u64) val;
> > +		break;
> 
> I think you've gone a bit overboard with brackets and spacing here. Can't
> you just do something like:
> 
>   ACCESS_ONCE(*(u64 *)ptr) = (u64)val;

Yeah, I went a little paranthesis crazy there, I'll correct this lest
it gets confused with LISP.

> 
> Anyway:
> 
>   Reviewed-by: Will Deacon <will.deacon@arm.com>

Ta Will,
I'll send out a V5 with the parantheses sanetised.

Cheers,
-- 
Steve
