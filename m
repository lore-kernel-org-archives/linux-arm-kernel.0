From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 24 Jul 2013 18:52:21 +0100
Subject: [PATCH 3/4] ARM: module: correctly relocate instructions in BE8
In-Reply-To: <1374510833-25716-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374510833-25716-4-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130724175221.GD4610@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 05:33:52PM +0100, Ben Dooks wrote:
> When in BE8 mode, our instructions are not in the same ordering as the
> data, so use <asm/opcodes.h> to take this into account.
> 
> Note, also requires modules to be built --be8
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/kernel/module.c |   57 +++++++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 1e9be5d..7e13787 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -24,6 +24,7 @@
>  #include <asm/sections.h>
>  #include <asm/smp_plat.h>
>  #include <asm/unwind.h>
> +#include <asm/opcodes.h>
>  
>  #ifdef CONFIG_XIP_KERNEL
>  /*
> @@ -60,6 +61,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  		Elf32_Sym *sym;
>  		const char *symname;
>  		s32 offset;
> +		u32 tmp;
>  #ifdef CONFIG_THUMB2_KERNEL
>  		u32 upper, lower, sign, j1, j2;
>  #endif
> @@ -95,7 +97,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  		case R_ARM_PC24:
>  		case R_ARM_CALL:
>  		case R_ARM_JUMP24:
> -			offset = (*(u32 *)loc & 0x00ffffff) << 2;
> +			offset = __mem_to_opcode_arm(*(u32 *)loc);
> +			offset = (offset & 0x00ffffff) << 2;
>  			if (offset & 0x02000000)
>  				offset -= 0x04000000;
>  
> @@ -111,9 +114,10 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  			}
>  
>  			offset >>= 2;
> +			offset &= 0x00ffffff;
>  
> -			*(u32 *)loc &= 0xff000000;
> -			*(u32 *)loc |= offset & 0x00ffffff;
> +			*(u32 *)loc &= __opcode_to_mem_arm(0xff000000);
> +			*(u32 *)loc |= __opcode_to_mem_arm(offset);

Here it's assumed that

__opcode_to_mem_arm(x | y) == __opcode_to_mem_arm(x) | __opcode_to_mem_arm(x)

(and related rules)

Since the macros really do just shuffle bits, that does work, but it may
be a bit cleaner to build on the instruction in canonical representation
and use __opcode_to_mem_arm() just once to avoid such subtleties.

Then we can simply treat instructions in memory as opaque data, which all
flows into the code through __mem_to_opcode*() and back out through
__opcode_to_mem*().

(analogous to ntohs() ... do something useful ... htons() etc.)


So:
			tmp = __mem_to_opcode_arm(*(u32 *)loc);
			tmp = (tmp & 0xff000000) | offset;
			*(u32 *)loc = __opcode_to_mem_arm(tmp);

I think that's cleaner, but it's open to debate.  GCC might generate
slightly inferior code, depending on how clever it is ... but this
isn't a fast path.


The same style could be applied to all the relocations here.  It
could help to avoid confusion about which byte order a particular
vairable or literal uses -- i.e., ARM ARM order is used for
everything except the contents of memory.


I have to abort this review now ... I'll try to look at the rest
tomorrow.

Cheers
---Dave

>  			break;
>  
>  	       case R_ARM_V4BX:
> @@ -121,8 +125,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  			* other bits to re-code instruction as
>  			* MOV PC,Rm.
>  			*/
> -		       *(u32 *)loc &= 0xf000000f;
> -		       *(u32 *)loc |= 0x01a0f000;
> +		       *(u32 *)loc &= __opcode_to_mem_arm(0xf000000f);
> +		       *(u32 *)loc |= __opcode_to_mem_arm(0x01a0f000);
>  		       break;
>  
>  		case R_ARM_PREL31:
> @@ -132,7 +136,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  
>  		case R_ARM_MOVW_ABS_NC:
>  		case R_ARM_MOVT_ABS:
> -			offset = *(u32 *)loc;
> +			offset = tmp = __mem_to_opcode_arm(*(u32 *)loc);
>  			offset = ((offset & 0xf0000) >> 4) | (offset & 0xfff);
>  			offset = (offset ^ 0x8000) - 0x8000;
>  
> @@ -140,16 +144,18 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS)
>  				offset >>= 16;
>  
> -			*(u32 *)loc &= 0xfff0f000;
> -			*(u32 *)loc |= ((offset & 0xf000) << 4) |
> -					(offset & 0x0fff);
> +			tmp &= 0xfff0f000;
> +			tmp |= ((offset & 0xf000) << 4) |
> +				(offset & 0x0fff);
> +
> +			*(u32 *)loc = __opcode_to_mem_arm(tmp);
>  			break;
>  
>  #ifdef CONFIG_THUMB2_KERNEL
>  		case R_ARM_THM_CALL:
>  		case R_ARM_THM_JUMP24:
> -			upper = *(u16 *)loc;
> -			lower = *(u16 *)(loc + 2);
> +			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
> +			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
>  
>  			/*
>  			 * 25 bit signed address range (Thumb-2 BL and B.W
> @@ -198,17 +204,20 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  			sign = (offset >> 24) & 1;
>  			j1 = sign ^ (~(offset >> 23) & 1);
>  			j2 = sign ^ (~(offset >> 22) & 1);
> -			*(u16 *)loc = (u16)((upper & 0xf800) | (sign << 10) |
> +			upper = (u16)((upper & 0xf800) | (sign << 10) |
>  					    ((offset >> 12) & 0x03ff));
> -			*(u16 *)(loc + 2) = (u16)((lower & 0xd000) |
> -						  (j1 << 13) | (j2 << 11) |
> -						  ((offset >> 1) & 0x07ff));
> +			lower = (u16)((lower & 0xd000) |
> +				      (j1 << 13) | (j2 << 11) |
> +				      ((offset >> 1) & 0x07ff));
> +
> +			*(u16 *)loc = __opcode_to_mem_thumb16(upper);
> +			*(u16 *)(loc + 2) = __opcode_to_mem_thumb16(lower);
>  			break;
>  
>  		case R_ARM_THM_MOVW_ABS_NC:
>  		case R_ARM_THM_MOVT_ABS:
> -			upper = *(u16 *)loc;
> -			lower = *(u16 *)(loc + 2);
> +			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
> +			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
>  
>  			/*
>  			 * MOVT/MOVW instructions encoding in Thumb-2:
> @@ -229,12 +238,14 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS)
>  				offset >>= 16;
>  
> -			*(u16 *)loc = (u16)((upper & 0xfbf0) |
> -					    ((offset & 0xf000) >> 12) |
> -					    ((offset & 0x0800) >> 1));
> -			*(u16 *)(loc + 2) = (u16)((lower & 0x8f00) |
> -						  ((offset & 0x0700) << 4) |
> -						  (offset & 0x00ff));
> +			upper = (u16)((upper & 0xfbf0) |
> +				      ((offset & 0xf000) >> 12) |
> +				      ((offset & 0x0800) >> 1));
> +			lower = (u16)((lower & 0x8f00) |
> +				      ((offset & 0x0700) << 4) |
> +				      (offset & 0x00ff));
> +			*(u16 *)loc = __opcode_to_mem_thumb16(upper);
> +			*(u16 *)(loc + 2) = __opcode_to_mem_thumb16(lower);
>  			break;
>  #endif
>  
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
