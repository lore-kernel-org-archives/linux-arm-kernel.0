From: n-horiguchi@ah.jp.nec.com (Naoya Horiguchi)
Date: Fri, 19 Oct 2018 01:59:31 +0000
Subject: [PATCH V2 2/5] mm/hugetlb: Distinguish between migratability
 and movability
In-Reply-To: <1539316799-6064-3-git-send-email-anshuman.khandual@arm.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-3-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181019015931.GA18973@hori1.linux.bs1.fc.nec.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 09:29:56AM +0530, Anshuman Khandual wrote:
> During huge page allocation it's migratability is checked to determine if
> it should be placed under movable zones with GFP_HIGHUSER_MOVABLE. But the
> movability aspect of the huge page could depend on other factors than just
> migratability. Movability in itself is a distinct property which should not
> be tied with migratability alone.
> 
> This differentiates these two and implements an enhanced movability check
> which also considers huge page size to determine if it is feasible to be
> placed under a movable zone. At present it just checks for gigantic pages
> but going forward it can incorporate other enhanced checks.

(nitpicking...)
The following code just checks hugepage_migration_supported(), so maybe
s/Movability/Migratability/ is expected in the comment?

  static int unmap_and_move_huge_page(...)
  {
          ...
          /*
           * Movability of hugepages depends on architectures and hugepage size.
           * This check is necessary because some callers of hugepage migration
           * like soft offline and memory hotremove don't walk through page
           * tables or check whether the hugepage is pmd-based or not before
           * kicking migration.
           */
          if (!hugepage_migration_supported(page_hstate(hpage))) {

Thanks,
Naoya Horiguchi

> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/hugetlb.h | 30 ++++++++++++++++++++++++++++++
>  mm/hugetlb.c            |  2 +-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 9c1b77f..456cb60 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -493,6 +493,31 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>  #endif
>  }
>  
> +/*
> + * Movability check is different as compared to migration check.
> + * It determines whether or not a huge page should be placed on
> + * movable zone or not. Movability of any huge page should be
> + * required only if huge page size is supported for migration.
> + * There wont be any reason for the huge page to be movable if
> + * it is not migratable to start with. Also the size of the huge
> + * page should be large enough to be placed under a movable zone
> + * and still feasible enough to be migratable. Just the presence
> + * in movable zone does not make the migration feasible.
> + *
> + * So even though large huge page sizes like the gigantic ones
> + * are migratable they should not be movable because its not
> + * feasible to migrate them from movable zone.
> + */
> +static inline bool hugepage_movable_supported(struct hstate *h)
> +{
> +	if (!hugepage_migration_supported(h))
> +		return false;
> +
> +	if (hstate_is_gigantic(h))
> +		return false;
> +	return true;
> +}
> +
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> @@ -589,6 +614,11 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>  	return false;
>  }
>  
> +static inline bool hugepage_movable_supported(struct hstate *h)
> +{
> +	return false;
> +}
> +
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c21775..a5a111d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -919,7 +919,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  /* Movability of hugepages depends on migration support. */
>  static inline gfp_t htlb_alloc_mask(struct hstate *h)
>  {
> -	if (hugepage_migration_supported(h))
> +	if (hugepage_movable_supported(h))
>  		return GFP_HIGHUSER_MOVABLE;
>  	else
>  		return GFP_HIGHUSER;
> -- 
> 2.7.4
> 
> 
