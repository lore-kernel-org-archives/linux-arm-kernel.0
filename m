From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Fri, 27 Jul 2018 09:47:23 +0530
Subject: [PATCH v6 5/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
In-Reply-To: <20180725110802.GA27325@redhat.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
 <20180725110802.GA27325@redhat.com>
Message-ID: <19d8abb0-44a3-cb26-405d-95f63fc01517@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 07/25/2018 04:38 PM, Oleg Nesterov wrote:
> No, I can't understand this patch...
> 
> On 07/16, Ravi Bangoria wrote:
>>
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -63,6 +63,8 @@ static struct percpu_rw_semaphore dup_mmap_sem;
>>
>>  /* Have a copy of original instruction */
>>  #define UPROBE_COPY_INSN	0
>> +/* Reference counter offset is reloaded with non-zero value. */
>> +#define REF_CTR_OFF_RELOADED	1
>>
>>  struct uprobe {
>>  	struct rb_node		rb_node;	/* node in the rb tree */
>> @@ -476,9 +478,23 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>  		return ret;
>>
>>  	ret = verify_opcode(old_page, vaddr, &opcode);
>> -	if (ret <= 0)
>> +	if (ret < 0)
>>  		goto put_old;
> 
> I agree, "ret <= 0" wasn't nice even before this change, but "ret < 0" looks
> worse because this is simply not possible.


Ok. Any better idea?
I think if we don't track all mms patched by uprobe, we have to rely
on current instruction.


> 
>> +	/*
>> +	 * If instruction is already patched but reference counter offset
>> +	 * has been reloaded to non-zero value, increment the reference
>> +	 * counter and return.
>> +	 */
>> +	if (ret == 0) {
>> +		if (is_register &&
>> +		    test_bit(REF_CTR_OFF_RELOADED, &uprobe->flags)) {
>> +			WARN_ON(!uprobe->ref_ctr_offset);
>> +			ret = update_ref_ctr(uprobe, mm, true);
>> +		}
>> +		goto put_old;
>> +	}
> 
> So we need to force update_ref_ctr(true) in case when uprobe_register_refctr()
> detects the already registered uprobe with ref_ctr_offset == 0, and then it calls
> register_for_each_vma().
> 
> Why this can't race with uprobe_mmap() ?
> 
> uprobe_mmap() can do install_breakpoint() right after REF_CTR_OFF_RELOADED was set,
> then register_for_each_vma() will find this vma and do install_breakpoint() too.
> If ref_ctr_vma was already mmaped, the counter will be incremented twice, no?


Hmm right. Probably, I can fix this race by using some lock, but I don't
know if it's good to do that inside uprobe_mmap().


> 
>> @@ -971,6 +1011,7 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>>  	bool is_register = !!new;
>>  	struct map_info *info;
>>  	int err = 0;
>> +	bool installed = false;
>>
>>  	percpu_down_write(&dup_mmap_sem);
>>  	info = build_map_info(uprobe->inode->i_mapping,
>> @@ -1000,8 +1041,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>>  		if (is_register) {
>>  			/* consult only the "caller", new consumer. */
>>  			if (consumer_filter(new,
>> -					UPROBE_FILTER_REGISTER, mm))
>> +					UPROBE_FILTER_REGISTER, mm)) {
>>  				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
>> +				installed = true;
>> +			}
>>  		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
>>  			if (!filter_chain(uprobe,
>>  					UPROBE_FILTER_UNREGISTER, mm))
>> @@ -1016,6 +1059,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>>  	}
>>   out:
>>  	percpu_up_write(&dup_mmap_sem);
>> +	if (installed)
>> +		clear_bit(REF_CTR_OFF_RELOADED, &uprobe->flags);
> 
> I simply can't understand this "bool installed"....


That boolean is needed because consumer_filter() returns false when this
function gets called first time from uprobe_register(). And consumer_filter
returns true when it gets called by uprobe_apply(). If I make it
unconditional, there is no effect of setting REF_CTR_OFF_RELOADED bit. So
this boolean is needed.

Though, there is one more issue I found. Let's say there are two processes
running and user probes on both of them using uprobe_register() using, let's
say systemtap. Now, some other guy does uprobe_register_refctr() using
'perf -p PID' on same uprobe but he is interested in only one process. Here,
we will increment the reference counter only in the "PID" process and we will
clear REF_CTR_OFF_RELOADED flag. Later, some other guy does 'perf -a' which
will call uprobe_register_refctr() for both the target but we will fail to
increment the counter in "non-PID" process because we had already clear
REF_CTR_OFF_RELOADED.

I have a solution for this. Idea is, if reference counter is reloaded, save
of all mms for which consumer_filter() denied to updated when being called
from register_for_each_vma(). Use this list of mms as checklist next time
onwards. I don't know if it's good to do that or not.


> 
> shouldn't we clear REF_CTR_OFF_RELOADED unconditionally after register_for_each_vma()?
> 


No, because uprobe_register() is simply NOP and breakpoint is actually
installed by uprobe_apply().


> 
> 
> Also. Suppose we have a registered uprobe with ref_ctr_offset == 0. Then you add and
> remove uprobe with ref_ctr_offset != 0. But afaics uprobe->ref_ctr_offset is never
> cleared, so another uprobe with a different ref_ctr_offset != 0 will hit pr_warn/-EINVAL
> in alloc_uprobe() and find_old_trace_uprobe() added by the previous patch can't detect
> this case?


This is a valid concern. So, this point is forcing me to make it a consumer
property. But if I do that, all optimization done by uprobe_perf_open() and
uprobe_perf_close() needs to be reverted, which I don't want to.


> 
> Plus it seems that we can have the unbalanced update_ref_ctr(false), at least in case
> when __uprobe_register() with REF_CTR_OFF_RELOADED set fails before it patches all mm's.
> If/when the 1st uprobe with ref_ctr_offset == 0 goes away, remove_breakpoint() will dec
> the counter even if wasn't incremented.


Hmm incase of failure, this could be possible.


> 
> Quite possibly I am totally confused, but this patch wrong in many ways...

No, you are right.

Please let me know if you have any better approach.

Thanks for the review :)
