From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 2 Jul 2018 23:16:12 -0700
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
Message-ID: <20180703061612.GG65296@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Current approach:
> 
>     ------------
>     register_for_each_vma() / uprobe_mmap()
>       install_breakpoint()
>         uprobe_write_opcode() {
>                 if (instruction is not already patched) {
>                         /* Gets called only _once_. */
>                         increment the reference counter;
>                         patch the instruction;
>                 }
>         }
>     ------------
> 

Lets say a user just installs a breakpoint which is part of USDT (using
either a trace or perf (or some other utility) 
Since the semaphore is not updated, it never hits the probe.
This is correct.

Now he toggles the semaphore and places a probe at the same spot using
systemtap or bcc.
The probes will now be active and we see hits.
This is also correct.

If the user toggles the semaphore or deletes the probe using
systemtap/bcc. The probes will still be active.
Since the reference count is removed on the last consumer deletion. No?
This may be wrong because, we may be unnecessarily hitting the probes.


> Thanks,
> Ravi
