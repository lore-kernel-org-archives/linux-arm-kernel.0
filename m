From: vinmenon@codeaurora.org (Vinayak Menon)
Date: Tue, 5 Dec 2017 21:26:29 +0530
Subject: [RFC PATCH] arm64: deactivate saved ttbr when mm is deactivated
In-Reply-To: <20171205145529.GA24035@arm.com>
References: <1512404606-26498-1-git-send-email-vinmenon@codeaurora.org>
 <20171204165533.GI29619@arm.com>
 <20171204180001.7gsub3wt6h5nl3v3@lakrids.cambridge.arm.com>
 <72abe8f2-4d82-1375-956c-5e8b7869864c@codeaurora.org>
 <20171205110619.et5nhkkprv7tmshu@lakrids.cambridge.arm.com>
 <20171205145529.GA24035@arm.com>
Message-ID: <18c6a5be-fb8b-e247-300f-f97baa479513@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/5/2017 8:25 PM, Will Deacon wrote:
> On Tue, Dec 05, 2017 at 11:06:20AM +0000, Mark Rutland wrote:
>> On Tue, Dec 05, 2017 at 10:30:40AM +0530, Vinayak Menon wrote:
>>> On 12/4/2017 11:30 PM, Mark Rutland wrote:
>>>> On Mon, Dec 04, 2017 at 04:55:33PM +0000, Will Deacon wrote:
>>>>> On Mon, Dec 04, 2017 at 09:53:26PM +0530, Vinayak Menon wrote:
>>>>>> A case is observed where a wrong physical address is read,
>>>>>> resulting in a bus error and that happens soon after TTBR0 is
>>>>>> set to the saved ttbr by uaccess_ttbr0_enable. This is always
>>>>>> seen to happen in the exit path of the task.
>>>>>>
>>>>>> exception
>>>>>> __arch_copy_from_user
>>>>>> __copy_from_user
>>>>>> probe_kernel_read
>>>>>> get_freepointer_safe
>>>>>> slab_alloc_node
>>>>>> slab_alloc
>>>>>> kmem_cache_alloc
>>>>>> kmem_cache_zalloc
>>>>>> fill_pool
>>>>>> __debug_object_init
>>>>>> debug_object_init
>>>>>> rcuhead_fixup_activate
>>>>>> debug_object_fixup
>>>>>> debug_object_activate
>>>>>> debug_rcu_head_queue
>>>>>> __call_rcu
>>>>>> ep_remove
>>>>>> eventpoll_release_file
>>>>>> __fput
>>>>>> ____fput
>>>>>> task_work_run
>>>>>> do_exit
>>>>>>
>>>>>> The mm has been released and the pgd is freed, but probe_kernel_read
>>>>>> invoked from slub results in call to __arch_copy_from_user. At the
>>>>>> entry to __arch_copy_from_user, when SW PAN is enabled, this results
>>>>>> in stale value being set to ttbr0. May be a speculative fetch aftwerwards
>>>>>> is resulting in invalid physical address access.
>>>> I think the problem here is that switch_mm() avoids updating the saved ttbr
>>>> value when the next mm is init_mm.
>>> For this switch to happen, the schedule() in do_task_dead at the end
>>> of do_exit() need to be called, right ?  The issue is happening soon
>>> after exit_mm (probably from exit_files).
>> I'd assumed that we'd switch_mm() away from the task's mm prior to the
>> final mmput(). Otherwise, I can't see why we don't have issues in the
>> non SW PAN case (as that would leave the HW TTBR0 stale).
>>
>> However, I can't see exactly where we do that, so I'll go diggging.
>> Something doesn't seem quite right.
>>
>> Do you have a reproducer for the issue?
> I'd be very interested in that, or just more details about how this was
> observed. What was the workload? Kernel version? Hardware? .config? Do you
> know for sure that it was a page table walk that triggered the abort?
>
> In the report above, Vinayak claims that "The mm has been released and the
> pgd is freed" but that really shouldn't happen in the do_exit path. We free
> the other levels of page table in free_pgtables, but deliberately keep the
> mm and the pgd around until we've switched away in finish_task_switch.
>
> I'm quite prepared to believe that the ttbr0 stashing by the SW PAN code
> isn't bulletproof, but I'm struggling to see how the backtrace above
> can happen.
The issue was reported on 3.18 kernel. The hardware configuration is A53 octa core. The test which reproduces this
is a reboot test, which just boots up android and then reboots, and this is done in a loop. It may be reproducing
this problem? as reboot causes the tasks to be killed (do_exit). Its not very easy to reproduce the problem. "The issue
is not reproducible when CONFIG_ARM64_SW_TTBR0_PAN is disabled". What I have looked at is the coredumps
collected when the problem happens. The issue is that one of the cores tries to access a physical address which is
invalid. Interestingly there is no mapping for this physical address in page tables. And every time the issue happens,
the core which issues the wrong address is found to be in the path above, few instructions after the TTBR0 write
inside uaccess_ttbr0_enable (and rest of the callstack is also consistent, debug_object_init->kmem_cache_alloc->probe_kernel_read).
We are not sure it is a page table walk that resulted in this, that was just a guess, that a speculative access
would have caused a table walk with an invalid TTBR0. As per the coredumps, tsk->mm is made NULL. Rest was
assumption, that mm is released and pgd is freed. I assumed do_exit->exit_mmap->mmput->__mmdrop will do that.
But let me go and check if I can figure out from the dumps if that has really happened. I remember doing it but let me
confirm. Let me know if you want me to collect any other info from the dumps.

Thanks,
Vinayak
