From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Dec 2017 12:10:00 +0000
Subject: [PATCH 2/2] arm64: SW PAN: Update saved ttbr0 value on
 enter_lazy_tlb
In-Reply-To: <1512558968-28980-3-git-send-email-will.deacon@arm.com>
References: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
 <1512558968-28980-3-git-send-email-will.deacon@arm.com>
Message-ID: <20171206120959.j6hqwpcfpue2gfcl@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 11:16:08AM +0000, Will Deacon wrote:
> enter_lazy_tlb is called when a kernel thread rides on the back of
> another mm, due to a context switch or an explicit call to unuse_mm
> where a call to switch_mm is elided.
> 
> In these cases, it's important to keep the saved ttbr value up to date
> with the active mm, otherwise we can end up with a stale value which
> points to a potentially freed page table.
> 
> This patch implements enter_lazy_tlb for arm64, so that the saved ttbr0
> is kept up-to-date with the active mm for kernel threads.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Vinayak Menon <vinmenon@codeaurora.org>
> Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

As with the prior patch, I think this needs:

Fixes: 39bc88e5e38e9b21 ("arm64: Disable TTBR0_EL1 during normal kernel execution")

Other than that, looks good to me.

Mark.

> ---
>  arch/arm64/include/asm/mmu_context.h | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index f7773f90546e..9d155fa9a507 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -156,20 +156,6 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
>  
>  #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
>  
> -/*
> - * This is called when "tsk" is about to enter lazy TLB mode.
> - *
> - * mm:  describes the currently active mm context
> - * tsk: task which is entering lazy tlb
> - * cpu: cpu number which is entering lazy tlb
> - *
> - * tsk->mm will be NULL
> - */
> -static inline void
> -enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> -{
> -}
> -
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  static inline void update_saved_ttbr0(struct task_struct *tsk,
>  				      struct mm_struct *mm)
> @@ -193,6 +179,16 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
>  }
>  #endif
>  
> +static inline void
> +enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> +{
> +	/*
> +	 * We don't actually care about the ttbr0 mapping, so point it at the
> +	 * zero page.
> +	 */
> +	update_saved_ttbr0(tsk, &init_mm);
> +}
> +
>  static inline void __switch_mm(struct mm_struct *next)
>  {
>  	unsigned int cpu = smp_processor_id();
> -- 
> 2.1.4
> 
