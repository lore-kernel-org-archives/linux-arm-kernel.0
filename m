From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Sep 2012 23:21:05 +0100
Subject: [PATCH 3/4] ARM: mm: introduce L_PTE_VALID for page table entries
In-Reply-To: <1348156605-30398-4-git-send-email-will.deacon@arm.com>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <1348156605-30398-4-git-send-email-will.deacon@arm.com>
Message-ID: <20120920222105.GB1837@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 04:56:44PM +0100, Will Deacon wrote:
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 2317a71..c44a1ec 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -115,6 +115,7 @@
>   * The PTE table pointer refers to the hardware entries; the "Linux"
>   * entries are stored 1024 bytes below.
>   */
> +#define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
>  #define L_PTE_PRESENT		(_AT(pteval_t, 1) << 0)
>  #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
>  #define L_PTE_FILE		(_AT(pteval_t, 1) << 2)	/* only when !PRESENT */
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index b249035..e32311a 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -67,7 +67,8 @@
>   * These bits overlap with the hardware bits but the naming is preserved for
>   * consistency with the classic page table format.
>   */
> -#define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Valid */
> +#define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
> +#define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Present */
>  #define L_PTE_FILE		(_AT(pteval_t, 1) << 2)		/* only when !PRESENT */
>  #define L_PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
>  #define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 41dc31f..df206c1 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -203,9 +203,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>  #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
>  #define pte_special(pte)	(0)
>  
> -#define pte_present_user(pte) \
> -	((pte_val(pte) & (L_PTE_PRESENT | L_PTE_USER)) == \
> -	 (L_PTE_PRESENT | L_PTE_USER))
> +#define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))

This causes the compiler to do the "present" test and then, only if that
evaluates true, to do the "user" test.  That's not what we want, we want
the compiler to combine the two tests into one (which it should be able
to do so.)
