From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 17 Mar 2014 15:07:30 -0700
Subject: [RESEND PATCH] mm: hugetlb: Introduce
 huge_pte_{page,present,young}
In-Reply-To: <1395082318-7703-1-git-send-email-steve.capper@linaro.org>
References: <1395082318-7703-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140317150730.156a3325ff96dfc6e1352902@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Mar 2014 18:51:58 +0000 Steve Capper <steve.capper@linaro.org> wrote:

> Introduce huge pte versions of pte_page, pte_present and pte_young.
> This allows ARM (without LPAE) to use alternative pte processing logic
> for huge ptes.
> 
> Where these functions are not defined by architectural code they
> fallback to the standard functions.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Hi,
> I'm resending this patch to provoke some discussion.
> 
> We already have some huge_pte_ style functions, and this patch adds a
> few more (that simplify to the pte_ equivalents where unspecified).
> 
> Having separate hugetlb versions of pte_page, present and mkyoung
> allows for a greatly simplified huge page implementation for ARM with
> the classical MMU (which has a different bit layout for huge ptes).

Looks OK to me.  One thing...

> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -353,6 +353,18 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>  }
>  #endif
>  
> +#ifndef huge_pte_page
> +#define huge_pte_page(pte)	pte_page(pte)
> +#endif

This #ifndef x #define x thing works well, but it is 100% unclear which
arch header file is supposed to define x if it wishes to override the
definition.  We've had problems with that in the past where different
architectures put it in different files and various breakages ensued.

So can we decide which arch header file is responsible for defining
these, then document that right here in a comment and add an explicit
#include <asm/that-file.h>?


> +#ifndef huge_pte_present
> +#define huge_pte_present(pte)	pte_present(pte)
> +#endif
> +
> +#ifndef huge_pte_mkyoung
> +#define huge_pte_mkyoung(pte)	pte_mkyoung(pte)
> +#endif
> +
