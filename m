From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 3 Jul 2018 13:13:58 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180703061612.GG65296@linux.vnet.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703061612.GG65296@linux.vnet.ibm.com>
Message-ID: <c21db380-7dc0-2165-8616-8dcb519aa787@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srikar,

On 07/03/2018 11:46 AM, Srikar Dronamraju wrote:
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
>>     ------------
>>
> 
> Lets say a user just installs a breakpoint which is part of USDT (using
> either a trace or perf (or some other utility) 
> Since the semaphore is not updated, it never hits the probe.
> This is correct.
> 
> Now he toggles the semaphore and places a probe at the same spot using
> systemtap or bcc.
> The probes will now be active and we see hits.
> This is also correct.
> 
> If the user toggles the semaphore or deletes the probe using
> systemtap/bcc. The probes will still be active.
> Since the reference count is removed on the last consumer deletion. No?
> This may be wrong because, we may be unnecessarily hitting the probes.


I'm not sure if I get your concerns but let me try to explain what happens
in such cases. please let me know if I misunderstood your point.

1. Install a probe using perf.
  # ./perf probe sdt_tick:loop2

  This does not do anything. Just creates an entry in trace_uprobe.

2. Start record using perf:
  # ./perf record -a -e sdt_tick:loop2

  This will call uprobe_register_refctr(inode, offfset, ref_ctr_offset)
  and will create an object of struct uprobe.

3. Start target process
  # ./tick

  When we start 'tick', kernel will load the binary and start creating
  vmas, which will basically call uprobe_mmap(). First vma will be of
  text section and thus instruction will be patched. But vma holding
  reference counter is not present yet and thus the uprobe will be
  added to delayed_uprobe_list. Now kernel will map the data section
  holding reference counter and uprobe_mmap() will check for any
  delayed_uprobe. It will find the uprobe and thus it will increment
  the reference counter.

  So, Reference counter = 1, instruction is patched with trap.

4. For simplicity, I'm using kernel module instead of systemtap / bcc.
   User loads a kernel module that registers a probe on the same uprobe
   by calling uprobe_register_refctr(inode, offset, ref_ctr_offset).

  # insmod test-sdt.ko

  The sequence of function call here will be:
    uprobe_register_refctr()
      register_for_each_vma()
        install_breakpoint()
          set_swbp()
            uprobe_write_opcode()

  But uprobe_write_opcode will find instruction is already patched and
  thus return without doing anything.

  So, Reference counter = 1, instruction is patched.

5. Let's say user kills perf record started in step 2. Function call
   sequence here will be:

     uprobe_unregister()
       register_for_each_vma() {
         if (!filter_chain())
            remove_breakpoint();
       }

   Here filter_chain return true because other consumer is active on the
   same uprobe. so uprobe_unregister() will return without doing anything.

   So, Reference counter = 1, instruction is patched.

6. User unloads the kernel module.
   # rmmod test-sdt.ko

   Same function sequence as step 5 but this time filter_chain() will
   return false because there are no consumer left. And thus
   remove_breakpoint() will get called which will reset instruction and
   decrement the counter.

  So, Reference counter = 0, instruction is reset.


Does this explain your concerns?

Thanks,
Ravi
