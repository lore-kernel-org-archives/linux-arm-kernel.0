From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 11 Jul 2018 11:55:23 +0100
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
In-Reply-To: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
References: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
Message-ID: <20180711105523.GL9486@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 09:09:59AM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> It does not matter if the caller of may_use_simd() migrates to
> another cpu after the call, but it is still important that the
> kernel_neon_busy percpu instance that is read matches the cpu the
> task is running on at the time of the read.
> 
> This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
> may appear true if the caller migrates during the execution of
> raw_cpu_read() and the next task to be scheduled in on the initial
> cpu calls kernel_neon_begin().
> 
> This patch replaces raw_cpu_read() with this_cpu_read() to protect
> against this race.
> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>

Looks ok to me.  You can add the following tags:

Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
Reviewed-by: Dave Martin <Dave.Martin@arm.com>


Cheers
---Dave


> ---
>  arch/arm64/include/asm/simd.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..784a8c2 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,7 +29,8 @@
>  static __must_check inline bool may_use_simd(void)
>  {
>  	/*
> -	 * The raw_cpu_read() is racy if called with preemption enabled.
> +	 * The this_cpu_read() is racy if called with preemption enabled,
> +	 * since the task may subsequently migrate to another CPU.
>  	 * This is not a bug: kernel_neon_busy is only set when
>  	 * preemption is disabled, so we cannot migrate to another CPU
>  	 * while it is set, nor can we migrate to a CPU where it is set.
> @@ -42,7 +43,7 @@ static __must_check inline bool may_use_simd(void)
>  	 * false.
>  	 */
>  	return !in_irq() && !irqs_disabled() && !in_nmi() &&
> -		!raw_cpu_read(kernel_neon_busy);
> +		!this_cpu_read(kernel_neon_busy);
>  }
>  
>  #else /* ! CONFIG_KERNEL_MODE_NEON */
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
