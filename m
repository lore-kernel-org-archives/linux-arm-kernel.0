From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Oct 2009 11:22:54 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023100639.GA19437@n2100.arm.linux.org.uk>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
Message-ID: <1256293374.6564.27.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-23 at 11:06 +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 23, 2009 at 10:41:21AM +0100, Catalin Marinas wrote:
> > ARMv6 onwards requires that there are no aliases to the same physical
> > location using different memory types (i.e. Normal vs Strongly Ordered).
> > Access to SO mappings when the unaligned accesses are handled in
> > hardware is also Unpredictable (pgprot_noncached() mappings in user
> > space).
> > 
> > The patch modifies the pgprot_noncached() for ARMv6+ architecture
> > versions to generate Normal uncached memory attributes rather than
> > Strongly Ordered. The patch also modifies the mandatory barriers to use
> > dmb() rather than being simple compiler barriers.
> 
> It's not this simple - pgprot_noncached() is used for /dev/mem O_SYNC
> mappings, which are used for device mappings.  This means you still
> end up with the unpredictable issue.

If it is used for accessing device memory, why not create a
pgprot_device() and use this instead (maybe after checking for pfn_valid
to make sure we don't map the RAM as device memory)? Of course, it needs
some modifications to the mem.c driver which may be ARM specific, though
some other architecture might benefit as well.

>From drivers/char/mem.c:

	/*
	 * On ia64, we ignore O_SYNC because we cannot tolerate memory attribute aliases.
	 */

So ARM it's not the only architecture with this issue (I know you don't
like this argument :-)).

I can see MIPS has its own #ifdef in the mem.c driver as well.

-- 
Catalin
