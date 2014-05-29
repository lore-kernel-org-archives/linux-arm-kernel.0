From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 28 May 2014 19:02:18 -0700
Subject: [PATCH v6 4/4] add 2nd stage page fault handling during live
 migration
In-Reply-To: <53862DF8.80709@samsung.com>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-5-git-send-email-m.smarduch@samsung.com>
 <20140527201945.GD16428@lvm> <53853C2F.8080003@samsung.com>
 <20140528080957.GH16428@lvm> <5386232A.3050602@samsung.com>
 <53862DF8.80709@samsung.com>
Message-ID: <5386952A.50201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Little bit more details on this question -

For 2nd stage 3-level tables PUD blocks don't exist - although
it appears you can have a PGD block but I don't see any
support for that. But should the code still work as if PUDs
(4-level table) are used and check for pud_huge()?

Looking at ARMv8 there are several block formats, I don't know which one
will be use for 2nd stage (4KB, 16,...) but one of them supports 4-level
table (have not looked at this in detail, could be wrong here).

Should pud_huge() be supported for future compatibility?

This impacts logging -
 - Some decisions are needed either clear the PUD entry and
   force them to pages or mark dirty bit map for each 4k page
   in the PUD Block range, IA64 appears to that in mark_pages_dirty().

 - If you assume pud_huge() then you probably have to support
   the logic for PUD Block descriptor even though
   it's not used in 3-level table at this time.

I think until PUD Blocks are actually used it's maybe better to
ignore them.

- Mario



On 05/28/2014 11:42 AM, Mario Smarduch wrote:
> 
>> emslot dirty_bitmap during and after write protect.
>>
>>>
>>> -Christoffer
> 
> Regarding huge pud that's causing some design problems, should huge PUD
> pages be considered at all?
> 
> Thanks,
>   Mario
>>>
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
