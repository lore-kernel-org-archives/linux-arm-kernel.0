From: vinmenon@codeaurora.org (Vinayak Menon)
Date: Tue, 5 Dec 2017 10:30:40 +0530
Subject: [RFC PATCH] arm64: deactivate saved ttbr when mm is deactivated
In-Reply-To: <20171204180001.7gsub3wt6h5nl3v3@lakrids.cambridge.arm.com>
References: <1512404606-26498-1-git-send-email-vinmenon@codeaurora.org>
 <20171204165533.GI29619@arm.com>
 <20171204180001.7gsub3wt6h5nl3v3@lakrids.cambridge.arm.com>
Message-ID: <72abe8f2-4d82-1375-956c-5e8b7869864c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/4/2017 11:30 PM, Mark Rutland wrote:
> On Mon, Dec 04, 2017 at 04:55:33PM +0000, Will Deacon wrote:
>> On Mon, Dec 04, 2017 at 09:53:26PM +0530, Vinayak Menon wrote:
>>> A case is observed where a wrong physical address is read,
>>> resulting in a bus error and that happens soon after TTBR0 is
>>> set to the saved ttbr by uaccess_ttbr0_enable. This is always
>>> seen to happen in the exit path of the task.
>>>
>>> exception
>>> __arch_copy_from_user
>>> __copy_from_user
>>> probe_kernel_read
>>> get_freepointer_safe
>>> slab_alloc_node
>>> slab_alloc
>>> kmem_cache_alloc
>>> kmem_cache_zalloc
>>> fill_pool
>>> __debug_object_init
>>> debug_object_init
>>> rcuhead_fixup_activate
>>> debug_object_fixup
>>> debug_object_activate
>>> debug_rcu_head_queue
>>> __call_rcu
>>> ep_remove
>>> eventpoll_release_file
>>> __fput
>>> ____fput
>>> task_work_run
>>> do_exit
>>>
>>> The mm has been released and the pgd is freed, but probe_kernel_read
>>> invoked from slub results in call to __arch_copy_from_user. At the
>>> entry to __arch_copy_from_user, when SW PAN is enabled, this results
>>> in stale value being set to ttbr0. May be a speculative fetch aftwerwards
>>> is resulting in invalid physical address access.
>>>
>>> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
>>> ---
>>>
>>> I have not tested this patch to see if it fixes the problem.
>>> Sending it early for comments.
>> I wonder whether it would be better to avoid restoring the user TTBR0 if
>> KERNEL_DS is set. 
> I think the problem here is that switch_mm() avoids updating the saved ttbr
> value when the next mm is init_mm.
For this switch to happen, the schedule() in do_task_dead at the end of do_exit() need to be called, right ?
The issue is happening soon after exit_mm (probably from exit_files).
>
> If we fixed that up to use the empty zero page (as we write to the real
> ttbr0 in this case), I think that solves the problem. Though I agree we
> should also avoid restoring the user TTBR for KERNEL_DS uaccess calls.
>
> Example below.
>
> Thanks,
> Mark.
>
> ---->8----
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 3257895a9b5e..ef3567ce80b3 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -174,10 +174,15 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>  static inline void update_saved_ttbr0(struct task_struct *tsk,
>                                       struct mm_struct *mm)
>  {
> +       u64 ttbr;
> +
>         if (system_uses_ttbr0_pan()) {
> -               BUG_ON(mm->pgd == swapper_pg_dir);
> -               task_thread_info(tsk)->ttbr0 =
> -                       virt_to_phys(mm->pgd) | ASID(mm) << 48;
> +               if (mm == &init_mm)
> +                       ttbr = __pa_symbol(empty_zero_page);
> +               else
> +                       ttbr = virt_to_phys(mm->pgd) | ASID(mm) << 48;
> +
> +               task_thread_info(tsk)->ttbr0 = ttbr;
>         }
>  }
>  #else
> @@ -214,11 +219,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>          * Update the saved TTBR0_EL1 of the scheduled-in task as the previous
>          * value may have not been initialised yet (activate_mm caller) or the
>          * ASID has changed since the last run (following the context switch
> -        * of another thread of the same process). Avoid setting the reserved
> -        * TTBR0_EL1 to swapper_pg_dir (init_mm; e.g. via idle_task_exit).
> +        * of another thread of the same process).
>          */
> -       if (next != &init_mm)
> -               update_saved_ttbr0(tsk, next);
> +       update_saved_ttbr0(tsk, next);
>  }
>  
>  #define deactivate_mm(tsk,mm)  do { } while (0)
