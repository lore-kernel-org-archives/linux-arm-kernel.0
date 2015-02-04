From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Feb 2015 17:48:05 +0800
Subject: [PATCH v8 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <20150203200936.GA21731@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-15-git-send-email-hanjun.guo@linaro.org>
 <20150203141749.GA32536@leverpostej>
 <20150203200936.GA21731@e104818-lin.cambridge.arm.com>
Message-ID: <54D1EAD5.4080105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?04? 04:09, Catalin Marinas wrote:
> On Tue, Feb 03, 2015 at 02:17:49PM +0000, Mark Rutland wrote:
>> On Mon, Feb 02, 2015 at 12:45:42PM +0000, Hanjun Guo wrote:
>>> Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
>>> from the GICC Structure introduced by ACPI 5.1.
>>>
>>> MPIDR is the CPU hardware ID as local APIC ID on x86 platform, so we use
>>> MPIDR not the GIC CPU interface ID to identify CPUs.
>>>
>>> Further steps would typedef a phys_id_t for in arch code(with
>>> appropriate size and a corresponding invalid value, say ~0) and use that
>>> instead of an int in drivers/acpi/processor_core.c to store phys_id, then
>>> no need for mpidr packing.
>>
>> I don't understand why we don't fix this now, and I'm very worried that
>> this patch leaves much potential for FW bugs due to potential Linux
>> bugs.
>>
>> Having a function called cpu_physical_id which _does not_ return a
>> physical ID makes no sense to me. Any time we really need a physical
>> ID, we're still going to have to unpack it (in an architecture-specific
>> manner).
>
> Do you mean something like this? Only briefly tested on Juno and I may
> have missed other calls:

Thanks, I think it is Mark's suggestion (and also Lorenzo's)

>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index ea4d2b35c57b..4fafd62b1b86 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -49,33 +49,12 @@ static inline void enable_acpi(void)
>   	acpi_noirq = 0;
>   }
>
> -/* MPIDR value provided in GICC structure is 64 bits, but the
> - * existing phys_id (CPU hardware ID) using in acpi processor
> - * driver is 32-bit, to conform to the same datatype we need
> - * to repack the GICC structure MPIDR.
> - *
> - * bits other than following 32 bits are defined as 0, so it
> - * will be no information lost after repacked.
> - *
> - * Bits [0:7] Aff0;
> - * Bits [8:15] Aff1;
> - * Bits [16:23] Aff2;
> - * Bits [32:39] Aff3;
> - */
> -static inline u32 pack_mpidr(u64 mpidr)
> -{
> -	return (u32) ((mpidr & 0xff00000000) >> 8) | mpidr;
> -}
> -
>   /*
>    * The ACPI processor driver for ACPI core code needs this macro
>    * to find out this cpu was already mapped (mapping from CPU hardware
>    * ID to CPU logical ID) or not.
> - *
> - * cpu_logical_map(cpu) is the mapping of MPIDR and the logical cpu,
> - * and MPIDR is the cpu hardware ID we needed to pack.
>    */
> -#define cpu_physical_id(cpu) pack_mpidr(cpu_logical_map(cpu))
> +#define cpu_physical_id(cpu) cpu_logical_map(cpu)
>
>   /*
>    * It's used from ACPI core in kdump to boot UP system with SMP kernel,
> diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
> index 59e282311b58..a492276e008d 100644
> --- a/arch/arm64/include/asm/smp_plat.h
> +++ b/arch/arm64/include/asm/smp_plat.h
> @@ -40,4 +40,6 @@ static inline u32 mpidr_hash_size(void)
>   extern u64 __cpu_logical_map[NR_CPUS];
>   #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>
> +typedef u64 cpuid_t;

I think cpuid_t is a little confused because people may recognize
it as cpu logical id, its original meaning is the physical cpu ID,
so how about:

typedef u64 phys_id_t; ?

Thanks
Hanjun
