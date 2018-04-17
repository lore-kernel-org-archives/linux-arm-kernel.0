From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 17 Apr 2018 15:46:31 +0100
Subject: [PATCH] arm64: signal: don't force known signals to SIGKILL
In-Reply-To: <20180416154501.56872-1-mark.rutland@arm.com>
References: <20180416154501.56872-1-mark.rutland@arm.com>
Message-ID: <20180417144630.GG16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 04:45:01PM +0100, Mark Rutland wrote:
> Since commit:
> 
>   a7e6f1ca90354a31 ("arm64: signal: Force SIGKILL for unknown signals in force_signal_inject")
> 
> ... any signal which is not SIGKILL will be upgraded to a SIGKILL be
> force_signal_inject(). This includes signals we do expect, such as
> SIGILL triggered by do_undefinstr().
> 
> Fix the check to use a logical AND rather than a logical OR, permitting
> signals whose layout is SIL_FAULT.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: a7e6f1ca90354a31 ("arm64: signal: Force SIGKILL for unknown signals in force_signal_inject")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index ba964da31a25..1cb2749a72bf 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -366,7 +366,7 @@ void force_signal_inject(int signal, int code, unsigned long address)
>  	}
>  
>  	/* Force signals we don't understand to SIGKILL */

Is it worth updating the comment here?

What's the rationale for this check?

IIRC the purpose of this is to ensure that any siginfo delivered to
userspace through this path is initialised correctly: so, either the
signal must be a SIL_FAULT signal (since that's what the subsequent code
initialises for) or SIGKILL (since userspace can't inspect the siginfo
post-mortem, so the initialisation doesn't matter in that case).


Maybe moving this check before the switch() would make the logic
clearer.  Not sure though.

> -	if (WARN_ON(signal != SIGKILL ||
> +	if (WARN_ON(signal != SIGKILL &&
>  		    siginfo_layout(signal, code) != SIL_FAULT)) {
>  		signal = SIGKILL;
>  	}

[...]

Cheers
---Dave
