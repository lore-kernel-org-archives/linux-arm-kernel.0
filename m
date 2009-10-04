From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Oct 2009 13:21:12 +0100
Subject: [PATCH 3/6] Change type of VMALLOC_END to unsigned long.
In-Reply-To: <1254394141-26673-4-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-3-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-4-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <20091004122112.GB26794@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 12:48:58PM +0200, Andreas Fenkart wrote:
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 38b6a78..0cc3c4b 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -104,11 +104,11 @@
>  #endif
>  
>  #ifndef PHYS_OFFSET
> -#define PHYS_OFFSET 		(CONFIG_DRAM_BASE)
> +#define PHYS_OFFSET 		UL(CONFIG_DRAM_BASE)
>  #endif
>  
>  #ifndef END_MEM
> -#define END_MEM     		(CONFIG_DRAM_BASE + CONFIG_DRAM_SIZE)
> +#define END_MEM     		UL(CONFIG_DRAM_BASE + CONFIG_DRAM_SIZE)

This is still not correct usage of UL().  This becomes:

	CONFIG_DRAM_BASE + CONFIG_DRAM_SIZE##UL

or, in the case of these being defined as zero:

	0 + 0UL

That might end up ultimately being an unsigned long expression, but it
would be far better to explicitly cast the right thing - the base.

Basically, UL() should not be used with an expression argument.  UL()'s
purpose is to allow the numerical value enclosed to be used in both C
as an unsigned long constant, and also in assembly without the UL suffix
(which would cause the assembler to error out.)  It's not there as a
generic "cast to unsigned long" operator.

> diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
> index 41c8938..5fd3784 100644
> --- a/arch/arm/mach-davinci/include/mach/hardware.h
> +++ b/arch/arm/mach-davinci/include/mach/hardware.h
> @@ -30,7 +30,7 @@
>  #define IO_PHYS				0x01c00000
>  #define IO_OFFSET			0xfd000000 /* Virtual IO = 0xfec00000 */
>  #define IO_SIZE				0x00400000
> -#define IO_VIRT				(IO_PHYS + IO_OFFSET)
> +#define IO_VIRT				UL(IO_PHYS + IO_OFFSET)

Same thing.
