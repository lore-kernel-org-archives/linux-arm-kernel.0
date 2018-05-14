From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 14 May 2018 11:06:46 +0100
Subject: [PATCH 05/18] arm64: kill change_cpacr()
In-Reply-To: <20180514094640.27569-6-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-6-mark.rutland@arm.com>
Message-ID: <20180514100645.GA7753@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:46:27AM +0100, Mark Rutland wrote:
> Now that we have sysreg_clear_set(), we can use this instead of
> change_cpacr().
> 
> Note that the order of the set and clear arguments differs between
> change_cpacr() and sysreg_clear_set(), so these are flipped as part of
> the conversion. Also, sve_user_enable() redundantly clears
> CPACR_EL1_ZEN_EL0EN before setting it; this is removed for clarity.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Looks right to me.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/kernel/fpsimd.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 87a35364e750..088940387a4d 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -172,23 +172,14 @@ static void *sve_pffr(struct task_struct *task)
>  		sve_ffr_offset(task->thread.sve_vl);
>  }
>  
> -static void change_cpacr(u64 val, u64 mask)
> -{
> -	u64 cpacr = read_sysreg(CPACR_EL1);
> -	u64 new = (cpacr & ~mask) | val;
> -
> -	if (new != cpacr)
> -		write_sysreg(new, CPACR_EL1);
> -}
> -
>  static void sve_user_disable(void)
>  {
> -	change_cpacr(0, CPACR_EL1_ZEN_EL0EN);
> +	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
>  }
>  
>  static void sve_user_enable(void)
>  {
> -	change_cpacr(CPACR_EL1_ZEN_EL0EN, CPACR_EL1_ZEN_EL0EN);
> +	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
>  }
>  
>  /*
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
