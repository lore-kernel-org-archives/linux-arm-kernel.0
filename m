From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 5 Mar 2018 14:05:06 +0000
Subject: [RFC PATCH] arm64: fault: Don't populate ESR context for user
 fault on kernel VA
In-Reply-To: <1520245875-32527-1-git-send-email-will.deacon@arm.com>
References: <1520245875-32527-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180305140506.GJ32331@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 10:31:15AM +0000, Will Deacon wrote:
> User faults on kernel addresses are a good sign that the faulting task
> is either up to no good or is in deep trouble. In such situations,
> exposing the optional ESR context on the sigframe as part of the
> delivered signal is only useful to attackers who are using information
> about underlying hardware fault (e.g. translation vs permission) as a
> mechanism to defeat KASLR.
> 
> Remove the ESR context from the sigframe for user faults on kernel
> addresses.

As this wording suggests, this change causes esr_context to disappear
entirely from the signal frame.  Previously, I think user code could
have relied on its being present for certain signals.

Does Debian's codesearch throw up any nontrivial users of esr_context?

Cheers
---Dave

> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Here's another one that doesn't make a huge amount of difference when
> kpti is enabled, but I think is a change worth making all the same.
> 
>  arch/arm64/mm/fault.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 49dfb08a6c4d..b9800395788e 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -292,8 +292,10 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>  
>  static void __do_user_fault(struct siginfo *info, unsigned int esr)
>  {
> -	current->thread.fault_address = (unsigned long)info->si_addr;
> -	current->thread.fault_code = esr;
> +	unsigned long addr = (unsigned long)info->si_addr;
> +
> +	current->thread.fault_address = addr;
> +	current->thread.fault_code = addr < TASK_SIZE ? esr : 0;
>  	arm64_force_sig_info(info, esr_to_fault_info(esr)->name, current);
>  }
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
