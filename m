From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 16:55:27 +0000
Subject: [RFC PATCH v2 23/41] arm64/sve: Move ZEN handling to the common
 task_fpsimd_load() path
In-Reply-To: <1490194274-30569-24-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-24-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170322165527.GD19950@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 22, 2017 at 02:50:53PM +0000, Dave Martin wrote:
>  void do_sve_acc(unsigned int esr, struct pt_regs *regs)
>  {
> -	unsigned long tmp;
> +	if (test_and_set_thread_flag(TIF_SVE)) {
> +		unsigned long tmp;
>  
> -	if (test_and_set_thread_flag(TIF_SVE))
> +		asm ("mrs %0, cpacr_el1" : "=r" (tmp));

Please use read_sysreg().

> +
> +		printk(KERN_INFO "%s: Strange, ZEN=%u\n",
> +		       __func__, (unsigned int)((tmp >> 16) & 3));
>  		BUG();

Given we're about to BUG(), I guess it would make more sense to use
pr_err() here, and be a bit more informative. e.g.

	pr_crit("SVE trap taken unexpectedly. CPACR_EL1.ZEN is %u\n",
		(unsigned int)((tmp >> 16) & 3));
	BUG();

... my usual comments w.r.t. magic numbers apply.

[...]

> +		BUILD_BUG_ON(_TIF_SVE != CPACR_EL1_ZEN_EL0EN);

As previously, I do not think this is a good idea. Treating these as
separate values is not difficult, and IMO far easier to reason about.

Thanks,
Mark.
