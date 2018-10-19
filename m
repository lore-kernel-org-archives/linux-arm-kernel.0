From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 19 Oct 2018 10:09:59 +0200
Subject: [PATCH V2 1/5] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <1539316799-6064-2-git-send-email-anshuman.khandual@arm.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-2-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181019080959.GL18839@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I planed to get to review this earlier but been busy. Anyway, this patch
should be applied only after movability one to prevent from
(theoretical) bisectability issues.

I would probably fold it into the one which defines arch specific hook.

On Fri 12-10-18 09:29:55, Anshuman Khandual wrote:
> Architectures like arm64 have PUD level HugeTLB pages for certain configs
> (1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
> enabled for migration. It can be achieved through checking for PUD_SHIFT
> order based HugeTLB pages during migration.
> 
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
