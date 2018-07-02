From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 2 Jul 2018 10:46:55 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180701210935.GA14404@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
Message-ID: <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 07/02/2018 02:39 AM, Oleg Nesterov wrote:
> On 06/28, Ravi Bangoria wrote:
>>
>> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
>>  	if (ret <= 0)
>>  		goto put_old;
>>  
>> +	/* Update the ref_ctr if we are going to replace instruction. */
>> +	if (!ref_ctr_updated) {
>> +		ret = update_ref_ctr(uprobe, mm, is_register);
>> +		if (ret)
>> +			goto put_old;
>> +
>> +		ref_ctr_updated = 1;
>> +	}
> 
> Why can't this code live in install_breakpoint() and remove_breakpoint() ?
> this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
> and the logic will be more simple.

IMO, it's more easier with current approach. Updating reference counter
inside uprobe_write_opcode() makes it tightly coupled with instruction
patching. Basically, reference counter gets incremented only when first
consumer gets activated and will get decremented only when last consumer
is going away.

Advantage is, we can get rid of sdt_mm_list patch*, because increment and
decrement are anyway happening in sync. This makes the implementation lot
more simpler. If I do it inside install_breakpoit()/ remove_breakpoint(),
I've to reintroduce sdt_mm_list which makes code more complicated and ugly.

* https://lkml.org/lkml/2018/4/17/28

BTW, is there any harm in exporting struct uprobe outside of uprobe.c?

> 
> And let me ask again... May be you have already explained this, but I can't
> find the previous discussion.
> 
> So why do we need a counter but not a boolean? IIRC, because the counter can
> be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
> right?

Actually, it's by design. This counter keeps track of current tracers
tracing on a particular SDT marker. So only boolean can't work here.
Also, yes, multiple markers can share the same reference counter.

> 
> But who else can use this counter and how? Say, can userspace update it too?

There are many different ways user can change the reference counter.
Ex, systemtap and bcc both uses uprobe to probe on a marker but reference
counter update logic is different in both of them. Systemtap records all
exec/mmap events and updates the counter when it finds interested process/
vma. bcc directly hooks into process's memory (/proc/pid/mem).

> If yes, why this can't race with __update_ref_ctr() ?

Right. But there is no synchronization mechanism provided by the SDT
infrastructure and this is all userspace so there are chances of race.
At least, this patch still tries to make sure that reference counter
does not go negative. If so, throw a warning and don't update it.

> 
> And btw, why does __update_ref_ctr() use FOLL_FORCE? This vma should be writeable
> or valid_ref_ctr_vma() should nack it?

I don't remember the exact reason but seem its unnecessary. Let me try to
recall the reason, otherwise will remove it in the next version.

> 
> And shouldn't valid_ref_ctr_vma() check VM_SHARED? IIUC we do not want to write
> to this file?

Hmm, I haven't seen reference counter shared across processes. But as this
is a generic infrastructure, I'll add a check there.

Thanks for the review,
Ravi
