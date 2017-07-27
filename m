From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Jul 2017 08:44:47 +0100
Subject: ARM64 board Hikey960 boot failure due to f2545b2d4ce1
 (jump_label: Reorder hotplug lock and jump_label_lock)
In-Reply-To: <20170727020830.GG2902@leoy-ThinkPad-T440>
References: <20170724143417.GA12788@leoy-ThinkPad-T440>
 <7e5cfa7c-b7a0-12bc-dad6-4355f23b5f21@arm.com>
 <20170727020830.GG2902@leoy-ThinkPad-T440>
Message-ID: <496ddcf6-329d-3809-1837-841752bec256@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/17 03:08, Leo Yan wrote:
> On Wed, Jul 26, 2017 at 04:13:49PM +0100, Marc Zyngier wrote:
>> [+Mark]
>>
>> Hi Leo,
>>
>> On 24/07/17 15:34, Leo Yan wrote:
>>> Hi all,
>>>
>>> We found the mainline arm64 kernel boot failure on Hikey960 board,
>>> this is caused by patch f2545b2d4ce1 (jump_label: Reorder hotplug lock
>>> and jump_label_lock), this patch adds locking cpus_read_lock() in
>>> function static_key_slow_inc() and introduce the dead lock issue by
>>> acquiring lock twice. Below are detailed flow:
>>>
>>> arch_timer_register()
>>>  `> cpuhp_setup_state()
>>>      `> __cpuhp_setup_state()
>>>         cpus_read_lock()
>>>          `> __cpuhp_setup_state_cpuslocked()
>>>              `> cpuhp_issue_call()
>>>                  `> arch_timer_starting_cpu()
>>>                      `> __arch_timer_setup()
>>>                          `> arch_timer_check_ool_workaround()
>>>                              `> arch_timer_enable_workaround()
>>>                                  `> static_branch_enable()
>>>                                      `> static_key_enable()
>>>                                          `> static_key_slow_inc()
>>>                                              `> cpus_read_lock()
>>>
>>> So finally there have called cpus_read_lock() twice, and kernel report
>>> log as below. So I am not sure what's the best way to fix this issue,
>>> could you give some suggestion for this? Thanks.
>>
>> [...]
>>
>> Thanks for this. Unfortunately, there is no easy fix for this.
>> Can you give the patch below a go and let us know if that solves
>> the issue you observed? I only tested in on a model...
>>
>> Should this be considered an acceptable solution, I'll split that
>> into individual patches and repost it as a proper series.
> 
> Thanks, Marc.
> 
> I confirm below patch can fix the booting failure issue on Hikey960;
> after generate formal patch set, also welcome to send me for testing.

Thanks for testing this. There is a couple of issues in this patch 
which I'm ironing out at the moment.

It turns out that the above call stack is only one part of the problem. 
The other part is on the secondary boot path, where the CPU is not yet 
in a context where we can take the rwsem:

[    1.151153] [<ffff000008089de8>] dump_backtrace+0x0/0x278
[    1.151153] [<ffff00000808a144>] show_stack+0x24/0x30
[    1.151153] [<ffff000008c22d8c>] dump_stack+0x8c/0xb0
[    1.151253] [<ffff000008106010>] dequeue_task_idle+0x30/0x48
[    1.151253] [<ffff0000080fed80>] deactivate_task+0xa8/0xf0
[    1.151384] [<ffff000008c3935c>] __schedule+0x41c/0x8e0
[    1.151432] [<ffff000008c39854>] schedule+0x34/0x98
[    1.151466] [<ffff000008c3cd5c>] rwsem_down_read_failed+0xcc/0x110
[    1.151466] [<ffff0000081249c4>] __percpu_down_read+0xe4/0x110
[    1.151573] [<ffff0000080d33b8>] cpus_read_lock+0x70/0xa0
[    1.151630] [<ffff0000081de864>] static_key_slow_inc_with_lock+0x14c/0x150
[    1.151679] [<ffff0000081de8a4>] static_key_enable_with_lock+0x3c/0x58
[    1.151753] [<ffff0000081de8e4>] static_key_enable+0x24/0x30
[    1.151794] [<ffff000008a59364>] arch_timer_check_ool_workaround+0x204/0x248
[    1.151853] [<ffff000008a596f8>] arch_timer_starting_cpu+0xe0/0x2b0
[    1.151893] [<ffff0000080d2828>] cpuhp_invoke_callback+0x98/0x5c8
[    1.151958] [<ffff0000080d4af8>] notify_cpu_starting+0x78/0x98
[    1.152006] [<ffff000008090810>] secondary_start_kernel+0xb8/0x120
[    1.152040] [<0000000080c441b4>] 0x80c441b4

I'll cc you on the updated patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
