From: ankijain@codeaurora.org (ankijain at codeaurora.org)
Date: Mon, 11 Sep 2017 08:44:36 +0530
Subject: Page fault while link_path_walk for path_len > 4060 bytes
In-Reply-To: <c4256a77288fd5f275a45bc73c9c78f0@codeaurora.org>
References: <08e7e3332dc86c535dd2961ac1cde0b5@codeaurora.org>
 <54083a824d6705a93d972ca5ef3a7b35@codeaurora.org>
 <3958983ccec4aca494bf72c397f34bfa@codeaurora.org>
 <953068e79da559bfd4f13e46e31c5a4e@codeaurora.org>
 <20170822125747.GB28024@arm.com>
 <b13b3a27e92c5413d168ad775163ea91@codeaurora.org>
 <20170828062050.GI5426@ZenIV.linux.org.uk>
 <c4256a77288fd5f275a45bc73c9c78f0@codeaurora.org>
Message-ID: <76820799214784dde3506e32901c3455@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al Viro

Could you please reply on below query.

Are below error messages pointing to an issue which we can face later if 
we remove force panic?
http://elixir.free-electrons.com/linux/v4.4.76/source/kernel/sched/core.c#L7605
http://elixir.free-electrons.com/linux/v4.4.76/source/kernel/sched/core.c#L7608

Regards,
Ankit Jain

On 2017-08-30 22:49, ankijain at codeaurora.org wrote:
> Hi Al Viro
> 
> Thanks for replying.
> 
> We are using AOSP project tree.
> You can refer http://elixir.free-electrons.com/linux/v4.4.76/source.
> 
> http://elixir.free-electrons.com/linux/v4.4.76/source/arch/arm64/mm/fault.c#L302
>   (might_sleep())
> 
> http://elixir.free-electrons.com/linux/v4.4.76/source/kernel/sched/core.c#L7592
>  (___might_sleep())
> 
> Panic is added forcefully in our code after
> http://elixir.free-electrons.com/linux/v4.4.76/source/kernel/sched/core.c#L7625
> .
> 
> we have a query:
> Are below error messages pointing to an issue which we can face later
> if we remove force panic?
> http://elixir.free-electrons.com/linux/v4.4.76/source/kernel/sched/core.c#L7605
> http://elixir.free-electrons.com/linux/v4.4.76/source/kernel/sched/core.c#L7608
> 
> 
> we will retest after removing the force panic and update you if any
> issue occurs.
> config file is attached.
> 
> Regards,
> Ankit Jain
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation
> Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
> 
> On 2017-08-28 11:50, Al Viro wrote:
>> On Mon, Aug 28, 2017 at 09:53:00AM +0530, ankijain at codeaurora.org 
>> wrote:
>>> Hi Will Deacon/ Al viro
>>> 
>>> 
>>> -->Please find the attached kmsg.txt
>>> <3>[17620.275249] BUG: sleeping function called from invalid context 
>>> at 
>>> /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/arch/arm64/mm/fault.c:313
>>> <3>[17620.276504] in_atomic(): 0, irqs_disabled(): 0, pid: 10290, 
>>> name:
>>> stress-ng-dirde
>>> <6>[17620.298995] ------------[ cut here ]------------
>>> <2>[17620.299009] kernel BUG at 
>>> /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/kernel/sched/core.c:8528!
>>> <6>[17620.306372] ------------[ cut here ]------------
>>> <2>[17620.327239] kernel BUG at 
>>> /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/kernel/sched/core.c:8528!
>>> 
>>> 
>>> --> we are using arm64 machine with kernel 4.4.
>>> --> can you please guide us, how to capture ESR value while taking 
>>> the
>>> fault?
>>> -->
>>> -    { do_page_fault,    SIGSEGV, SEGV_MAPERR,    "level 3 
>>> translation
>>> fault"    },
>>> +    { do_translation_fault,    SIGSEGV, SEGV_MAPERR,    "level 3
>>> translation fault"    },
>>> we will try with above changes and get back to you.
>>> 
>>> -> config and kmsg are attached.
>>> 
>>> Regards,
>>> Ankit Jain
>>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>>> Center, Inc.
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
>>> Linux Foundation Collaborative Project
>> 
>> Umm...  Line numbers make no sense for 4.4.  Could you post a 
>> reference
>> to the actual tree used (repository + SHA1; again, it can't be vanilla
>> 4.4, or stable/linux-4.4.y, for that matter) as well as your .config?
>> 
>> In any case, looks like in_atomic() is false there, so we need an 
>> explicit
>> pagefault_disable() to make sure it goes to no_context.
>> 
>> Looking through the callchains...
>> 	* __d_lookup() -> d_same_name() -> dentry_cmp() -> 
>> dentry_string_cmp()
>> with rcu_read_lock() held by __d_lookup().
>> 	* d_alloc_parallel() -> d_same_name(), etc.  rcu_read_lock() held by
>> d_alloc_parallel() in one case, dentry->d_lock in another.
>> 	* d_exact_alias() -> d_same_name().  inode->i_lock held by 
>> d_exact_alias().
>> 	* d_alloc_parallel() -> __d_lookup_rcu() -> dentry_cmp().
>> rcu_read_lock() held by d_alloc_parallel().
>> 	* lookup_fast() -> __d_lookup_rcu(), etc.  rcu_read_lock() grabbed by
>> path_init().
>> 	* full_name_hash().  Fuckloads.
>> 	* hashlen_string().  Fewer, but...
>> 	* link_path_walk() -> hash_name().  rcu_read_lock() held by 
>> path_init().
>> 
>> And then there's siphash(), but that one AFAICS should never see those 
>> faults.
>> 
>> Hell knows...  I'm somewhat tempted to slap
>> pagefault_disable()/pagefault_enable()
>> in dentry_string_cmp(), full_name_hash(), hashlen_string() and 
>> hash_name().
>> Regardless of the locks held by callers.  Doing that in 
>> load_unaligned_zeropad()
>> itself would be ridiculously costly, but these 4 would probably be 
>> saner...
>> 
>> I still would like to see the details of config, though.
