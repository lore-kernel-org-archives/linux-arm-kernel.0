From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Oct 2017 11:14:26 +0100
Subject: [PATCH] arm64: Enable MRS emulation early
In-Reply-To: <20171004094805.24009-1-suzuki.poulose@arm.com>
References: <20171004094805.24009-1-suzuki.poulose@arm.com>
Message-ID: <20171004101425.GB23092@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 10:48:05AM +0100, Suzuki K Poulose wrote:
> Make sure the MRS emulation is enabled early enough, such that the
> early userspace applications (e.g, those run from initrd) could
> use the facility without crashing them.
> 
> Fixes: commit 77c97b4ee2129 ("arm64: cpufeature: Expose CPUID registers by emulation")
> Reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Dave Martin <Dave.martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: stable at vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

This looks sensible, but shouldn't we do the same for other
late_inicalls can affect initrd userspace?

e.g. armv8_deprecated_init, fpsimd_init, sys_reg_genericv8_init?

Thanks,
Mark.

> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9f9e0064c8c1..276eecab6cea 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1294,4 +1294,4 @@ static int __init enable_mrs_emulation(void)
>  	return 0;
>  }
>  
> -late_initcall(enable_mrs_emulation);
> +core_initcall(enable_mrs_emulation);
> -- 
> 2.13.5
> 
