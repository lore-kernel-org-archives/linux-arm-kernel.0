From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Feb 2015 10:52:02 +0000
Subject: [PATCH v8 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <54D33773.5090000@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-15-git-send-email-hanjun.guo@linaro.org>
 <20150203141749.GA32536@leverpostej>
 <20150203200936.GA21731@e104818-lin.cambridge.arm.com>
 <54D1EAD5.4080105@linaro.org>
 <20150204112105.GA26006@e104818-lin.cambridge.arm.com>
 <54D33773.5090000@linaro.org>
Message-ID: <20150205105202.GB18158@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 09:27:15AM +0000, Hanjun Guo wrote:
> On 2015?02?04? 19:21, Catalin Marinas wrote:
> > On Wed, Feb 04, 2015 at 09:48:05AM +0000, Hanjun Guo wrote:
> >> On 2015?02?04? 04:09, Catalin Marinas wrote:
> >>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> >>> index ea4d2b35c57b..4fafd62b1b86 100644
> >>> --- a/arch/arm64/include/asm/acpi.h
> >>> +++ b/arch/arm64/include/asm/acpi.h
> >>> @@ -49,33 +49,12 @@ static inline void enable_acpi(void)
> >>>    	acpi_noirq = 0;
> >>>    }
> >>>
> >>> -/* MPIDR value provided in GICC structure is 64 bits, but the
> >>> - * existing phys_id (CPU hardware ID) using in acpi processor
> >>> - * driver is 32-bit, to conform to the same datatype we need
> >>> - * to repack the GICC structure MPIDR.
> >>> - *
> >>> - * bits other than following 32 bits are defined as 0, so it
> >>> - * will be no information lost after repacked.
> >>> - *
> >>> - * Bits [0:7] Aff0;
> >>> - * Bits [8:15] Aff1;
> >>> - * Bits [16:23] Aff2;
> >>> - * Bits [32:39] Aff3;
> >>> - */
> >>> -static inline u32 pack_mpidr(u64 mpidr)
> >>> -{
> >>> -	return (u32) ((mpidr & 0xff00000000) >> 8) | mpidr;
> >>> -}
> >>> -
> >>>    /*
> >>>     * The ACPI processor driver for ACPI core code needs this macro
> >>>     * to find out this cpu was already mapped (mapping from CPU hardware
> >>>     * ID to CPU logical ID) or not.
> >>> - *
> >>> - * cpu_logical_map(cpu) is the mapping of MPIDR and the logical cpu,
> >>> - * and MPIDR is the cpu hardware ID we needed to pack.
> >>>     */
> >>> -#define cpu_physical_id(cpu) pack_mpidr(cpu_logical_map(cpu))
> >>> +#define cpu_physical_id(cpu) cpu_logical_map(cpu)
> >>>
> >>>    /*
> >>>     * It's used from ACPI core in kdump to boot UP system with SMP kernel,
> >>> diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
> >>> index 59e282311b58..a492276e008d 100644
> >>> --- a/arch/arm64/include/asm/smp_plat.h
> >>> +++ b/arch/arm64/include/asm/smp_plat.h
> >>> @@ -40,4 +40,6 @@ static inline u32 mpidr_hash_size(void)
> >>>    extern u64 __cpu_logical_map[NR_CPUS];
> >>>    #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
> >>>
> >>> +typedef u64 cpuid_t;
> >>
> >> I think cpuid_t is a little confused because people may recognize
> >> it as cpu logical id, its original meaning is the physical cpu ID,
> >> so how about:
> >>
> >> typedef u64 phys_id_t; ?
> >
> > I would keep "cpu" somewhere in the name as "phys" is too generic, maybe
> > phys_cpuid_t.
> 
> This is pretty fine to me too :)
> 
> x86 and IA64 use 32 bit cpu phys_id (apic_id) everywhere in the arch
> code, but I think I don't need to touch them in this patch.

No, as long as you define phys_cpuid_t to be 32-bit (I guess an int) on
these architectures.

-- 
Catalin
