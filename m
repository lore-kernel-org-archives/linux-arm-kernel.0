From: monstr@monstr.eu (Michal Simek)
Date: Wed, 05 Jun 2013 14:54:54 +0200
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
In-Reply-To: <20130605112913.GD18614@n2100.arm.linux.org.uk>
References: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
 <51AC5060.80806@linaro.org> <51AC672A.5050501@monstr.eu>
 <51AC8F74.2060302@linaro.org>
 <CAP245DUsRcomDaNKbxYry39ZLCrR33SDRRAhNCdR91e17sHF-A@mail.gmail.com>
 <51ADD667.3010203@linaro.org> <20130604141017.GW18614@n2100.arm.linux.org.uk>
 <20130604141701.GX18614@n2100.arm.linux.org.uk> <51AF1752.1040804@monstr.eu>
 <20130605112913.GD18614@n2100.arm.linux.org.uk>
Message-ID: <51AF351E.6010109@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 01:29 PM, Russell King - ARM Linux wrote:
> On Wed, Jun 05, 2013 at 12:47:46PM +0200, Michal Simek wrote:
>> On 06/04/2013 04:17 PM, Russell King - ARM Linux wrote:
>>> And yes, indeed, zynq can control the secondary CPU:
>>>
>>> void zynq_slcr_cpu_start(int cpu)
>>> {
>>>         /* enable CPUn */
>>>         writel(SLCR_A9_CPU_CLKSTOP << cpu,
>>>                zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
>>>         /* enable CLK for CPUn */
>>>         writel(0x0 << cpu, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
>>> }
>>>
>>> void zynq_slcr_cpu_stop(int cpu)
>>> {
>>>         /* stop CLK and reset CPUn */
>>>         writel((SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu,
>>>                zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
>>> }
>>>
>>> So there's no need for the pen.  There's no need for the low power crap
>>> in hotplug.c, there's no need for the pen in hotplug.c.  You just arrange
>>> for the secondary CPU to have its clock stopped and reset when it is
>>> taken offline.
>>>
>>> Hotplugging a CPU back in _should_ be no different from its initial
>>> bringup into the kernel.
>>
>> I have tested that and cpu_die code is performed on cpu which
>> should die.
>> And simple calling zynq_slcr_cpu_stop() on cpu which should die
>> just doesn't work.
>> There is probably any expectation which I can't see.
> 
> Have you checked whether the CPU to die can write to this register to
> stop its own clock and reset itself?  Maybe you need a wfi() after
> writing to that register to trigger the hardware to shutdown the CPU?

One thing is clear here. Definitely cpu can't reset itself because
it must be done in 3 steps and after the first cpu is in reset and without CLK.
It means another cpu has to get another cpu out of reset.

Based on my tests cpu can't stop clock and reset itself.

> It's also entirely possible that you need some other CPU to do those
> steps while the CPU to die spins in a loop or a wfi or something like
> that.  You can hook into that via the cpu_kill() callback, which will
> have the CPU which is to die as its argument.

That's how it is written in the code right now.
Cpu 1, flush L1 cache and run that code in zynq_cpu_enter_lowpower code
and then end up in wfi().
Then cpu0 runs cpu_kill function with argument 1 which means kill cpu1.

If cpu gets wakeup between wfi/cpu_kill is called then spurious is increase.

> Without knowing how your hardware works, it's very difficult to be able
> to positively point you in an appropriate direction, but the fact that
> it's allegedly possible to turn the clock off and place the secondary
> CPU in reset means that this should be possible somehow.

I hope I have described zynq hw to get all information.

Because what seems to me problematic is.
1. In current code cpu1 is all the time in "for" loop and zynq_cpu_leave_lowpower
is completely unused because there is no way to jump there
2. I expect that smp.c/cpu_die() is designed for system which should after wake-up
jump to secondary_start_kernel to boot it. And this wakeup is performed from cpu0 from
boot_secondary code.

Let me propose change for zynq which is like this.

void zynq_platform_cpu_die(unsigned int cpu)
{
	zynq_cpu_enter_lowpower();
	for (;;)
		cpu_do_idle();
}

Remove zynq_cpu_leave_lowpower, zynq_platform_do_lowpower + spurious var.

It never returns from zynq_platform_cpu_die function.
It should enter to lowpower before wfi(if this make sense)
to save energy because it can take some time till cpu0 calls kill function.

Is this a sensible solution?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130605/512c2c67/attachment.sig>
