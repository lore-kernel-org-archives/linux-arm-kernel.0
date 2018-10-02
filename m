From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 2 Oct 2018 14:39:09 +0200
Subject: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181002123909.GS18290@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 02-10-18 17:45:28, Anshuman Khandual wrote:
> Architectures like arm64 have PUD level HugeTLB pages for certain configs
> (1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
> enabled for migration. It can be achieved through checking for PUD_SHIFT
> order based HugeTLB pages during migration.

Well a long term problem with hugepage_migration_supported is that it is
used in two different context 1) to bail out from the migration early
because the arch doesn't support migration at all and 2) to use movable
zone for hugetlb pages allocation. I am especially concerned about the
later because the mere support for migration is not really good enough.
Are you really able to find a different giga page during the runtime to
move an existing giga page out of the movable zone?

So I guess we want to split this into two functions
arch_hugepage_migration_supported and hugepage_movable. The later would
be a reasonably migrateable subset of the former. Without that this
patch migth introduce subtle regressions when somebody relies on movable
zone to be really movable.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/hugetlb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6b68e34..9c1b77f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -483,7 +483,8 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>  {
>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	if ((huge_page_shift(h) == PMD_SHIFT) ||
> -		(huge_page_shift(h) == PGDIR_SHIFT))
> +		(huge_page_shift(h) == PUD_SHIFT) ||
> +			(huge_page_shift(h) == PGDIR_SHIFT))
>  		return true;
>  	else
>  		return false;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
