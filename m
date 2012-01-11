From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 11 Jan 2012 19:23:18 +0900
Subject: ARM kexec SMP problem using exynos4210
In-Reply-To: <20120111100623.GA27887@mudshark.cambridge.arm.com>
References: <4F0D49DD.80305@samsung.com>
 <20120111100623.GA27887@mudshark.cambridge.arm.com>
Message-ID: <4F0D6316.4090800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2012 07:06 PM, Will Deacon wrote:
> On Wed, Jan 11, 2012 at 08:35:41AM +0000, Joonyoung Shim wrote:
>> Hi,
> Hello [adding linux-arm-kernel],
>
>> I have tested kexec to Nuri board using Exynos4210(Dual-core ARM
>> Cortex-A9) on the latest mainline kernel but i am facing one problem.
>>
>> The kernel enabled SMP, kernel_kexec() calls machine_shutdown to stop
>> all cpus except current cpu and jumps to the new kernel but the kernel
>> is hanged soon.
>>
>> I used cpu_down(1) to make disabled cpu1 instead of smp_send_stop of
>> machine_shutdown and it is booted successfully to new kernel.
>>
>> Any ideas?
> I suspect that the secondary CPUs are not being parked correctly in the first
> kernel. For this, you need to implement platform_cpu_kill for your platform.
>
> Given that exynos just does:
>
> int platform_cpu_kill(unsigned int cpu)
> {
> 	return 1;
> }
>
> then I'm not surprised it doesn't work. Try adding something in there which puts
> the CPU into a state where it can be booted by the next kernel.
Thanks, i will try it.

One more question, generally boot cpu is first cpu(cpu0). If current
cpu is secondary cpu(cpu1), smp_send_stop of machine_shutdown will stop
first cpu and next kernel will try to boot on secondary cpu. Is it
possible?

> I considered adding a purely software mechanism for doing this (in fact, I
> prototyped something up on vexpress) but after discussions with some board
> maintainers it became clear that most SMP SoCs have hardware assists for
> hotplug, and the software approach is really only need for things like the
> ARM development boards.
>
> Will
>
