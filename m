From: james.morse@arm.com (James Morse)
Date: Thu, 22 Feb 2018 12:14:17 +0000
Subject: [PATCH 1/3] signal: Add FPE_FLTUNK si_code for undiagnosable
 fp exceptions
In-Reply-To: <1519228960-10883-2-git-send-email-Dave.Martin@arm.com>
References: <1519228960-10883-1-git-send-email-Dave.Martin@arm.com>
 <1519228960-10883-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <5A8EB419.1020508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 21/02/18 16:02, Dave Martin wrote:
> Some architectures cannot always report accurately what kind of
> floating-point exception triggered a floating-point exception trap.
> 
> This can occur with fp exceptions occuring on lanes in a vector

(Nit: occurring)

> instruction on arm64 for example.
> 
> Rather than have every architecture come up with its own way of
> descrbing such a condition, this patch adds a common FPE_FLTUNK do

(Nits: describing; 'to report')

> report that an fp exception caused a trap but we cannot be certain
> which kind of fp exception it was.


> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 85dc965..10304de 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -229,7 +229,8 @@ typedef struct siginfo {
>  # define __FPE_INVASC	12	/* invalid ASCII digit */
>  # define __FPE_INVDEC	13	/* invalid decimal digit */
>  #endif
> -#define NSIGFPE		13
> +#define FPE_FLTUNK	14	/* undiagnosed floating-point exception */
> +#define NSIGFPE		14

It looks like x86's compat relies on this value not changing:
| arch/x86/kernel/signal_compat.c:        BUILD_BUG_ON(NSIGFPE  != 13);
| include/uapi/asm-generic/siginfo.h:#define NSIGFPE              13

(from v4.16-rc2)


Thanks,

James
