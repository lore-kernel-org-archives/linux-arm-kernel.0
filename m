From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Jan 2012 09:37:40 +0000
Subject: [PATCH 4/7] Store huge page linux pte in mm_struct
In-Reply-To: <1327910238-18704-5-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-5-git-send-email-bill4carson@gmail.com>
Message-ID: <CAHkRjk4j3MMQuwbCFwxaXcbu+5ztARJTZ4KrQm6RpAqSi0oxuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2012 07:57,  <bill4carson@gmail.com> wrote:
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3cc3062..88f76e6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -23,6 +23,11 @@
> ?struct address_space;
>
> ?#define USE_SPLIT_PTLOCKS ? ? ?(NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
> +#ifdef CONFIG_ARM_HUGETLB_SUPPORT
> +#define HUGE_2M_PTE_SIZE ? ? ?2
> +#define HUGE_2M_PTE_1ST_ARRAY 0
> +#define HUGE_2M_PTE_2ND_ARRAY 1
> +#endif
>
> ?/*
> ?* Each physical page in the system has a struct page associated with
> @@ -388,6 +393,12 @@ struct mm_struct {
> ?#ifdef CONFIG_CPUMASK_OFFSTACK
> ? ? ? ?struct cpumask cpumask_allocation;
> ?#endif
> +
> +#ifdef CONFIG_ARM_HUGETLB_SUPPORT
> + ? ? ? /* we place hugepage linux pte at mm_struct ?*/
> + ? ? ? pte_t *huge_2m_pte[HUGE_2M_PTE_SIZE];
> + ? ? ? pte_t *huge_16m_pte;
> +#endif
> ?};
>
> ?static inline void mm_init_cpumask(struct mm_struct *mm)

Please don't touch generic code. There is mm_context_t defined in
arch/arm/include/asm/mmu.h, just add the stuff you need there.

-- 
Catalin
