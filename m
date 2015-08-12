From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Aug 2015 15:47:38 +0100
Subject: [PATCH v8 5/7] arm64: Add trampoline code for kretprobes
In-Reply-To: <1439254364-15362-6-git-send-email-dave.long@linaro.org>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-6-git-send-email-dave.long@linaro.org>
Message-ID: <20150812144738.GG23540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Aug 11, 2015 at 01:52:42AM +0100, David Long wrote:
> From: William Cohen <wcohen@redhat.com>
> 
> The trampoline code is used by kretprobes to capture a return from a probed
> function.  This is done by saving the registers, calling the handler, and
> restoring the registers.  The code then returns to the original saved caller
> return address.  It is necessary to do this directly instead of using a
> software breakpoint because the code used in processing that breakpoint
> could itself be kprobe'd and cause a problematic reentry into the debug
> exception handler.
> 
> Signed-off-by: William Cohen <wcohen@redhat.com>
> Signed-off-by: David A. Long <dave.long@linaro.org>

[...]

> diff --git a/arch/arm64/kernel/kprobes_trampoline.S b/arch/arm64/kernel/kprobes_trampoline.S
> new file mode 100644
> index 0000000..dd0172b
> --- /dev/null
> +++ b/arch/arm64/kernel/kprobes_trampoline.S
> @@ -0,0 +1,61 @@
> +/*
> + * trampoline entry and return code for kretprobes.
> + */
> +
> +#include <linux/linkage.h>
> +#include <generated/asm-offsets.h>
> +
> +	.text
> +
> +ENTRY(kretprobe_trampoline)
> +
> +	sub sp, sp, #S_FRAME_SIZE
> +
> +	stp x0, x1, [sp, #S_X0]
> +	stp x2, x3, [sp, #S_X2]
> +	stp x4, x5, [sp, #S_X4]
> +	stp x6, x7, [sp, #S_X6]
> +	stp x8, x9, [sp, #S_X8]
> +	stp x10, x11, [sp, #S_X10]
> +	stp x12, x13, [sp, #S_X12]
> +	stp x14, x15, [sp, #S_X14]
> +	stp x16, x17, [sp, #S_X16]
> +	stp x18, x19, [sp, #S_X18]
> +	stp x20, x21, [sp, #S_X20]
> +	stp x22, x23, [sp, #S_X22]
> +	stp x24, x25, [sp, #S_X24]
> +	stp x26, x27, [sp, #S_X26]
> +	stp x28, x29, [sp, #S_X28]
> +	str x30, [sp, #S_LR]
> +	mrs x0, nzcv
> +	str x0, [sp, #S_PSTATE]

I'm slightly wary of this, as it means user_mode(regs) will return true
for the pt_regs passed into the handler. Do we need to force the mode?
What about things like the I bit?

Similarly, why don't you save the stack pointer?

> +
> +	mov x0, sp
> +	bl trampoline_probe_handler
> +	/* Replace trampoline address in lr with actual
> +	   orig_ret_addr return address. */
> +	str x0, [sp, #S_LR]

Why can't the trampoline_probe_handler update the pt_regs directly?

Will
