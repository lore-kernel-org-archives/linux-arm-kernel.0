From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 17:11:37 +0100
Subject: A crash on ARM64 in move_freepages_block due to uninitialized
 pages in reserved memory
In-Reply-To: <alpine.LRH.2.02.1808301148260.18300@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808171527220.2385@file01.intranet.prod.int.rdu2.redhat.com>
 <20180821104418.GA16611@dhcp22.suse.cz>
 <e35b7c14-c7ea-412d-2763-c961b74576f3@arm.com>
 <alpine.LRH.2.02.1808220808050.17906@file01.intranet.prod.int.rdu2.redhat.com>
 <c823eace-8710-9bf5-6e76-d01b139c0859@arm.com>
 <20180824114158.GJ29735@dhcp22.suse.cz>
 <541193a6-2bce-f042-5bb2-88913d5f1047@arm.com>
 <alpine.LRH.2.02.1808301148260.18300@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180830161137.GC13005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 11:58:19AM -0400, Mikulas Patocka wrote:
> On Wed, 29 Aug 2018, James Morse wrote:
> > HOLES_IN_ZONE is similar, if some memory is smaller than MAX_ORDER_NR_PAGES,
> > possibly due to nomap holes.
> > 
> > 6d526ee26ccd only enabled it for NUMA systems on arm64, because the NUMA code
> > was first to fall foul of this, but there is nothing NUMA specific about nomap
> > holes within a MAX_ORDER_NR_PAGES region.
> > 
> > I'm convinced arm64 should always enable HOLES_IN_ZONE because nomap pages can
> > occur anywhere. I'll post a fix.
> 
> But x86 had the same bug -
> https://bugzilla.redhat.com/show_bug.cgi?id=1598462

Yeah, that's not readable and lkml.org is down. Any idea what x86 did?

> And x86 fixed it without enabling HOLES_IN_ZONE. On x86, the BIOS can also 
> reserve any memory range - so you can have arbitrary holes there that are 
> not predictable when the kernel is compiled.

What happens when the BIOS reserves a page on x86? Is it still mapped by
the kernel (and therefore has a valid struct page) or is it treated like
NOMAP?

> Currently HOLES_IN_ZONE is selected only for ia64, mips/octeon - so does 
> it mean that all the other architectures don't have holes in the memory 
> map?

Possibly. Note also that arm64 already selects HOLES_IN_ZONE if NUMA.

> What should be architecture-independent way how to handle the holes?

Until firmware is architecture-independent, I think handling this
generically is a lost cause.

Will
