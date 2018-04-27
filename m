From: labbott@redhat.com (Laura Abbott)
Date: Fri, 27 Apr 2018 12:30:47 -0700
Subject: [PATCH] arm64: mm: Fix false positives in W+X checking
In-Reply-To: <20180425163745.GJ8383@arm.com>
References: <1524665611-14040-1-git-send-email-jhugo@codeaurora.org>
 <20180425150353.GG8383@arm.com>
 <381aee7b-9caa-b16b-3f5e-a47737405c03@codeaurora.org>
 <CAGXu5j+WhNdY09s_tPQ-BKqEqi_bbbp8XnRSnoGTN-HOPSJFPQ@mail.gmail.com>
 <3a105d2c-19b8-11fc-88d3-2da4fa846296@codeaurora.org>
 <20180425163745.GJ8383@arm.com>
Message-ID: <d4ca1cff-0975-983d-b587-e4c65fc5c3c7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2018 09:37 AM, Will Deacon wrote:
> On Wed, Apr 25, 2018 at 10:36:25AM -0600, Jeffrey Hugo wrote:
>> On 4/25/2018 10:23 AM, Kees Cook wrote:
>>> On Wed, Apr 25, 2018 at 8:12 AM, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>>>> On 4/25/2018 9:03 AM, Will Deacon wrote:
>>>>> On Wed, Apr 25, 2018 at 08:13:31AM -0600, Jeffrey Hugo wrote:
>>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>>> index 2dbb2c9..40d45fd 100644
>>>>>> --- a/arch/arm64/mm/mmu.c
>>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>>> @@ -503,6 +503,12 @@ void mark_rodata_ro(void)
>>>>>>          update_mapping_prot(__pa_symbol(__start_rodata), (unsigned
>>>>>> long)__start_rodata,
>>>>>>                              section_size, PAGE_KERNEL_RO);
>>>>>>    +     /*
>>>>>> +        * load_module() results in W+X mappings, which are cleaned up
>>>>>> with
>>>>>> +        * call_rcu_sched().  Let's make sure that queued work is flushed
>>>>>> so
>>>>>> +        * that we don't hit false positives.
>>>>>> +        */
>>>>>> +       rcu_barrier_sched();
>>>>>>          debug_checkwx();
>>>>>>    }
>>>>>
>>>>>
>>>>> Whilst this looks correct to me, it looks to me like other architectures
>>>>> (e.g. x86) would be affected by this problem as well. Perhaps it would be
>>>>> better to solve it in the core code before invoking mark_rodata_ro, or is
>>>>> there some reason that we only run into this on arm64?
>>>>>
>>>>
>>>> Thanks for the review.
>>>>
>>>> I was actually pondering pushing this into ptdump_check_wx() so that the
>>>> "barrier" hit is only observed with CONFIG_DEBUG_WX.
>>>>
>>>> I agree, in principal this is not an arm64 specific issue.  I do not have
>>>> sufficient equipment to validate other architectures.  On QDF2400, the
>>>> reproduction rate is very low, roughly 1-3 instances in 2000-3000 reboots.
>>>> I do have a system simulator which happens to repro the issue 100% of the
>>>> time, which is what I used to debug and test this fix, before applying it to
>>>> QDF2400.
>>>>
>>>> I'm waffling.  I see the benefit of fixing this in common code, but the
>>>> "core" functionality of mark_rodata_ro doesn't need this barrier...
>>>>
>>>> I suppose I can push it up to core code, and see what the rest of the
>>>> community says.  Is that what you recommend?
>>>
>>> I think fixing this in the general case makes sense.
>>
>> Ok.  I'll give it until Monday to see if Laura has any insights into x86,
>> and then spin a v2.
> 
> Thanks, Jeffrey.
> 
> Will
> 

I set up some test code that does request_module in a late_initcall
and stuck a delay and print in do_free_init and triggered it:

[    6.115319]  ? module_memfree+0x10/0x10
[    6.116082]  rcu_process_callbacks+0x1bd/0x7f0
[    6.116895]  __do_softirq+0xd9/0x2af
[    6.117588]  irq_exit+0xa9/0xb0
[    6.118193]  smp_apic_timer_interrupt+0x67/0x120
[    6.118993]  apic_timer_interrupt+0xf/0x20
[    6.119732]  </IRQ>
[    6.120265] RIP: 0010:__change_page_attr_set_clr+0x667/0xc80
[    6.121363] RSP: 0018:ffffc90000197c60 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[    6.123417] RAX: 00000000000001e8 RBX: 80000000000000e3 RCX: ffffffff81c031d1
[    6.124677] RDX: 0000000000000000 RSI: ffffc90000197dd8 RDI: 80000000028000e3
[    6.125905] RBP: ffff8800029e7000 R08: 00000000ffffd801 R09: 000ffffffffff000
[    6.127114] R10: 0000000000000001 R11: 000ffffffffff000 R12: 80000000000000e3
[    6.128350] R13: 00000000000029e7 R14: 0000000000000200 R15: 80000000000000e3
[    6.129522]  ? __alloc_pages_nodemask+0xfc/0x220
[    6.130218]  ? smp_call_function_many+0x1e7/0x230
[    6.130935]  ? load_new_mm_cr3+0xe0/0xe0
[    6.131566]  __change_page_attr_set_clr+0xc59/0xc80
[    6.132293]  ? cpumask_next+0x16/0x20
[    6.132894]  change_page_attr_set_clr+0x131/0x470
[    6.133601]  set_memory_rw+0x21/0x30
[    6.134172]  free_init_pages+0x59/0x80
[    6.134766]  ? rest_init+0xb0/0xb0
[    6.135322]  kernel_init+0x14/0x100
[    6.135885]  ret_from_fork+0x35/0x40

This is part way through mark_rodata_ro which does the debug_checkwx()
so I think it could still be an issue on x86. The set_memory_* functions
on x86 are a bit more involved than arm64 and may provide more
opportunities for the rcu callbacks to run. I'm guessing arm64 may just
be loading modules that could be particularly likely to load other
modules.

So if you're willing to take some of my hand waving, I think this
should go in generic code since this is difficult to reproduce.

Thanks,
Laura
