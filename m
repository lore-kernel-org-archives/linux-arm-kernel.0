From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 9 Jul 2018 11:27:46 +0100
Subject: [PATCH] arm64: neon: Do not access kernel_neon_busy with
 preemption enabled
In-Reply-To: <1530936171-16169-1-git-send-email-yandong77520@gmail.com>
References: <1530936171-16169-1-git-send-email-yandong77520@gmail.com>
Message-ID: <20180709102724.GA9486@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 07, 2018 at 12:02:51PM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> Dear, Dave
> Thank you very much for reading my email. I have a question and
> I hope toget your reply.
> It is a bug to not close the preemption when executing
> raw_cpu_read(kernel_neon_busy) in the function may_use_simd()!
> We encountered a ?sysdump? problem on Kernel 4.14 code because
> the program entered BUG_ON() in the function kernel_neon_begin().
> Our analysis concludes that the process is migrating while executing
> raw_cpu_read(kernel_neon_busy).

Can you include a backtrace, please?

Also, do you have any significant patches applies on top of v4.14?  Is
your configuration different from defconfig?

> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> ---
>  arch/arm64/include/asm/simd.h | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..0d91084 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,20 +29,13 @@
>  static __must_check inline bool may_use_simd(void)
>  {
>  	/*
> -	 * The raw_cpu_read() is racy if called with preemption enabled.
> -	 * This is not a bug: kernel_neon_busy is only set when
> -	 * preemption is disabled, so we cannot migrate to another CPU
> -	 * while it is set, nor can we migrate to a CPU where it is set.
> -	 * So, if we find it clear on some CPU then we're guaranteed to
> -	 * find it clear on any CPU we could migrate to.
> -	 *
> -	 * If we are in between kernel_neon_begin()...kernel_neon_end(),
> -	 * the flag will be set, but preemption is also disabled, so we
> -	 * can't migrate to another CPU and spuriously see it become
> -	 * false.
> +	 * Operations for contexts where we do not want to do any checks for
> +	 * preemptions.  Unless strictly necessary, always use this_cpu_*()
> +	 * instead. Because of the kernel_neon_busy here we have to make sure
> +	 * that it is the current cpu.
>  	 */
>  	return !in_irq() && !irqs_disabled() && !in_nmi() &&
> -		!raw_cpu_read(kernel_neon_busy);
> +		!this_cpu_read(kernel_neon_busy);

This doesn't really make sense by itself: this function is required to
work in preemptible contexts, so in some situations there is no way to
be sure which cpu's kernel_neon_busy flag is read.

The original comment attempts to explain why this doesn't matter, and
why raw_cpu_read() is valid.  Can you explain why this is wrong?


The BUG_ON() in kernel_neon_begin() is there for the purpose of
detecting invalid uses of kernel_neon_begin() -- i.e., one
kernel_neon_begin() nested inside another, or kernel_neon_begin() called
from hardirq or nmi context.

Are you sure kernel_neon_begin() is not being used wrongly somewhere?

If kernel_neon_begin() is being used wrongly, the following hack may
help to identify where the problem is:

Cheers
---Dave

--8<--

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8afc518..e6cabf6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1165,6 +1165,7 @@ void fpsimd_flush_cpu_state(void)
 
 DEFINE_PER_CPU(bool, kernel_neon_busy);
 EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
+static DEFINE_PER_CPU(void *, kernel_neon_caller);
 
 /*
  * Kernel-side NEON support functions
@@ -1188,11 +1189,23 @@ void kernel_neon_begin(void)
 	if (WARN_ON(!system_supports_fpsimd()))
 		return;
 
-	BUG_ON(!may_use_simd());
+	preempt_disable();
+	if (!may_use_simd()) {
+		if (in_irq() || irqs_disabled() || in_nmi())
+			pr_err("fpsimd: kernel_neon_begin() from hardirq/nmi context\n");
+
+		if (this_cpu_read(kernel_neon_busy))
+			pr_err("fpsimd: kernel_neon_begin() already called by %pF\n",
+			       this_cpu_read(kernel_neon_caller));
+
+		BUG();
+	}
+	preempt_enable();
 
 	local_bh_disable();
 
 	__this_cpu_write(kernel_neon_busy, true);
+	__this_cpu_write(kernel_neon_caller, (void *)_RET_IP_);
 
 	/* Save unsaved fpsimd state, if any: */
 	fpsimd_save();
