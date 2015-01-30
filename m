From: mgorman@suse.de (Mel Gorman)
Date: Fri, 30 Jan 2015 10:06:20 +0000
Subject: [PATCH] arm/mm: fix compiler warning in pmdp_invalidate() (in
 -next)
In-Reply-To: <1422553680-25374-1-git-send-email-andre.przywara@arm.com>
References: <1422553680-25374-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150130100620.GL2395@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 05:48:00PM +0000, Andre Przywara wrote:
> Commit ff61d185f4e7 ("mm: convert p[te|md]_mknonnuma and remaining
> page table manipulations") removed a check in
> mm/pgtable-generic.c:pmdp_invalidate(), which leaves the
> pmd_mknotpresent macro the only user of the entry variable.
> For ARM/LPAE we use a constant 0 without referencing the argument to
> mark this condition, so the entry variable is no longer used here:
> 
> mm/pgtable-generic.c: In function 'pmdp_invalidate':
> mm/pgtable-generic.c:195:8: warning: unused variable 'entry' [-Wunused-variable]
>   pmd_t entry = *pmdp;
>         ^
> 
> Replace the ARM macro implementation with a static inline function to
> get rid of this warning.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Patch looks fine to me but this is against a mmotm patch that is
included in mmotm. The commit ID is not going to last. This should be
sent to Andrew Morton with a note saying it's a fix to the mmotm patch
mm-convert-p_mknonnuma-and-remaining-page-table-manipulations.patch .
He'll then fold your fix into the original patch so that bisection works
correctly when merged to mainline. Do you mind doing that please?

-- 
Mel Gorman
SUSE Labs
