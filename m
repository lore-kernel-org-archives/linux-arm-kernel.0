From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 10 Jul 2018 14:11:20 +0100
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
In-Reply-To: <1531189300-26216-1-git-send-email-yandong77520@gmail.com>
References: <1531189300-26216-1-git-send-email-yandong77520@gmail.com>
Message-ID: <20180710131119.GI9486@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:21:40AM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> Operations for contexts where we do not want to do any checks for
> preemptions.  Unless strictly necessary, always use this_cpu_read()
> instead.  Because of the kernel_neon_busy here we have to make sure
> that it is the current cpu.

I find this wording a bit confusing.

Does the following make look OK to you?

--8<--

It does not matter if the caller of may_use_simd() migrates to
another cpu after the call, but it is still important that the
kernel_neon_busy percpu instance that is read matches the cpu the
task is running on@the time of the read.

This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
may appear true if the caller migrates during the execution of
raw_cpu_read() and the next task to be scheduled in on the initial
cpu calls kernel_neon_begin().

This patch replaces raw_cpu_read() with this_cpu_read() to protect
against this race.

-->8--

> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> ---
>  arch/arm64/include/asm/simd.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index fa8b3fe..8b97f8b 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,7 +29,8 @@
>  static __must_check inline bool may_use_simd(void)
>  {
>  	/*
> -	 * The raw_cpu_read() is racy if called with preemption enabled.
> +	 * The this_cpu_read() is racy if called with preemption enabled,
> +	 * since the task my subsequently migrate to another CPU.

"my" -> "may"

(apologies if I was responsible for that typo)


[...]

Cheers
---Dave
