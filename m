From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 2 Oct 2018 13:38:01 +0100
Subject: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
Message-ID: <835085a2-79c2-4eb5-2c10-13bb2893f611@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anshuman

On 02/10/18 13:15, Anshuman Khandual wrote:
> Architectures like arm64 have PUD level HugeTLB pages for certain configs
> (1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
> enabled for migration. It can be achieved through checking for PUD_SHIFT
> order based HugeTLB pages during migration.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   include/linux/hugetlb.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6b68e34..9c1b77f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -483,7 +483,8 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>   {
>   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>   	if ((huge_page_shift(h) == PMD_SHIFT) ||
> -		(huge_page_shift(h) == PGDIR_SHIFT))
> +		(huge_page_shift(h) == PUD_SHIFT) ||


> +			(huge_page_shift(h) == PGDIR_SHIFT))

nit: Extra Tab ^^.
Also, if only arm64 supports PUD_SHIFT, should this be added only in the 
arm64 specific backend, which we introduce later ?

Suzuki
