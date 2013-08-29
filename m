From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Aug 2013 12:24:21 +0100
Subject: [PATCH v5 2/5] ARM: arch_timer: add support to configure and
 enable event stream
In-Reply-To: <1377686689-30828-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1377686689-30828-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1377686689-30828-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130829112421.GF13704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 11:44:46AM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This patch adds support for configuring the event stream frequency
> and enabling it.
> 
> It also adds the hwcaps definitions to the user to detect this event
> stream feature.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/arm/include/asm/arch_timer.h | 33 ++++++++++++++++++++++++++++-----
>  arch/arm/include/uapi/asm/hwcap.h |  1 +
>  arch/arm/kernel/setup.c           |  1 +
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 1a3e967..4e38609 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -89,22 +89,45 @@ static inline u64 arch_counter_get_cntvct(void)
>  	return cval;
>  }
>  
> -static inline void arch_counter_set_user_access(void)
> +static inline u32 arch_timer_get_cntkctl(void)
>  {
>  	u32 cntkctl;
> -
>  	asm volatile("mrc p15, 0, %0, c14, c1, 0" : "=r" (cntkctl));
> +	return cntkctl;
> +}
> +
> +static inline void arch_timer_set_cntkctl(u32 cntkctl)
> +{
> +	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
> +}
> +
> +static inline void arch_counter_set_user_access(void)
> +{
> +	u32 cntkctl = arch_timer_get_cntkctl();
>  
>  	/* Disable user access to both physical/virtual counters/timers */
> -	/* Also disable virtual event stream */
>  	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
>  			| ARCH_TIMER_USR_VT_ACCESS_EN
> -			| ARCH_TIMER_VIRT_EVT_EN
>  			| ARCH_TIMER_USR_VCT_ACCESS_EN
>  			| ARCH_TIMER_USR_PCT_ACCESS_EN);
> +	arch_timer_set_cntkctl(cntkctl);
> +}

You can keep the ARCH_TIMER_VIRT_EVT_EN clearing here, especially if we
drop the bool enable argument to arch_timer_evtstrm_config(). You can
add the same clearing to arm64 in one of the latter patches.

-- 
Catalin
