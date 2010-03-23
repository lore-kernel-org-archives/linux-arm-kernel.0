From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Mar 2010 12:53:46 +0000
Subject: ARM caches variants.
In-Reply-To: <4BA8B672.7030508@xenomai.org>
References: <4BA8B672.7030508@xenomai.org>
Message-ID: <1269348826.13209.10.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-23 at 12:39 +0000, Gilles Chanteperdrix wrote:
> As I understood, the VIVT cache has the following issues:
> - issue #1; two processes may use the same virtual address for different
> physical addresses, but will share the same cache line and see memory
> corruption if no precaution is taken;
> - issue #2; two processes may use different virtual addresses for the
> same physical address (shared mapping), but will use different cache
> lines, causing all sorts of incoherence if no precaution is taken;
> - issue #3; the same process may use different virtual addresses for the
> same physical address (same shared mapping mapped several time in the
> same process virtual memory), basically almost the same issue as issue #2.
[...]
> Now, if we look at VIPT, aliasing caches:
> - the physical tagging solves issue #1 automatically,
> - the cache colouring technique used in arch_get_unmapped_area solves
> issue #2 and #3 by ensuring that the areas using the same physical
> address will end up using the same cache lines, and avoid aliases "by
> construction".
[...]
> First question: did I get it right?

Yes.

> Second question: do issue #1, #2 and #3 have official non-ambiguous names?

I don't think there are any official names. You could say cache aliasing
though not sure it covers everything.

> Now, the stupid question: why not using the cache colouring technique
> used for VIPT caches to solve issue #3 with VIVT caches?

Because with aliasing VIPT it is guaranteed that if a virtual address
has the same offset in a 16KB block (i.e. the same colour - there are
only 4 colours given by bits 13 and 12 of the virtual address), you get
the same cache line allocated for a given physical address. The tag of a
cache line is given by bits 31..14 of the physical address.

With VIVT, the cache tags are not aware of the physical address, hence
you can have 2^20 colours (bits 31..12 of the virtual address). You
would need to map a physical address at the same virtual address in all
applications sharing it (and you may end up with uClinux :)).

-- 
Catalin
