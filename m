From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jun 2018 16:44:48 +0100
Subject: [PATCH v13 3/3] arm64: Implement page table free interfaces
In-Reply-To: <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180606154447.GG6631@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 12:31:21PM +0530, Chintan Pandya wrote:
> arm64 requires break-before-make. Originally, before
> setting up new pmd/pud entry for huge mapping, in few
> cases, the modifying pmd/pud entry was still valid
> and pointing to next level page table as we only
> clear off leaf PTE in unmap leg.
> 
>  a) This was resulting into stale entry in TLBs (as few
>     TLBs also cache intermediate mapping for performance
>     reasons)
>  b) Also, modifying pmd/pud was the only reference to
>     next level page table and it was getting lost without
>     freeing it. So, page leaks were happening.
> 
> Implement pud_free_pmd_page() and pmd_free_pte_page() to
> enforce BBM and also free the leaking page tables.
> 
> Implementation requires,
>  1) Clearing off the current pud/pmd entry
>  2) Invalidation of TLB
>  3) Freeing of the un-used next level page tables
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)

Thanks, I think this looks really good now:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
