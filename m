From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 10:30:18 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <AANLkTimpcQCjnfzT0R+Af+f38RwBg6DUBg_b85opJJnh@mail.gmail.com>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
	<1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
	<20110215113242.GD4152@n2100.arm.linux.org.uk>
	<20110215121437.GG4152@n2100.arm.linux.org.uk>
	<1297780926.14691.164.camel@e102109-lin.cambridge.arm.com>
	<20110220121227.GB14495@n2100.arm.linux.org.uk>
	<AANLkTimpcQCjnfzT0R+Af+f38RwBg6DUBg_b85opJJnh@mail.gmail.com>
Message-ID: <20110221103018.GH14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 09:39:32AM +0000, Catalin Marinas wrote:
> On 20 February 2011 12:12, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 15, 2011 at 02:42:06PM +0000, Catalin Marinas wrote:
> >> On Tue, 2011-02-15 at 12:14 +0000, Russell King - ARM Linux wrote:
> >> > On Tue, Feb 15, 2011 at 11:32:42AM +0000, Russell King - ARM Linux wrote:
> >> > > The point of TLB shootdown is that we unmap the entries from the page
> >> > > tables, then issue the TLB flushes, and then free the pages and page
> >> > > tables after that. ?All that Peter's patch tries to do is to get ARM to
> >> > > use the generic stuff.
> >> >
> >> > As Peter's patch preserves the current behaviour, that's not sufficient.
> >> > So, let's do this our own way and delay pages and page table frees on
> >> > ARMv6 and v7. ?Untested.
> >>
> >> ARMv7 should be enough, I'm not aware of any pre-v7 with this behaviour.
> >
> > ARM11MPCore. ?Any SMP system can access a page which was free'd by the
> > tlb code but hasn't been flushed from the hardware TLBs. ?So maybe we
> > want it to be "defined(CONFIG_SMP) || defined(CONFIG_CPU_32v7)" ?
> 
> In practice, since the hardware TLB does not store higher level
> entries on existing v6 cores, there is no cached value pointing to the
> freed pte page.

It's not about cached values of PTE pointers.

> In theory, we first clear the pmd entry but another
> CPU could be doing a PTW at the same time and had already read the pmd
> before being cleared. But the timing constraints are difficult to
> reproduce in practice.

I don't think you properly understand the problem.

CPU#0 is unmapping page tables, eg due to munmap(), mremap(), etc.
CPU#1 is running a thread, and has TLB entries for the region being unmapped.

	CPU#0				CPU#1
	clear page table entry
	frees page
	loop continues
					accesses page
	...
	sometime in the future
	invalidates TLB

The point here is that user threads on CPU#1 should not have access to
a page which has been freed back into the pool, no matter how slim the
possibility of hitting such a condition.  What if a thread on CPU#2 is
given that free page which CPU#1 still has access to, and CPU#2 stores
your SSH private key there?
