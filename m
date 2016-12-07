From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Dec 2016 10:57:31 +0000
Subject: [PATCH 4/7] arm: Add ftrace with regs support
In-Reply-To: <1481043967-15602-5-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-5-git-send-email-abelvesa@linux.com>
Message-ID: <20161207105731.GI14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 05:06:04PM +0000, Abel Vesa wrote:
> This adds __ftrace_regs_caller which, unlike __ftrace_caller,
> adds register saving/restoring and livepatch handling if
> the pc register gets modified by klp_ftrace_handler.
> 
> Signed-off-by: Abel Vesa <abelvesa@linux.com>
> ---
>  arch/arm/kernel/entry-ftrace.S | 49 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index c73c403..b6ada5c 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -92,6 +92,46 @@
>  2:	mcount_exit
>  .endm
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +
> +.macro __ftrace_regs_caller suffix
> +
> +	stmdb	sp!, {r0-r15}
> +	mov	r3, sp
> +
> +	ldr	r10, [sp, #60]
> +
> +	mcount_get_lr   r1                      @ lr of instrumented func
> +	mcount_adjust_addr	r0, lr		@ instrumented function
> +
> +	.globl ftrace_regs_call\suffix
> +ftrace_regs_call\suffix:
> +	bl	ftrace_stub
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +	.globl ftrace_regs_graph_call\suffix
> +ftrace_regs_graph_call\suffix:
> +	mov	r0, r0
> +#endif
> +#ifdef CONFIG_LIVEPATCH
> +	ldr	r0, [sp, #60]
> +	cmp	r0, r10
> +	beq	ftrace_regs_caller_end
> +	ldmia	sp!, {r0-r12}
> +	add	sp, sp, #8
> +	ldmia	sp!, {r11}
> +	sub	sp, r12, #16
> +	str	r11, [sp, #12]
> +	ldmia	sp!, {r11, r12, lr, pc}

Some comments about the above stack manipulation (in the code) would be
useful - remember, the contents of your cover letter is lost when the
patches are applied.

However, I'm not convinced yet that this doesn't unbalance the stack,
unless the livepatching code pushes some extra registers onto it,
particularly with the following unstacking code after the livepatch
code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
