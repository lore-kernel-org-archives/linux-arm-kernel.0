From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jul 2014 14:39:42 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140717083342.GS21766@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140717102425.34fe0181@free-electrons.com>
 <20140717083342.GS21766@n2100.arm.linux.org.uk>
Message-ID: <6510599.Qoc205T3v7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 09:33:42 Russell King - ARM Linux wrote:
> On Thu, Jul 17, 2014 at 10:24:25AM +0200, Thomas Petazzoni wrote:
> > If I understand correctly, we are already changing the page tables
> > anyway, to switch certain pages to be mapped uncached, to do DMA
> > coherent allocations, no?
> 
> I've no idea, I never looked at that code.  I hope that Marek has
> considered the requirements of the architecture when creating that
> code...
> 
> > So wouldn't it be possible to keep the early
> > assembly code as it is today, and then later, in C code, once we have
> > identified the platform on which we're running, modify the page tables
> > to switch to the appropriate page attributes (write allocate cache
> > policy, shareable attribute, etc.) ?
> 
> No - the problem is that we're running from the page table in question
> with global mappings, and we need to switch all these mappings, including
> the ones we're currently using to execute from.
> 
> We can't even create a new page table and switch to it because the
> mappings in question are global mappings.
> 
> The only way to do that safely from an architectural point of view would
> be to turn the MMU off, and drop back to assembly code to change the
> page tables, and re-enable the MMU.  For something as obscure as Marvell's
> coherency stuff, that's not something I want to see in core code.

Is this different from what we do in the LPAE version of
early_paging_init()? That code already adjusts all the page
table entries on a per-platform setting and should be very
easy to extend for a modified procinfo->__cpu_mm_mmu_flags,
and possibly able to extend for traditional (non-LPAE)
page tables without a lot of duplication.

At the moment it only handles a platform-specific undetectable
PHYS_OFFSET for mach-keystone, which to me sounds equally
hacky as the platform-specific undetectable pmdprot value
for mvebu.

Is there anything I'm missing why one works and the other doesn't?

	Arnd
