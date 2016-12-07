From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 7 Dec 2016 10:06:38 +0100
Subject: [PATCH 0/2] Hibernate fixes for 'Fix memmap to be initialized
 for the entire section'
In-Reply-To: <20161206173810.GU2498@arm.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <20161202144909.18405-1-james.morse@arm.com>
 <CAKv+Gu9AVVPp+UM5pCeYCt4HE-Azijp0iUf0QZv6YKFgAuckYw@mail.gmail.com>
 <20161206173810.GU2498@arm.com>
Message-ID: <20161207090638.GI10776@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.12.16 17:38:11, Will Deacon wrote:
> On Mon, Dec 05, 2016 at 03:42:14PM +0000, Ard Biesheuvel wrote:
> > On 2 December 2016 at 14:49, James Morse <james.morse@arm.com> wrote:
> > > Patch "arm64: mm: Fix memmap to be initialized for the entire section"
> > > changes pfn_valid() in a way that breaks hibernate. These patches fix
> > > hibernate, and provided struct page's are allocated for nomap pages,
> > > can be applied before [0].
> > >
> > > Hibernate core code belives 'valid' to mean "I can access this". It
> > > uses pfn_valid() to test the page if the page is 'valid'.
> > >
> > > pfn_valid() needs to be changed so that all struct pages in a numa
> > > node have the same node-id. Currently 'nomap' pages are skipped, and
> > > retain their pre-numa node-ids, which leads to a later BUG_ON().
> > >
> > > These patches make hibernate's savable_page() take its escape route
> > > via 'if (PageReserved(page) && pfn_is_nosave(pfn))'.
> > >
> > 
> > This makes me feel slightly uneasy. Robert makes a convincing point,
> > but I wonder if we can expect more fallout from the ambiguity of
> > pfn_valid(). Now we are not only forced to assign non-existing (as far
> > as the OS is concerned) pages to the correct NUMA node, we also need
> > to set certain page flags.
> 
> Yes, I really don't know how to proceed here. Playing whack-a-mole with
> pfn_valid() users doesn't sounds like an improvement on the current
> situation to me.
> 
> Robert -- if we leave pfn_valid() as it is, would a point-hack to
> memmap_init_zone help, or do you anticipate other problems?

I would suggest to fix the hibernation code as I commented on before
to use pfn_is_nosave() that defaults to pfn_valid() but uses memblock_
is_nomap() for arm64. Let's just fix it and see if no other issues
arise. I am trying to send a patch for this until tomorrow.

I am also going to see how early_pfn_valid() could be redirected to
use memblock_is_nomap() on arm64. That would "quick fix" the problem,
though I rather prefer to go further with the current solution.

-Robert
