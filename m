From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 3 Jul 2018 11:00:58 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180702180156.GA31400@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
Message-ID: <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 07/02/2018 11:31 PM, Oleg Nesterov wrote:
> On 07/02, Ravi Bangoria wrote:
>>
>> Hi Oleg,
>>
>> On 07/02/2018 02:39 AM, Oleg Nesterov wrote:
>>> On 06/28, Ravi Bangoria wrote:
>>>>
>>>> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
>>>>  	if (ret <= 0)
>>>>  		goto put_old;
>>>>
>>>> +	/* Update the ref_ctr if we are going to replace instruction. */
>>>> +	if (!ref_ctr_updated) {
>>>> +		ret = update_ref_ctr(uprobe, mm, is_register);
>>>> +		if (ret)
>>>> +			goto put_old;
>>>> +
>>>> +		ref_ctr_updated = 1;
>>>> +	}
>>>
>>> Why can't this code live in install_breakpoint() and remove_breakpoint() ?
>>> this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
>>> and the logic will be more simple.
>>
>> IMO, it's more easier with current approach. Updating reference counter
>> inside uprobe_write_opcode() makes it tightly coupled with instruction
>> patching. Basically, reference counter gets incremented only when first
>> consumer gets activated and will get decremented only when last consumer
>> is going away.
>>
>> Advantage is, we can get rid of sdt_mm_list patch*, because increment and
>> decrement are anyway happening in sync. This makes the implementation lot
>> more simpler. If I do it inside install_breakpoit()/ remove_breakpoint(),
>> I've to reintroduce sdt_mm_list which makes code more complicated and ugly.
> 
> Why? I do not understand. Afaics you can have the same logic, but the resulting
> code will be simpler and more clear.


Ok let me explain the difference.

Current approach:

    ------------
    register_for_each_vma() / uprobe_mmap()
      install_breakpoint()
        uprobe_write_opcode() {
                if (instruction is not already patched) {
                        /* Gets called only _once_. */
                        increment the reference counter;
                        patch the instruction;
                }
        }
    ------------

Here, reference counter is updated only if we are going to patch the
instruction. No matter how many consumers are there, no matter how many
times install_breakpoint() gets called. Same case for decrement as well.
Reference counter will get decremented only when we are going to reset
the instruction.

Now, if I put it inside install_breakpoint():

    ------------
    uprobe_register()
      register_for_each_vma()
        install_breakpoint() {
                /* Called _for each consumer_ */
                increment the reference counter _once_;
                uprobe_write_opcode()
		...
        }

  OR

    uprobe_mmap()
      install_breakpoint() {
                increment the reference counter _for each consumer_;
                uprobe_write_opcode()
		...
      }
    ------------

By putting it inside install_breaopoint() / remove_breakpoint(), we
increment and decremnet the counter for each consumer.

Consider this python example:

    ------------
    # readelf -n /usr/lib64/libpython2.7.so.1.0 | grep -A2 Provider
      Provider: python
      Name: function__entry
      ... Semaphore: 0x00000000002899d8

    # sudo perf probe sdt_python:function__entry

    # strace python
      mmap(NULL, 2738968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fff92460000
      mmap(0x7fff926a0000, 327680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x230000) = 0x7fff926a0000
      mprotect(0x7fff926a0000, 65536, PROT_READ) = 0
    ------------

The first mmap() maps the whole library into one region. Second mmap()
and third mprotect() split out the whole region into smaller vmas and
sets appropriate protection flags.

Now, in this case, install_breakpoint() will update reference counter
twice -- by second mmap() call and by third mprotect() call -- because
both regions contains the same reference counter. But, remove_brekpoint()
will decrement the reference counter only once, which will left counter
greater than 0 even when no one is tracing on that uprobe.

To solve this issue, I have to re-introduced sdt_mm_list, a list of
{consumer,mm} tuple for each uprobe. This tells us, for X consumer
we already have incremented the counter in Y mm so that we don't
increment same counter again. This additional complexity is to make
sure increment and decrement happen in sync.

Fortunately, we don't need to maintain this list with current approach,
because we know for sure that, increment and decrement will happen only
once when we patch/up-patch the instruction.

In short, if I put it inside install_breakpoint()/remove_breakpoint(),
I'll have to put the same logic there with more complication to
increment / decrement counter for each consumer. And additionally,
I've to maintain sdt_mm_list to make sure increment and decrement
happen in sync. With current approach, this all happens by default :)


> 
>> BTW, is there any harm in exporting struct uprobe outside of uprobe.c?
> 
> I think it is always better to avoid the exporting if possible (and avoid
> changing the arch-dependant set_swbp/set_orig_insn). But once again, I think
> this only complicates the code for no reason.> 
>>> So why do we need a counter but not a boolean? IIRC, because the counter can
>>> be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
>>> right?
>>
>> Actually, it's by design. This counter keeps track of current tracers
>> tracing on a particular SDT marker. So only boolean can't work here.
>> Also, yes, multiple markers can share the same reference counter.
> 
> markers or uprobes? OK, I'll assume that multiple uprobes can share the counter.


Yes, I meant uprobe.


> 
>>> But who else can use this counter and how? Say, can userspace update it too?
>>
>> There are many different ways user can change the reference counter.
>> Ex, systemtap and bcc both uses uprobe to probe on a marker but reference
>> counter update logic is different in both of them. Systemtap records all
>> exec/mmap events and updates the counter when it finds interested process/
>> vma. bcc directly hooks into process's memory (/proc/pid/mem).
> 
> OK, and how exactly they update the counter? I mean, can we assume that, say,
> bcc or systemtap can only increment or decrement it?


I don't think we can assume anything here because this is all in user's
control. User can even manually go and update the counter by directly
hooking into the memory. Ex, Brendan Gregg's blog on USDT explains how
to change counter manually in "Hacking with Ftrace: Is-Enabled" section
of his blog:
  http://www.brendangregg.com/blog/2015-07-03/hacking-linux-usdt-ftrace.html


> 
> If yes, perhaps we can simplify the kernel code...


Sure, let me know if you have any better idea.

Thanks,
Ravi
