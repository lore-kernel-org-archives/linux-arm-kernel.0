From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Feb 2016 13:24:58 -0500 (EST)
Subject: [PATCH 3/3] [RESEND] ARM: kprobes: use "I" constraint for inline
 assembly offsets
In-Reply-To: <1455815113-2562966-4-git-send-email-arnd@arndb.de>
References: <1455815113-2562966-1-git-send-email-arnd@arndb.de>
 <1455815113-2562966-4-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1602181248430.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Arnd Bergmann wrote:

> build-testing with clang showed that the "J" constraint does not take
> positive arguments on clang when building in for Thumb-2:
> 
> core.c:540:3: error: invalid operand for inline asm constraint 'J'
> 
> This has been reported as llvm bug https://llvm.org/bugs/show_bug.cgi?id=26061
> 
> However, looking at the source code in depth, I found that the
> kernel is also wrong, and it should not use "J" at all, but should
> use "I" to pass an immediate argument to the inline assembly when that
> is used as an offset to an 'ldr' instruction rather than the 'sub'
> argument.

I don't follow you.

>From the gcc manual:

     'I'
          Integer that is valid as an immediate operand in a data
          processing instruction.  That is, an integer in the range 0 to
          255 rotated by a multiple of 2

     'J'
          Integer in the range -4095 to 4095

>From the ARM ARM:

   LDR<c> <Rt>, [<Rn>{, #+/-<imm12>}]



where imm12 is a constant between 0 and 4095.

So J is really the appropriate constraint here.

Sure, in this case it is very likely that I would just works given that 
offset_of() is unlikely to exceed shifted 8 bits and that's what people 
use in most cases. But strictly speaking it's J that perfectly matches 
the LDR/STR instructions.








> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/probes/kprobes/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index a4ec240ee7ba..4b34b40ca917 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -570,10 +570,10 @@ void __kprobes jprobe_return(void)
>  		:
>  		: "r" (kcb->jprobe_saved_regs.ARM_sp),
>  		  "I" (sizeof(struct pt_regs) * 2),
> -		  "J" (offsetof(struct pt_regs, ARM_sp)),
> -		  "J" (offsetof(struct pt_regs, ARM_pc)),
> -		  "J" (offsetof(struct pt_regs, ARM_cpsr)),
> -		  "J" (offsetof(struct pt_regs, ARM_lr))
> +		  "I" (offsetof(struct pt_regs, ARM_sp)),
> +		  "I" (offsetof(struct pt_regs, ARM_pc)),
> +		  "I" (offsetof(struct pt_regs, ARM_cpsr)),
> +		  "I" (offsetof(struct pt_regs, ARM_lr))
>  		: "memory", "cc");
>  }
>  
> -- 
> 2.7.0
> 
> 
