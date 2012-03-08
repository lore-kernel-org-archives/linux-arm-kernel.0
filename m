From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Mar 2012 10:52:46 +0000
Subject: [PATCH v2 4/5] Cortex-M3: Add base support for Cortex-M3
In-Reply-To: <1330967042-25612-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAHkRjk70x+Fn+Z4iUxSMc7Zq2cKBo_ka0tNhV0i5JWmEixpRrA@mail.gmail.com>
 <1330967042-25612-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120308105246.GC26727@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Mar 05, 2012 at 05:04:01PM +0000, Uwe Kleine-K?nig wrote:
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -49,7 +49,15 @@ struct thread_struct {
>  #ifdef CONFIG_MMU
>  #define nommu_start_thread(regs) do { } while (0)
>  #else
> +#ifndef CONFIG_CPU_V7M
>  #define nommu_start_thread(regs) regs->ARM_r10 = current->mm->start_data
> +#else
> +#define nommu_start_thread(regs) do {                                  \
> +       regs->ARM_r10 = current->mm->start_data;                        \
> +       regs->ARM_sp -= 32;             /* exception return state */    \
> +       regs->ARM_EXCRET = 0xfffffffdL;                                 \
> +} while (0)
...
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -39,16 +39,25 @@
> @@ -127,7 +136,11 @@ struct pt_regs {
>  #define ARM_r2         uregs[2]
>  #define ARM_r1         uregs[1]
>  #define ARM_r0         uregs[0]
> +#if defined CONFIG_CPU_V7M
> +#define ARM_EXCRET     uregs[17]
> +#else
>  #define ARM_ORIG_r0    uregs[17]
> +#endif

Could we save the exception return somewhere in thread_info and preserve
ORIG_r0?

Alternatively, with some care, we could extend the kernel pt_regs
definition with two more registers and use one of them for exception
return. The user variant would remain the same as it's used by ptrace.

-- 
Catalin
