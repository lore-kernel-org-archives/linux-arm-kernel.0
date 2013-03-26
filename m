From: monstr@monstr.eu (Michal Simek)
Date: Tue, 26 Mar 2013 08:42:50 +0100
Subject: [PATCH 08/10] arm: zynq: Add smp support
In-Reply-To: <5150CB64.5030502@gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-8-git-send-email-michal.simek@xilinx.com>
 <51505C39.4060507@gmail.com> <51507BCC.2050707@monstr.eu>
 <5150CB64.5030502@gmail.com>
Message-ID: <CAHTX3dLD6gPG-1nzbk9gcsiO=SAq7UKDa7vvOOYHvTHt8zJhUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/25 Rob Herring <robherring2@gmail.com>:
> On 03/25/2013 11:31 AM, Michal Simek wrote:
>> On 03/25/2013 03:16 PM, Rob Herring wrote:
>>> On 03/25/2013 08:53 AM, Michal Simek wrote:
>>>> Zynq is dual core Cortex A9 which starts always
>>>> at zero. Using simple trampoline ensure long jump
>>>> to secondary_startup code.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>   arch/arm/mach-zynq/Makefile  |    1 +
>>>>   arch/arm/mach-zynq/common.c  |    1 +
>>>>   arch/arm/mach-zynq/common.h  |    7 ++
>>>>   arch/arm/mach-zynq/platsmp.c |  160
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>   arch/arm/mach-zynq/slcr.c    |   29 ++++++++
>>>>   5 files changed, 198 insertions(+)
>>>>   create mode 100644 arch/arm/mach-zynq/platsmp.c
>
> [...]
>
>>>> +}
>>>> +
>>>> +int __cpuinit zynq_cpun_start(u32 address, int cpu)
>>>> +{
>>>> +    if (cpu > ncores) {
>>>> +        pr_warn("CPU No. is not available in the system\n");
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    /* MS: Expectation that SLCR are directly map and accessible */
>>>> +    /* Not possible to jump to non aligned address */
>>>> +    if (!(address & 3) && (!address || (address >= 0xC))) {
>>>
>>> What about Thumb2 kernel entry?
>>
>> I have no idea what's that.
>> Still more microblaze guy than Arm one.
>
> It's the 16-bit (mostly) instruction mode. Why it matters here is bit 0
> being set in an address will trigger a switch to Thumb mode in a bx/blx
> instruction. So you can't really check for alignment as only 0x2 would
> not be allowed. More below...

ok.


>
>>
>>>
>>>> +        slcr_cpu_stop(cpu);
>>>
>>> Isn't a secondary cpu already stopped?
>>
>> On the normal boot this is really necessary because first stage bootloader
>> doesn't stop cpu just keep it in loop and without stopping cpu
>> and starting it again it doesn't work.
>
> And there is no way to exit the loop other than a reset?

You can exit the loop by writing jump address to one location where bootloader
expect it. Then it jumps to proper function and it was done like that before.
But this is not suitable for cpu hotplug because that loop is placed
in OCM (on chip memory)
and it can be used for different purpose.
Also there is no way how to return cpu to this mode.

> So for for hotplug this would not be needed. Perhaps .smp_prepare_cpus
> is a better spot for this.

I don't think so because smp_prepare_cpus is called by the kernel just once
in bootup time.
For cpu hotplug I see that only smp_boot_secondary is called.


> If you can change the bootloader, then you should look at doing PSCI
> support. Here's some information:

Unfortunately no.

>
> http://lca-13.zerista.com/files_user/attachments/9311/psci_update.pdf
>
> I've also submitted highbank patches which add support for PSCI.

Interesting. I will look at it. Thanks.


>>>> +
>>>> +        /*
>>>> +         * This is elegant way how to jump to any address
>>>> +         * 0x0: Load address at 0x8 to r0
>>>> +         * 0x4: Jump by mov instruction
>>>> +         * 0x8: Jumping address
>>>> +         */
>>>> +        if (address) {
>>>> +            /* 0: ldr r0, [8] */
>>>> +            __raw_writel(0xe59f0000, phys_to_virt(0x0));
>>>> +            /* 4: mov pc, r0 */
>>>> +            __raw_writel(0xe1a0f000, phys_to_virt(0x4));
>
> This should be a "bx r0" to work with Thumb2 entry address.
>
> Also, this part of the setup could be one time rather than every hotplug.

It is better to copy it there all the time because we have one AMP demo
where rtos runs from 0x0 because there are reset vectors for it.
That's why it is necessary to copy this trampoline code all the time.


>>>> +            __raw_writel(address, phys_to_virt(0x8));
>
> This should be a per core address including core 0 if you ever want to
> do something like cpuidle powergating on one core and hotplug on another.

That's interesting idea.
Please correct me if I am wrong, I didn't play with cpuidle.

Zynq is dual core and hotplug can be done only on cpu1. (not sure if
in general cpu0
can be unplugged too. If yes, are you doing that?).
I didn't play with cpuidle code but I am not quite sure if you can use hotplug
if cpu0 is in idle because this code is for >cpu0.

I can imagine to be more flexible on quad core where your comment make
definitely sense.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
