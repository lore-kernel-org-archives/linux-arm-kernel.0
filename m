From: qiuxishi@huawei.com (Xishi Qiu)
Date: Thu, 5 Nov 2015 19:10:58 +0800
Subject: [PATCH 2/2] arm64: Allow changing of attributes outside of modules
In-Reply-To: <563A4A74.60900@redhat.com>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <1446587315-18145-3-git-send-email-labbott@fedoraproject.org>
 <563974A8.3060306@huawei.com> <563A4A74.60900@redhat.com>
Message-ID: <563B3942.90305@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/5 2:12, Laura Abbott wrote:

> On 11/03/2015 06:59 PM, zhong jiang wrote:
>>
>> Hi Laura
>>
>> This patch seems vaild, but I didn't feel very reasonable.
>> Because of the large page to make TLB performance better, just
>> split it if it is necessary.therefore, I think the first thing
>> we try to keep it, if they fail ,and then to split.
>>
> 
> I'm not quite sure I understand the request. We know we are going
> to have to have something mapped at page size granularity so we
> are going to have to break down the larger mappings no matter
> what. Can you explain a bit more where you think we could try to
> keep the larger mappings?
> 

Hi Laura,

He means like this, if the range is aligned with large page, we
need not to split it, just change the flag.

I have one more question.

alloc_init_pud()
	...
	if (!pud_none(old_pud))
		...
		memblock_free(table, PAGE_SIZE);
		...

Here we will free the memory from pmd page, so why not free
more memory from 512 pte pages, if the 512 old pmds are not none?

Thanks,
Xishi Qiu

> At least two things I noticed looking at this again though:
> - This only splits the start address. If the range happens
> to overlap a pud/pmd this won't work. I'll address that in v2
> - We're always flushing the TLB even if nothing changed. Was
> this what you were referring to?
> 
>  
>> thanks
>> zhongjiang
>>
>>
> 
> Thanks,
> Laura
> 
> 
> .
> 
