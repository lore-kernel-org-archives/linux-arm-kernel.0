From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 13 Jun 2013 17:15:24 -0400
Subject: [PATCH v2 3/3] ARM: keystone: Enable SMP support on Keystone
 machines
In-Reply-To: <20130613154949.GD27414@e106331-lin.cambridge.arm.com>
References: <1371072317-15030-1-git-send-email-santosh.shilimkar@ti.com>
 <1371072317-15030-4-git-send-email-santosh.shilimkar@ti.com>
 <20130613154949.GD27414@e106331-lin.cambridge.arm.com>
Message-ID: <51BA366C.2090508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Thursday 13 June 2013 11:49 AM, Mark Rutland wrote:
> On Wed, Jun 12, 2013 at 10:25:17PM +0100, Santosh Shilimkar wrote:
>> Add basic SMP support for Keystone machines. This does not
>> include support for CPU hotplug for now.
>>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: arm at kernel.org
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---

[..]

>> +static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
>> +						struct task_struct *idle)
>> +{
>> +	unsigned long start = virt_to_phys(&secondary_startup);
>> +	int error;
>> +
>> +	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
>> +		 cpu, start);
>> +
>> +	asm volatile (
>> +		"mov    r0, #0\n"	/* power on cmd	*/
>> +		"mov    r1, %1\n"	/* cpu		*/
>> +		"mov    r2, %2\n"	/* start	*/
>> +		".inst  0xe1600070\n"	/* smc #0	*/
> 
> In arch/arm/asm/opcodes-sec.h we have an __SMC() macro you could use here
> that'll use the correct opcode for arm or thumb kernels.
> 
Thanks for the suggestion though I am going to leave above as is now.
I need to move this code to asm file when I add remainder of the
monitor API support. Also inserting the macro in between means,
I need to break down the asm into two blocks which I want to
avoid for now.

Regards,
Santosh
