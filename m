From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 30 Apr 2018 14:49:44 -0600
Subject: [PATCH v3] init: Fix false positives in W+X checking
In-Reply-To: <CAGXu5jJFjH4hiRqovOtaMOuKUQbGYWjBiGGDV-bjWSmTvZp9Pw@mail.gmail.com>
References: <1525103946-29526-1-git-send-email-jhugo@codeaurora.org>
 <e87810b2-db26-ee13-731a-cde53185e977@redhat.com>
 <CAGXu5jJFjH4hiRqovOtaMOuKUQbGYWjBiGGDV-bjWSmTvZp9Pw@mail.gmail.com>
Message-ID: <2fd6b503-17b9-4e4c-e3ea-44eb34d209e9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/30/2018 12:40 PM, Kees Cook wrote:
> On Mon, Apr 30, 2018 at 10:19 AM, Laura Abbott <labbott@redhat.com> wrote:
>> On 04/30/2018 08:59 AM, Jeffrey Hugo wrote:
>>>
>>> load_module() creates W+X mappings via __vmalloc_node_range() (from
>>> layout_and_allocate()->move_module()->module_alloc()) by using
>>> PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
>>> "call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().
>>>
>>> This is a problem because call_rcu_sched() queues work, which can be run
>>> after debug_checkwx() is run, resulting in a race condition.  If hit, the
>>> race results in a nasty splat about insecure W+X mappings, which results
>>> in a poor user experience as these are not the mappings that
>>> debug_checkwx() is intended to catch.
>>>
>>> This issue is observed on multiple arm64 platforms, and has been
>>> artificially triggered on an x86 platform.
>>>
>>> Address the race by flushing the queued work before running the
>>> arch-defined mark_rodata_ro() which then calls debug_checkwx().
>>>
>>> Reported-by: Timur Tabi <timur@codeaurora.org>
>>> Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
>>> Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>> Acked-by: Kees Cook <keescook@chromium.org>
>>> Acked-by: Ingo Molnar <mingo@kernel.org>
>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>> ---
>>>
>>
>> Acked-by: Laura Abbott <labbott@redhat.com>
>>
>> If you don't have a tree for this to go through, I might suggest having
>> Kees take it.
> 
> akpm has taken the W^X stuff in the past, but I'm happy to do so. Just
> let me know either way. :)
> 
> -Kees
> 

That sounds fine to me.  Is that agreeable to you, Andrew?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
