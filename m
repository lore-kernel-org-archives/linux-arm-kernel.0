From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 17:31:08 +0100
Subject: [PATCH 08/10] arm: zynq: Add smp support
In-Reply-To: <51505C39.4060507@gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-8-git-send-email-michal.simek@xilinx.com>
 <51505C39.4060507@gmail.com>
Message-ID: <51507BCC.2050707@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 03:16 PM, Rob Herring wrote:
> On 03/25/2013 08:53 AM, Michal Simek wrote:
>> Zynq is dual core Cortex A9 which starts always
>> at zero. Using simple trampoline ensure long jump
>> to secondary_startup code.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>   arch/arm/mach-zynq/Makefile  |    1 +
>>   arch/arm/mach-zynq/common.c  |    1 +
>>   arch/arm/mach-zynq/common.h  |    7 ++
>>   arch/arm/mach-zynq/platsmp.c |  160 ++++++++++++++++++++++++++++++++++++++++++
>>   arch/arm/mach-zynq/slcr.c    |   29 ++++++++
>>   5 files changed, 198 insertions(+)
>>   create mode 100644 arch/arm/mach-zynq/platsmp.c
>
> [...]
>
>> +/* Secondary CPU kernel startup is a 2 step process. The primary CPU
>> + * starts the secondary CPU by giving it the address of the kernel and
>> + * then sending it an event to wake it up. The secondary CPU then
>> + * starts the kernel and tells the primary CPU it's up and running.
>> + */
>> +static void __cpuinit zynq_secondary_init(unsigned int cpu)
>> +{
>> +	/*
>> +	 * if any interrupts are already enabled for the primary
>> +	 * core (e.g. timer irq), then they will not have been enabled
>> +	 * for us: do so
>> +	 */
>> +	gic_secondary_init(0);
>> +
>> +	/*
>> +	 * Synchronise with the boot thread.
>> +	 */
>> +	spin_lock(&boot_lock);
>> +	spin_unlock(&boot_lock);
>
> Why do you think this is needed? Platforms that need this
> synchronization are only the ones that just do wfi for hotplug rather
> than properly reseting the core. You appear to do the latter and should
> not need this.

ok.


>> +}
>> +
>> +int __cpuinit zynq_cpun_start(u32 address, int cpu)
>> +{
>> +	if (cpu > ncores) {
>> +		pr_warn("CPU No. is not available in the system\n");
>> +		return -1;
>> +	}
>> +
>> +	/* MS: Expectation that SLCR are directly map and accessible */
>> +	/* Not possible to jump to non aligned address */
>> +	if (!(address & 3) && (!address || (address >= 0xC))) {
>
> What about Thumb2 kernel entry?

I have no idea what's that.
Still more microblaze guy than Arm one.

>
>> +		slcr_cpu_stop(cpu);
>
> Isn't a secondary cpu already stopped?

On the normal boot this is really necessary because first stage bootloader
doesn't stop cpu just keep it in loop and without stopping cpu
and starting it again it doesn't work.

>> +
>> +		/*
>> +		 * This is elegant way how to jump to any address
>> +		 * 0x0: Load address at 0x8 to r0
>> +		 * 0x4: Jump by mov instruction
>> +		 * 0x8: Jumping address
>> +		 */
>> +		if (address) {
>> +			/* 0: ldr r0, [8] */
>> +			__raw_writel(0xe59f0000, phys_to_virt(0x0));
>> +			/* 4: mov pc, r0 */
>> +			__raw_writel(0xe1a0f000, phys_to_virt(0x4));
>> +			__raw_writel(address, phys_to_virt(0x8));
>> +		}
>> +
>> +		flush_cache_all();
>> +		outer_flush_all();
>
> You should only need to flush range on address 0-4 here.

ok.

Thanks,
Michal



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
