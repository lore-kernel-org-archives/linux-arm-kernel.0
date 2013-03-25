From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Mar 2013 17:10:44 -0500
Subject: [PATCH 08/10] arm: zynq: Add smp support
In-Reply-To: <51507BCC.2050707@monstr.eu>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-8-git-send-email-michal.simek@xilinx.com>
 <51505C39.4060507@gmail.com> <51507BCC.2050707@monstr.eu>
Message-ID: <5150CB64.5030502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 11:31 AM, Michal Simek wrote:
> On 03/25/2013 03:16 PM, Rob Herring wrote:
>> On 03/25/2013 08:53 AM, Michal Simek wrote:
>>> Zynq is dual core Cortex A9 which starts always
>>> at zero. Using simple trampoline ensure long jump
>>> to secondary_startup code.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>   arch/arm/mach-zynq/Makefile  |    1 +
>>>   arch/arm/mach-zynq/common.c  |    1 +
>>>   arch/arm/mach-zynq/common.h  |    7 ++
>>>   arch/arm/mach-zynq/platsmp.c |  160
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   arch/arm/mach-zynq/slcr.c    |   29 ++++++++
>>>   5 files changed, 198 insertions(+)
>>>   create mode 100644 arch/arm/mach-zynq/platsmp.c

[...]

>>> +}
>>> +
>>> +int __cpuinit zynq_cpun_start(u32 address, int cpu)
>>> +{
>>> +    if (cpu > ncores) {
>>> +        pr_warn("CPU No. is not available in the system\n");
>>> +        return -1;
>>> +    }
>>> +
>>> +    /* MS: Expectation that SLCR are directly map and accessible */
>>> +    /* Not possible to jump to non aligned address */
>>> +    if (!(address & 3) && (!address || (address >= 0xC))) {
>>
>> What about Thumb2 kernel entry?
> 
> I have no idea what's that.
> Still more microblaze guy than Arm one.

It's the 16-bit (mostly) instruction mode. Why it matters here is bit 0
being set in an address will trigger a switch to Thumb mode in a bx/blx
instruction. So you can't really check for alignment as only 0x2 would
not be allowed. More below...

> 
>>
>>> +        slcr_cpu_stop(cpu);
>>
>> Isn't a secondary cpu already stopped?
> 
> On the normal boot this is really necessary because first stage bootloader
> doesn't stop cpu just keep it in loop and without stopping cpu
> and starting it again it doesn't work.

And there is no way to exit the loop other than a reset?

So for for hotplug this would not be needed. Perhaps .smp_prepare_cpus
is a better spot for this.

If you can change the bootloader, then you should look at doing PSCI
support. Here's some information:

http://lca-13.zerista.com/files_user/attachments/9311/psci_update.pdf

I've also submitted highbank patches which add support for PSCI.

>>> +
>>> +        /*
>>> +         * This is elegant way how to jump to any address
>>> +         * 0x0: Load address at 0x8 to r0
>>> +         * 0x4: Jump by mov instruction
>>> +         * 0x8: Jumping address
>>> +         */
>>> +        if (address) {
>>> +            /* 0: ldr r0, [8] */
>>> +            __raw_writel(0xe59f0000, phys_to_virt(0x0));
>>> +            /* 4: mov pc, r0 */
>>> +            __raw_writel(0xe1a0f000, phys_to_virt(0x4));

This should be a "bx r0" to work with Thumb2 entry address.

Also, this part of the setup could be one time rather than every hotplug.

>>> +            __raw_writel(address, phys_to_virt(0x8));

This should be a per core address including core 0 if you ever want to
do something like cpuidle powergating on one core and hotplug on another.

Rob
