From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Sep 2012 18:38:45 +0100
Subject: [PATCH v2 08/31] arm64: CPU support
In-Reply-To: <20120815001043.GD19607@quad.lixom.net>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-9-git-send-email-catalin.marinas@arm.com>
 <20120815001043.GD19607@quad.lixom.net>
Message-ID: <20120914173845.GD2927@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 01:10:43AM +0100, Olof Johansson wrote:
> On Tue, Aug 14, 2012 at 06:52:09PM +0100, Catalin Marinas wrote:
> > +#ifndef __ASM_CPUTYPE_H
> > +#define __ASM_CPUTYPE_H
> > +
> > +#define ID_MIDR_EL1		"midr_el1"
> > +#define ID_CTR_EL0		"ctr_el0"
> > +
> > +#define ID_AA64PFR0_EL1		"id_aa64pfr0_el1"
> > +#define ID_AA64DFR0_EL1		"id_aa64dfr0_el1"
> > +#define ID_AA64AFR0_EL1		"id_aa64afr0_el1"
> > +#define ID_AA64ISAR0_EL1	"id_aa64isar0_el1"
> > +#define ID_AA64MMFR0_EL1	"id_aa64mmfr0_el1"
> > +
> > +#define read_cpuid(reg) ({						\
> > +	u64 __val;							\
> > +	asm("mrs	%0, " reg : "=r" (__val));			\
> > +	__val;								\
> > +})
> > +
> > +/*
> > + * The CPU ID never changes at run time, so we might as well tell the
> > + * compiler that it's constant.  Use this function to read the CPU ID
> > + * rather than directly reading processor_id or read_cpuid() directly.
> > + */
> > +static inline u32 __attribute_const__ read_cpuid_id(void)
> > +{
> > +	return read_cpuid(ID_MIDR_EL1);
> > +}
> > +
> > +static inline u32 __attribute_const__ read_cpuid_cachetype(void)
> > +{
> > +	return read_cpuid(ID_CTR_EL0);
> > +}
> 
> Is this perhaps a carry-over from arch/arm? Abstracting out read_cpuid()
> doesn't seem to buy anything here, just opencode the one-line assembly
> in each.

read_cpuid() is called from several other files under arch/arm64 and
also used in expressions, so it's a good abstraction.

> > --- /dev/null
> > +++ b/arch/arm64/mm/proc.S
> > @@ -0,0 +1,193 @@
> > +	.section ".proc.info.init", #alloc, #execinstr
> > +
> > +	.type	__v8_proc_info, #object
> > +__v8_proc_info:
> > +	.long	0x000f0000			// Required ID value
> > +	.long	0x000f0000			// Mask for ID
> > +	b	__cpu_setup
> > +	nop
> > +	.quad	cpu_name
> > +	.long	0
> > +	.size	__v8_proc_info, . - __v8_proc_info
> 
> I know this is a carry-over from arch/arm, but how about moving this
> to more of a C construct similar to arch/powerpc/kernel/cputable.c
> instead? It's considerably easier to read that way, and it's convenient
> to have the definitions all in one place, making it easier to share some
> of the functions, etc.

Done in version 3. It's easier to read :).

-- 
Catalin
