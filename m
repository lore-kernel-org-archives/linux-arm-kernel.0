From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Jan 2012 09:57:29 +0000
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
Message-ID: <CAHkRjk55+83jj2eL-p22bqh5uz2AKy+ypUO78KSxTd1gLfwTkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2012 07:57,  <bill4carson@gmail.com> wrote:
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 2317a71..062c93c 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -123,6 +123,11 @@
> ?#define L_PTE_USER ? ? ? ? ? ? (_AT(pteval_t, 1) << 8)
> ?#define L_PTE_XN ? ? ? ? ? ? ? (_AT(pteval_t, 1) << 9)
> ?#define L_PTE_SHARED ? ? ? ? ? (_AT(pteval_t, 1) << 10) ? ? ? ?/* shared(v6), coherent(xsc3) */
> +#ifdef CONFIG_ARM_HUGETLB_SUPPORT
> +#define L_PTE_HUGEPAGE (_AT(pteval_t, 1) << 11) /* mark hugepage */

Do we actually need this bit? The checks are done starting from the
top pgd/pud/pmd. So we stop at the pmd level and check whether it is
table or a section mapping. I don't think we ever check a pte entry
for whether it is huge or not (as,@least with the implementation
you posted, it does not support 64K pages).

> +#define L_PTE_HPAGE_2M ?(_AT(pteval_t, 1) << 12) /* only when HUGEPAGE set */
> +#define L_PTE_HPAGE_16M (_AT(pteval_t, 1) << 13) /* only when HUGEPAGE set */

If we go for 2MB only, we can ignore both definitions here.

-- 
Catalin
