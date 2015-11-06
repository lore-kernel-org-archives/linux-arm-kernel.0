From: labbott@redhat.com (Laura Abbott)
Date: Thu, 5 Nov 2015 17:11:21 -0800
Subject: [PATCH 2/2] arm64: Allow changing of attributes outside of modules
In-Reply-To: <563B3942.90305@huawei.com>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <1446587315-18145-3-git-send-email-labbott@fedoraproject.org>
 <563974A8.3060306@huawei.com> <563A4A74.60900@redhat.com>
 <563B3942.90305@huawei.com>
Message-ID: <563BFE39.4050700@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2015 03:10 AM, Xishi Qiu wrote:
> On 2015/11/5 2:12, Laura Abbott wrote:
>
>> On 11/03/2015 06:59 PM, zhong jiang wrote:
>>>
>>> Hi Laura
>>>
>>> This patch seems vaild, but I didn't feel very reasonable.
>>> Because of the large page to make TLB performance better, just
>>> split it if it is necessary.therefore, I think the first thing
>>> we try to keep it, if they fail ,and then to split.
>>>
>>
>> I'm not quite sure I understand the request. We know we are going
>> to have to have something mapped at page size granularity so we
>> are going to have to break down the larger mappings no matter
>> what. Can you explain a bit more where you think we could try to
>> keep the larger mappings?
>>
>
> Hi Laura,
>
> He means like this, if the range is aligned with large page, we
> need not to split it, just change the flag.
>

This complicates the logic for doing the update. Apply to page range
nicely walks across all the 4K pages and does the update. It looks
like x86 does the check to keep the large pages though so I'll
give it some thought.

> I have one more question.
>
> alloc_init_pud()
> 	...
> 	if (!pud_none(old_pud))
> 		...
> 		memblock_free(table, PAGE_SIZE);
> 		...
>
> Here we will free the memory from pmd page, so why not free
> more memory from 512 pte pages, if the 512 old pmds are not none?
>

It would be nice to reclaim the memory but I'm not sure if that will
work. The memory was allocated before any of the regular kernel data
structures were set up. It's not clear if giving the pages back to
the buddy allocator would actually work. I'll take a look though.
  
> Thanks,
> Xishi Qiu
>

Thanks,
Laura
