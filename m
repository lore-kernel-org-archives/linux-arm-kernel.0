From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 28 Jun 2018 15:50:40 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <20180627132826.GB30631@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com> <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com>
Message-ID: <5B34F5C0.9090001@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2018/6/27 14:28, Will Deacon wrote:
> On Wed, Jun 27, 2018 at 02:22:03PM +0100, Wei Xu wrote:
>> On 2018/6/26 18:47, Will Deacon wrote:
>>> If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
>>> replacing:
>>>
>>> 	dc      civac, cur_\()\type\()p
>>>
>>> with:
>>>
>>> 	dc      ivac, cur_\()\type\()p
>>>
>>> please? Only do this for the guest kernel, not the host. KVM will upgrade
>>> the clean to a clean+invalidate, so it's interesting to see if this has
>>> an effect on the behaviour.
>>
>> Only changed the guest kernel, the guest still failed to boot and the log
>> is same with the last mail.
>>
>> But if I changed to cvac as below for the guest, it is kind of stable.
>> 	dc      cvac, cur_\()\type\()p
>>
>> I have synced with our SoC guys about this and hope we can find the reason.
>> Do you have any more suggestion?
> 
> Unfortunately, not. It looks like somehow clean+invalidate is behaving
> just as an invalidate, and we're corrupting the page table as a result.
> 
> Hopefully the SoC guys will figure it out.

After replaced the dmb with dsb in both __idmap_kpti_get_pgtable_ent and
__idmap_kpti_put_pgtable_ent_ng, we tested 20 times and we can not reproduce
the issue.
Today we will continue to do the stress testing and will update the result tomorrow.

The dsb in __idmap_kpti_get_pgtable_ent is to make sure the dc has been done and
the following ldr can get the latest data.

The dsb in __idmap_kpti_put_pgtable_ent_ng is to make sure the str will be done
before dc. Although dmb can guarantee the order of the str and dc on the L2 cache,
dmb can not guarantee the order on the bus.

How do you think about it?
Thanks!

----

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 03646e6..bb767ea 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -209,7 +209,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)

        .macro  __idmap_kpti_get_pgtable_ent, type
        dc      cvac, cur_\()\type\()p          // Ensure any existing dirty
-       dmb     sy                              // lines are written back before
+       dsb     sy                              // lines are written back before
        ldr     \type, [cur_\()\type\()p]       // loading the entry
        tbz     \type, #0, skip_\()\type        // Skip invalid and
        tbnz    \type, #11, skip_\()\type       // non-global entries
@@ -218,8 +218,9 @@ ENDPROC(idmap_cpu_replace_ttbr1)
        .macro __idmap_kpti_put_pgtable_ent_ng, type
        orr     \type, \type, #PTE_NG           // Same bit for blocks and pages
        str     \type, [cur_\()\type\()p]       // Update the entry and ensure
-       dmb     sy                              // that it is visible to all
+       dsb     sy                              // that it is visible to all
        dc      civac, cur_\()\type\()p         // CPUs. 	


Best Regards,
Wei

> 
> Will
> 
> .
> 
