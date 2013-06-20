From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 12:08:58 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <20130620095705.GA18536@arm.com>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
Message-ID: <51C2D4BA.8020406@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 11:57 AM, Catalin Marinas wrote:
> Hi Marc,
> 
> On Thu, Jun 20, 2013 at 09:43:33AM +0100, Marc Kleine-Budde wrote:
>> on current linus/master on armv5 we observed stack trashing[1] on high
>> load. I bisected this problem down to commit:
>>
>>> b9d4d42ad901cc848ac87f1cb8923fded3645568 is the first bad commit
>>> commit b9d4d42ad901cc848ac87f1cb8923fded3645568
>>> Author: Catalin Marinas <catalin.marinas@arm.com>
>>> Date:   Mon Nov 28 21:57:24 2011 +0000
>>>
>>>     ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs
>>>
>>>     This patch removes the __ARCH_WANT_INTERRUPTS_ON_CTXSW definition for
>>>     ARMv5 and earlier processors. On such processors, the context switch
>>>     requires a full cache flush. To avoid high interrupt latencies, this
>>>     patch defers the mm switching to the post-lock switch hook if the
>>>     interrupts are disabled.
>>>
>>>     Reviewed-by: Will Deacon <will.deacon@arm.com>
>>>     Tested-by: Will Deacon <will.deacon@arm.com>
>>>     Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
>>>     Tested-by: Marc Zyngier <Marc.Zyngier@arm.com>
>>>     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>>
>>> :040000 040000 034899bdcbc9aa59b5455a85a9d78b646b4cf784 ecc23e33a4ca807d4153f87fbea85a9437ff2928 M      arch
>>
>> The problem can be reproduced on several mx28 and an at91sam9263 and
>> only occurs of CONFIG_PREEMPT (Preemptible Kernel (Low-Latency Desktop))
>> is enabled.
>>
>> I have the gut feeling that the "if (irqs_disabled())" check in the
>> above patch is not correct for CONFIG_PREEMPT.
> 
> The check is there to avoid long interrupt latencies (flushing the whole
> cache with interrupts disabled during context switch). You can drop the
> check and always call cpu_switch_mm() to confirm that it fixes the
> faults.

I have disabled the check:

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index a7b85e0..7b3f67f 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -39,7 +39,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
        if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
                __check_vmalloc_seq(mm);

-       if (irqs_disabled())
+       if (0 && irqs_disabled())
                /*
                 * cpu_switch_mm() needs to flush the VIVT caches. To avoid
                 * high interrupt latencies, defer the call and continue

...and the test is running without problems, while I'm writing this
email. No more segfaults so far.

> finish_task_switch() calls finish_arch_post_lock_switch() after the
> interrupts have been enabled so that the CPU can actually switch the mm.
> I wonder whether we could actually be preempted after
> finish_lock_switch() but before we actually switched the MMU.
> 
> Here's an untested patch (trying to keep it in the arch/arm code):
> 
> 
> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
> index a7b85e0..ded85e9 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -39,17 +39,20 @@ static inline void check_and_switch_context(struct mm_struct *mm,
>  	if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
>  		__check_vmalloc_seq(mm);
>  
> -	if (irqs_disabled())
> +	if (irqs_disabled()) {
>  		/*
>  		 * cpu_switch_mm() needs to flush the VIVT caches. To avoid
>  		 * high interrupt latencies, defer the call and continue
>  		 * running with the old mm. Since we only support UP systems
>  		 * on non-ASID CPUs, the old mm will remain valid until the
> -		 * finish_arch_post_lock_switch() call.
> +		 * finish_arch_post_lock_switch() call. Preemption needs to be
> +		 * disabled until the MMU is switched.
>  		 */
>  		set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
> -	else
> +		preempt_disable();
> +	} else {
>  		cpu_switch_mm(mm->pgd, mm);
> +	}
>  }
>  
>  #define finish_arch_post_lock_switch \
> @@ -59,6 +62,10 @@ static inline void finish_arch_post_lock_switch(void)
>  	if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
>  		struct mm_struct *mm = current->mm;
>  		cpu_switch_mm(mm->pgd, mm);
> +		/*
> +		 * Preemption disabled in check_and_switch_context().
> +		 */
> +		preempt_enable();
>  	}
>  }

Will now reboot to test your patch.

thanks,
Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/510c114b/attachment.sig>
