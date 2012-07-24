From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 13:56:29 -0400
Subject: [RFC 21/23] ARM: keystone: introducing TI Keystone platform
In-Reply-To: <201207241446.53401.arnd@arndb.de>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-22-git-send-email-cyril@ti.com>
 <201207241446.53401.arnd@arndb.de>
Message-ID: <500EE1CD.6030701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Thanks for taking the time to dig through this.

On 7/24/2012 10:46 AM, Arnd Bergmann wrote:
> On Tuesday 24 July 2012, Cyril Chemparathy wrote:
>
>> diff --git a/arch/arm/boot/dts/keystone-sim.dts b/arch/arm/boot/dts/keystone-sim.dts
>> new file mode 100644
>> index 0000000..118d631
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/keystone-sim.dts
>> @@ -0,0 +1,77 @@
>> +/dts-v1/;
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +	model = "Texas Instruments Keystone 2 SoC";
>> +	compatible = "ti,keystone-evm";
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>
> I would assume that you need at least #address-cells=<2>, possibly
> also #size-cells=<2>, in order to express large memory ranges.
>

Thanks, will fix.

>> diff --git a/arch/arm/mach-keystone/include/mach/entry-macro.S b/arch/arm/mach-keystone/include/mach/entry-macro.S
>> new file mode 100644
>> index 0000000..7f486f3
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/include/mach/entry-macro.S
>>
>> +	.macro	disable_fiq
>> +	.endm
>> +
>> +	.macro	arch_ret_to_user, tmp1, tmp2
>> +	.endm
>
> I think it would be better to enable MULTI_IRQ_HANDLER and remove
> this file.
>

Agreed.

>> diff --git a/arch/arm/mach-keystone/include/mach/io.h b/arch/arm/mach-keystone/include/mach/io.h
>> new file mode 100644
>> index 0000000..844d659
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/include/mach/io.h
>
>> +#ifndef __MACH_IO_H
>> +#define __MACH_IO_H
>> +
>> +#define __io(a)		({ (void)(a); __typesafe_io(0); })
>> +#define __mem_pci(a)	(a)
>> +
>> +#endif
>
> This should also be removed.
>

Agreed.

>> diff --git a/arch/arm/mach-keystone/include/mach/memory.h b/arch/arm/mach-keystone/include/mach/memory.h
>> new file mode 100644
>> index 0000000..7c78b1e
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/include/mach/memory.h
>
>> +#ifndef __ASM_MACH_MEMORY_H
>> +#define __ASM_MACH_MEMORY_H
>> +
>> +#define MAX_PHYSMEM_BITS	36
>> +#define SECTION_SIZE_BITS	34
>> +
>> +#endif /* __ASM_MACH_MEMORY_H */
>
> I wonder if there is anything we can do to make these generic. What you
> have here is ok for now, but we will need to do this differently once
> we are building multiplatform kernels with keystone and sparse memory.
>

Understood.  Any ideas on the general direction towards solving this?

>> diff --git a/arch/arm/mach-keystone/include/mach/system.h b/arch/arm/mach-keystone/include/mach/system.h
>> new file mode 100644
>> index 0000000..4887b4c
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/include/mach/system.h
>
>> +#ifndef __MACH_SYSTEM_H
>> +#define __MACH_SYSTEM_H
>> +
>> +static inline void arch_idle(void)
>> +{
>> +	cpu_do_idle();
>> +}
>> +
>> +static inline void arch_reset(char mode, const char *cmd)
>> +{
>> +	while (1)
>> +		;
>> +}
>> +
>> +#endif
>
> These are no longer used, please remove the file.
>

Sure.

>
>> diff --git a/arch/arm/mach-keystone/include/mach/vmalloc.h b/arch/arm/mach-keystone/include/mach/vmalloc.h
>> new file mode 100644
>> index 0000000..9d34c09
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/include/mach/vmalloc.h
>
>> +
>> +#define VMALLOC_END		0xFE800000UL
>> +
>> +#endif
>
> same here.
>

Sure.

>> +DT_MACHINE_START(KEYSTONE, "Keystone")
>> +	.map_io		= keystone_map_io,
>> +	.init_irq	= keystone_init_irq,
>> +	.timer		= &keystone_timer,
>> +	.handle_irq	= gic_handle_irq,
>> +	.init_machine	= keystone_init,
>> +	.dt_compat	= keystone_match,
>> +	.nr_irqs	= 480,
>> +MACHINE_END
>
> IIRC, you don't need to set the nr_irqs this high in advance,
> they will be allocated automatically since you have enabled
> sparse IRQs.
>

We were seeing a complaint without nr_irqs set, but I'll dig into that 
further.

-- 
Thanks
- Cyril
