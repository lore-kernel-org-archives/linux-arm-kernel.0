From: rric@kernel.org (Robert Richter)
Date: Fri, 23 May 2014 14:11:35 +0200
Subject: [PATCH RESEND 2/7] ARM: Introduce arm_get_current_stack_frame()
In-Reply-To: <1400837196-22339-3-git-send-email-Nikolay.Borisov@arm.com>
References: <1400837196-22339-1-git-send-email-Nikolay.Borisov@arm.com>
 <1400837196-22339-3-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140523121135.GV27560@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.05.14 10:26:31, Nikolay Borisov wrote:

> +#define frame_pointer(regs)				  \
> +	IS_ENABLED(CONFIG_THUMB2_KERNEL) ? (regs)->ARM_r7 \
> +	: (regs)->ARM_fp				  \

#ifdef CONFIG_THUMB2_KERNEL

... is better here, this is booleon, not tristate, better to read, and
no mixed c and macro statements either.

> +void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
> +{
> +		frame->fp = frame_pointer(regs);
> +		frame->sp = regs->ARM_sp;
> +		frame->lr = regs->ARM_lr;
> +		frame->pc = regs->ARM_pc;
> +}
> +EXPORT_SYMBOL_GPL(arm_get_current_stackframe);

I am wondering if this should be better implemented as inline function
as this is in the hot path.

-Robert
