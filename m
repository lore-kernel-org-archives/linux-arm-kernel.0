From: marc.ceeeee@gmail.com (Marc C)
Date: Mon, 25 Nov 2013 22:42:03 -0800
Subject: [RFC] ARM Generic Timer + Interaction with WFI on Cortex-A15
In-Reply-To: <20131121120025.GC31695@e102568-lin.cambridge.arm.com>
References: <528DBD0C.6040203@gmail.com>
 <20131121120025.GC31695@e102568-lin.cambridge.arm.com>
Message-ID: <529442BB.1000006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lorenzo,

> It is an A15 oddity and we should not care, given that this behaviour
> is platform specific and likely to fail in most common A15
> implementations.

I'm supporting a platform where this "oddity" is actually a relied-upon
feature. Our ARMv7-compliant MPCore implements the ARM Generic Timer per
spec. Our implementation isn't a constituent of a big.LITTLE
arrangement, and we'll never completely power-off all cores (we just use
WFI).

According to the documentation that currently exists, it seems that the
behavior of the ARM Generic Timer on cores like the A15 is really just
an attribute of that specific implementation. As you've alluded to,
there may be other implementations that are also usable when the CPUs
enter WFI. That said, do you object to having an optional boolean
property in the arch_timer DT binding [1] which allows users to override
the C3STOP flag? The default behavior would be as is currently
implemented, and for the odd machines we can add the new property to the DT.

Regards,
Marc

[1]
https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/arch_timer.txt

On 11/21/13, 4:00 AM, Lorenzo Pieralisi wrote:
> On Thu, Nov 21, 2013 at 07:58:04AM +0000, Marc C wrote:
>> Hello,
>>
>> I have a question regarding the interaction with the ARM Generic (or
>> architected) timer, high-resolution timer support, and the WFI instruction.
>>
>> This commit [1] sets up the "C3STOP" flag on the arch_timer. According
>> to the commit log, an ARM core which implements the ARM Generic Timer
>> may power-down and thus invalidate some registers within the timer.
>> Therefore, flagging the timer with C3STOP will ensure that an
>> appropriate broadcast timer will be used whenever the CPU goes into idle.
>>
>> However, according to this article [2], there is a difference in
>> implementation between the Cortex-A7 and Cortex-A15, wherein the A7 will
>> power-down on idle, and the A15 will not.
> 
> There is a difference in implementation, which implies that A15 local
> timers might still be running when a CPU is power gated since the
> local timer voltage domain is different from the vcpu, voltage to the core.
> 
> It is an A15 oddity. On A7 and newer cores, the local timer will be
> held in reset/power down when a single core is shutdown.
> 
> See, point is, even if on A15 the timer is still running when a single
> core is shutdown, this might not be true when the A15 cluster goes down.
> 
> At that point in time, when the last CPU running in a cluster is about
> to call a cluster shutdown, how can you offload the local timer of _another_
> CPU to an always-on timer acting as broadcast ? Wake up that CPU up just
> to enter broadcast mode ? This is not really power efficient and we add
> complexity in the kernel. There might be a way to solve this by using
> the clock event API but I would rule it out.
> 
> It is basically the same reason why we save/restore the GIC CPU IF
> configuration whenever a single core goes down (but the GIC stays on),
> because there is no way to read it from other CPUs when the GIC is shutdown
> for good (NB this is just an example and is likely to change with future GIC
> implementations).
> 
> Since it is an A15 oddity, I think we should not care and keep things as
> they are in the kernel.
> 
>> Now, given the 2 citations, can someone explain why the C3STOP flag is
>> used for _all_ implementations? Is it not the case that the A15-based
>> arch_timer can be used as a broadcast timer, even if the kernel is
>> configured to call WFI and put the CPU into low-power mode?
>>
>> There have been some recent commits which conditionally setup the C3STOP
>> flag, depending on the CONFIG_CPU_IDLE flag. However, my concern is that
>> there are some ARM implementations that can actually go into low-power
>> mode and still use the arch_timer reliably.
> 
> It is an A15 oddity and we should not care, given that this behaviour is
> platform specific and likely to fail in most common A15 implementations.
> 
> Thank you for pointing that out though.
> 
> Lorenzo
> 
