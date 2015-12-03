From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Dec 2015 12:20:54 +0000
Subject: [PATCH v6 10/19] arm64:ilp32 use the native LP64 'start_thread'
 for ILP32 threads
In-Reply-To: <1447795019-30176-11-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-11-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151203122054.GL10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 12:16:50AM +0300, Yury Norov wrote:
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -28,6 +28,7 @@
>  #ifdef __KERNEL__
>  
>  #include <linux/string.h>
> +#include <linux/thread_info.h>
>  
>  #include <asm/fpsimd.h>
>  #include <asm/hw_breakpoint.h>
> @@ -123,6 +124,15 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
>  static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
>  				       unsigned long sp)
>  {
> +#ifdef CONFIG_ARM64_ILP32
> +	/* ILP32 thread are started the same way as LP64 threads.
> +	   Note we cannot use is_ilp32_compat_task here as that
> +	   would introduce a header depency issue.  */
> +	if (test_thread_flag(TIF_32BIT_AARCH64)) {
> +		start_thread(regs, pc, sp);
> +		return;
> +	}

Nitpicks: use IS_ENABLED(CONFIG_ARM64_ILP32) instead of #ifdef. Also
follow the coding style for multi-line comments:

	/*
	 * .....
	 * .....
	 */

-- 
Catalin
