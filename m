From: labbott@redhat.com (Laura Abbott)
Date: Fri, 13 Nov 2015 11:09:27 -0800
Subject: [PATCHv2 2/2] arm64: Allow changing of attributes outside of
 modules
In-Reply-To: <56459EED.4030109@huawei.com>
References: <1447207057-11323-1-git-send-email-labbott@fedoraproject.org>
 <1447207057-11323-3-git-send-email-labbott@fedoraproject.org>
 <56459EED.4030109@huawei.com>
Message-ID: <56463567.7050801@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 12:27 AM, Xishi Qiu wrote:
> On 2015/11/11 9:57, Laura Abbott wrote:
<snip>
>>   }
>>
>>   static int change_memory_common(unsigned long addr, int numpages,
>> @@ -43,7 +180,6 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	unsigned long size = PAGE_SIZE*numpages;
>>   	unsigned long end = start + size;
>>   	int ret;
>> -	struct page_change_data data;
>>
>>   	if (!PAGE_ALIGNED(addr)) {
>>   		start &= PAGE_MASK;
>> @@ -51,17 +187,15 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   		WARN_ON_ONCE(1);
>>   	}
>>
>> -	if (start < MODULES_VADDR || start >= MODULES_END)
>> +	if (start < PAGE_OFFSET && !is_vmalloc_addr((void *)start) &&
>> +		(start < MODULES_VADDR || start >= MODULES_END))
>
> How about abstracting "start < MODULES_VADDR || start >= MODULES_END" to a new function?
> e.g. is_module_addr(), however it is a little confusion with is_module_address().
>
>>   		return -EINVAL;
>>
>> -	if (end < MODULES_VADDR || end >= MODULES_END)
>> +	if (end < PAGE_OFFSET && !is_vmalloc_addr((void *)end) &&
>> +		(end < MODULES_VADDR || end >= MODULES_END))
>>   		return -EINVAL;
>>
>
> It will not filter this case, start in module range and end in vmalloc range, right?
> start and end should be both in one range.
>

The goal of this check was to prevent it from being used on userspace addresses. It's
very complicated and hard to understand. I'm going to give this some more thought about
a better way to do this check.

  
> Thanks,
> Xishi Qiu

Thanks,
Laura
