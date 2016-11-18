From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Nov 2016 19:05:31 +0000
Subject: [PATCHv3 6/6] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <16e4b3da-c552-252d-108a-0681b71b12ef@redhat.com>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
 <1479431816-5028-7-git-send-email-labbott@redhat.com>
 <20161118175327.GE1197@leverpostej>
 <16e4b3da-c552-252d-108a-0681b71b12ef@redhat.com>
Message-ID: <20161118190531.GJ1197@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 10:42:56AM -0800, Laura Abbott wrote:
> On 11/18/2016 09:53 AM, Mark Rutland wrote:
> > On Thu, Nov 17, 2016 at 05:16:56PM -0800, Laura Abbott wrote:

> >> +#define __virt_to_phys_nodebug(x) ({					\
> >>  	phys_addr_t __x = (phys_addr_t)(x);				\
> >> -	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
> >> -				 (__x - kimage_voffset); })
> >> +	((__x & ~PAGE_OFFSET) + PHYS_OFFSET);				\
> >> +})
> > 
> > Given the KASAN failure, and the strong possibility that there's even
> > more stuff lurking in common code, I think we should retain the logic to
> > handle kernel image addresses for the timebeing (as x86 does). Once
> > we've merged DEBUG_VIRTUAL, it will be easier to track those down.
> 
> Agreed. I might see about adding another option DEBUG_STRICT_VIRTUAL
> for catching bad __pa vs __pa_symbol usage and keep DEBUG_VIRTUAL for
> catching addresses that will work in neither case.

I think it makes sense for DEBUG_VIRTUAL to do both, so long as the
default behaviour (and fallback after a WARN for virt_to_phys()) matches
what we currently do. We'll get useful diagnostics, but a graceful
fallback.

I think the helpers I suggested below do that?  Or have I misunderstood,
and you mean something stricter (e.g. checking whether a lm address is
is backed by something)?

> > phys_addr_t __virt_to_phys(unsigned long x)
> > {
> > 	WARN(!__is_lm_address(x),
> > 	     "virt_to_phys() used for non-linear address: %pK\n",
> > 	     (void*)x);
> > 	
> > 	return __virt_to_phys_nodebug(x);
> > }
> > EXPORT_SYMBOL(__virt_to_phys);

> > phys_addr_t __phys_addr_symbol(unsigned long x)
> > {
> > 	/*
> > 	 * This is bounds checking against the kernel image only.
> > 	 * __pa_symbol should only be used on kernel symbol addresses.
> > 	 */
> > 	VIRTUAL_BUG_ON(x < (unsigned long) KERNEL_START ||
> > 		       x > (unsigned long) KERNEL_END);
> > 
> > 	return __pa_symbol_nodebug(x);
> > }
> > EXPORT_SYMBOL(__phys_addr_symbol);

Thanks,
Mark.
