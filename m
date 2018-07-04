From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Wed, 4 Jul 2018 10:19:30 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180703163645.GA23144@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com>
Message-ID: <69c83765-a2a5-c515-2d35-8a95d534f6e5@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 07/03/2018 10:06 PM, Oleg Nesterov wrote:
> On 07/03, Ravi Bangoria wrote:
>>
>> Ok let me explain the difference.
>>
>> Current approach:
>>
>>     ------------
>>     register_for_each_vma() / uprobe_mmap()
>>       install_breakpoint()
>>         uprobe_write_opcode() {
>>                 if (instruction is not already patched) {
>>                         /* Gets called only _once_. */
>>                         increment the reference counter;
>>                         patch the instruction;
>>                 }
>>         }
> 
> Yes I see. And I am not sure this all is correct. And I still hope we can do
> something better, I'll write another email.
> 
> For now, let's discuss your current approach.
> 
>> Now, if I put it inside install_breakpoint():
>>
>>     ------------
>>     uprobe_register()
>>       register_for_each_vma()
>>         install_breakpoint() {
>>                 /* Called _for each consumer_ */
> 
> How so? it is not called for each consumer. I think you misread this code.


Actually, I meant entire sequence

  uprobe_register()
    register_for_each_vma()
      install_breakpoint()

gets called for each consumer. Not just install_breakpoint(). Sorry
for a bit of ambiguity.


> 
>>                 increment the reference counter _once_;
>>                 uprobe_write_opcode()
>> 		...
>>         }
> 
> So. I meant that you can move the _same_ logic into install_breakpoint() and
> remove_breakpoint(). And note that ref_ctr_updated in uprobe_write_opcode() is
> only needed because it can retry the fault.
> 
> IOW, you can simply do update_ref_ctr(is_register => 1) at the start of
> install_breakpoint(), and update_ref_ctr(0) in remove_breakpoint(), there are
> no other callers of uprobe_write_opcode(). To clarify, it is indirectly called
> by set_swbp() and set_orig_insn(), but this doesn't matter.
> 
> Or you can kill update_ref_ctr() and (roughly) do
> 
> 	rc_vma = find_ref_ctr_vma(...);
> 	if (rc_vma)
> 		__update_ref_ctr(..., 1);
> 	else
> 		delayed_uprobe_add(...);
> 
> at the start of install_breakpoint() and
> 
> 	rc_vma = find_ref_ctr_vma(...);
> 	if (rc_vma)
> 		__update_ref_ctr(..., -1);
> 	delayed_uprobe_remove(...);
> 
> in remove_breakpoint().
> 
> 
>>     uprobe_mmap()
>>       install_breakpoint() {
>>                 increment the reference counter _for each consumer_;
> 
> Again, I do not understand where do you see the "for each consumer" thing.
> 
>>                 uprobe_write_opcode()
> 
> In short. There is a 1:1 relationship between uprobe_write_opcode(is_register => 1)
> and install_breakpoint(), and between uprobe_write_opcode(is_register => 0) and
> remove_breakpoint(). Whatever uprobe_write_opcode() can do if is_register == 1 can be
> done in install_breakpoint(), the same for is_register == 0 and remove_breakpont().
> 
> What have I missed?


Yes, the verify_opcode() stuff as you have mentioned in another reply.

Thanks,
Ravi
