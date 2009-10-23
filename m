From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Oct 2009 11:34:20 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <1256293374.6564.27.camel@pc1117.cambridge.arm.com>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
Message-ID: <20091023103420.GC19437@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 11:22:54AM +0100, Catalin Marinas wrote:
> On Fri, 2009-10-23 at 11:06 +0100, Russell King - ARM Linux wrote:
> > On Fri, Oct 23, 2009 at 10:41:21AM +0100, Catalin Marinas wrote:
> > > ARMv6 onwards requires that there are no aliases to the same physical
> > > location using different memory types (i.e. Normal vs Strongly Ordered).
> > > Access to SO mappings when the unaligned accesses are handled in
> > > hardware is also Unpredictable (pgprot_noncached() mappings in user
> > > space).
> > > 
> > > The patch modifies the pgprot_noncached() for ARMv6+ architecture
> > > versions to generate Normal uncached memory attributes rather than
> > > Strongly Ordered. The patch also modifies the mandatory barriers to use
> > > dmb() rather than being simple compiler barriers.
> > 
> > It's not this simple - pgprot_noncached() is used for /dev/mem O_SYNC
> > mappings, which are used for device mappings.  This means you still
> > end up with the unpredictable issue.
> 
> If it is used for accessing device memory, why not create a
> pgprot_device() and use this instead (maybe after checking for pfn_valid
> to make sure we don't map the RAM as device memory)? Of course, it needs
> some modifications to the mem.c driver which may be ARM specific, though
> some other architecture might benefit as well.

People keep fiddling with /dev/mem, and it keeps having these problems.
I suggest we leave that area well alone - we can not properly solve the
/dev/mem problems.  Fixing it to use "memory" mappings will break attempts
to use it to access devices, and fixing it for "device" mappings will break
attempts to access memory.

No amount of fiddling with uncached_access() can fix that.


When it comes to the writecombine and DMA coherent mappings, these are
architecture private stuff.  I guess on ARMv6 and v7, there is no
difference between these two (since writecombine is already uncacheable
normal memory).
