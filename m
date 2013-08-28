From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 17:44:50 +0100
Subject: [PATCH 11/19] ARM: alignment: correctly decode instructions in
 BE8 mode.
In-Reply-To: <1377639509-22778-12-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-12-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828164450.GD3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:21PM +0100, Ben Dooks wrote:
> If we are in BE8 mode, we must deal with the instruction stream being
> in LE order when data is being loaded in BE order. Ensure the data is
> swapped before processing to avoid thre following:
> 
> Change to using <asm/opcodes.h> to provide the necessary conversion
> functions to change the byte ordering.
> 
> Alignment trap: not handling instruction 030091e8 at [<80333e8c>]
> Unhandled fault: alignment exception (0x001) at 0xbfa09567

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mm/alignment.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 6f4585b..9240364 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -25,6 +25,7 @@
>  #include <asm/cp15.h>
>  #include <asm/system_info.h>
>  #include <asm/unaligned.h>
> +#include <asm/opcodes.h>
>  
>  #include "fault.h"
>  
> @@ -762,21 +763,25 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (thumb_mode(regs)) {
>  		u16 *ptr = (u16 *)(instrptr & ~1);
>  		fault = probe_kernel_address(ptr, tinstr);
> +		tinstr = __mem_to_opcode_thumb16(tinstr);
>  		if (!fault) {
>  			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
>  			    IS_T32(tinstr)) {
>  				/* Thumb-2 32-bit */
>  				u16 tinst2 = 0;
>  				fault = probe_kernel_address(ptr + 1, tinst2);
> -				instr = (tinstr << 16) | tinst2;
> +				tinst2 = __mem_to_opcode_thumb16(tinst2);
> +				instr = __opcode_thumb32_compose(tinstr, tinst2);
>  				thumb2_32b = 1;
>  			} else {
>  				isize = 2;
>  				instr = thumb2arm(tinstr);
>  			}
>  		}
> -	} else
> +	} else {
>  		fault = probe_kernel_address(instrptr, instr);
> +		instr = __mem_to_opcode_arm(instr);
> +	}
>  
>  	if (fault) {
>  		type = TYPE_FAULT;
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
