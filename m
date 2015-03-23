From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 23 Mar 2015 17:22:57 +0000
Subject: [PATCH] arm64: efi: don't restore TTBR0 if active_mm points at
 init_mm
In-Reply-To: <20150323154458.GC12757@e104818-lin.cambridge.arm.com>
References: <1426779780-4706-1-git-send-email-will.deacon@arm.com>
 <1427116945.2693.10.camel@linaro.org>
 <20150323154458.GC12757@e104818-lin.cambridge.arm.com>
Message-ID: <1427131377.2693.25.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-23 at 15:44 +0000, Catalin Marinas wrote:
[...]
> I think for stable, we can do
> with the patch below. We could clean up the cpu_switch_mm() uses through
> the arch/arm64 and set the reserved ttbr0 but we only have two at the
> moment (__cpu_suspend and efi_set_pgd).
> 
> -----------------8<-------------------------
> 
> From 5d9e3540b6480558528612dd3672543fa8ab3528 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Mon, 23 Mar 2015 15:06:50 +0000
> Subject: [PATCH] arm64: Use the reserved TTBR0 if context switching to the
>  init_mm
> 
> The idle_task_exit() function may call switch_mm() with next ==
> &init_mm. On arm64, init_mm.pgd cannot be used for user mappings, so
> this patch simply sets the reserved TTBR0.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Jon Medhurst (Tixy) <tixy@linaro.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

That unsurprising fixes the BUG_ON I was seeing on Juno, so...
Tested-by: Jon Medhurst (Tixy) <tixy@linaro.org>

One question, is bypassing setting the mm_cpumask and context.id for
init_mm OK? I'm not familiar with the code but had a quick look, and it
looks like they are just used for ASID management, in which case I
assume everything is OK - ASIDs only being relevant for user mappings in
ttbr0?
 
> ---
>  arch/arm64/include/asm/mmu_context.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index a9eee33dfa62..101a42bde728 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -151,6 +151,15 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> +	/*
> +	 * init_mm.pgd does not contain any user mappings and it is always
> +	 * active for kernel addresses in TTBR1. Just set the reserved TTBR0.
> +	 */
> +	if (next == &init_mm) {
> +		cpu_set_reserved_ttbr0();
> +		return;
> +	}
> +
>  	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next)
>  		check_and_switch_context(next, tsk);
>  }
