From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Aug 2013 14:27:12 +0100
Subject: [PATCH v3 4/6] ARM64: arch_timer: configure and enable event
 stream
In-Reply-To: <1376414984-14182-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130820132712.GE26129@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

Couple of comments inline...

On Tue, Aug 13, 2013 at 06:29:42PM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This patch configures the event stream frequency and enables it.
> It also adds the hwcaps as well as compat-specific definitions to
> the user to detect this event stream feature.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> [sudeep: moving ARM/ARM64 changes into separate patches]
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/arm64/include/asm/arch_timer.h | 12 ++++++++++--
>  arch/arm64/include/asm/hwcap.h      |  4 +++-
>  arch/arm64/include/uapi/asm/hwcap.h |  1 +
>  arch/arm64/kernel/setup.c           |  1 +
>  4 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 69f5c8e..43f322a 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -106,14 +106,22 @@ static inline void arch_counter_set_user_access(int divider)
>  	/* Disable user access to the timers and the physical counter. */
>  	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
>  			| ARCH_TIMER_USR_VT_ACCESS_EN
> +			| ARCH_TIMER_EVT_TRIGGER_MASK
>  			| ARCH_TIMER_USR_PCT_ACCESS_EN);
>  
> -	/* Enable user access to the virtual counter. */
> -	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
> +	/* Enable event stream and user access to the virtual counter */
> +	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
> +			| ARCH_TIMER_VIRT_EVT_EN
> +			| ARCH_TIMER_USR_VCT_ACCESS_EN;
>  
>  	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
>  }
>  
> +static inline void arch_timer_set_hwcap_evtstrm(void)
> +{
> +	elf_hwcap |= HWCAP_EVTSTRM;
> +}
> +
>  static inline u64 arch_counter_get_cntvct(void)
>  {
>  	u64 cval;
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 6d4482f..effd8f9 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -30,6 +30,7 @@
>  #define COMPAT_HWCAP_IDIVA	(1 << 17)
>  #define COMPAT_HWCAP_IDIVT	(1 << 18)
>  #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
> +#define COMPAT_HWCAP_EVTSTRM	(1 << 21)

Looking@the context, we should also add COMPAT_HWCAP_LPAE as a separate
patch (not part of this series).

>  #ifndef __ASSEMBLY__
>  /*
> @@ -41,7 +42,8 @@
>  				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
>  				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
>  				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
> -				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV)
> +				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV|\
> +				 COMPAT_HWCAP_EVTSTRM)

So here you're hardcoding COMPAT_HWCAP_EVTSTRM in the COMPAT_ELF_HWCAP, yet
we only enable the native one from the arch-timer driver. The question then is
"Can we rely on the event-stream working for AArch64?". If so, we don't need
the native hwcap at all. If not, then we need to make the compat hwcap
dynamic.

Will
