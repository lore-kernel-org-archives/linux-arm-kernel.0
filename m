From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 6 Aug 2018 15:22:28 +0530
Subject: [PATCH v7 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180803112455.GA13794@redhat.com>
References: <20180731035143.11942-1-ravi.bangoria@linux.ibm.com>
 <20180731035143.11942-4-ravi.bangoria@linux.ibm.com>
 <20180803112455.GA13794@redhat.com>
Message-ID: <bfb47985-8f58-e5e4-f8b4-695dfea7937f@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

Sorry for bit late reply.


On 08/03/2018 04:54 PM, Oleg Nesterov wrote:
> Hi Ravi,
> 
> I was going to give up and ack this series, but it seems I noticed
> a bug...
> 
> On 07/31, Ravi Bangoria wrote:
>>
>> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +	struct delayed_uprobe *du;
>> +
>> +	if (delayed_uprobe_check(uprobe, mm))
>> +		return 0;
>> +
>> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
>> +	if (!du)
>> +		return -ENOMEM;
>> +
>> +	du->uprobe = uprobe;
>> +	du->mm = mm;
> 
> I am surprised I didn't notice this before...
> 
> So
> 	du->mm = mm;
> 
> is fine, mm can't go away, uprobe_clear_state() does delayed_uprobe_remove(NULL,mm).
> 
> But
> 	du->uprobe = uprobe;
> 
> doesn't look right, uprobe can go away and it can be freed, its memory can be reused.
> We can't rely on remove_breakpoint(),


I'm sorry. I didn't get this. How can uprobe go away without calling
    uprobe_unregister()
    -> rergister_for_each_vma()
       -> remove_breakpoint()
And remove_breakpoint() will get called only when last uprobe consumer is going
away _for that mm_. So, we can rely on remove_breakpoint() to remove {uprobe,mm}
from delayed_uprobe_list. Am I missing anything? Or it would be even better if
you can tell me some example scenario.


> the application can unmap the probed page/vma.
> Yes we do not care about the application in this case, say, the next uprobe_mmap() can
> wrongly increment the counter, we do not care although this can lead to hard-to-debug
> problems. But, if nothing else, the kernel can crash if the freed memory is unmapped.
> So I think put_uprobe() should do delayed_uprobe_remove(uprobe, NULL) before kfree()
> and delayed_uprobe_remove() should be updated to handle the mm==NULL case.
> 
> Also. delayed_uprobe_add() should check the list and avoid duplicates. Otherwise the
> trivial
> 
> 	for (;;)
> 		munmap(mmap(uprobed_file));
> 
> will eat the memory until uprobe is unregistered.


I'm already calling delayed_uprobe_check(uprobe, mm) from delayed_uprobe_add().
So, we don't add same {uprobe,mm} multiple time in delayed_uprobe_list.

Is it the same check you are asking me to add or something else.


> 
> 
>> +static bool valid_ref_ctr_vma(struct uprobe *uprobe,
>> +			      struct vm_area_struct *vma)
>> +{
>> +	unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
>> +
>> +	return uprobe->ref_ctr_offset &&
>> +		vma->vm_file &&
>> +		file_inode(vma->vm_file) == uprobe->inode &&
>> +		vma->vm_flags & VM_WRITE &&
>> +		!(vma->vm_flags & VM_SHARED) &&
> 
> 		vma->vm_flags & (VM_WRITE|VM_SHARED) == VM_WRITE &&
> 
> looks a bit better to me, but I won't insist.

Sure. I'll change it.

> 
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
>> +		if (!valid_ref_ctr_vma(du->uprobe, vma))
>> +			continue;
>> +
>> +		vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
>> +		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
>> +		/* Record an error and continue. */
>> +		err = ret & !err ? ret : err;
> 
> I try to avoid the cosmetic nits, but I simply can't look at this line ;)
> 
> 		if (ret && !err)
> 			err = ret;

This is neat. Will replace it.

> 
>> @@ -1072,7 +1281,14 @@ int uprobe_mmap(struct vm_area_struct *vma)
>>  	struct uprobe *uprobe, *u;
>>  	struct inode *inode;
>>
>> -	if (no_uprobe_events() || !valid_vma(vma, true))
>> +	if (no_uprobe_events())
>> +		return 0;
>> +
>> +	if (vma->vm_flags & VM_WRITE &&
>> +	    test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
>> +		delayed_uprobe_install(vma);
> 
> OK, so you also added the VM_WRITE check and I agree. But then I think we
> should also check VM_SHARED, just like valid_ref_ctr_vma() does?

Right. I'll add a check here.

Thanks for reviewing :)
