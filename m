From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Dec 2011 19:29:23 +0000
Subject: Oops in guest after ioremap() on ARMv7
In-Reply-To: <20111222181356.GI20635@arm.com>
References: <4EF31DA7.9030407@citrix.com> <20111222144937.GE20635@arm.com>
 <4EF35CFF.3050200@citrix.com> <20111222181356.GI20635@arm.com>
Message-ID: <20111222192923.GN2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 06:13:56PM +0000, Catalin Marinas wrote:
> It could as well be a model bug but people are on holiday at the moment
> (and I'm off shortly as well, until 3rd of January). Could you try to
> disable the cacheability of the page table walks for both stage 1 (TTBRx
> with classic page tables or TTBCR with LPAE) and stage 2 (VTCR)? Since
> Linux does the correct cache flushing and I assume the hypervisor as
> well, this may work around possible model bug.

Note that Linux, through and through, expects that page table entries are
not negatively cached.  Non-present page table entries are expected to be
refetched without requiring any kind of TLB flushing at any point.

If later hardware is, then it's incompatible with how Linux works (and
with every other CPU which Linux supports.)  It'd mean a new raft of
endless problems which only affect ARM.  So, I'd recommend getting rid
of this feature in hardware, not only because of this reason, but also
because it's absolutely insane: negative caching probably does _more_
to hurt performance by taking up valuable positive TLB caching space.
Not only that, but non-present page table entries aren't used very often,
and when they are they're normally part of a slow path.

So I suspect that the amount of traction you'd get to solve such an issue
in mainline would be fairly minimal.
