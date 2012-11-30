From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Nov 2012 19:32:54 +0000
Subject: [PATCH 07/10] arm: arch_timer: add arch_counter_enable_user_access
In-Reply-To: <1354297568-26366-8-git-send-email-mark.rutland@arm.com>
References: <1354297568-26366-1-git-send-email-mark.rutland@arm.com>
 <1354297568-26366-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20121130193254.GA12819@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 05:46:05PM +0000, Mark Rutland wrote:
> Several bits in CNTKCTL reset to 0, including PL0VTEN. For platforms
> using the generic timer which wish to have a fast gettimeofday vDSO
> implementation, these bits must be set to 1 by the kernel.
> 
> Add an arch_counter_enable_user_access function for this. As we don't
> (currently) use the counter from PL0 on arm, the implementation is an
> empty stub.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/arch_timer.h |    7 +++++++
>  arch/arm/kernel/arch_timer.c      |    2 ++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 701f2b7..c50e415 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -108,6 +108,13 @@ static inline u64 arch_counter_get_cntvct(void)
>  	return cval;
>  }
>  
> +static inline void __cpuinit arch_counter_enable_user_access(void)
> +{
> +	/*
> +	 * Do nothing - the counter is never mapped to userspace threads,
> +	 * so we don't care whether access is enabled or not.
> +	 */
> +}

Might be worth explicitly *disabling* userspace access for the time being
then (and rename this function to arch_counter_set_user_access?).

Will
