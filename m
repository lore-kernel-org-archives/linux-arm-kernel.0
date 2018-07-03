From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 3 Jul 2018 11:59:26 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180702160158.GD65296@linux.vnet.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180702160158.GD65296@linux.vnet.ibm.com>
Message-ID: <ac5ab301-7df6-90fb-748b-3dc4624ea3c4@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srikar,

On 07/02/2018 09:31 PM, Srikar Dronamraju wrote:
>> Implement the reference counter logic in core uprobe. User will be
>> able to use it from trace_uprobe as well as from kernel module. New
>> trace_uprobe definition with reference counter will now be:
>>
>>     <path>:<offset>[(ref_ctr_offset)]
>>
>> where ref_ctr_offset is an optional field. For kernel module, new
>> variant of uprobe_register() has been introduced:
>>
>>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
>>
> 
> Sorry for bringing this again, but I would actually think the ref_ctr is
> a consumer property. i.e the ref_ctr_offset should be part of
> uprobe_consumer.


I agree that reference counter is a consumer property and that was the
main reason my initial draft was to change trace_uprobe. But there were
couple of issues with that approach too. I've already mentioned few of
them here: https://lkml.org/lkml/2018/6/6/129. Apart from these, if I
do it inside trace_uprobe, kernel module won't have a way to use
reference counter.

Now about adding ref_ctr_offset into uprobe_consumer. Actually, I
didn't want to change the uprobe_consumer definition because it's
already exported and tools like systemtap are using it. And thus, I
haven't explored how difficult or easy it will be to implement it that
way.


> 
> The advantages of doing that would be
> 1. Dont need to expose uprobe structure and just update our
> uprobe_consumer which is already an exported structure.
> - Exporting uprobe structure would expose some of our internal
>   implementation details, basically reduce the freedom of changing stuff
>   internally.


I agree. We will loose the freedom to change stuff by exporting uprobe.


> - we came up with uprobe_arch for the parts that we wanted to expose
>   to archs. exposing uprobe and uprobe_arch looks weird.


Hmm, how about this ...

  set_swbp(arch_uprobe, ...) {
    uprobe_write_opcode(arch_uprobe, ...) {
      uprobe = container_of(arch_uprobe);
      ...
    }
  }

Let me think on this. If this works, I won't need to export struct uprobe
outside.


> 
> 2. ref_ctr_offset is necessarily a consumer property, its not a uprobe
> property at all.


I agree.


> 
> 3. We dont need to change/add new uprobe_register functions.


Quite possible. I need to explore on that.


> 
> The way I look at it is.
> 
> Based on the ref_ctr_offset field in consumer, we update_ref_ctr()
> around install_breakpoint/remove_breakpoint.
> 
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
>> +	list_add(&du->list, &delayed_uprobe_list);
>> +	return 0;
>> +}
>> +
> 
> If I understood the delayed_uprobe stuff, its when we could insert a
> breakpoint but the vma that has the ref_ctr_offset is not loaded. Is
> that correct?


That's correct.

Thanks,
Ravi
