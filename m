From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Mar 2018 17:11:53 +0000
Subject: [PATCH v2 2/3] arm64: fpsimd: Fix bad si_code for undiagnosed
 SIGFPE
In-Reply-To: <1519926248-12591-3-git-send-email-Dave.Martin@arm.com>
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
 <1519926248-12591-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180308171153.GD14918@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 05:44:07PM +0000, Dave Martin wrote:
> Currently a SIGFPE delivered in response to a floating-point
> exception trap may have si_code set to 0 on arm64.  As reported by
> Eric, this is a bad idea since this is the value of SI_USER -- yet
> this signal is definitely not the result of kill(2), tgkill(2) etc.
> and si_uid and si_pid make limited sense whereas we do want to
> yield a value for si_addr (which doesn't exist for SI_USER).

[...]

> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index e7226c4..9040038 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -39,6 +39,7 @@
>  #include <linux/slab.h>
>  #include <linux/sysctl.h>
>  
> +#include <asm/esr.h>
>  #include <asm/fpsimd.h>
>  #include <asm/cputype.h>
>  #include <asm/simd.h>
> @@ -867,18 +868,20 @@ asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
>  asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>  {
>  	siginfo_t info;
> -	unsigned int si_code = FPE_FIXME;
> -
> -	if (esr & FPEXC_IOF)
> -		si_code = FPE_FLTINV;
> -	else if (esr & FPEXC_DZF)
> -		si_code = FPE_FLTDIV;
> -	else if (esr & FPEXC_OFF)
> -		si_code = FPE_FLTOVF;
> -	else if (esr & FPEXC_UFF)
> -		si_code = FPE_FLTUND;
> -	else if (esr & FPEXC_IXF)
> -		si_code = FPE_FLTRES;
> +	unsigned int si_code = FPE_FLTUNK;

Happy to take this patch once the dependency on FPE_FLTUNK in core code is
resolved.

Will
