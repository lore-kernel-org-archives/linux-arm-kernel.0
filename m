From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 6 Dec 2016 16:28:26 +0000
Subject: [PATCH v2 2/2] arm64: Work around broken .inst when defective
 gas is detected
In-Reply-To: <1481038065-32153-4-git-send-email-marc.zyngier@arm.com>
References: <1481038065-32153-1-git-send-email-marc.zyngier@arm.com>
 <1481038065-32153-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20161206162826.GW1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 03:27:45PM +0000, Marc Zyngier wrote:
> .inst being largely broken with older binutils, it'd be better not
> to emit it altogether when detecting such configuration (as it
> leads to all kind of horrors when using alternatives).

GAS seems to provide few guarantees about the constantness of anything
other than an expression composed purely of literal constants.  So,
this may rather be lack of a useful feature rather than a bug per se.

> Generalize the __emit_inst macro and use it extensively in
> asm/sysreg.h, and make it generate a .long when a broken gas is
> detected. The disassembly will be crap, but at least we can write
> semi-sane code.

Don't know how much this helps, but if we want decent disassembly then
one option is to use macros instead of symbols, so that the argument to
.inst involves only literals after macro expansion.

Something like:

.ifndef .L__with_reg_defined
	.set .L__with_reg_defined, 1

	.macro __def_reg name, num
		.macro __with_reg__\name instr:vararg
			\instr \num
		.endm
	.endm

	.irp n, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
		__def_reg x\n, \n
	.endr
	__def_reg xzr, 31

	.macro __with_reg regname, instr:vararg
		__with_reg__\regname \instr
	.endm
.endif

.ifndef .L__msr_s_defined
	.set .L__msr_s_defined, 1

	.macro __msr_s sreg, rn
		.inst	0xd5000000 | (\sreg) | (\rn)
	.endm

	.macro msr_s sreg, rn
		__with_reg \rn, __msr_s \sreg,
	.endm
.endif

For the inline asm case, gcc will think that the asm assembles to much
larger code that it really does in this, but I suspect this won't matter
in realistic situations.

For the .S case, we would define the macros once only, in the header (as
at present) -- the guards won't be necessary for that.

Cheers
---Dave

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e16a18..98ae03f 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -35,12 +35,33 @@
>  #define sys_reg(op0, op1, crn, crm, op2) \
>  	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
>  
> +#ifndef CONFIG_BROKEN_GAS_INST
> +
>  #ifdef __ASSEMBLY__
>  #define __emit_inst(x)			.inst (x)
>  #else
>  #define __emit_inst(x)			".inst " __stringify((x)) "\n\t"
>  #endif
>  
> +#else  /* CONFIG_BROKEN_GAS_INST */
> +
> +#ifndef CONFIG_CPU_BIG_ENDIAN
> +#define __INSTR_BSWAP(x)		(x)
> +#else  /* CONFIG_CPU_BIG_ENDIAN */
> +#define __INSTR_BSWAP(x)		((((x) << 24) & 0xff000000)	| \
> +					 (((x) <<  8) & 0x00ff0000)	| \
> +					 (((x) >>  8) & 0x0000ff00)	| \
> +					 (((x) >> 24) & 0x000000ff))
> +#endif	/* CONFIG_CPU_BIG_ENDIAN */
> +
> +#ifdef __ASSEMBLY__
> +#define __emit_inst(x)			.long __INSTR_BSWAP(x)
> +#else  /* __ASSEMBLY__ */
> +#define __emit_inst(x)			".long " __stringify(__INSTR_BSWAP(x)) "\n\t"
> +#endif	/* __ASSEMBLY__ */
> +
> +#endif	/* CONFIG_BROKEN_GAS_INST */
> +
>  #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
>  #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
>  #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
> @@ -232,11 +253,11 @@
>  	.equ	.L__reg_num_xzr, 31
>  
>  	.macro	mrs_s, rt, sreg
> -	.inst	0xd5200000|(\sreg)|(.L__reg_num_\rt)
> +	 __emit_inst(0xd5200000|(\sreg)|(.L__reg_num_\rt))
>  	.endm
>  
>  	.macro	msr_s, sreg, rt
> -	.inst	0xd5000000|(\sreg)|(.L__reg_num_\rt)
> +	__emit_inst(0xd5000000|(\sreg)|(.L__reg_num_\rt))
>  	.endm
>  
>  #else
> @@ -250,11 +271,11 @@ asm(
>  "	.equ	.L__reg_num_xzr, 31\n"
>  "\n"
>  "	.macro	mrs_s, rt, sreg\n"
> -"	.inst	0xd5200000|(\\sreg)|(.L__reg_num_\\rt)\n"
> +	__emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))
>  "	.endm\n"
>  "\n"
>  "	.macro	msr_s, sreg, rt\n"
> -"	.inst	0xd5000000|(\\sreg)|(.L__reg_num_\\rt)\n"
> +	__emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))
>  "	.endm\n"
>  );
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
