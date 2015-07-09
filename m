From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Jul 2015 11:12:44 +0100
Subject: [PATCH 01/13] arm/arm64: Add new is_kernel_in_hyp_mode predicate
In-Reply-To: <559E476E.2000306@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-2-git-send-email-marc.zyngier@arm.com>
 <20150709094230.GA20105@leverpostej> <559E476E.2000306@arm.com>
Message-ID: <20150709101244.GC20105@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 11:05:34AM +0100, Marc Zyngier wrote:
> On 09/07/15 10:42, Mark Rutland wrote:
> > Hi,
> > 
> >> +static inline bool is_kernel_in_hyp_mode(void)
> >> +{
> >> +	u64 el;
> >> +
> >> +	asm("mrs %0, CurrentEL" : "=r" (el));
> >> +	return el == CurrentEL_EL2;
> >> +}
> > 
> > If you can include cputype.h, I think this can be:
> > 
> > static inline bool is_kernel_in_hyp_mode(void)
> > {
> > 	return read_cpuid(CurrentEL) == CurrentEL_EL2;
> > }
> 
> This would indeed work, but CurrentEL is hardly an ID register. I feel
> slightly uncomfortable using read_cpuid (which might return a cached
> version at some point) for random system registers.
> 
> Thoughts?

I have no strong feelings either way, but I agree with the general
uneasiness w.r.t. what read_cpuid can be expected to do.

Elsewhere we just use inline asm to read non CPUID system registers, so
let's leave your patch as it was.

Thanks,
Mark.
