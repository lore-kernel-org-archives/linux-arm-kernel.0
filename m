From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 12:22:53 +0100
Subject: [PATCH 12/19] ARM: traps: use <asm/opcodes.h> to get correct
 instruction order
In-Reply-To: <1377639509-22778-13-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-13-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828112245.GA3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:22PM +0100, Ben Dooks wrote:
> The trap handler needs to take into account the endian configuration of
> the system when loading instructions. Use <asm/opcodes.h> to provide the
> necessary conversion functions.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/kernel/traps.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index ab517fc..99bcd0e3 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -34,6 +34,7 @@
>  #include <asm/unwind.h>
>  #include <asm/tls.h>
>  #include <asm/system_misc.h>
> +#include <asm/opcodes.h>
>  
>  static const char *handler[]= { "prefetch abort", "data abort", "address exception", "interrupt" };
>  
> @@ -402,25 +403,28 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>  	if (processor_mode(regs) == SVC_MODE) {
>  #ifdef CONFIG_THUMB2_KERNEL
>  		if (thumb_mode(regs)) {
> -			instr = ((u16 *)pc)[0];
> +			instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
>  			if (is_wide_instruction(instr)) {
> -				instr <<= 16;
> -				instr |= ((u16 *)pc)[1];
> +				u16 inst2;
> +				instr2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);

Typo?

inst2 versus instr2.

Cheers
---Dave

> +				instr = __opcode_thumb32_compose(instr, instr2);
>  			}
>  		} else
>  #endif
> -			instr = *(u32 *) pc;
> +			instr = __mem_to_opcode_arm(*(u32 *) pc);
>  	} else if (thumb_mode(regs)) {
>  		if (get_user(instr, (u16 __user *)pc))
>  			goto die_sig;
> +		instr = __mem_to_opcode_thumb16(instr);
>  		if (is_wide_instruction(instr)) {
>  			unsigned int instr2;
>  			if (get_user(instr2, (u16 __user *)pc+1))
>  				goto die_sig;
> -			instr <<= 16;
> -			instr |= instr2;
> +			instr2 = __mem_to_opcode_thumb16(instr2);
> +			instr = __opcode_thumb32_compose(instr, instr2);
>  		}
>  	} else if (get_user(instr, (u32 __user *)pc)) {
> +		instr = __mem_to_opcode_arm(instr);
>  		goto die_sig;
>  	}
>  
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
