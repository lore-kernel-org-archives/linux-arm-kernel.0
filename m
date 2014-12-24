From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Dec 2014 09:54:51 +0000
Subject: [PATCH] ARM: 8235/1: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1419374520.4705.84.camel@decadent.org.uk>
References: <1419374520.4705.84.camel@decadent.org.uk>
Message-ID: <20141224095451.GA13399@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 10:42:00PM +0000, Ben Hutchings wrote:
> On Sat, 2014-11-29 at 02:33 +0100, Jungseung Lee wrote:
> > Modern ARMv7-A/R cores optionally implement below new
> > hardware feature:
> > 
> > - PXN:
> > Privileged execute-never(PXN) is a security feature. PXN bit
> > determines whether the processor can execute software from
> > the region. This is effective solution against ret2usr attack.
> > On an implementation that does not include the LPAE, PXN is
> > optionally supported.
> > 
> > This patch set PXN bit on user page table for preventing
> > user code execution with privilege mode.
> [...]
> > +
> > +	/*
> > +	 * Check is it with support for the PXN bit
> > +	 * in the Short-descriptor translation table format descriptors.
> > +	 */
> > +	if (cpu_arch == CPU_ARCH_ARMv7 &&
> > +		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) == 4) {
> > +		user_pmd_table |= PMD_PXNTABLE;
> > +	}
> [...]
> 
> I thought it was odd that this checks for a specific value of 4 bits,
> not just 1.  Unfortunately I don't have access to the ARM Architecture
> Reference Manual, but I reviewed the public documentation to find the
> value of MMFR0 in current Cortex-A and -R cores.
> 
> So far as I can see, these 4 bits are equal to 5 on the Cortex cores
> that support LPAE (A7, A15, A53, A57), 3 on other v7-A cores and 0 on
> v7-R cores.
> 
> I think that if a non-LPAE kernel runs on a processor that supports
> LPAE, it should use PXN in short descriptors.  In that case, this test
> should be changed to match a value of 5 as well.  Maybe it should be
> simply be read_cpuid_ext(CPUID_EXT_MMFR0) & 4, but as I said I can't
> check this against the ARM ARM.

The MMFR0.VMSA field is 4 bits wide. The individual bits don't have a
meaning, it's just a counter as follows:

0b0000 Not supported.
0b0001 Support for IMPLEMENTATION DEFINED VMSA.
0b0010 Support for VMSAv6, with Cache and TLB Type Registers
       implemented.
0b0011 Support for VMSAv7, with support for remapping and the Access
       flag. ARMv7-A profile.
0b0100 As for 0b0011, and adds support for the PXN bit in the
       Short-descriptor translation table format descriptors.
0b0101 As for 0b0100, and adds support for the Long-descriptor
       translation table format.

So I agree that we should not just check for 4 since 5 has the PXN
feature (they are incremental, so it would be safe for 6/7/8 etc). But I
would use ">= 4" rather than just checking a bit in case we ever get to
8.

-- 
Catalin
