From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 16:48:10 +0000
Subject: [RFC PATCH v2 21/41] arm64/sve: Enable SVE on demand for userspace
In-Reply-To: <1490194274-30569-22-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-22-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170322164809.GC19950@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 22, 2017 at 02:50:51PM +0000, Dave Martin wrote:
> This patch tracks whether a task has ever attempted to use the
> Scalable Vector Extension.  If and only if SVE is in use by a task,
> it will be enabled for userspace when scheduling the task in.  For
> other tasks, SVE is disabled when scheduling in.

>  #define TIF_SYSCALL_AUDIT	9
>  #define TIF_SYSCALL_TRACEPOINT	10
>  #define TIF_SECCOMP		11
> +#define TIF_SVE			17	/* Scalable Vector Extension in use */

Please don't skip ahead to bit 17. I see why you're doing that, but I
don't think that's a good idea. More on that below.

> +void do_sve_acc(unsigned int esr, struct pt_regs *regs)
> +{
> +	unsigned long tmp;
> +
> +	if (test_and_set_thread_flag(TIF_SVE))
> +		BUG();
> +
> +	asm ("mrs %0, cpacr_el1" : "=r" (tmp));
> +	asm volatile ("msr cpacr_el1, %0" :: "r" (tmp | (1 << 17)));

Please de-magic the number, e.g. with something like:

#define CPACR_SVE_EN	(1 << 17)

... in <asm/sysreg.h>.

Please also use {read,write}_sysreg(), e.g.

	val = read_sysreg(cpacr_el1);
	tmp |= CPACR_SVE_EN;
	write_sysreg(tmp, cpacr_el1);

[...]

> +		if (IS_ENABLED(CONFIG_ARM64_SVE)) {
> +			/*
> +			 * Flip SVE enable for userspace if it doesn't
> +			 * match the current_task.
> +			 */
> +			asm ("mrs %0, cpacr_el1" : "=r" (tmp));
> +			flags = current_thread_info()->flags;
> +			if ((tmp ^ (unsigned long)flags) & (1 << 17)) {
> +				tmp ^= 1 << 17;
> +				asm volatile ("msr cpacr_el1, %0" :: "r" (tmp));
> +			}

I think it's a bad idea to rely on the TIF flag and CPACR bit to have
the same index. It makes this painful to read, and it leaves us fragile
if the TIF bits are reorganised.

How about:

	unsigned long cpacr = read_sysreg(cpacr_el1);
	bool hw_enabled = !!(cpacr & CPACR_SVE_EN);
	bool sw_enabled = test_thread_flag(TIF_SVE);

	/*
	 * Flip SVE enable for userspace if it doesn't
	 * match the current_task.
	 */
	if (hw_enabled != sw_enabled) {
		cpacr ^= CPACR_SVE_EN;
		write_sysreg(cpacr, cpacr_el1);
	}

Thanks,
Mark.
