From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 12 May 2014 15:06:04 -0400 (EDT)
Subject: set_fiq_handler: Bad mode in data abort handler detected (mmu
 translation fault)
In-Reply-To: <9398501.4D8aYHERx3@dabox>
References: <2527501.cXAbiV8bqS@dabox> <7402473.jpZGckhttH@dabox>
 <20140425135117.GP26756@n2100.arm.linux.org.uk> <9398501.4D8aYHERx3@dabox>
Message-ID: <alpine.LFD.2.11.1405121452470.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 May 2014, Tim Sander wrote:

> I did an prefaulting for each available processes:
>     for_each_process(process)
>     {
>         printk("process: %s [%d]\n",process->comm,process->pid);
>         if(process->mm) {
>             switch_mm(old_process->mm,process->mm,process);
>             ioread32(priv->my_hardware);   // access the memory, prefault mmu
>             old_process = process;
>         }
>     }
> but still i get the the "Bad mode in data abort":
> Bad mode in data abort handler detected
> Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP ARM
> Modules linked in: firq(O+) ipv6
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O 3.12.0-xilinx-00005-gc9455c0-dirty #97
> task: c05cb420 ti: c05c0000 task.ti: c05c0000
> PC is at 0xe3fc0000
> LR is at arch_cpu_idle+0x20/0x2c
> pc : [<e3fc0000>]    lr : [<c000f344>]    psr: 600701d1
> sp : c05c1f70  ip : 00000000  fp : 00000000
> r10: 00000000  r9 : 413fc090  r8 : c0a7b4c0
> r7 : c05b6088  r6 : c0412348  r5 : c06008c0  r4 : c05c0000
> r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c0a7e9f8
> Flags: nZCv  IRQs off  FIQs off  Mode FIQ_32  ISA ARM  Segment kernel
> Control: 18c5387d  Table: 1ec2c04a  DAC: 00000015
> Process swapper/0 (pid: 0, stack limit = 0xc05c0240)
> Stack: (0xc05c1f70 to 0xc05c2000)
> 1f60:                                     c0a7e9f8 00000000 00000000 00000000
> 1f80: c05c0000 c06008c0 c0412348 c05b6088 c0a7b4c0 413fc090 00000000 00000000
> 1fa0: 00000000 c05c1f70 c000f344 e3fc0000 600701d1 ffffffff 00000000 c0056748
> 1fc0: c0414a30 c0592a60 ffffffff ffffffff c0592574 00000000 00000000 c05b6088
> 1fe0: 18c5387d c05c83cc c05b6084 c05cc440 0000406a 00008074 00000000 00000000
> [<c000f344>] (arch_cpu_idle+0x20/0x2c) from [<00000000>] (  (null))
> Code: bad PC value
> ---[ end trace 38f263d4b2076bcb ]---
> 
> But then i realized that its always swapper/0 which is faulting. But i don't see a pid 0 process
> in my for_each_process loop. So i tried some special handling for pid 0 to also prefault it:
> 
>     process = pid_task(&init_struct_pid, PIDTYPE_PID);
>     if(process) {
>         printk("process: %s [%d]\n",process->comm,process->pid);
>         switch_mm(current_task->mm,process->mm,process);
>         ioread32(priv->my_hardware);  // access the memory, prefault mmu
>         switch_mm(process->mm,current_task->mm,current_task);
>     } else printk("process pid prefault failed\n");  //<this path is taken
> 
> But it seems that the scheduler pid struct has no process associated. So its 
> not possible to get the mmu_struct for the pid 0. The structure can't be 
> implicit or otherwise there should be an mmu entry due to the prefaulting done
> or due to the static mapping. So it seems there is an MMU table which is not
> associated with any process and is used during scheduler/swapper work...
> but where is it hiding?

The mmu_struct for PID 0 is at &init_mm.  

Try: switch_mm(current_task->mm, &init_mm, NULL);


Nicolas
