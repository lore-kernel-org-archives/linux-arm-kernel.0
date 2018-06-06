From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jun 2018 16:44:38 +0100
Subject: [PATCH v13 1/3] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <1528268481-19299-2-git-send-email-cpandya@codeaurora.org>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-2-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180606154437.GE6631@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 12:31:19PM +0530, Chintan Pandya wrote:
> From: Chintan Pandya <cpandya@codeaurora.org>
> 
> The following kernel panic was observed on ARM64 platform due to a stale
> TLB entry.
> 
>  1. ioremap with 4K size, a valid pte page table is set.
>  2. iounmap it, its pte entry is set to 0.
>  3. ioremap the same address with 2M size, update its pmd entry with
>     a new value.
>  4. CPU may hit an exception because the old pmd entry is still in TLB,
>     which leads to a kernel panic.
> 
> Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> table") has addressed this panic by falling to pte mappings in the above
> case on ARM64.
> 
> To support pmd mappings in all cases, TLB purge needs to be performed
> in this case on ARM64.
> 
> Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
> so that TLB purge can be added later in seprate patches.
> 
> [toshi at hpe.com: merge changes, rewrite patch description]
> Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: <stable@vger.kernel.org>
> 
> ---
>  arch/arm64/mm/mmu.c           | 4 ++--
>  arch/x86/mm/pgtable.c         | 8 +++++---
>  include/asm-generic/pgtable.h | 8 ++++----
>  lib/ioremap.c                 | 4 ++--
>  4 files changed, 13 insertions(+), 11 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
