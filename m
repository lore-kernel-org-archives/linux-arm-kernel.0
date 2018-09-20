From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Sep 2018 18:25:29 +0100
Subject: [PATCH v13 3/3] arm64: Implement page table free interfaces
In-Reply-To: <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180920172527.GB18934@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

On Wed, Jun 06, 2018 at 12:31:21PM +0530, Chintan Pandya wrote:
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8ae5d7a..65f8627 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/tlbflush.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -977,12 +978,51 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pte_t *table;
> +	pmd_t pmd;
> +
> +	pmd = READ_ONCE(*pmdp);
> +
> +	/* No-op for empty entry and WARN_ON for valid entry */
> +	if (!pmd_present(pmd) || !pmd_table(pmd)) {
> +		VM_WARN_ON(!pmd_table(pmd));
> +		return 1;
> +	}

What's this VM_WARN_ON supposed to do here? If the pmd is 0, we trigger
it all the time. Did you actually mean something like:

		VM_WARN_ON(!pmd_none(pmd));

or pmd_present(pmd)?

Since the comment mentions empty entry, I'd rather make it explicit:

	if (pmd_none(pmd) || !pmd_table(pmd))
		VM_WARN_ON(!pmd_none(pmd));
		return 1;
	}

Similarly for the pud_free_pmd_page():

----------8<--------------------------

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..2662937ef879 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -986,8 +986,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 	pmd = READ_ONCE(*pmdp);
 
 	/* No-op for empty entry and WARN_ON for valid entry */
-	if (!pmd_present(pmd) || !pmd_table(pmd)) {
-		VM_WARN_ON(!pmd_table(pmd));
+	if (pmd_none(pmd) || !pmd_table(pmd)) {
+		VM_WARN_ON(!pmd_none(pmd));
 		return 1;
 	}
 
@@ -1008,8 +1008,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	pud = READ_ONCE(*pudp);
 
 	/* No-op for empty entry and WARN_ON for valid entry */
-	if (!pud_present(pud) || !pud_table(pud)) {
-		VM_WARN_ON(!pud_table(pud));
+	if (pud_none(pud) || !pud_table(pud)) {
+		VM_WARN_ON(!pud_none(pud));
 		return 1;
 	}
 
