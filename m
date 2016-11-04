From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Nov 2016 18:16:16 -0600
Subject: [PATCH 1/2] arm64: hugetlb: remove the wrong pmd check in
 find_num_contig()
In-Reply-To: <1478140059-13829-2-git-send-email-shijie.huang@arm.com>
References: <1478140059-13829-1-git-send-email-shijie.huang@arm.com>
 <1478140059-13829-2-git-send-email-shijie.huang@arm.com>
Message-ID: <20161104001616.ssjbemliorxi6evl@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 10:27:38AM +0800, Huang Shijie wrote:
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 2e49bd2..4811ef1 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -61,10 +61,6 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>  		return 1;
>  	}
>  	pmd = pmd_offset(pud, addr);
> -	if (!pmd_present(*pmd)) {
> -		VM_BUG_ON(!pmd_present(*pmd));
> -		return 1;
> -	}
>  	if ((pte_t *)pmd == ptep) {
>  		*pgsize = PMD_SIZE;
>  		return CONT_PMDS;

BTW, for the !pud_present() and !pgd_present() cases, shouldn't
find_num_contig() actually return 0? These are more likely real bugs, so
no point in setting the huge pte.

-- 
Catalin
