From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 14 Jun 2016 10:42:28 +0900
Subject: [PATCH v13 05/10] arm64: Kprobes with single stepping support
In-Reply-To: <1464924384-15269-6-git-send-email-dave.long@linaro.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-6-git-send-email-dave.long@linaro.org>
Message-ID: <20160614104228.0e94341a298b3ca94b2f47c3@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

I have additional comments on this.

On Thu,  2 Jun 2016 23:26:19 -0400
David Long <dave.long@linaro.org> wrote:
> +/*
> + * The D-flag (Debug mask) is set (masked) upon deug exception entry.

deug -> debug

> + * Kprobes needs to clear (unmask) D-flag -ONLY- in case of recursive
> + * probe i.e. when probe hit from kprobe handler context upon
> + * executing the pre/post handlers. In this case we return with
> + * D-flag clear so that single-stepping can be carried-out.
> + *
> + * Leave D-flag set in all other cases.
> + */
> +static void __kprobes
> +spsr_set_debug_flag(struct pt_regs *regs, int mask)
> +{
> +	unsigned long spsr = regs->pstate;
> +
> +	if (mask)
> +		spsr |= PSR_D_BIT;
> +	else
> +		spsr &= ~PSR_D_BIT;
> +
> +	regs->pstate = spsr;
> +}
> +
[..]
> +
> +int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
> +{
> +	struct kprobe *cur = kprobe_running();
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	switch (kcb->kprobe_status) {
> +	case KPROBE_HIT_SS:
> +	case KPROBE_REENTER:
> +		/*
> +		 * We are here because the instruction being single
> +		 * stepped caused a page fault. We reset the current
> +		 * kprobe and the ip points back to the probe address
> +		 * and allow the page fault handler to continue as a
> +		 * normal page fault.
> +		 */
> +		instruction_pointer(regs) = (unsigned long)cur->addr;
> +		if (!instruction_pointer(regs))
> +			BUG();

As according to the recent x86 kprobe bug on fault handler
discussion, here this also need kernel_disable_single_stap()
and spsr_set_debug_flag() in case of KPROBE_REENTER as you did
in kprobe_single_step_handler(). (Also, those code should be
a function for reuse)


> +		if (kcb->kprobe_status == KPROBE_REENTER)
> +			restore_previous_kprobe(kcb);
> +		else
> +			reset_current_kprobe();

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
