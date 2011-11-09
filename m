From: jon.medhurst@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 09 Nov 2011 13:38:41 +0000
Subject: [PATCH] ARM: hw_breakpoint: don't fault when debug is not powered
In-Reply-To: <1320843602-12278-1-git-send-email-linus.walleij@stericsson.com>
References: <1320843602-12278-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1320845921.2427.15.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-09 at 14:00 +0100, Linus Walleij wrote:
> From: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> If the debug logic is not powered, the processor can unfortunately
> raise an undefined instruction exception on the instruction that
> we use to check if the debug logic is powered up or not.
> 
> Handle this with an undef hook, so that the kernel doesn't crash
> on boot on such setups.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/kernel/hw_breakpoint.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index 814a52a9..f46137c 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -854,6 +854,25 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
>  	return ret;
>  }
>  
> +static int hw_breakpoint_undef(struct pt_regs *regs, unsigned int instr)
> +{
> +	int reg = (instr >> 12) & 15;
> +
> +	/* Fake sticky power-down cleared */
> +	regs->uregs[reg] = 0;
> +	regs->ARM_pc += 4;
> +
> +	return 0;
> +}
> +
> +static struct undef_hook hw_breakpoint_hook = {
> +	.instr_mask	= 0xffff0fff,
> +	.instr_val	= 0xee110e95,
> +	.cpsr_mask	= MODE_MASK,
> +	.cpsr_val	= SVC_MODE,
> +	.fn		= hw_breakpoint_undef,
> +};
> +

This should work OK on Thumb2 kernels as the encoding for the MRC
instruction is the same as on ARM :-) Is it worth a comment to this
effect?

-- 
Tixy
