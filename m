From: jonathan@raspberrypi.org (Jonathan Bell)
Date: Sun, 23 Mar 2014 18:38:12 +0000
Subject: [arm arch] local_irq_restore() does not play well with
 local_fiq_enable()
In-Reply-To: <20140320210941.GD7528@n2100.arm.linux.org.uk>
References: <op.xc1dkcblfh00o9@enterprised.lan>
 <20140320200233.GC7528@n2100.arm.linux.org.uk>
 <op.xc1f4mxnfh00o9@enterprised.lan>
 <20140320210941.GD7528@n2100.arm.linux.org.uk>
Message-ID: <op.xc6t1yd2fh00o9@enterprised.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 21:09:41 -0000, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> On Thu, Mar 20, 2014 at 08:49:24PM +0000, Jonathan Bell wrote:
>> On Thu, 20 Mar 2014 20:02:34 -0000, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>
>>> On Thu, Mar 20, 2014 at 07:54:02PM +0000, Jonathan Bell wrote:
>>>> hcd_init:
>>>> 	setup the FIQ state
>>>> 	install the fiq handler
>>>> 	enable_fiq(USB)
>>>> 	local_fiq_enable()
>>>> 	usb_add_hcd()
>>>
>>> You're not supposed to use local_fiq_enable() to enable FIQs in a  
>>> device
>>> driver - they should already be enabled by this point.
>>>
>>> There has been a hole in that where FIQs haven't been enabled in the
>>> idle thread, but that's a bug which needs fixing.  Otherwise, you  
>>> should
>>> assume that FIQs are always unmasked everywhere except for any short
>>> code sequences that are contained within a short local_fiq_disable()..
>>> local_fiq_enable() block.
>>>

Ok, I went away and did a bit of research.

> Realise that the state of the CPSR is per-process.  So if you're enabling
> it in PID 1 when your driver initialises and it isn't enabled in PID 0,
> then it will still remain not enabled in PID 0 - and that's a big problem
> because that means whenever the system is idle, FIQs will be masked.
>
> Now, what I'm reading in 3.14-rc7 is that:
>
> - there is a local_fiq_enable() in arch_cpu_idle_prepare() which ensures
>   that FIQs will be enabled for the idle loop for PID0.
>
> - secondary CPUs have a local_fiq_enable() in secondary_start_kernel()
>   which ensures that the have FIQs enabled too.

The issue I describe happens on a uniprocessor platform. I have no data
for SMP.

> - when a kernel thread is created, the initial register set is created
>   by copy_thread() which sets the CPSR to just 'SVC_MODE', thus clearing
>   the IRQ and FIQ mask bits in any spawned thread.

At the end of start_kernel there's the call to rest_init, which creates
two kernel threads (kernel_init and kthreadd) and subsequently does some
scheduling that ensures all built-in drivers are probed, etc.

The arch call to enable FIQs on the boot CPU is done at the end of this
function right before the entry into the idle loop, therefore after the  
built-in
drivers are probed and various threads are created.

> So that all appears to be correct.

Appears to be. However the issue stands. I can see where copy_thread saves
a set of registers including CPSR (set to SVC_MODE in the case of kernel
threads as you describe), but I cannot find anywhere in the actual call
for a context switch (__switch_to / finish_task_switch) the point where  
the CPSR is updated.

As far as I can see, the CPSR F/I bits are unaltered during a context  
switch.
