From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Nov 2018 18:26:27 +0000
Subject: [PATCH v10 12/22] kasan, arm64: fix up fault handling logic
In-Reply-To: <4891a504adf61c0daf1e83642b6f7519328dfd5f.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <4891a504adf61c0daf1e83642b6f7519328dfd5f.1541525354.git.andreyknvl@google.com>
Message-ID: <20181107182626.GD255021@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 06:30:27PM +0100, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 7d9571f4ae3d..d9a84d6f3343 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -32,6 +32,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/preempt.h>
>  #include <linux/hugetlb.h>
> +#include <linux/kasan.h>
>  
>  #include <asm/bug.h>
>  #include <asm/cmpxchg.h>
> @@ -141,6 +142,8 @@ void show_pte(unsigned long addr)
>  	pgd_t *pgdp;
>  	pgd_t pgd;
>  
> +	addr = (unsigned long)kasan_reset_tag((void *)addr);
> +
>  	if (addr < TASK_SIZE) {
>  		/* TTBR0 */
>  		mm = current->active_mm;

I think we should clear the tag earlier on in the fault handling code,
before reaching show_pte().

-- 
Catalin
