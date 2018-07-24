From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 24 Jul 2018 09:04:47 +0530
Subject: [PATCH v6 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180723162629.GA8584@redhat.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
 <20180723162629.GA8584@redhat.com>
Message-ID: <e722ee62-eaba-3abd-7f34-bf38ba3d4f95@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 07/23/2018 09:56 PM, Oleg Nesterov wrote:
> I have a mixed feeling about this series... I'll try to summarise my thinking
> tomorrow, but I do not see any obvious problem so far. Although I have some
> concerns about 5/6, I need to re-read it after sleep.

Sure.

> 
> 
> On 07/16, Ravi Bangoria wrote:
>>
>> +static int delayed_uprobe_install(struct vm_area_struct *vma)
>> +{
>> +	struct list_head *pos, *q;
>> +	struct delayed_uprobe *du;
>> +	unsigned long vaddr;
>> +	int ret = 0, err = 0;
>> +
>> +	mutex_lock(&delayed_uprobe_lock);
>> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +		du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +		if (!du->uprobe->ref_ctr_offset ||
> 
> Is it possible to see ->ref_ctr_offset == 0 in delayed_uprobe_list?

I'll remove this check.

> 
>> @@ -1072,7 +1282,13 @@ int uprobe_mmap(struct vm_area_struct *vma)
>>  	struct uprobe *uprobe, *u;
>>  	struct inode *inode;
>>  
>> -	if (no_uprobe_events() || !valid_vma(vma, true))
>> +	if (no_uprobe_events())
>> +		return 0;
>> +
>> +	if (vma->vm_flags & VM_WRITE)
>> +		delayed_uprobe_install(vma);
> 
> Obviously not nice performance-wise... OK, I do not know if it will actually
> hurt in practice and probably we can use the better data structures if necessary.
> But can't we check MMF_HAS_UPROBES at least? I mean,
> 
> 	if (vma->vm_flags & VM_WRITE && test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
> 		delayed_uprobe_install(vma);
> 
> ?

Yes.

> 
> 
> Perhaps we can even add another flag later, MMF_HAS_DELAYED_UPROBES set by
> delayed_uprobe_add().

Yes, good idea.

Thanks for the review,
Ravi
