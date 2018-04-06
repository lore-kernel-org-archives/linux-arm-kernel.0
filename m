From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Apr 2018 11:57:09 +0100
Subject: [PATCH 1/5] arm64: entry: isb in el1_irq
In-Reply-To: <20180405171800.5648-2-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
Message-ID: <20180406105709.kd3uumwustwnzcd4@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 08:17:56PM +0300, Yury Norov wrote:
> Kernel text patching framework relies on IPI to ensure that other
> SMP cores observe the change. Target core calls isb() in IPI handler
> path, but not at the beginning of el1_irq entry. There's a chance
> that modified instruction will appear prior isb(), and so will not be
> observed.
> 
> This patch inserts isb early at el1_irq entry to avoid that chance.

As James pointed out, taking an exception is context synchronizing, so
this looks unnecessary.

Also, it's important to realise that the exception entry is not tied to a
specific interrupt. We might take an EL1 IRQ because of a timer interrupt,
then an IPI could be taken before we get to gic_handle_irq().

This means that we can race:

	CPU0				CPU1
	<take IRQ>
	ISB
					<patch text>
					<send IPI>
	<discover IPI pending>

... and thus the ISB is too early.

Only once we're in the interrupt handler can we pair an ISB with the IPI, and
any code executed before that is not guaranteed to be up-to-date.

Thanks,
Mark.

> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arm64/kernel/entry.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ec2ee720e33e..9c06b4b80060 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -593,6 +593,7 @@ ENDPROC(el1_sync)
>  
>  	.align	6
>  el1_irq:
> +	isb					// pairs with aarch64_insn_patch_text
>  	kernel_entry 1
>  	enable_da_f
>  #ifdef CONFIG_TRACE_IRQFLAGS
> -- 
> 2.14.1
> 
