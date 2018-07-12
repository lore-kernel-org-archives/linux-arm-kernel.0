From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 12 Jul 2018 10:56:05 +0100
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
In-Reply-To: <1531366178-17630-1-git-send-email-yandong77520@gmail.com>
References: <1531366178-17630-1-git-send-email-yandong77520@gmail.com>
Message-ID: <20180712095602.GN9486@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 11:29:38AM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> It does not matter if the caller of may_use_simd() migrates to
> another cpu after the call, but it is still important that the
> kernel_neon_busy percpu instance that is read matches the cpu the
> task is running on at the time of the read.
> 
> This means that raw_cpu_read() is not sufficient. kernel_neon_busy
> may appear true if the caller migrates during the execution of
> raw_cpu_read() and the next task to be scheduled in on the initial
> cpu calls kernel_neon_begin().
> 
> This patch replaces raw_cpu_read() with this_cpu_read() to protect
> against this race.
> 
> Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm..com>
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> ---
>  arch/arm64/include/asm/simd.h | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..6495cc5 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,20 +29,15 @@
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
> +	 * kernel_neon_busy is only set while preemption is disabled,
> +	 * and is clear whenever preemption is enabled. Since
> +	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
> +	 * cannot change under our feet -- if it's set we cannot be
> +	 * migrated, and if it's clear we cannot be migrated to a CPU
> +	 * where it is set.
>  	 */

This new explanation looks fine to me.

[...]

Cheers
---Dave
