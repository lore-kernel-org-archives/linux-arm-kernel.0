From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Wed, 25 Apr 2018 09:18:15 -0600
Subject: arm64: W+X mapping check failures
In-Reply-To: <20180425145050.GB18651@hc>
References: <20180425133704.GA6474@hc>
 <f3945f76-04ae-1823-a4bd-85af883f152f@codeaurora.org>
 <20180425145050.GB18651@hc>
Message-ID: <eee7b68f-b6fd-3031-e733-0051a6cec360@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2018 8:50 AM, Jan Glauber wrote:
> On Wed, Apr 25, 2018 at 07:55:20AM -0600, Jeffrey Hugo wrote:
>> Hi Jan,
>>
>> On 4/25/2018 7:37 AM, Jan Glauber wrote:
>>> Hi all,
>>>
>>> enabling CONFIG_DEBUG_WX we see insecure mappings reported across various kernel
>>> versions and machines. I've not yet seen this with upstream but that doesn't
>>> mean much as the issue is a race and I cannot trigger it reliably.
>>>
>>> The reported W+X mappings are gone after the boot is finished. The addresses
>>> all belong to .init.* sections of the first loaded kernel modules.
>>>
>>> Example log (I changed the warnings as I found the backtrace quite useless):
>>>
>>> [   39.157884] Freeing unused kernel memory: 5248K
>>> [   39.167997] note_prot_wx: Found insecure W+X mapping at start: ffff000000ab9000  addr: ffff000000abd000  pages: 4
>>> [   39.178246] note_prot_wx: Found insecure W+X mapping at start: ffff000000ac3000  addr: ffff000000ac5000  pages: 2
>>> [   39.188495] note_prot_wx: Found insecure W+X mapping at start: ffff000000acd000  addr: ffff000000ad0000  pages: 3
>>> [   39.198745] note_prot_wx: Found insecure W+X mapping at start: ffff000000af9000  addr: ffff000000afc000  pages: 3
>>> [   39.212981] Checked W+X mappings: FAILED, 12 W+X pages found, 0 non-UXN pages found
>>>
>>> I think this is a race between module loading and the ptdump_check_wx().
>>> The RCU'd do_free_init() can be delayed _after_ ptdump_check_wx() for a coming module.
>>>
>>> I tried using stop_machine() around the memory check similar to arm but that does not
>>> solve the race. It is not a critical issue as the .init sections are freed afterwards
>>> anyway but still the warning is a bit misleading.
>>>
>>> Any thoughts?
>>>
>>> --Jan
>>
>> You are correct.  It appears you have independently found the issue
>> I was about to send a fix for.
>>
>> I have a setup that can repro this 100% of the time, and have
>> confirmed there is a race between ptdump_check_wx() and
>> do_free_init().
> 
> How did you manage to hit this every time? Just wondering...

SW based system simulator that is basically singlethreaded.  If the 
simulator hits a race condition, it hits it every time.

On hardware (QDF2400), I have to put several devices into a reboot loop 
and wait 12+ hours for single repro.  Usually ends up being 2000+ 
reboots combined.

>> My fix is to put rcu_barrier_sched() just before the call to
>> ptdump_check_wx().  This "flushes" the queued work, ensuring it runs
>> to completion before ptdump_check_wx().
> 
> Looks good to me, I tried synchronize_sched() which did not help but
> I should have read the documentation first.

Yep.  I thought of using synchronize_sched() based on the comment from 
do_init_module() until I went and scrutinized the documentation in the 
RCU header.

> 
>> In my testing, it works, however this fix does not prevent
>> additional load_module() invocations from being triggered, and
>> recreating the race condition.  From my debugging, it appears this
>> might not be an issue in practice, as it looks like all modules that
>> are expected to be loaded in that phase of boot are loaded before
>> ptdump_check_wx() is called.
> 
> Yes, the race would still be there. We would need some combination of
> stop_machine and the rcu barrier but I guess calling rcu_barrier_sched()
> inside stop_machine would be a very very bad idea.
> 

Yeah, that sounds like a horrible idea to me, but I'm certainly not an 
expert.

>> The other alternative would be to remove the use of PAGE_KERNEL_EXEC
>> from module_alloc(), but based on the effort to clean that up
>> afterward in the module loading process, I suspect that is not
>> viable.
>>


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
