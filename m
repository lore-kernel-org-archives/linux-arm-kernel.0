From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Aug 2012 09:44:39 +0100
Subject: [PATCH 1/1] ARM: Fix mapping in alloc_init_section for
 unaligned addresses.
In-Reply-To: <1344063622-11021-1-git-send-email-r.sricharan@ti.com>
References: <1344063622-11021-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20120804084439.GC6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 04, 2012 at 12:30:22PM +0530, R Sricharan wrote:
> When either the start address or end address or physical address
> to be mapped is unaligned, alloc_init_section creates
> page granularity mappings. alloc_init_section calls
> alloc_init_pte which populates one pmd entry and sets up
> the ptes. But if the size is greater than what can be mapped
> by one pmd entry, then the rest remains unmapped.
> 
> The issue becomes visible when LPAE is enabled, where we have
> the 3 levels with seperate pgd and pmd's.
> When a static mapping for 3MB is requested, only 2MB is mapped
> and the remaining 1MB is unmapped. Fixing this here, by looping
> in to map the entire unaligned address range.

This doesn't look like a nice fix.  The implication above is that it's
only alloc_init_pte() which is affected - so why not add a loop there?

Remember that pte's cover two sections, not one, so you need to use a
different increment to sections.
