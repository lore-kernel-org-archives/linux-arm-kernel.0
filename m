From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Apr 2016 16:00:42 +0100
Subject: [RFC 0/1] ARM: mm: cache shareability tweak
In-Reply-To: <570D00F9.4070406@ti.com>
References: <1460448880-5677-1-git-send-email-t-kristo@ti.com>
 <20160412132505.GG28057@leverpostej> <570D00F9.4070406@ti.com>
Message-ID: <20160412150042.GI28057@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 05:06:49PM +0300, Tero Kristo wrote:
> On 04/12/2016 04:25 PM, Mark Rutland wrote:
> >On Tue, Apr 12, 2016 at 11:14:39AM +0300, Tero Kristo wrote:
> >>Some obvious holes in this implementation:
> >>
> >>1) during execution of arch/arm/kernel/head.S, the tweaked MMU shareability
> >>    settings are not in place. However, I am not too sure how much that
> >>    matters, as I am not sure what is mapped at this point. Kernel image
> >>    mapping should not matter at least, as we typically should not be doing
> >>    any DMA transfers from the kernel image.
> >
> >Strictly speaking, changing the shareability can result in a loss of
> >coherency, even if all accesses are made by the same CPU. See
> >"Mismatched memory attributes" in section A3.5.7 of the ARMv7-AR
> >Reference Manual (ARM DDI 0406C.c).
> 
> Basically we are not attempting to change shareability in-the-fly,
> but instead configure a different shareability value that is going
> to be used always.

I understood that this was a one-time transition; the problem still
applies, per the architecture. Your implementation _may_ provide
stronger guarantees than architecturally required.

Caches lines allocated as a result of accesses with one set of
attributes are not necessarily coherent with accesses with differing
attributes (even if only differing in terms of shareability). Until the
cache maintenance mandated by the ARM ARM is performed, you may
encounter a number of issues.

Thus changing attributes once during the boot process is potentially
problematic.

> >It's not just DMA that matters. I believe we may have page tables as
> >part of the kernel image, for instance, and those need to be accessed
> >with consistent attributes by the MMU when doing page table walks.
> >
> >You can avoid issues so long as you have appropriate cache maintenance,
> >but that's both expensive (all memory previously mapped must be
> >Clean+Invalidated by VA) and painful (as you can't reliably use any of
> >said memory until after the maintenance).
> 
> The hack we have internally just maps all the DMA pages as outer
> shareable.

I'm not sure precisely what you mean by "DMA pages" here. Surely this
applies to any mappings created using the usual page table accessors?

> I think maybe adding the original hack might help understanding the
> issue, so added inline in the end as reference. We just attempt to
> change the shareability value from 3 (the current) to 2.

I understand that you only wish to change the shareability.

What I am describing are the caveats that come with doing do, which are
not necessarily intuitive, but are laid out in the ARM ARM.

Thanks,
Mark.
