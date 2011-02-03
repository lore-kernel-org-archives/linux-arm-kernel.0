From: mel@csn.ul.ie (Mel Gorman)
Date: Thu, 3 Feb 2011 13:30:54 +0000
Subject: [PATCH] ARM: mm: enforce pageblock alignment when freeing
	memmap entries at init
In-Reply-To: <AANLkTimrP4u5VJBVGCK0tXZo6G2S4tXJnJcqc0+oVeeF@mail.gmail.com>
References: <1295567231-2384-1-git-send-email-dima@android.com>
	<20110126082916.GM18984@csn.ul.ie>
	<AANLkTimrP4u5VJBVGCK0tXZo6G2S4tXJnJcqc0+oVeeF@mail.gmail.com>
Message-ID: <20110203133053.GG11958@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 01:57:53PM -0800, Dima Zavin wrote:
> On Wed, Jan 26, 2011 at 12:29 AM, Mel Gorman <mel@csn.ul.ie> wrote:
> > On Thu, Jan 20, 2011 at 03:47:11PM -0800, Dima Zavin wrote:
> >> On some machines, the nodes do not always start on pageblock
> >> boundaries. In these cases it is possible for free_unused_memmap
> >> to free mappings for pages inside a pageblock with otherwise
> >> valid pages. This presents problems for page migration since it
> >> operates on whole pageblocks at a time.
> >>
> >
> > This patch is not aligning on a pageblock boundary - it's aligning on
> > MAX_ORDER_NR_PAGES which is the boundary the buddy allocator works on.
> > This is a minor but important nit as different assumptions are made
> > about pageblocks and MAX_ORDER_NR_PAGES. Anyway;
> 

Sorry for the long delay. I'm in the process of changing jobs at the
moment and my schedule is heavily disrupted. It's likely to be a mess
for at least a month.

> Thank you for the nit. I'm kind of a VM noob so any insight is
> appreciated. I naively equated the two in my head when writing the
> description.
> 

It's fine. The distinction is very subtle.

> > If the node is not starting on the MAX_ORDER boundary then node_start_pfn
> > should also not be on the same boundary but the patch does not imply
> > that this has been broken. If anything it appears at a glance that there
> > is memmap *not* being freed because it was allocated on the
> > MAX_ORDER_NR_PAGES boundary and only partially freed.
> >
> > The comment then is confusing because the function is freeing memmap but
> > rounding down to free more of it ensures that all pages get a mapping?
> > It's not clear at all to me what was broken or how this patch fixes it
> > but bear in mind that it's rare I look at how ARM is initialised.
> 
> The function frees the mappings *between* the nodes. So when the patch
> rounds down the start of the node, it preserves (i.e. frees less) the
> mappings from MAX_ORDER_NR_PAGES boundary to the actual first valid
> page. Otherwise, I would have to define CONFIG_HOLES_IN_ZONE and pay
> the penalty. Looking through the history, a similar patch was already
> taken to roundup the previous bank end to MAX_ORDER_NR_PAGES. I'm
> doing the same to the start.
> 
> Am I totally off base?
> 

No, the description and patch comment is just misleading. Clarify that
you are catching the situation where a node boundary is in the middle of a
MAX_ORDER_NR_PAGES block of pages and you are preventing memmap belonging
to another node being freed and it's fine.

-- 
Mel Gorman
