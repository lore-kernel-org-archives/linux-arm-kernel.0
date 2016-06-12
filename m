From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Sun, 12 Jun 2016 20:39:00 +0800
Subject: [PATCH 21/23] arm64: ilp32: introduce ilp32-specific handlers for
 sigframe and ucontext
In-Reply-To: <1464048292-30136-22-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-22-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <575D57E4.6020709@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury


Here is another print issue in this patch:

On 2016/5/24 8:04, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
>
> ILP32 uses AARCH32 compat structures and syscall handlers for signals.
> But ILP32 struct rt_sigframe  and ucontext differs from both LP64 and
> AARCH32. So some specific mechanism is needed to take care of it.
>
[...]
> diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
> new file mode 100644
> index 0000000..841e8f8
> --- /dev/null
> +++ b/arch/arm64/kernel/signal_ilp32.c
> @@ -0,0 +1,192 @@
> +/*
[...]
> +asmlinkage long ilp32_sys_rt_sigreturn(struct pt_regs *regs)
> +{
> +	struct ilp32_rt_sigframe __user *frame;
> +
> +	/* Always make any pending restarted system calls return -EINTR */
> +	current->restart_block.fn = do_no_restart_syscall;
> +
> +	/*
> +	 * Since we stacked the signal on a 128-bit boundary,
> +	 * then 'sp' should be word aligned here.  If it's
> +	 * not, then the user is trying to mess with us.
> +	 */
> +	if (regs->sp & 15)
> +		goto badframe;
> +
> +	frame = (struct ilp32_rt_sigframe __user *)regs->sp;
> +
> +	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
> +		goto badframe;
> +
> +	if (restore_ilp32_sigframe(regs, &frame->sig))
> +		goto badframe;
> +
> +	if (compat_restore_altstack(&frame->sig.uc.uc_stack))
> +		goto badframe;
> +
> +	return regs->regs[0];
> +
> +badframe:
> +	if (show_unhandled_signals)
> +		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
> +				    current->comm, task_pid_nr(current), __func__,
> +				    regs->pc, regs->compat_sp);
It should be sp instead of compat_sp. The latter one is used by aarch32 EE.

Regards

Bamvor
> +	force_sig(SIGSEGV, current);
> +	return 0;
> +}
> +
